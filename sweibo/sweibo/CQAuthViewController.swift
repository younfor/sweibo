//
//  CQAuthViewController.swift
//  sweibo
//
//  Created by y on 15/11/17.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit
import Alamofire

class CQAuthViewController: UIViewController,UIWebViewDelegate {
    // 请求
    var base_URL = "https://api.weibo.com/oauth2/authorize"
    let client_id = "1387425479"
    let redirect_uri = "http://www.baidu.com"
    let secret_id = "eab9f3952739a6a4a70d449ac1f4fa3e"
    // 返回
    let testUrl = "http://localhost/~y/info.php"
    let tokenUrl = "https://api.weibo.com/oauth2/access_token"
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载登陆授权
        let webView = UIWebView.init()
        webView.frame = self.view.frame
        webView.delegate = self
        self.view.addSubview(webView)
        let urlString = self.base_URL + "?client_id=" + self.client_id + "&redirect_uri=" + self.redirect_uri
                let url = NSURL.init(string: urlString)
        let request = NSURLRequest.init(URL: url!)
        webView.loadRequest(request)
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        MBProgressHUD.hide(self.view)
    }
    func webViewDidStartLoad(webView: UIWebView) {
        // 开始加载
       MBProgressHUD.showLoading(self.view)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        // 隐藏加载框
       MBProgressHUD.hide(self.view)
    }
    // 页面请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URL?.absoluteString
        let codeRange = request.URL?.absoluteString.rangeOfString("code=")
        // 获取code
        if  codeRange?.count > 0 {
            let code = url?.substringFromIndex((codeRange?.endIndex)!)
            // 获取Accesstoken
            self.accessByCode(code!)
            return false
        }
        return true
    }
    
    // 获取Token
    func accessByCode(code: String) {
        let paras = ["client_id":self.client_id,"client_secret":self.secret_id,"p":
        "authorization_code","code":code,"redirect_uri":self.redirect_uri]
        Alamofire.request(.POST, self.tokenUrl, parameters: paras)
            .responseJSON  { (res:Response<AnyObject, NSError>) -> Void in
                //print(res.data)
                //res.data?.writeToFile("/Users/y/Desktop/a.json", atomically: true)
                do {
                    var js:AnyObject?;
                    try js = NSJSONSerialization.JSONObjectWithData(res.data!, options: NSJSONReadingOptions.AllowFragments)
                    let account:CQAccount! = CQAccount.initWithDic(js! as! NSDictionary)
                    // 存起来
                    account.save()
                    CQAccount.instance()
                } catch {
                    print(error)
                }
                
        }
        
        /*
        {"access_token":"2.009Nq_wB_kUtVBd21559f8e5ZHtA1E","remind_in":"157679999","expires_in":157679999,"uid":"1777889274"}
        */
      
    }

}
