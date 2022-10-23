//
//  CommunityViewController.swift
//  BodyDetection
//
//  Created by Richard Luo on 10/22/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    
    var imageData: [String] = [String]()
    var imageCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Community";
        
        // Do any additional setup after loading the view.
        imageData = ["astronaut", "1", "2", "9", "3", "4", "5", "6", "7", "8", "10"]
        
        b1.titleLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        b2.titleLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        b3.titleLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        b4.titleLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        b1.titleLabel!.adjustsFontSizeToFitWidth = true
        b1.titleLabel!.minimumScaleFactor = 0.01
        b2.titleLabel!.adjustsFontSizeToFitWidth = true
        b2.titleLabel!.minimumScaleFactor = 0.01
        b3.titleLabel!.adjustsFontSizeToFitWidth = true
        b3.titleLabel!.minimumScaleFactor = 0.01
        b4.titleLabel!.adjustsFontSizeToFitWidth = true
        b4.titleLabel!.minimumScaleFactor = 0.01
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! GridCellCollectionViewCell
        
        cell.backgroundColor = UIColor.black
        
        var currImage:String = ""
        
        currImage = self.imageData[self.imageCounter]
        
        self.imageCounter += 1
        
        if self.imageCounter >= self.imageData.count {
            self.imageCounter = 0
        }
        cell.image.image = UIImage(named: currImage)
        
        return cell
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width:  self.view.frame.size.width / 3, height:  self.view.frame.size.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
