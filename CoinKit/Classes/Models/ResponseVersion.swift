import GRDB

class ResponseVersion: Record {
    let id: String
    let version: Int

    init(id: String, version: Int) {
        self.id = id
        self.version = version

        super.init()
    }

    override class var databaseTableName: String {
        "response_versions"
    }

    enum Columns: String, ColumnExpression {
        case id
        case version
    }

    required init(row: Row) {
        id = row[Columns.id]
        version = row[Columns.version]

        super.init(row: row)
    }

    override func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.version] = version
    }

}
