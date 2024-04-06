//
//  SearchViewModel.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    private let data: [String] = ["a", "b", "c", "abc", "ab", "bc", "cc", "aa", "abcc"] // 더미
    private let disposeBag = DisposeBag()
    
    struct Input {
        // 검색했을 때
        let searchBarButtonClicked: ControlEvent<Void>
        // searchBar의 글자
        let searchText: ControlProperty<String?>
//        let tableCellClicked: ControlEvent<Int>
    }
    
    struct Output {
        let tableViewItems: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let tableViewItems = BehaviorRelay<[String]>(value: data)
        // 검색하면
        input.searchBarButtonClicked
            .withLatestFrom(input.searchText.orEmpty)
            .subscribe(with: self) { owner, text in
                let list = text == "" ? owner.data : owner.data.filter{$0.contains(text)}
                tableViewItems.accept(list)
                
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(tableViewItems: tableViewItems.asDriver())
    }
}
