//
//  BaseUIViewController.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import RxSwift

class BaseUIViewController: UIViewController{
  
  internal var baseDisposeBag = DisposeBag() /// deinit (only)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white()
    
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    
  }
  
  deinit {
    baseDisposeBag = DisposeBag()
  }
  
  internal func setupViews(){}
}

// MARK: Style
extension BaseUIViewController{
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

// MARK: Present
extension BaseUIViewController{
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    viewControllerToPresent.modalPresentationStyle = .fullScreen
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
}

// MARK: Gesture
extension BaseUIViewController : UIGestureRecognizerDelegate{
  
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     if touches.first != nil { self.view.endEditing(true) }
     super.touchesBegan(touches, with: event)
   }
   
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    if gestureRecognizer is UITapGestureRecognizer { return false }
     return (gestureRecognizer is UIScreenEdgePanGestureRecognizer)
   }
   
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     return true
   }
}
