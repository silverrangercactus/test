//
//  ViewController.swift
//  testovoeIntersvyaz
//
//  Created by Fedor Boriskin on 08.02.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var photosArray: [Cartoons] = []

    private var photoCollectianView: UICollectionView = {
        let layuot = UICollectionViewFlowLayout()
        let photoCollectianView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        photoCollectianView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self))
        return photoCollectianView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupCollectionView()
        
        NetworkService.shared.startURLSessionDataTask { cartoon in
            DispatchQueue.main.async {
                self.photosArray = cartoon
                self.photoCollectianView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

    }
    
    private func setupCollectionView() {
        photoCollectianView.dataSource = self
        photoCollectianView.delegate = self
        view.addSubview(photoCollectianView)
        
        photoCollectianView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            photoCollectianView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollectianView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectianView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollectianView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectianView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
        
        if let url = URL(string: self.photosArray[indexPath.row].thumbnailURL) {
            cell.photoMy.loadImage(imageURL: url)
            }
        return cell
    }

    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 8 * 4) / 3, height: (collectionView.frame.width - 8 * 4) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(8), left: CGFloat(8), bottom: CGFloat(8), right: CGFloat(8))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8)
    }

}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: self.photosArray[indexPath.row].url) else { return }
        
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                let photoTitle = self.photosArray[indexPath.row].title
                let datailView = InformationViewController(image: image, title: photoTitle)
                navigationController?.pushViewController(datailView, animated: true)
            }
        }
    }
}
