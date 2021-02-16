import UIKit

class MainController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)

        let coinController = CoinController()
        coinController.tabBarItem = UITabBarItem(title: "Coins", image: UIImage(systemName: "dollarsign.circle"), tag: 0)

        viewControllers = [
            UINavigationController(rootViewController: coinController),
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
