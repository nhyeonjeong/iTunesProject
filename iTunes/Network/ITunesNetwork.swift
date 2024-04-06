//
//  Network.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
//르세라핌 아이브 에스파
final class ITunesNetwork {

    static let shared = ITunesNetwork()
    private init() {
        
    }
    func fetchBoxOfficeData(searchText: String) -> Observable<Itunes> { // 실질적인 데이터를 빼주겠다
//        DisposeBag

        /*
        AF.request("https://https://itunes.apple.com/search?term=\(query)&country=KR", method: .get, encoding: URLEncoding(destination: .queryString)).responseString { data in
//            print("response String\(api.typeString)")
            print("data: \(data)")
            print("--------------------------------------------")
        }
        */
    
  
        return Observable<Itunes>.create { observer in // 항상 Disposable타입으로 반환이 되어야 하기때문에 맞춰서 return 해준다.
//            let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchText)&country=KR") else {
//                observer.onError(APIError.invalidURL) // 에러 이벤트를 던져준다.
                print("invalidURL")
                return Disposables.create()
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("XYZ", forHTTPHeaderField: "User-Agent")
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                print("DataTask Succeed")
                
                if let _ = error { // error가 nil이어야 문제가 없는 것
//                    observer.onError(APIError.unknownResponse)
                    print("unknownResponse")
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
//                    observer.onError(APIError.statusError)
                    print("Response Error")
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(Itunes.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted() // 중첩 구독을 막기 위해
                } else {
                    print("응답은 왔으나 디코딩 실패")
//                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            
            return Disposables.create()
            
        }

        
    }
}
