//
//  DetailView.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/08.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailView: BaseView {
    private let image = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    private let textLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.textColor = .black
        return view
    }()
    private let getButton = {
        let view = UIButton()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemBlue
        view.setTitle("  받기  ", for: .normal)
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    override func configureHierarchy() {
        addviews([image, textLabel, getButton])
    }
    override func configureConstraints() {
        image.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.leading.top.equalTo(safeAreaLayoutGuide).inset(10)
        }
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(15)
            make.top.equalTo(image.snp.top).inset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
        getButton.snp.makeConstraints { make in
            make.bottom.equalTo(image.snp.bottom)
            make.leading.equalTo(image.snp.trailing).offset(15)
        }
    }
}

extension DetailView {
    func upgradeView(_ music: Music) {
        image.kf.setImage(with: URL(string: music.image)!)
        textLabel.text = music.name
    }
}
