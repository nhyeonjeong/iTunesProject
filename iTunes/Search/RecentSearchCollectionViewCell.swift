//
//  RecentSearchCollectionViewCell.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/08.
//

import UIKit
import SnapKit

class RecentSearchCollectionViewCell: UICollectionViewCell {
    private let label = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    
    // 스토리보드로 할 때 실행되는 구문
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("textfield required init")
        fatalError("no storyboard")
    }
}
extension RecentSearchCollectionViewCell {
    private func configureHierarchy() {
        contentView.addSubview(label)
    }
    
    private func configureConstrainsts() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func upgradeCell(_ text: String) {
        label.text = text
    }
    
}
