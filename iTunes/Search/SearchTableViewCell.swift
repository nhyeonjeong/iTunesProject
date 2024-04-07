//
//  SearchTableViewCell.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    private let iTunesImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let iTunesTextLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.textColor = .black
        return view
    }()
    
    private let getButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.setTitle("  받기  ", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addviews([iTunesImageView, iTunesTextLabel, getButton])
    }
    
    func configureConstraints() {
        iTunesImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(10)
            make.size.equalTo(50)
        }
        iTunesTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(iTunesImageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            
        }
        getButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(iTunesTextLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func upgradeCell(_ data: Music) {
        iTunesImageView.kf.setImage(with: URL(string: data.image))
        iTunesTextLabel.text = data.name
    }
}
