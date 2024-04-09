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

enum ItunesError: Error {
    case invalidURL
    case unknownResponse
    case statusError
    case decodeError
    
    var errorMessage: String {
        switch self {
        case .invalidURL :
            return "URL이 올바르지 않습니다"
        case .unknownResponse:
            return "통신 오류"
        case .statusError:
            return "상태코드 오류"
        case .decodeError:
            return "데이터를 불러오는데 실패했습니다(디코딩에러)"
        }
    }
}
final class ITunesNetwork {

    static let shared = ITunesNetwork()
    private init() {
        
    }
    func fetchBoxOfficeData(searchText: String) -> Observable<Itunes> {
        /*
        AF.request("https://https://itunes.apple.com/search?term=\(query)&country=KR", method: .get, encoding: URLEncoding(destination: .queryString)).responseString { data in
//            print("response String\(api.typeString)")
            print("data: \(data)")
            print("--------------------------------------------")
        }
        */
  
        return Observable<Itunes>.create { observer in
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchText)&country=KR") else {
                observer.onError(ItunesError.invalidURL)
                print("invalidURL")
                return Disposables.create()
            }
            // User-Agent변경
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("XYZ", forHTTPHeaderField: "User-Agent")
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                print("DataTask Succeed")
                
                if let _ = error { // error가 nil이어야 문제가 없는 것
                    observer.onError(ItunesError.unknownResponse)
                    print("unknownResponse")
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    observer.onError(ItunesError.statusError)
                    print("Response Error")
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(Itunes.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted() // 중첩 구독을 막기 위해
                } else {
                    print("응답은 왔으나 디코딩 실패")
                    observer.onError(ItunesError.decodeError)
                }
            }.resume()
            
            return Disposables.create()
            
        }

        
    }
}
