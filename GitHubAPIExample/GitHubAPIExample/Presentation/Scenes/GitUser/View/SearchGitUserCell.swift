//
//  SearchGitUserCell.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa

final class SearchGitUserCell: BaseUITableViewCell{
    
    private var viewModel: SearchGitUserCellViewModelDelegate?
    
    public static let identifier = "SearchGitUserCell"

    public let containerView = SearchGitUserCellView()
    public var updateDone = PublishRelay<[GitRepoEntity]>.init()
    public var item: GitUserEntity! {
        didSet {
            containerView.userNameLabel.text = item.login
            containerView.avatarImageView.kf.setImage(with: try? item.avatarUrl.asURL())
            
            if item.repoUpdateDone {
                containerView
                    .repoCountLabel.text = "Number of repos: \(item.repoList.count)"
            }else {
                containerView
                    .repoCountLabel.text = "Number of repos: ..."
            }
        }
    }
    
    override func setupViews() {
        addSubview(containerView)

        selectionStyle = .none
    }
    
    public func bind(to viewModel: SearchGitUserCellViewModelDelegate){
        self.viewModel = viewModel
        
        viewModel
            .gitRepoData.list
            .bind{ [weak self] list in
                
                guard let self = self else{ return }
                guard !self.item.repoUpdateDone else { return }
                
                self.viewModel?.getGitRepoList(
                    username: self.item.login,
                    pagenation: list.count > 0 ? .next : .none
                )
            }.disposed(by: baseDisposeBag)
        
        viewModel
            .updateDone
            .bind{ [weak self] list in
                
                self?.containerView
                    .repoCountLabel.text = "Number of repos: \(list.count)"
                
                self?.item.repoList = list
                
                self?.updateDone.accept(list)
                
            }.disposed(by: baseDisposeBag)
        
    }
}
