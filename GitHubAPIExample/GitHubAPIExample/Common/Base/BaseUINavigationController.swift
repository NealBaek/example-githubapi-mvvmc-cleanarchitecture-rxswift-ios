//
//  BaseUINavigationController.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

class BaseUINavigationController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .default
  }
  
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    viewControllerToPresent.modalPresentationStyle = .fullScreen
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    interactivePopGestureRecognizer?.isEnabled = true
    super.pushViewController(viewController, animated: animated)
  }
}
