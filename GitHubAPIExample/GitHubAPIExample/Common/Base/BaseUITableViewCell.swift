//
//  BaseUITableViewCell.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import RxSwift

class BaseUITableViewCell: UITableViewCell {
  
    public var baseDisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        baseDisposeBag = DisposeBag()
    }
    
    deinit {
        baseDisposeBag = DisposeBag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    internal func setupViews(){}
}
