//
//  Application.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import Foundation

import Kingfisher
import RxSwift

final class Application {
  
    public static let shared = Application()
  
    private init(){}
    
    private var disposeBag = DisposeBag()
    private let appDIContainer = AppDIContainer()
    
    public var appCoordinator: AppCoordinator!
    public var gitHubUrlScheme = PublishSubject<String>()
    
    func start(with window: UIWindow){
        
        // start coordinator
        appCoordinator = .init(appDIContainer: appDIContainer)
        appCoordinator?.start(window: window)

        // KingFisher SetUp
        ImageCache.default.diskStorage.config.sizeLimit = UInt(50 * 1024 * 1024)
        ImageCache.default.diskStorage.config.expiration = .days(7)
        ImageDownloader.default.downloadTimeout = 15.0


        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        checkNetwork(disposeBag: disposeBag)
    }

  
    @objc private func willEnterForeground(){
        disposeBag = DisposeBag()
        checkNetwork(disposeBag: disposeBag)
    }
  
    
    private func checkNetwork(disposeBag: DisposeBag){
        // 네트워크 연결 확인
        ReachabilityManager.shared.observeNetConn().subscribe(onNext: {  isConn in

              guard !isConn else { return }

              UIApplication.topViewController()?.showAlert(
                  title: "경고",
                  msg: "와이파이 상태 확인",
                  yesTitle: "설정",
                  yesHandler: { UIApplication.openSettingUrl() }
              )

            }).disposed(by: disposeBag)
    }
}

