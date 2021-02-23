import UIKit
import CoinKit

class MainController: UITabBarController {
    private let coinKit: Kit

    init() {
        coinKit = try! Kit.instance()

        super.init(nibName: nil, bundle: nil)

        let coinController = CoinController(coinKit: coinKit)
        coinController.tabBarItem = UITabBarItem(title: "Coins", image: UIImage(systemName: "dollarsign.circle"), tag: 0)

        let coinExternalIdController = CoinExternalIdController(coinKit: coinKit)
        coinExternalIdController.tabBarItem = UITabBarItem(title: "Ids", image: UIImage(systemName: "dollarsign.circle"), tag: 0)

        viewControllers = [
            UINavigationController(rootViewController: coinController),
            UINavigationController(rootViewController: coinExternalIdController),
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
