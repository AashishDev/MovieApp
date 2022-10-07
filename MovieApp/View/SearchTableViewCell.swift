//
//  SearchTableViewCell.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/9/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = 8.0
        iconImageView.backgroundColor = UIColor.lightGray
        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
        iconImageView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movie:Movie) {
        iconImageView.loadImage(with: movie.postImageUrl)
        title.text = movie.title
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        self.selectedBackgroundView = backgroundView
    }
}
