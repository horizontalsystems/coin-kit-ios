import ObjectMapper

class CoinProviderManager {
    private let coinProvider: CoinExternalIdProvider
    private let storage: ICoinExternalIdStorage

    init(coinProvider: CoinExternalIdProvider, storage: ICoinExternalIdStorage) {
        self.coinProvider = coinProvider
        self.storage = storage
    }

    private func sync() {
        do {
            storage.save(coinExternalIds: try coinProvider.coinExternalIds())
        } catch {
            print(error.localizedDescription)
        }
    }

}

extension CoinProviderManager {

    func providerId(id: String, providerName: String) -> String? {
        if storage.emptyExternalIds {
            sync()
        }

        return storage.providerId(id: id, providerName: providerName)
    }

    func id(providerId: String, providerName: String) -> String? {
        if storage.emptyExternalIds {
            sync()
        }

        return storage.id(providerId: providerId, providerName: providerName)
    }

}