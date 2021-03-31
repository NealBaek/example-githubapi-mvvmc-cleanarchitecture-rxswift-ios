//
//  UIViewController.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

extension UIViewController{
    
    // MARK: Alert
    func showAlert(title: String, msg: String, yesTitle: String, noTitle: String? = nil, yesHandler: (() -> Void)? = nil, noHandler: (() -> Void)? = nil){
      
      let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
      
      let actionYes = UIAlertAction(title: yesTitle, style: .default, handler: { alertAction in yesHandler?() })
      alert.addAction(actionYes)
      
      
      if let noTitle = noTitle{
        let actionNo = UIAlertAction(title: noTitle, style: .destructive, handler: { alertAction in noHandler?() })
        alert.addAction(actionNo)
      }
      
      present(alert, animated: true, completion: nil)
      
    }
    
}
