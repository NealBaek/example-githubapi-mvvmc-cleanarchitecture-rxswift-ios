//
//  AppDIContainer.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

final class AppDIContainer {
    
    // MARK: - Services
    private let gitUserService = WebAPI<GitHubAPI>()
    
}

extension AppDIContainer{
    
    // MARK: - DIContainers
    func createGitUserSceneDIContainer() -> GitUserSceneDIContainer {
        return GitUserSceneDIContainer(
            dependencies: .init(service: gitUserService)
        )
    }
    
}
