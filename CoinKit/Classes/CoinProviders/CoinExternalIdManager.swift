import ObjectMapper

struct CoinExternalIdResponse: ImmutableMappable {
    let coins: [CoinExternalData]

    init(map: Map) throws {
        coins = try map.value("coins")
    }

}

class CoinProviderManager {
    private let coinProvider: CoinExternalIdProvider
    private let storage: IProviderCoinStorage

    init(coinProvider: CoinExternalIdProvider, storage: IProviderCoinStorage) {
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
        if storage.isEmpty {
            sync()
        }

        return storage.providerId(id: id, providerName: providerName)
    }

    func id(providerId: String, providerName: String) -> String? {
        if storage.isEmpty {
            sync()
        }

        return storage.id(providerId: providerId, providerName: providerName)
    }

}