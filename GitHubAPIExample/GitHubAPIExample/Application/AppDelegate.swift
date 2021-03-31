//
//  AppDelegate.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        Application.shared.start(with: window!)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let scheme = url.scheme,
           scheme == "nealbaekgithubapiexampleapp",
           let query = url.query,
           let code = query.split(separator: "=").last {
            
            Application
                .shared
                .gitHubUrlScheme
                .onNext(String(code))
        }
        
        return false
    }
}

