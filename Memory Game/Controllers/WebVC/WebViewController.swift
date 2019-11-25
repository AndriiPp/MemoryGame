//
//  ViewController.swift
//  Copyright © 2019 AndriiPp. All rights reserved.
//
import Foundation
import UIKit
import WebKit
import FBSDKCoreKit

class WebViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate, WKUIDelegate {
 
    var firstUrlLoaded = false
    var lastRequest : URLRequest?
    let PROTOCOL = "https://"
    let URL_NOT_VALID = "vseigru"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeepLink()
        mainWebView.scrollView.delegate = self
        mainWebView.navigationDelegate = self
        self.mainWebView.uiDelegate = self
        setupReload()
        loadWebViewWithDelay()
        
    }
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBAction func tryAgainClick(_ sender: Any) {
        loadWebViewWithDelay()
    }
    
    private func loadLevel(){
        weak var levelVC = (VSBuilder.createLevelVC() as! LevelViewController)
        self.present(levelVC!, animated: true, completion: nil)
    }
    private func loadWebViewWithDelay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if let url = URL(string: self.formString()) {
                let request = URLRequest(url: url)
                self.mainWebView.load(request)
                self.lastRequest = request
            }
        }
    }
    private func getDeepLinkWithDelay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getDeepLink()
        }
    }
    private func formString() -> String{
        var deepLink = "kls52vf2oc4lrqsl0odp&adid=landid_adid&pixelid=pixelid&buyerid=general_ios"
        if (UserDefaults.standard.object(forKey: "referrer")) != nil{
            deepLink = (UserDefaults.standard.object(forKey: "referrer") as! String)
        }
        var url = PROTOCOL + (UserDefaults.standard.object(forKey: "domen") as! String) + deepLink
        if (UserDefaults.standard.object(forKey: "url") != nil) {
            url = UserDefaults.standard.object(forKey: "url") as! String
        }
        return url
    }
    private func formingCasLogin1() -> String{
        let language = checkDeviceLanguage()
        let urlString = PROTOCOL + "mobile3.gameassists.co.uk/Lobby/" + language + "/Quatro/login"
        return urlString
    }
    private func formingCasLogin2() -> String{
        let language = checkDeviceLanguage()
        let urlString = PROTOCOL + "mobile2.gameassists.co.uk/Lobby/" + language + "/Cosmo/login"
        return urlString
    }
    private func formingCasLogin3() -> String{
        let language = checkDeviceLanguage()
        let urlString = PROTOCOL + "mobile3.gameassists.co.uk/Lobby/" + language + "/GrandMondial/login"
        return urlString
    }
    private func formingCasLogin4() -> String{
        let language = checkDeviceLanguage()
        let urlString = PROTOCOL + "mobile3.gameassists.co.uk/Lobby/" + language + "/YukonGold/login"
        return urlString
    }
    private func setupReload(){
        
        tryAgainButton.titleLabel?.minimumScaleFactor = 0.5
        tryAgainButton.titleLabel?.numberOfLines = 1
        tryAgainButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tryAgainButton.titleLabel?.textAlignment = .center
        tryAgainButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: 8,bottom: 0,right: 8)
    }
    
    private func verificationUrl(URL : String) -> Bool {
        if URL.contains(URL_NOT_VALID) {
            return true
        }
        return false
    }
    
    private func getDeepLink(){
        FBSDKAppLinkUtility.fetchDeferredAppLink { [weak self] url, error in
            guard self != nil else { return }
            if let urlString = url?.absoluteString {
                let stringArr = urlString.components(separatedBy: "referrer=")
                UserDefaults.standard.set(stringArr.last, forKey: "referrer")
            }
        }
        
    }
    private func checkDeviceLanguage() -> String {
        let prefferedLanguage = Locale.preferredLanguages[0].prefix(2)
        let arr = prefferedLanguage.components(separatedBy: "-")
        let deviceLanguage = arr[0]
        print(deviceLanguage)
        return deviceLanguage
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(String(describing: webView.url))
        if !firstUrlLoaded {
            loadingIndicator.startAnimating()
        }
        tryAgainButton.isHidden = true
        backgroundImageView.isHidden = true
        mainWebView.isHidden = false
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        firstUrlLoaded = true
        loadingIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url?.absoluteString {
            lastRequest = navigationAction.request
            if (url.contains("vseigru")){
                loadLevel()
            }
            if (url.contains("thanks") && url.contains("success")){
                var urlString : String?
                if (url.contains("qtr")){
                    urlString = formingCasLogin1()
                } else if (url.contains("cos")) {
                    urlString = formingCasLogin2()
                } else if (url.contains("gmd")) {
                    urlString = formingCasLogin3()
                } else  if (url.contains("yg")){
                    urlString = formingCasLogin4()
                }
                if urlString != nil{
                    UserDefaults.standard.set(urlString, forKey: "url")
                }
            }
        }
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if !(error._domain == NSURLErrorDomain && error._code == NSURLErrorNotConnectedToInternet) {
            return
        }
        firstUrlLoaded = false
        
        tryAgainButton.setTitle(NSLocalizedString("No internet connection. Click to reload", comment: ""), for: .normal)
        tryAgainButton.isHidden = false
        backgroundImageView.isHidden = false
        mainWebView.isHidden = true
    }
}



