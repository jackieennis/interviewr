//
//  VideoRecorderViewController.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/3/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoRecorderViewController: UIViewController, AVCaptureFileOutputRecordingDelegate{
    @IBOutlet weak var cameraButton: UIButton!
    
    let captureSession = AVCaptureSession()
    var currentDevice: AVCaptureDevice?
    var videoFileOutput: AVCaptureMovieFileOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        // Preset the session for taking photo in full resolution
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        // Get the available devices that is capable of taking video
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as!
            [AVCaptureDevice]
        // Get the front-facing camera for taking videos
        for device in devices {
            if device.position == AVCaptureDevicePosition.Front {
                currentDevice = device
            }
        }
        let captureDeviceInput: AVCaptureDeviceInput
        do {
            captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
        } catch {
            print(error)
            return
        }
        
        // Configure the session with the output for capturing video
        videoFileOutput = AVCaptureMovieFileOutput()
        
        // Configure the session with the input and the output devices
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(videoFileOutput)
        
        // Provide a camera preview
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        // Bring the camera button to front
        view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
        
        // Provide a camera preview
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        // Bring the camera button to front
        view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func capture(sender: AnyObject) {
        if !isRecording {
            isRecording = true
            UIView.animateWithDuration(0.5, delay: 0.0, options: [.Repeat,
                .Autoreverse, .AllowUserInteraction], animations: { () -> Void in
                    self.cameraButton.transform = CGAffineTransformMakeScale(0.5, 0.5)
                }, completion: nil)
            let outputPath = NSTemporaryDirectory() + "output.mov"
            let outputFileURL = NSURL(fileURLWithPath: outputPath)
            videoFileOutput?.startRecordingToOutputFileURL(outputFileURL, recordingDelegate: self)
        } else {
            isRecording = false
            
            UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations: {
                () -> Void in
                self.cameraButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
            cameraButton.layer.removeAllAnimations()
            videoFileOutput?.stopRecording()
        }
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!,
                       didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections
        connections: [AnyObject]!, error: NSError!) {
        if error != nil {
            print(error)
            return
        }
        performSegueWithIdentifier("playVideo", sender: outputFileURL)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideo" {
            let videoPlayerViewController = segue.destinationViewController as!
            AVPlayerViewController
            let videoFileURL = sender as! NSURL
            videoPlayerViewController.player = AVPlayer(URL: videoFileURL)
        }
    }
    
    @IBAction func unwindToCamera(segue:UIStoryboardSegue) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


