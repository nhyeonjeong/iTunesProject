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
    var data: [Music] = [] // 더미
    var recentList: [String] = []
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
        let recentItems: Driver<[String]>
        let errorMessage: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let tableViewItems = BehaviorRelay<[Music]>(value: data)
        let recentItems = BehaviorRelay<[String]>(value: recentList)
        let errorMessage = PublishRelay<String>()
        // 검색하면
        let inputSearchBar = input.searchBarButtonClicked
            .withLatestFrom(input.searchText.orEmpty)
        inputSearchBar
            .flatMap {
                ITunesNetwork.shared.fetchBoxOfficeData(searchText: $0)
                    .catch { error in
                        let error = error as! ItunesError
                        print(error)
                        errorMessage.accept(error.errorMessage)
                        return Observable<Itunes>.never()
                    }
//                    .catch { error in
//                        switch error {
//                        case ItunesError.invalidURL:
//                            print("invalidURL")
//                            
//                        }
//                    }
            }
            .debug()
            .subscribe(with: self) { owner, text in
                owner.data = text.results
                tableViewItems.accept(owner.data)
            }
            .disposed(by: disposeBag)

        inputSearchBar
            .subscribe(with: self) { owner, text in
                owner.recentList.append(text)
                recentItems.accept(owner.recentList)
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewItems: tableViewItems.asDriver(), recentItems: recentItems.asDriver(), errorMessage: errorMessage.asDriver(onErrorJustReturn: ""))
    }
}
