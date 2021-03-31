//
//  SearchGitUserCellViewModel.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift
import RxCocoa

protocol SearchGitUserCellViewModelDelegate {
    
    var gitRepoData: (page: Int, list: BehaviorRelay<[GitRepoEntity]>) { get }
    var updateDone: PublishRelay<[GitRepoEntity]> { get }
    var error: PublishSubject<NSError> { get }
    
    func getGitRepoList(username: String, pagenation: SearchGitUserCellViewModel.Pagenation)
    
}

final class SearchGitUserCellViewModel: SearchGitUserCellViewModelDelegate{
    
    private let fetchGitRepoUseCase: FetchGitRepoListUseCaseDelegate
    
    private var disposeBag = DisposeBag()
    
    public var gitRepoData = (page: 1, list: BehaviorRelay<[GitRepoEntity]>(value: []))
    public var updateDone = PublishRelay<[GitRepoEntity]>.init()
    
    public let error = PublishSubject<NSError>()
    
    public enum Pagenation{
        case next
        case none
    }
    
    private enum Const: Int{
        case perPage = 100
    }
    
    init(fetchGitRepoUseCase: FetchGitRepoListUseCaseDelegate) {
        self.fetchGitRepoUseCase = fetchGitRepoUseCase
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
}

// MARK: - GitRepoList
extension SearchGitUserCellViewModel{
    
    public func getGitRepoList(username: String, pagenation: Pagenation){

        var toPage = gitRepoData.page
        
        if case .next = pagenation {
            toPage += 1
        }else {
            toPage = 1
        }
        
        fetchGitRepoUseCase
            .execute(username: username, page: toPage, perPage: Const.perPage.rawValue)
            .subscribe { [weak self] list in
                
                guard let self = self else { return }
                
                guard list.count > 0 else {
                    self.updateDone.accept(self.gitRepoData.list.value)
                    return
                }
                
                guard toPage > 1 else {
                    self.updateGitRepoData(list: list, page: toPage)
                    return
                }
                
                var copied = self.gitRepoData.list.value
                copied.append(contentsOf: list)
                
                self.updateGitRepoData(list: copied, page: toPage)
                
            } onError: { [weak self] error in
                self?.error.onNext(error.asNSError())
            }.disposed(by: disposeBag)

    }
    
    private func updateGitRepoData(list: [GitRepoEntity], page: Int){
        gitRepoData.list.accept(list)
        gitRepoData.page = page
    }
}
