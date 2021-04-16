import Foundation

class CoinManager {
    private let coinProvider: CoinProvider
    private var storage: ICoinStorage

    init(coinProvider: CoinProvider, storage: ICoinStorage) {
        self.coinProvider = coinProvider
        self.storage = storage

        do {
            try updateDefaultCoins()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func updateDefaultCoins() throws {
        let defaultCoins = try coinProvider.defaultCoins()

        guard let currentVersion = storage.defaultListVersion else {
            storage.defaultListVersion = defaultCoins.version
            storage.save(coins: defaultCoins.coins)
            return
        }

        guard currentVersion != defaultCoins.version else {
            return
        }

        storage.defaultListVersion = currentVersion
        merge(coins: defaultCoins.coins)
    }

    private func merge(coins: [Coin]) {
        //todo: make right merge for new coins
        storage.save(coins: coins)
    }

}

extension CoinManager {

    var coins: [Coin] {
        storage.coins
    }

    func coin(id: String) -> Coin? {
        storage.coin(id: id)
    }

    func save(coins: [Coin]) {
        storage.save(coins: coins)
    }

}
