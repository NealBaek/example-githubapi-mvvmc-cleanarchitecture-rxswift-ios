//
//  FetchGitOAuthUseCase.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift

protocol FetchGitOAuthUseCaseDelegate {
    func execute(clientId: String, clientSecret: String, code: String) -> Single<GitOAuthEntity>
}

final class FetchGitOAuthUseCase: FetchGitOAuthUseCaseDelegate {

    private let repository: GitOAuthRepositoryDelegate

    init(repository: GitOAuthRepositoryDelegate) {

        self.repository = repository
    }

}

extension FetchGitOAuthUseCase{
    public func execute(clientId: String, clientSecret: String, code: String) -> Single<GitOAuthEntity>{
        return repository.fetchOAuth(clientId: clientId, clientSecret: clientSecret, code: code)
    }
}
