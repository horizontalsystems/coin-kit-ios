import RxSwift
import GRDB

class GrdbStorage {
    private let dbPool: DatabasePool

    init(databaseDirectoryUrl: URL, databaseFileName: String) {
        let databaseURL = databaseDirectoryUrl.appendingPathComponent("\(databaseFileName).sqlite")

        let configuration: Configuration = Configuration()
//        configuration.trace = { print($0) }

        dbPool = try! DatabasePool(path: databaseURL.path, configuration: configuration)

        try! migrator.migrate(dbPool)
    }

    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createCoinExternalIds") { db in
            try db.create(table: CoinExternalIdRecord.databaseTableName) { t in
                t.column(CoinExternalIdRecord.Columns.id.name, .text).notNull()
                t.column(CoinExternalIdRecord.Columns.providerName.name, .text).notNull()
                t.column(CoinExternalIdRecord.Columns.providerId.name, .text).notNull()

                t.primaryKey([CoinExternalIdRecord.Columns.id.name, CoinExternalIdRecord.Columns.providerName.name], onConflict: .replace)
            }
        }

        return migrator
    }
}

extension GrdbStorage: IProviderCoinStorage {

    func save(coinExternalIds: [CoinExternalIdRecord]) {
        _ = try! dbPool.write { db in
            try coinExternalIds.forEach { record in
                try record.insert(db)
            }
        }
    }

    func providerId(id: String, providerName: String) -> String? {
        try! dbPool.read { db in
            let record = try CoinExternalIdRecord
                    .filter(CoinExternalIdRecord.Columns.id == id && CoinExternalIdRecord.Columns.providerName == providerName)
                    .fetchOne(db)
            return record?.providerId
        }
    }

    func id(providerId: String, providerName: String) -> String? {
        try! dbPool.read { db in
            try CoinExternalIdRecord
                    .filter(CoinExternalIdRecord.Columns.providerId == providerId && CoinExternalIdRecord.Columns.providerName == providerName)
                    .fetchAll(db)
                    .first?.id
        }
    }

    var isEmpty: Bool {
        try! dbPool.read { db in
            try CoinExternalIdRecord.fetchCount(db)
        } == 0
    }

}
