import UIKit
import SnapKit
import RxSwift
import CoinKit

class CoinController: UIViewController {
    private let disposeBag = DisposeBag()

    private let tableView = UITableView(frame: .zero, style: .plain)

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Coins"


        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self

        let coinKit = try! CoinKit.instance()

        print(coinKit.providerId(id: CoinType.bitcoinCash.rawValue, providerName: "coingecko"))
        print(coinKit.providerId(id: CoinType.bitcoin.rawValue, providerName: "coingecko"))
    }

}

extension CoinController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self)) {
//            return cell
//        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? PostCell, posts.count > indexPath.row else {
//            return
//        }
//
//        let post = posts[indexPath.row]
//        cell.bind(title: post.title, timestamp: post.timestamp)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

}
