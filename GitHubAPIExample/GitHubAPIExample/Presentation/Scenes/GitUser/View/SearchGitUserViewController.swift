//
//  SearchGitUserViewController.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class SearchGitUserViewController: BaseUIViewController {
    
    private var containerView: SearchGitUserView!
    private var viewModel: SearchGitUserViewModelDelegate!
    
    
    static func create(viewModel: SearchGitUserViewModelDelegate, containerView: SearchGitUserView) -> SearchGitUserViewController {
        return SearchGitUserViewController().then{
            $0.viewModel = viewModel
            $0.containerView = containerView
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel, with: baseDisposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        guard UserDefaults
                .getValue(defaultValue: "", key: .accessToken)
                .isEmpty else { return }
        
        viewModel
            .doGitOAuthLogin(clientId: AppConfigs.clientId.rawValue)
    }
    
    override func setupViews() {
        super.setupViews()
        
        navigationItem.titleView = containerView.searchBar
        view.addSubview(containerView)
    }
    
    private func bind(to viewModel: SearchGitUserViewModelDelegate, with disposeBag: DisposeBag){
        
        Application
            .shared
            .gitHubUrlScheme
            .subscribe(onNext: { [weak self] code in
            
                guard let self = self else { return }
            
                self.viewModel
                    .getGitOAuth(
                        clientId: AppConfigs.clientId.rawValue,
                        clientSecret: AppConfigs.clientSecret.rawValue,
                        code: code)
            
            }).disposed(by: disposeBag)
        
        containerView.searchBar
            .rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] searchQuery in
                
                guard let self = self else { return }
                
                let name = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard !name.isEmpty else {
                    self.viewModel.resetSearch()
                    return
                }
                self.viewModel.searchGitUser(username: name, pagenation: .none)
                
            }).disposed(by: disposeBag)
        
        containerView.searchBar
            .rx.searchButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.view.endEditing(true)
            }).disposed(by: disposeBag)
        
        viewModel
            .isTableViewHidden
            .bind{ [weak self] isHidden in
                self?.containerView.tableView.isHidden = isHidden
                self?.containerView.noListLabel.isHidden = !isHidden
            }.disposed(by: disposeBag)
        
        
        viewModel
            .gitUserData.list
            .bind{ [weak self] list in
                self?.viewModel.isTableViewHidden.accept(list.count == 0)
            }.disposed(by: disposeBag)

        
        viewModel
            .gitUserData.list
            .bind(to: containerView.tableView.rx.items(
                cellIdentifier: SearchGitUserCell.identifier,
                cellType: SearchGitUserCell.self)) { index, entity, cell in

                let viewModel = Application.shared.appCoordinator!
                    .gitUserSceneDiContainer
                    .createSearchGitUserCellViewModel()
                
                cell.item = entity
                cell.bind(to: viewModel)
                cell.updateDone.bind{ [weak self] list in
                    guard let self = self else { return }
                    
                    var copied = self.viewModel.gitUserData.list.value
                    
                    guard copied.count > index else { return }
                    
                    var item = copied[index]
                    item.repoList = list
                    item.repoUpdateDone = true
                    
                    copied[index] = item
                    
                    self.viewModel.gitUserData.list.accept(copied)
                    
                }.disposed(by: cell.baseDisposeBag)
                
            }.disposed(by: disposeBag)
        
        
        containerView.tableView
            .rx.prefetchRows.subscribe(onNext: { [weak self] indexPathList in

                guard let self = self else { return }

                if case .next = self.viewModel.checkPagenation(indexPathList: indexPathList) {
                    guard let name = self.containerView.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                        return
                    }

                    self.viewModel.searchGitUser(username: name, pagenation: .next)
                }

            }).disposed(by: disposeBag)
        
        
        viewModel
            .error
            .subscribe(onNext: { error in
                print(error)
            }).disposed(by: disposeBag)
    }


}
