//
//  WebviewController.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 28..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class WebviewController: UIViewController , UITextFieldDelegate , UIWebViewDelegate{
    
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var bookMarkSegmentedControl: UISegmentedControl!
    @IBOutlet var mainWebView: UIWebView!
    @IBOutlet var spinningActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://www.facebook.com"
        mainWebView.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))
        urlTextField.text = urlString
        
    }
    
    @IBAction func bookMarkAction(sender: AnyObject) {
        let bookMarkUrl = bookMarkSegmentedControl.titleForSegmentAtIndex(bookMarkSegmentedControl.selectedSegmentIndex)
        let urlString = "http://www.\(bookMarkUrl!).com"
        
        print("request url : \(urlString)")
        
        mainWebView.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))
        urlTextField.text = urlString
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var urlString = "\(urlTextField.text!)"
        
        if !urlString.hasPrefix("http://") {
            urlString = "http://\(urlString)"
        }
        
        mainWebView.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))
        textField.resignFirstResponder();
        
        return true
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        spinningActivityIndicatorView.stopAnimating()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        spinningActivityIndicatorView.startAnimating()
    }
    
}









