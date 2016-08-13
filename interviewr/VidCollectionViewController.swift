//
//  VidCollectionViewController.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/9/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreMedia

private let reuseIdentifier = "Default"

class VidCollectionViewController: UICollectionViewController {
    
    var selectedIndexPath: Int?
    var ourPlayer: AVPlayer!
    var screenWidth: CGFloat!
    var screenSize: CGRect!
    
    var newThumbNailArray = [UIImageView]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
        layout.minimumInteritemSpacing = 5; // this number could be anything <=5. Need it here because the default is 10.
        layout.itemSize = CGSizeMake((self.collectionView!.frame.size.width - 20)/3, 100) // 20 is 2*5 for the 2 edges plus 2*5 for the spaces between the cells
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        print(VideoRecorderViewController.interviewTitlesArray)
        //self.collectionView?.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        newThumbNailArray = VideoRecorderViewController.thumbnailsArray
        //self.collectionView?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideolol" {
            let videoPlayerViewController = segue.destinationViewController as! AVPlayerViewController
            print(VideoRecorderViewController.allRecordingsArray)
            print(selectedIndexPath)
            let videoURL = VideoRecorderViewController.allRecordingsArray[selectedIndexPath!]
            ourPlayer = AVPlayer(URL: videoURL)
            videoPlayerViewController.player = ourPlayer
        }
    }
    

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let numberOfItemsInSection = VideoRecorderViewController.interviewTitlesArray.count
        return numberOfItemsInSection
    }

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VidCollectionViewCell
        cell.label.text = VideoRecorderViewController.interviewTitlesArray[indexPath.row]
        cell.videoURL = VideoRecorderViewController.allRecordingsArray[indexPath.row]
        VidCollectionViewCell.thumbnailOutputPath = VideoRecorderViewController.thumbnailOutputPathsArray[indexPath.row]
        print(VideoRecorderViewController.thumbnailsArray[indexPath.row].image)
        print("lolololol",newThumbNailArray)
        //cell.backgroundView?.removeFromSuperview()
        //cell.backgroundView = newThumbNailArray[indexPath.row]
        //cell.backgroundView = VideoRecorderViewController.thumbnailsArray[indexPath.row]
        newThumbNailArray[indexPath.row].frame = cell.bounds
        cell.addSubview(newThumbNailArray[indexPath.row])
        
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndexPath = indexPath.item
        print(selectedIndexPath)
        //        let videoURL = VideoRecorderViewController.allRecordingsArray[indexPath.row]
        performSegueWithIdentifier("playVideolol", sender: self)
    }
    
    
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
}
