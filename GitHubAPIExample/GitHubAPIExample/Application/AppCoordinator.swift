//
//  AppCoordinator.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

final class AppCoordinator {

    private let appDIContainer: AppDIContainer
    
    public var gitUserSceneDiContainer: GitUserSceneDIContainer!
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }

}

extension AppCoordinator{
    
    func start(window: UIWindow) {
        
        gitUserSceneDiContainer = appDIContainer.createGitUserSceneDIContainer()
        let gitUserSceneCoordinator = gitUserSceneDiContainer.createGitUserSceneCoordinator()
        
        gitUserSceneCoordinator.start(window: window)
    }
    
}
