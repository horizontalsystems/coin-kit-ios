import ObjectMapper

struct CoinExternalIdResponse: ImmutableMappable {
    let coins: [CoinExternalIdData]

    init(map: Map) throws {
        coins = try map.value("coins")
    }

}

class CoinExternalIdData: ImmutableMappable {
    let id: String
    let providerIds: [String: String]

    init(id: String, code: String, name: String, platform: String, providerIds: [String: String]) {
        self.id = id
        self.providerIds = providerIds
    }

    public required init(map: Map) throws {
        id = try map.value("id")

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