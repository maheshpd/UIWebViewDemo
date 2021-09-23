//
//  ViewController.swift
//  UIWebViewDemo
//
//  Created by Mahesh Prasad on 23/09/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {
    
    var webView: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        //Inject JavaScript which sending message to App
        let js: String = "window.webkit.messageHandlers.callbackHandler.postMessage('Hello from JavaScript');"
        
        let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        
        contentController.removeAllUserScripts()
        contentController.addUserScript(userScript)
        //Add ScriptMessageHandler
        contentController.add(
        self,
        name: "callbackHandler"
        )
        
        webConfiguration.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://app.toolsninja.in/member")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
        }
    }

}

