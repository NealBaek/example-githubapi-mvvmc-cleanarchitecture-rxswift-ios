//
//  ReachabilityManager.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import Alamofire
import RxSwift

public final class ReachabilityManager: NSObject {

    public static let shared = ReachabilityManager()
    public let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return reachSubject.asObservable()
    }

    override init() {
        super.init()
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
        
            switch status {
            case .notReachable:
                self.reachSubject.onNext(false)
            case .reachable(.ethernetOrWiFi):
                self.reachSubject.onNext(true)
            case .reachable(.cellular):
                self.reachSubject.onNext(true)
            case .unknown:
                self.reachSubject.onNext(false)
            }
        })
    }
    
    public func observeNetConn() -> Observable<Bool> {

        let subject = PublishSubject<Bool>().asObserver()

        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
            
            switch status {
            case .reachable( .ethernetOrWiFi), .reachable(.cellular):
                subject.onNext(true)
            default:
                subject.onNext(false)
            }

        })

        return subject
    }
}
