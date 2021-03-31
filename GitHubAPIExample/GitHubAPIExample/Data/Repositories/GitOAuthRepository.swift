//
//  GitOAuthRepository.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift
import SwiftyJSON

final class GitOAuthRepository {

    private let service: WebAPI<GitHubAPI>
    
    private var disposeBag = DisposeBag()
    
    init(service: WebAPI<GitHubAPI>) {
        self.service = service
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}

extension GitOAuthRepository: GitOAuthRepositoryDelegate {
    
    public func fetchOAuth(clientId: String, clientSecret: String, code: String) -> Single<GitOAuthEntity> {
        
        return Single.create{ [weak self] single in
            
            if let self = self {
                self.service.request(.oauth(clientId: clientId, clientSecret: clientSecret, code: code))
                    .filterSuccessfulStatusCodes()
                    .map(GitOAuthResponseDTO.self)
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
