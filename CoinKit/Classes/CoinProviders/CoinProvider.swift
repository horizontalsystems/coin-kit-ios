import ObjectMapper

struct CoinResponse: ImmutableMappable {
    let version: Int
    let coins: [Coin]

    init(map: Map) throws {
        version = try map.value("version")
        coins = try map.value("coins")
    }

}

class CoinProvider {
    private let parser: JsonParser
    private let filename: String

    init(parser: JsonParser, testNet: Bool) {
        self.parser = parser
        filename = testNet ? "default.coins.testnet" : "default.coins"
    }

    func defaultCoins() throws -> CoinResponse {
        try parser.parse(filename: filename)
    }


}
