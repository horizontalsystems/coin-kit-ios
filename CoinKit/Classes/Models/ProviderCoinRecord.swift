import GRDB

class ProviderCoinRecord: Record {
    let id: String
    let code: String
    let name: String
    let platform: String

    init(id: String, code: String, name: String, platform: String) {
        self.id = id
        self.code = code
        self.name = name
        self.platform = platform

        super.init()
    }

    override class var databaseTableName: String {
        "provider_coins"
    }

    enum Columns: String, ColumnExpression {
        case id
        case code
        case name
        case platform
    }

    required init(row: Row) {
        id = row[Columns.id]
        code = row[Columns.code]
        name = row[Columns.name]
        platform = row[Columns.platform]

        super.init(row: row)
    }

    override func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.code] = code
        container[Columns.name] = name
        container[Columns.platform] = platform
    }

}
