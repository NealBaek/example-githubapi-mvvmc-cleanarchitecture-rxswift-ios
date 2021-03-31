//
//  WebAPI.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import Moya
import RxSwift
import SwiftyJSON

final class WebAPI<T> where T: Moya.TargetType {
    
    fileprivate let onlineObserver: Observable<Bool> = ReachabilityManager.shared.reach
    fileprivate let provider: MoyaProvider<T>

    init() {
        provider = MoyaProvider<T>()
    }
  
    func request(_ target: T) -> Single<Response> {
        let req = self.provider.rx.request(target)
        
        return onlineObserver.take(1)
          .flatMap { isOnline in
            
            
            
            return req
              .flatMap({ response in
                
                return Single.create{ single in
                    
                    switch response.statusCode {
                    case 200: single(.success(response))
                    default:
                        if let msg =
                            JSON(response.data)
                            .dictionaryObject?["message"] as? String{
                            print("GitHub API: \(msg)")
                        }
                    }
                    
                    return Disposables.create()
                }
              })
        }.asSingle()
    }
}
