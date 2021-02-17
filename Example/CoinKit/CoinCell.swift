import UIKit

class CoinCell: UITableViewCell {
    private let topLabel = UILabel()
    private let middleLabel = UILabel()
    private let bottomLabel = UILabel()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(topLabel)
        topLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.top.equalToSuperview().inset(8)
        }

        topLabel.font = .boldSystemFont(ofSize: 14)
        topLabel.textColor = .black

        contentView.addSubview(middleLabel)
        middleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(32)
            maker.top.equalTo(topLabel.snp.bottom).offset(4)
        }

        middleLabel.font = .systemFont(ofSize: 13)
        middleLabel.textColor = .black

        contentView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(32)
            maker.top.equalTo(middleLabel.snp.bottom).offset(4)
        }

        bottomLabel.font = .systemFont(ofSize: 13)
        bottomLabel.textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var topTitle: String? {
        get { topLabel.text }
        set { topLabel.text = newValue }
    }

    var middleTitle: String? {
        get { middleLabel.text }
        set { middleLabel.text = newValue }
    }

    var bottomTitle: String? {
        get { bottomLabel.text }
        set { bottomLabel.text = newValue }
    }

}
