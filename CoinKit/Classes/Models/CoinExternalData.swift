import ObjectMapper

class CoinExternalData: ImmutableMappable {
    let id: String
    let code: String
    let name: String
    let platform: String
    let providerIds: [String: String]

    init(id: String, code: String, name: String, platform: String, providerIds: [String: String]) {
        self.id = id
        self.code = code
        self.name = name
        self.platform = platform
        self.providerIds = providerIds
    }

    public required init(map: Map) throws {
        id = try map.value("id")
        code = try map.value("code")
        name = try map.value("name")
        platform = try map.value("platform")

        if let ids: [String: Any] = try? map.value("external_id") {
            var providerIds = [String: String]()

            ids.forEach { (key, value) in
                if let value = value as? String {
                    providerIds[key] = value
                }
            }

            self.providerIds = providerIds
        } else {
            providerIds = [:]
        }
    }

}