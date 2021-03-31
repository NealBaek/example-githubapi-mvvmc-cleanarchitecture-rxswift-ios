//
//  GitUserSceneDIContainer.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

final class GitUserSceneDIContainer: GitUserSceneCoordinatorDependency {
    
    struct Dependencies {
        let service: WebAPI<GitHubAPI>
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
}

extension GitUserSceneDIContainer{
    
    // MARK: - Repository
    func createGitOAuthRepository() -> GitOAuthRepositoryDelegate {
        return GitOAuthRepository(service: dependencies.service)
    }
    func createGitUserRepository() -> GitUserRepositoryDelegate {
        return GitUserRepository(service: dependencies.service)
    }
    func createGitRepoRepository() -> GitRepoRepositoryDelegate {
        return GitRepoRepository(service: dependencies.service)
    }
    
    // MARK: - Use Case
    func createFetchGitOAuthUseCase() -> FetchGitOAuthUseCaseDelegate {
        return FetchGitOAuthUseCase(repository: createGitOAuthRepository())
    }
    func createSearchGitUserUseCase() -> SearchGitUserUseCaseDelegate {
        return SearchGitUserUseCase(repository: createGitUserRepository())
    }
    func createFetchGitRepoListUseCase() -> FetchGitRepoListUseCaseDelegate {
        return FetchGitRepoListUseCase(repository: createGitRepoRepository())
    }

    // MARK: ViewModel
    func createSearchGitUserViewModel() -> SearchGitUserViewModelDelegate {
        return SearchGitUserViewModel(
            fetchGitOAuthUseCase: createFetchGitOAuthUseCase(),
            searchGitUserUseCase: createSearchGitUserUseCase()
        )
    }
    func createSearchGitUserCellViewModel() ->
        SearchGitUserCellViewModelDelegate {
        return SearchGitUserCellViewModel(
            fetchGitRepoUseCase: createFetchGitRepoListUseCase()
        )
    }
    
    // MARK: ContainerView
    func createSearchGitUserView() -> SearchGitUserView {
        return SearchGitUserView()
    }
    
    // MARK: ViewController
    func createSearchGitUserViewController() -> SearchGitUserViewController {
        return SearchGitUserViewController.create(
            viewModel: createSearchGitUserViewModel(),
            containerView: createSearchGitUserView()
        )
    }
    
    // MARK: Coordinator
    func createGitUserSceneCoordinator() -> GitUserSceneCoordinator{
        return .init(dependencies: self)
    }
    
}
