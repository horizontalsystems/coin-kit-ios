import GRDB

class CoinExternalIdRecord: Record {
    let id: String
    let providerName: String
    let providerId: String

    init(id: String, providerName: String, providerId: String) {
        self.id = id
        self.providerName = providerName
        self.providerId = providerId

        super.init()
    }

    override class var databaseTableName: String {
        "coin_external_ids"
    }

    enum Columns: String, ColumnExpression {
        case id
        case providerName
        case providerId
    }

    required init(row: Row) {
        id = row[Columns.id]
        providerName = row[Columns.providerName]
        providerId = row[Columns.providerId]

        super.init(row: row)
    }

    override func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.providerName] = providerName
        container[Columns.providerId] = providerId
    }

}
