//
//  SearchView.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    private let titleLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 27, weight: .heavy)
        view.text = "검색"
        return view
    }()
    let searchBar = UISearchBar()
    let tableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.rowHeight = 70
        return view
    }()
    
    override func configureHierarchy() {
        addviews([titleLabel, searchBar, tableView])
    }
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(22)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        searchBar.placeholder = "게임, 앱, 스토리 등"
    }

}
