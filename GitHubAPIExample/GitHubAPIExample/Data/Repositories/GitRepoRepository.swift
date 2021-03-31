//
//  GitRepoRepository.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift

final class GitRepoRepository {

    private let service: WebAPI<GitHubAPI>
    
    private var disposeBag = DisposeBag()
    
    init(service: WebAPI<GitHubAPI>) {
        self.service = service
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}

extension GitRepoRepository: GitRepoRepositoryDelegate {
    
    public func fetchGitRepoList(username: String, page: Int, perPage: Int) -> Single<[GitRepoEntity]> {
        
        return Single.create{ [weak self] single in
            
            if let self = self {
                self.service.request(.repoList(username: username, page: page, perPage: perPage))
                    .filterSuccessfulStatusCodes()
                    .map([GitRepoListResponseDTO].self)
                    .subscribe { dto in
                        
                        single(.success(dto.map{$0.toEntity()}))
                        
                    } onError: { error in
                        single(.error(error))
                    }.disposed(by: self.disposeBag)
            }
            
            return Disposables.create()
        }

    }
    
}
