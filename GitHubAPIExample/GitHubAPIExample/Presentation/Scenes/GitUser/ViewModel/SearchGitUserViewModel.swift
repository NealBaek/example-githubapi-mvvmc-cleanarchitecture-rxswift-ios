//
//  SearchGitUserViewModel.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift
import RxCocoa

protocol SearchGitUserViewModelDelegate {
    var gitUserData: (page: Int, list: BehaviorRelay<[GitUserEntity]>) { get }
    var isTableViewHidden: PublishRelay<Bool> { get }
    var error: PublishSubject<NSError> { get }
    
    func doGitOAuthLogin(clientId: String)
    func getGitOAuth(clientId: String, clientSecret: String, code: String)
    
    func searchGitUser(username: String, pagenation: SearchGitUserViewModel.Pagenation)
    func checkPagenation(indexPathList: [IndexPath])->SearchGitUserViewModel.Pagenation
    func resetSearch()
    
}

final class SearchGitUserViewModel: SearchGitUserViewModelDelegate{
    
    private let fetchGitOAuthUseCase: FetchGitOAuthUseCaseDelegate
    private let searchGitUserUseCase: SearchGitUserUseCaseDelegate
    
    private var disposeBag = DisposeBag()
    
    public var gitUserData = (page: 1, list: BehaviorRelay(value: [GitUserEntity]()))
    public var isTableViewHidden = PublishRelay<Bool>()
    public let error = PublishSubject<NSError>()
    
    public enum Pagenation{
        case next
        case none
    }
    
    private enum Const: Int{
        case perPage = 20
        case pagenationIndex = 5
    }
    
    init(
        fetchGitOAuthUseCase: FetchGitOAuthUseCaseDelegate,
        searchGitUserUseCase: SearchGitUserUseCaseDelegate) {
        
        self.fetchGitOAuthUseCase = fetchGitOAuthUseCase
        self.searchGitUserUseCase = searchGitUserUseCase
        
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
}

// MARK: - GitOAuth
extension SearchGitUserViewModel{
    
    public func doGitOAuthLogin(clientId: String){
        if let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientId)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    public func getGitOAuth(clientId: String, clientSecret: String, code: String){
        
        fetchGitOAuthUseCase
            .execute(clientId: clientId, clientSecret: clientSecret, code: code)
            .subscribe { oauth in
                
                UserDefaults.setValue(data: "\(oauth.tokenType) \(oauth.accessToken)", key: .accessToken)
                
            } onError: { [weak self] error in
                self?.error.onNext(error.asNSError())
            }.disposed(by: disposeBag)

    }
}

// MARK: - SearchGitUser
extension SearchGitUserViewModel{
    
    public func searchGitUser(username: String, pagenation: Pagenation){
        
        guard !username.isEmpty else { return }
        
        var toPage = gitUserData.page
        
        if case .next = pagenation {
            toPage += 1
        }else {
            toPage = 1
        }
        
        searchGitUserUseCase
            .execute(username: username, page: toPage, perPage: Const.perPage.rawValue)
            .subscribe { [weak self] list in
                
                guard let self = self else { return }
                
                self.isTableViewHidden.accept(list.count == 0)
                
                guard list.count > 0 && toPage > 1 else {
                    self.updateGitUserData(list: list, page: toPage)
                    return
                }
                
                var copied = self.gitUserData.list.value
                copied.append(contentsOf: list)
                
                self.updateGitUserData(list: copied, page: toPage)
                
            } onError: { [weak self] error in
                self?.error.onNext(error.asNSError())
            }.disposed(by: disposeBag)
    }
    
    private func updateGitUserData(list: [GitUserEntity], page: Int){
        gitUserData.list.accept(list)
        gitUserData.page = page
    }
    
    public func checkPagenation(indexPathList: [IndexPath])->Pagenation{
        
        let gitUserCount = gitUserData.list.value.count

        let indexPathCount = indexPathList.count
        
        for i in 0..<indexPathCount{
            let indexPath = indexPathList[i]
            
            if indexPath.row == (gitUserCount - Const.pagenationIndex.rawValue) {
                
                guard gitUserCount/Const.perPage.rawValue >= gitUserData.page else {
                    continue
                }

                return .next
            }
        }
        
        return .none
    }
    
    public func resetSearch(){
        self.gitUserData.list.accept([])
        self.gitUserData.page = 1
        self.isTableViewHidden.accept(true)
    }
}
