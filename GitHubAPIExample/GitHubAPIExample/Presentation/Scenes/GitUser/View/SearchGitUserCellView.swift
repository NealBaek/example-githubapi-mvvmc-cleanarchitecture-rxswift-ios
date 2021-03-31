//
//  SearchGitUserCellView.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import SnapKit
import Then

final class SearchGitUserCellView: BaseSnapKitContainerUIView{

    public let avatarImageView: UIImageView = UIImageView.init(image: UIImage()).then{
        $0.contentMode = .scaleAspectFit
    }
    public let userNameLabel: UILabel = UILabel().then{
        $0.textAlignment = .left
        $0.textColor = UIColor.black()
        
    }
    public let repoCountLabel: UILabel = UILabel().then{
        $0.textAlignment = .left
        $0.textColor = UIColor.lightGray()
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.text = "Number of repos: ..."
    }
    
    
    override func initViews() {
        backgroundColor = UIColor.white()
    }

    override func addSubViews() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        addSubview(repoCountLabel)
        
    }

    override func addConstraints(_ superViewWidth: CGFloat, _ superViewHeight: CGFloat){

        avatarImageView.snp.makeConstraints{
            $0.width.height.equalTo(60)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        userNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        repoCountLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
    }
}
