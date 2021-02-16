import RxSwift

protocol IProviderCoinStorage {
    var isEmpty: Bool { get }
    func save(coinExternalIds: [CoinExternalIdRecord])
    func providerId(id: String, providerName: String) -> String?
    func id(providerId: String, providerName: String) -> String?
}
