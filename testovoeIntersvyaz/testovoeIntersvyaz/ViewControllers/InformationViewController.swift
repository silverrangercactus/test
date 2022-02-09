//
//  InformationViewController.swift
//  testovoeIntersvyaz
//
//  Created by Fedor Boriskin on 09.02.2022.
//

import UIKit

class InformationViewController: UIViewController {

    var image: UIImage
    
    var titlePhoto: String
    
    init(image: UIImage, title: String) {
        self.image = image
        self.titlePhoto = title
        super.init(nibName: nil, bundle: nil)
    }
       
    required init(coder: NSCoder) {
        fatalError()
    }
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 20)
        return textLabel
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.backgroundColor = .purple
        shareButton.setTitle("Share photo", for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.layer.masksToBounds = true
        shareButton.layer.cornerRadius = 10
        shareButton.addTarget(self, action: #selector(sharePhoto), for: .touchUpInside)
        return shareButton
    }()
    
    @objc func sharePhoto(){
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        setupUI()
        imageView.image = image
        textLabel.text = titlePhoto
    }
    
    
    func setupUI() {
        view.addSubview(imageView)
        view.addSubview(textLabel)
        view.addSubview(shareButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
   

}
