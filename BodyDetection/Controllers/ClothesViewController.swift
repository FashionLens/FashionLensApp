//
//  ClothesViewController.swift
//  BodyDetection
//
//  Created by Lucas Yim on 10/22/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class ClothesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! CollectionViewCell
        
        print("got here")
        cell.configure(imageString: "fashion_lens_logo")
        
        return cell
    }
    

    var collectionView: UICollectionView!
    var images:[String] = ["","","","","","","","","","","",""]
    let reuse = "reuse"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("asdfsadf")
        print("\n\n\n\n")
        view.backgroundColor = .white
        let charLayout = UICollectionViewFlowLayout()
        charLayout.scrollDirection = .vertical
        charLayout.minimumLineSpacing = 2
        charLayout.minimumInteritemSpacing = 2
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: charLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuse)
        
        collectionView.backgroundColor = .yellow
        view.addSubview(collectionView)
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
    
    

}
