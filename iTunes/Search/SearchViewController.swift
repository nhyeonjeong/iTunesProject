//
//  SearchViewController.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    private let viewModel = SearchViewModel()
    private let mainView = SearchView()
    
    private let disposeBag = DisposeBag()
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {

        let input = SearchViewModel.Input(searchBarButtonClicked: mainView.searchBar.rx.searchButtonClicked,
                                          searchText: mainView.searchBar.rx.text)
        
        let output = viewModel.transform(input: input)
        // 테이블 그리기
        output.tableViewItems
            .drive(mainView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)){(row, element, cell) in
                cell.upgradeCell(element)
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
