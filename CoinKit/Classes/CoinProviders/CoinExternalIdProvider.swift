class CoinExternalIdProvider {
    private let filename = "provider.coins"
    private let parser: JsonParser

    init(parser: JsonParser) {
        self.parser = parser
    }

    func coinExternalIds() throws -> [CoinExternalIdRecord] {
        let response: CoinExternalIdResponse = try parser.parse(filename: filename)
        var externalIds = [CoinExternalIdRecord]()

        response.coins.forEach { coin in
            coin.providerIds.forEach { (name, id) in
                externalIds.append(CoinExternalIdRecord(id: coin.id, providerName: name, providerId: id))
            }
        }

        return externalIds
    }

}
