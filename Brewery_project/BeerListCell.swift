//
//  BeerListCell.swift
//  Brewery_project
//
//  Created by mac on 2022/05/04.
//


import UIKit
import SnapKit
import Kingfisher

protocol ReuseableView {
    static var resuseIdentifier : String { get }
}

class BeerListCell : UITableViewCell {
    
    static let identifier = "BeerListCell"
    
    let imageLiteral = #imageLiteral(resourceName: "beer_icon")
    let beerImageView = UIImageView()
    let namelabel = UILabel()
    let taglineLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        [beerImageView,namelabel,taglineLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImageView.contentMode = .scaleToFill
        
        namelabel.font = .systemFont(ofSize: 18 , weight: .bold)
        namelabel.numberOfLines = 2
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .regular)
        taglineLabel.textColor = .blue
        taglineLabel.numberOfLines = 0
        
        
        beerImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        namelabel.snp.makeConstraints { make in
            make.leading.equalTo(beerImageView.snp.trailing).offset(12)
            make.bottom.equalTo(beerImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(namelabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(namelabel)
            
        }
        
    }
    
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "" )
        beerImageView.kf.setImage(with: imageURL, placeholder: imageLiteral)
        namelabel.text = beer.name ?? "unknwon Beer"
        taglineLabel.text = beer.tagLine
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
    }
    
}

extension BeerListCell {
    
    static var reuseIdentifier : String {
        return String(describing: self)
    }
    
}
