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
    var cgImage: CGImage!
    
    override func viewDidLoad() {
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        super.viewDidLoad()
        
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
        cell.backgroundColor = UIColor.whiteColor()
        
        var err: NSError? = nil
        let asset = AVURLAsset(URL: NSURL(fileURLWithPath: "\(cell.videoURL)"), options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
        } catch {
            print(err)
        }
        
        // !! check the error before proceeding
        let uiImage = UIImage(CGImage: cgImage)
        cell.cellImage.image = uiImage
        // lay out this image view, or if it already exists, set its image property to uiImage
        
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
