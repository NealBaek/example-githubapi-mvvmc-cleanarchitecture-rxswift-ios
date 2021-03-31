//
//  BaseSnapKitUIView.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import SnapKit

class BaseSnapKitUIView: UIView {
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    initViews()
    addSubViews()
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    guard let superView = superview else { return }
    
    addConstraints(superView.frame.width, superView.frame.height)
  }
  
  internal func initViews(){
  }
  internal func addSubViews(){}
  internal func addConstraints(_ superViewWidth: CGFloat, _ superViewHeight: CGFloat){}
}


class BaseSnapKitContainerUIView: BaseSnapKitUIView {
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    guard let superView = superview else { return }
    
    snp.makeConstraints {
      $0.top.equalTo(superView.safeAreaLayoutGuide.snp.top)
      $0.bottom.equalTo(superView.safeAreaLayoutGuide.snp.bottom)
      $0.left.equalTo(superView.safeAreaLayoutGuide.snp.left)
      $0.right.equalTo(superView.safeAreaLayoutGuide.snp.right)
    }
  }
  
}
