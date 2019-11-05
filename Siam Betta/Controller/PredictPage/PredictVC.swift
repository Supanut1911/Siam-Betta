//
//  PredictVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 31/10/2562 BE.
//  Copyright © 2562 Supanut Laddayam. All rights reserved.
//

import UIKit
import AVFoundation
import CameraManager

class PredictVC: UIViewController {

    //Var
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var inputImage: UIImage!
    
    let cameraManager = CameraManager()
    
    
    @IBOutlet weak var shutterBtn: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setipPreviewLayer()
        startRunningCaptureSession()
    }
    
    func setupCaptureSession() {
           captureSession.sessionPreset = AVCaptureSession.Preset.photo

       }
    
    func setupDevice() {
        let devicDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = devicDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
        cameraManager.addPreviewLayerToView(cameraView)
        cameraManager.shouldEnableTapToFocus = true
        cameraManager.shouldEnablePinchToZoom = true

    }
    
    func setipPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print("------->\(error)")
        }
    }
    
 
    
    
    @IBAction func shutterDidTap(_ sender: Any) {
//        let setting = AVCapturePhotoSettings()
//        photoOutput?.capturePhoto(with: setting, delegate: self)
        cameraManager.capturePictureWithCompletion { (result) in
            switch result {
            case .failure:
                print("error")
            case .success(let content):
                self.inputImage = content.asImage
                self.performSegue(withIdentifier: "toRestPhotoSegue", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toRestPhotoSegue" {
             let imageVC = segue.destination as! restImageVC
             imageVC.image = self.inputImage
         }
     }
}



//extension PredictVC: AVCapturePhotoCaptureDelegate {
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        if let imageData = photo.fileDataRepresentation() {
//            inputImage = UIImage(data: imageData)
//            performSegue(withIdentifier: "toRestPhotoSegue", sender: nil)
//        }
//    }
//}
