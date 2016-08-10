////
////  VideoPickerViewController.swift
////  interviewr
////
////  Created by Jackie Ennis on 8/3/16.
////  Copyright © 2016 Jackie Ennis. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//
//private let reuseIdentifier = "Cell"
//
//class VideoPickerViewController: UICollectionViewController {
//    //var interviewTitles = [String]()
//   
//    var interviewTitles = ["test 1", "test 2", "test 3"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
////        self.collectionView!.registerClass(VideoPickerCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        layoutCells()
//        
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Register cell classes
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        /*if segue.identifier == "playVideo" {
//            let videoPlayerViewController = segue.destinationViewController as!
//            AVPlayerViewController
//            let videoFileURL = sender as! NSURL
//            videoPlayerViewController.player = AVPlayer(URL: videoFileURL)
//        }*/
//     }
//    
//    // MARK: UICollectionViewDataSource
//    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        //Return the number of sections
//        return 1
//    }
//    
//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //Return the number of items
//        return 5 //interviewTitles.count
//    }
//    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        
//        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VideoPickerCollectionViewCell
//        
//        // Configure the cell
//        //cell.interviewTitleLabel.text = "kenken"
//
////        let label = UILabel()
////        label.frame = CGRect(x: 50, y: 50, width: 100, height: 30)
////        label.text = "poops"
////        cell.contentView.addSubview(label)
//        
//        
////        cell.backgroundColor = UIColor.whiteColor()
////        print(cell.description)
////        cell.labe.textColor = UIColor.redColor()
////        print("X \(cell.labe.center.x)")
////        //interviewTitles[indexPath.row]
////        
////        return cell
//    }
//    
//    func layoutCells() {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//        layout.minimumInteritemSpacing = 5.0
//        layout.minimumLineSpacing = 5.0
//        layout.itemSize = CGSize(width: (UIScreen.mainScreen().bounds.size.width - 40)/3, height: ((UIScreen.mainScreen().bounds.size.width - 40)/3))
//        collectionView!.collectionViewLayout = layout
//    }
//    
//    // MARK: UICollectionViewDelegate
//    
//    /*
//     // Uncomment this method to specify if the specified item should be highlighted during tracking
//     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//     return true
//     }
//     */
//    
//    /*
//     // Uncomment this method to specify if the specified item should be selected
//     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//     return true
//     }
//     */
//    
//    /*
//     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//     return false
//     }
//     
//     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
//     return false
//     }
//     
//     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
//     
//     }
//     */
//    
//}
