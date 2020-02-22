//
//  CaptureVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 13/1/2563 BE.
//  Copyright © 2563 Supanut Laddayam. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

class CaptureVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

//    var bufferSize: CGSize = .zero
//    var rootLayer: CALayer! = nil
//
//    private let session = AVCaptureSession()
//    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
//    private let videoDataOutput = AVCaptureVideoDataOutput()
//    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
//
//    @IBOutlet weak private var previewView: UIView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func captureOutput(_ output: AVCaptureOutput, didOutput samleBuffer: CMSampleBuffer, from commection: AVCaptureConnection){
//
//    }
//
//    func setupAVCapture() {
//        var deviceInput: AVCaptureDeviceInput!
//
//        //select a video device, make an input
//        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
//
//        do{
//            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
//        } catch {
//            print("could not create video device input:\(error)")
//        }
//
//        session.beginConfiguration()
//        session.sessionPreset = .vga640x480
//
//        //add a video input
//        guard session.canAddInput(deviceInput) else {
//            print("could not add video device input to the session")
//            session.commitConfiguration()
//            return
//        }
//        session.addInput(deviceInput)
//        if session.canAddOutput(videoDataOutput) {
//            session.addOutput(videoDataOutput)
//            //add a video data output
//            videoDataOutput.alwaysDiscardsLateVideoFrames = true
//            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String:
//                Int(kCVPixelFormatType_420YpCbCr8PlanarFullRange)]
//            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
//        } else {
//            print("cant add video data output to the session")
//            session.commitConfiguration()
//            return
//        }
//
//        let captureConnection = videoDataOutput.connection(with: .video)
//        //alawys process the frame
//        captureConnection?.isEnabled = true
//        do {
//            try videoDevice!.lockForConfiguration()
//            let dismensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
//            bufferSize.width = CGFloat(dismensions.width)
//            bufferSize.height = CGFloat(dismensions.height)
//            videoDevice!.unlockForConfiguration()
//        } catch {
//            print(error)
//        }
//
//        session.commitConfiguration()
//        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        rootLayer = previewView.layer
//        previewLayer.frame = rootLayer.bounds
//        rootLayer.addSublayer(previewLayer)
//    }
//
//    func startCaptureSession() {
//        session.startRunning()
//    }
//
//    func teardownAVCapture() {
//        previewLayer.removeFromSuperlayer()
//        previewLayer = nil
//    }
//
//    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
//
//    }
//
//    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
//           let curDeviceOrientation = UIDevice.current.orientation
//           let exifOrientation: CGImagePropertyOrientation
//
//           switch curDeviceOrientation {
//           case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
//               exifOrientation = .left
//           case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
//               exifOrientation = .upMirrored
//           case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
//               exifOrientation = .down
//           case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
//               exifOrientation = .up
//           default:
//               exifOrientation = .up
//           }
//           return exifOrientation
//       }
    
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    
    @IBOutlet weak private var previewView: UIView!
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // to be implemented in the subclass
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAVCapture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device, make an input
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .vga640x480 // Model image size is smaller.
        
        // Add a video input
        guard session.canAddInput(deviceInput) else {
            print("Could not add video device input to the session")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            // Add a video data output
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        let captureConnection = videoDataOutput.connection(with: .video)
        // Always process the frames
        captureConnection?.isEnabled = true
        do {
            try  videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice!.unlockForConfiguration()
        } catch {
            print(error)
        }
        session.commitConfiguration()
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = previewView.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
    }
    

    func startCaptureSession() {
        session.startRunning()
    }
    
    // Clean up capture setup
    func teardownAVCapture() {
        previewLayer.removeFromSuperlayer()
        previewLayer = nil
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // print("frame dropped")
    }
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
    
    
    
    
}
