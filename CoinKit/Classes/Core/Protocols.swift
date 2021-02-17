import RxSwift

protocol ICoinStorage {
    var coins: [Coin] { get }
    var defaultListVersion: Int? { get set }
    func coin(id: String) -> Coin?
    func save(coins: [Coin])
}

protocol ICoinExternalIdStorage {
    var emptyExternalIds: Bool { get }
    func save(coinExternalIds: [CoinExternalIdRecord])
    func providerId(id: String, providerName: String) -> String?
    func id(providerId: String, providerName: String) -> String?
}
