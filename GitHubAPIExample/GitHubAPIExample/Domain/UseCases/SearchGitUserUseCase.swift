//
//  SearchGitUserUseCase.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift

protocol SearchGitUserUseCaseDelegate {
    func execute(username: String, page: Int, perPage: Int) -> Single<[GitUserEntity]>
}

final class SearchGitUserUseCase: SearchGitUserUseCaseDelegate {

    private let repository: GitUserRepositoryDelegate

    init(repository: GitUserRepositoryDelegate) {

        self.repository = repository
    }

}

extension SearchGitUserUseCase{
    public func execute(username: String, page: Int, perPage: Int) -> Single<[GitUserEntity]>{
        return repository.searchGitUser(username: username, page: page, perPage: perPage)
    }
}

