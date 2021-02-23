import RxSwift

protocol ICoinStorage {
    var coins: [Coin] { get }
    var defaultListVersion: Int? { get set }
    func coin(id: String) -> Coin?
    func save(coins: [Coin])
}
