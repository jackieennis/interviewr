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

private let reuseIdentifier = "Default"

class VidCollectionViewController: UICollectionViewController {
    
    var selectedIndexPath: Int?
    var ourPlayer: AVPlayer!
    var screenWidth: CGFloat!
    var screenSize: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenWidth = screenSize.width
        screenSize = UIScreen.mainScreen().bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        print(VideoRecorderViewController.interviewTitlesArray)
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndexPath = indexPath.item
        print(selectedIndexPath)
//        let videoURL = VideoRecorderViewController.allRecordingsArray[indexPath.row]
        performSegueWithIdentifier("playVideolol", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideolol" {
            let videoPlayerViewController = segue.destinationViewController as! AVPlayerViewController
            //let url = sender as! NSURL
            //print("\(url)")
            print(VideoRecorderViewController.allRecordingsArray)
            print(selectedIndexPath)
            let videoURL = VideoRecorderViewController.allRecordingsArray[selectedIndexPath!]
            ourPlayer = AVPlayer(URL: videoURL)
            videoPlayerViewController.player = ourPlayer
        }
    
    }

    // MARK: UICollectionViewDataSource

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
        print(VideoRecorderViewController.interviewTitlesArray.count)
        print(VideoRecorderViewController.allRecordingsArray.count)
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
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
