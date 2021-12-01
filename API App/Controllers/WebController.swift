//
//  WebController.swift
//  API App
//
//  Created by Pat Keller on 11/21/21.
//
import UIKit
import WebKit
var url:String = ""

class WebController: UIViewController, WKUIDelegate {
        

    @IBOutlet var webViewCell: UIView!
    
    var webView: WKWebView!
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print("this is the entry - \(url)")
            let myURL = URL(string:url)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
}
