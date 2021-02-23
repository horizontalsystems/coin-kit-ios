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

        migrator.registerMigration("createResponseVersions") { db in
            try db.create(table: ResponseVersion.databaseTableName) { t in
                t.column(ResponseVersion.Columns.id.name, .text).notNull()
                t.column(ResponseVersion.Columns.version.name, .integer).notNull()

                t.primaryKey([Coin.Columns.id.name], onConflict: .replace)
            }
        }

        migrator.registerMigration("createCoins") { db in
            try db.create(table: Coin.databaseTableName) { t in
                t.column(Coin.Columns.id.name, .text).notNull()
                t.column(Coin.Columns.title.name, .text).notNull()
                t.column(Coin.Columns.code.name, .text).notNull()
                t.column(Coin.Columns.decimal.name, .integer).notNull()

                t.primaryKey([Coin.Columns.id.name], onConflict: .replace)
            }
        }

        return migrator
    }
}

extension GrdbStorage: ICoinStorage {

    var coins: [Coin] {
        try! dbPool.read { db in
            try Coin.fetchAll(db)
        }
    }

    var defaultListVersion: Int? {
        get {
            try! dbPool.read { db in
                try ResponseVersion
                        .filter(ResponseVersion.Columns.id == String(describing: Coin.self))
                        .fetchOne(db)?
                        .version
            }
        }
        set {
            _ = try! dbPool.write { db in
                guard let version = newValue else {
                    try ResponseVersion
                            .filter(ResponseVersion.Columns.id == String(describing: Coin.self))
                            .deleteAll(db)
                    return
                }
                try ResponseVersion(id: String(describing: Coin.self), version: version).insert(db)
            }
        }
    }

    func save(coins: [Coin]) {
        _ = try! dbPool.write { db in
            try coins.forEach { record in
                try record.insert(db)
            }
        }
    }

    func coin(id: String) -> Coin? {
        try! dbPool.read { db in
            let coin = try Coin
                    .filter(Coin.Columns.id == id)
                    .fetchOne(db)
            return coin
        }
    }

}
