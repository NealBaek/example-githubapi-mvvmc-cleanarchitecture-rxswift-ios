//
//  GitUserRepository.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift
import SwiftyJSON

final class GitUserRepository {

    private let service: WebAPI<GitHubAPI>
    
    private var disposeBag = DisposeBag()
    
    init(service: WebAPI<GitHubAPI>) {
        self.service = service
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}

extension GitUserRepository: GitUserRepositoryDelegate {
    
    public func searchGitUser(username: String, page: Int, perPage: Int) -> Single<[GitUserEntity]> {
        
        return Single.create{ [weak self] single in
            
            if let self = self {
                self.service.request(.searchUser(username: username, page: page, perPage: perPage))
                    .filterSuccessfulStatusCodes()
                    .map(SearchGitUserResponseDTO.self)
                    .subscribe { dto in
                        
                        single(.success(dto.toEntity()))
                        
                    } onError: { error in
                        single(.error(error))
                    }.disposed(by: self.disposeBag)
            }
            
            return Disposables.create()
        }

    }
    
}
