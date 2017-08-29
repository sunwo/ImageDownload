//
//  ViewController.swift
//  ImageDownload
//
//  Created by admin on 2017. 8. 29..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var downloadTask:URLSessionDownloadTask!
    
    //URLSession
    //AFNetworking
    @IBAction func downloadAction(_ sender: Any) {
        self.imgView.image = nil
        self.progressView.setProgress(0.0, animated: false)
        indicator.startAnimating()
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        downloadTask = session.downloadTask(with: URL(string : "https://i.imgur.com/Ryw1REr.png")!)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let tempData:Data = try! Data(contentsOf: location)
        self.imgView.image = UIImage(data: tempData)
         indicator.stopAnimating()
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let tempProgress:Float = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        self.progressView.setProgress(tempProgress, animated: true)
    }
    
    @IBAction func suspendedAction(_ sender: Any) {
        downloadTask.suspend()
        
    }
    
    @IBAction func resumedAction(_ sender: Any) {
        downloadTask.resume()
    }
    
    @IBAction func canceledAction(_ sender: Any) {
        downloadTask.cancel()
        self.progressView.setProgress(0.0, animated: false)
        indicator.stopAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

