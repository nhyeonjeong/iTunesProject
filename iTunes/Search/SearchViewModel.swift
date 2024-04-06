//
//  SearchViewModel.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
final class SearchViewModel {
    private let data: [Music] = [] // 더미
    private let disposeBag = DisposeBag()
    
    struct Input {
        // 검색했을 때
        let searchBarButtonClicked: ControlEvent<Void>
        // searchBar의 글자
        let searchText: ControlProperty<String?>
//        let tableCellClicked: ControlEvent<Int>
    }
    
    struct Output {
        let tableViewItems: Driver<[Music]>
    }
    
    func transform(input: Input) -> Output {
        // 이벤트를 직접 만들어,,?ㅜ
        
        let tableViewItems = BehaviorRelay<[Music]>(value: data)
        // 검색하면
        input.searchBarButtonClicked
            .withLatestFrom(input.searchText.orEmpty)
            .flatMap {
                ITunesNetwork.shared.fetchBoxOfficeData(searchText: $0)
            }
            .debug()
            .subscribe(with: self) { owner, text in
                let list = text.results
                tableViewItems.accept(list)
                
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(tableViewItems: tableViewItems.asDriver())
    }
}
