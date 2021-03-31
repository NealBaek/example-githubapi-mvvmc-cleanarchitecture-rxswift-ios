//
//  FetchGitRepoListUseCase.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift

protocol FetchGitRepoListUseCaseDelegate {
    func execute(username: String, page: Int, perPage: Int) -> Single<[GitRepoEntity]>
}

final class FetchGitRepoListUseCase: FetchGitRepoListUseCaseDelegate {

    private let repository: GitRepoRepositoryDelegate

    init(repository: GitRepoRepositoryDelegate) {

        self.repository = repository
    }

}

extension FetchGitRepoListUseCase{
    public func execute(username: String, page: Int, perPage: Int) -> Single<[GitRepoEntity]>{
        return repository.fetchGitRepoList(username: username, page: page, perPage: perPage)
    }
}
