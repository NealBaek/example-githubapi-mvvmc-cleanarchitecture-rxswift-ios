//
//  Reactive.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift
import RxCocoa
import RxGesture

extension Reactive where Base: UIView {
    func tap() -> Observable<UITapGestureRecognizer> {
      return tapGesture().when(.recognized).throttle(.seconds(1), scheduler: MainScheduler.instance)
    }
}
