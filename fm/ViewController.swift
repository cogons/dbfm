//
//  ViewController.swift
//  fm
//
//  Created by Cogons on 16/7/28.
//  Copyright © 2016年 Cogons. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

var channelId:Int = 0

class ViewController: UIViewController,ChannelProtocol,HttpProtocol {

    @IBOutlet weak var songName: UILabel!
    
    var player = AVPlayer()
    //定义一个变量，接收频道的歌曲数据
    var tableData = []
    var data = [:]
    var num:Int = 0
    
    var cid:Int = 1
    var eHttp:HttpController = HttpController()
    var url:String = "https://www.douban.com/j/app/radio/people?app_name=radio_android&version=100&type=n&channel=1"
    //定义一个变量，接收频道的数据
    var channelData = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var player:AVPlayer
        eHttp.delegate = self
        eHttp.onSearch(url)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getMyName:", name:"NotificationIdentifier", object: nil)
        
    }
    
   
    @IBAction func play(sender: AnyObject) {
        self.player.pause()
        eHttp.onSearch(url)
        playSong()
    }

    
    func playSong(){
        
        print(url)
        
        if data["song"] != nil{
        
        var songUrl = data["song"]![0]["url"] as! String
        var videoURL = NSURL(string: songUrl)
        self.player = AVPlayer(URL: videoURL!)
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        self.player.play()
        self.songName.text = data["song"]![0]["title"] as! String
        }
        
//        var urlPath = NSURL(string: url)
//        var session = NSURLSession.sharedSession()
//        var task = session.dataTaskWithURL(urlPath!){data,response,error in
//            var jsonResult:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            dispatch_async(dispatch_get_main_queue()){
//                self.songName.text = jsonResult["song"]![0]["title"] as! String
//                
//                var songUrl = jsonResult["song"]![0]["url"] as! String
//                var videoURL = NSURL(string: songUrl)
//                self.player = AVPlayer(URL: videoURL!)
//                
//                let playerLayer = AVPlayerLayer(player: self.player)
//                playerLayer.frame = self.view.bounds
//                self.view.layer.addSublayer(playerLayer)
//                self.player.play()
//            }
//            
//        }
//        task.resume()
        
    }
    
   

    func send(id: Int){
        
//        cid = id
//        player.pause()
//        play(id)
        
    

        
    }
    
    func didReceive(results:AnyObject){
        //        println("获取到得数据：\(results)")
        //print(results)
        
            self.data = results as! NSDictionary
        
        self.num = self.channelData.count
        //print(self.channelData)
        //print(self.tableData)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func getMyName(notification:NSNotification){
        
        //获取词典中的值
        let name = notification.object!
        
        
        //notification.userInfo 接收object 对象 一些信息 例如入键盘的一些信息
        
        self.player.pause()
        url = "https://www.douban.com/j/app/radio/people?app_name=radio_android&version=100&type=n&channel=\(notification.object!)"
        eHttp.onSearch(url)
        playSong()
        
            }

    
}


//func getChannels(){
//    var urlPath = NSURL(string: "https://www.douban.com/j/app/radio/channels")
//    var session = NSURLSession.sharedSession()
//    var task = session.dataTaskWithURL(urlPath!){data,response,error in
//        var jsonResult:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//        dispatch_async(dispatch_get_main_queue()){
//            self.songName.text = jsonResult["channels"]![0]["name_en"] as! String
//        }
//        
//    }
//    task.resume()
//}
//
//
//func getSong(){
//    var urlPath = NSURL(string: "https://douban.fm/j/mine/playlist?channel=0")
//    var session = NSURLSession.sharedSession()
//    var task = session.dataTaskWithURL(urlPath!){data,response,error in
//        var jsonResult:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//        dispatch_async(dispatch_get_main_queue()){
//            self.songName.text = jsonResult["song"]![0]["public_time"] as! String
//        }
//        
//    }
//    task.resume()
//}

