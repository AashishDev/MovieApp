//
//  MovieListTableViewCell.swift
//  MovieApp
//
//  Created by Aashish Tyagi on 9/9/22.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    static let identifier = "MovieListTableViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    private var movies:[Movie] = []
    var loadMore:(() -> Void)?
    var isLoading = false
    var selectedItem:((Movie) -> Void)?
    
    var isPopular:Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = UIColor.black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with vm:[Movie], indexPath:IndexPath) {
        self.movies = vm
        isPopular = (indexPath.section == 0)
        self.collectionView.reloadData()
    }
}

extension MovieListTableViewCell:UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NowPlayingCollectionViewCell.identifier,
            for: indexPath) as? NowPlayingCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let movie = self.movies[indexPath.row]
        let title = movie.title
        cell.title.text = title
        
        cell.imageView.layer.cornerRadius = 8.0
        cell.imageView.backgroundColor = UIColor.lightGray
        cell.imageView.loadImage(with: movie.postImageUrl)
        cell.imageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView.layer.borderWidth = 0.5
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isPopular {
            return CGSize(width:250, height: collectionView.frame.size.height)
        } else {
            return CGSize(width:300, height: collectionView.frame.size.height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        if indexPath.row > movies.count-2, !isLoading {
           // print("\n------Load More --------")
            loadMore?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = self.movies[indexPath.row]
        self.selectedItem?(movie)
        // print("Selected Index : \(movie.title)")
    }
    
}
