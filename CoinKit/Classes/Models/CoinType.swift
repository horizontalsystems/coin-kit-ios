public enum CoinType {
    case bitcoin
    case litecoin
    case bitcoinCash
    case dash
    case ethereum
    case zcash
    case binanceSmartChain
    case erc20(address: String)
    case bep2(symbol: String)
    case bep20(address: String)
    case unsupported(id: String)
}

extension CoinType: Equatable {

    public static func ==(lhs: CoinType, rhs: CoinType) -> Bool {
        switch (lhs, rhs) {
        case (.bitcoin, .bitcoin): return true
        case (.litecoin, .litecoin): return true
        case (.bitcoinCash, .bitcoinCash): return true
        case (.dash, .dash): return true
        case (.ethereum, .ethereum): return true
        case (.zcash, .zcash): return true
        case (.binanceSmartChain, .binanceSmartChain): return true
        case (.erc20(let lhsAddress), .erc20(let rhsAddress)):
            return lhsAddress.lowercased() == rhsAddress.lowercased()
        case (.bep2(let lhsSymbol), .bep2(let rhsSymbol)):
            return lhsSymbol == rhsSymbol
        case (.bep20(let lhsSymbol), .bep20(let rhsSymbol)):
            return lhsSymbol == rhsSymbol
        case (.unsupported(let lhsId), .unsupported(let rhsId)):
            return lhsId == rhsId
        default: return false
        }
    }

}

extension CoinType: Hashable {

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .bitcoin:
            hasher.combine("bitcoin")
        case .litecoin:
            hasher.combine("litecoin")
        case .bitcoinCash:
            hasher.combine("bitcoinCash")
        case .dash:
            hasher.combine("dash")
        case .ethereum:
            hasher.combine("ethereum")
        case .zcash:
            hasher.combine("Zcash")
        case .binanceSmartChain:
            hasher.combine("binance_smart_chain")
        case .erc20(let address):
            hasher.combine("erc20_\(address)")
        case .bep2(let symbol):
            hasher.combine("bep2_\(symbol)")
        case .bep20(let address):
            hasher.combine("bep20_\(address)")
        case .unsupported(let id):
            hasher.combine(id)
        }
    }

}

extension CoinType: RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        let chunks = rawValue.split(separator: "|")

        if chunks.count == 1 {          // platform
            switch chunks[0] {
            case "bitcoin": self = .bitcoin
            case "litecoin": self = .litecoin
            case "bitcoin-cash": self = .bitcoinCash
            case "dash": self = .dash
            case "ethereum": self = .ethereum
            case "zcash": self = .zcash
            case "binance": self = .binanceSmartChain
            default: self = .unsupported(id: String(chunks[0]))
            }
        } else {
            switch chunks[0] {
            case "erc20": self = .erc20(address: String(chunks[1]))
            case "bep2": self = .bep2(symbol: String(chunks[1]))
            case "bep20": self = .bep20(address: String(chunks[1]))
            case "unsupported": self = .unsupported(id: chunks.suffix(from: 1).joined(separator: "|"))
            default: self = .unsupported(id: chunks.joined(separator: "|"))
            }
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .bitcoin: return "bitcoin"
        case .litecoin: return "litecoin"
        case .bitcoinCash: return "bitcoin-cash"
        case .dash: return "dash"
        case .ethereum: return "ethereum"
        case .zcash: return "zcash"
        case .erc20(let address): return ["erc20", address].joined(separator: "|")
        case .binanceSmartChain: return "binance"
        case .bep2(let symbol): return ["bep2", symbol].joined(separator: "|")
        case .bep20(let address): return ["bep20", address].joined(separator: "|")
        case .unsupported(let id): return ["unsupported", id].joined(separator: "|")
        }
    }

}
