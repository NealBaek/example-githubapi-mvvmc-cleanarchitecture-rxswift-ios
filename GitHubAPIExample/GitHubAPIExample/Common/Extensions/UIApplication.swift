//
//  UIApplication.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

extension UIApplication{
    
    public static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
       if let navigationController = controller as? UINavigationController {
           return topViewController(controller: navigationController.visibleViewController)
       }
       if let tabController = controller as? UITabBarController {
           if let selected = tabController.selectedViewController {
               return topViewController(controller: selected)
           }
       }
       if let presented = controller?.presentedViewController {
           return topViewController(controller: presented)
       }
       return controller
    }

    public static func openSettingUrl(){
        if let url = URL(string:UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
