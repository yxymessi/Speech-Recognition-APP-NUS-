//
//  ViewController.swift
//  nus_ipad
//
//  Created by apple on 2020/8/13.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

//首先导入音频框架
import AVFoundation
var num=0
var thres=60.0
class ViewController: UIViewController {
    
    
    var btn1:UIButton?
    var timer:Timer?
    var label:UILabel?
    var a = 0.0
    @IBOutlet weak var textLabel: UILabel!
    
    //    初始化音频播放对像，做为视图控制器类的属性
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVAudioSession.sharedInstance()
////        创建一个异常捕捉语句
//        do{
////            启动音频会话的管理，此时会阻断后台音乐的播放
//            try session.setActive(true)
////            设置音频操作类别，标示该应用仅支持音频的播放
//            try session.setCategory(AVAudioSession.Category.playback)
////            设置应用程序支持接受远程控制事件
//            UIApplication.shared.beginReceivingRemoteControlEvents()
//            
////            定义一个字符常量，描述声音文件的路经
//            let path = Bundle.main.path(forResource: "test", ofType: "mp3")
////            将字符串路径，转换为网址路径
//            let soudUrl = URL(fileURLWithPath: path!)
////            对音频播放对象进行初始化，并加载指定的音频文件
//            try audioPlayer = AVAudioPlayer(contentsOf: soudUrl)
//            audioPlayer.prepareToPlay()
////            设置音频播放对象的音量大小/
//            audioPlayer.volume = 1.0
////            设置音频的播放次数，-1为无限循环
//            audioPlayer.numberOfLoops = 0
////            开始播放
//            audioPlayer.play()
//        } catch{
//            print(error)
//        }
        let label = UILabel(frame:CGRect(x:10, y:20, width:300, height:100))
        label.font = UIFont(name:"Optima", size:15)
        label.numberOfLines = 2
        label.text = "Instruction ：Say out loud as many words that begin with the letter ."
        self.view.addSubview(label);
        initBtn()
        
    }
   override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
   }
    
    //初始化按钮，点击按钮跳转页面
    func initBtn() {
        
        let screenSize = UIScreen.main.bounds.size
        let jumpBtn = UIButton(type: .system)
        jumpBtn.setTitle("go on", for: .normal)
        jumpBtn.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.height - 50, width: 100, height: 30)
        jumpBtn.backgroundColor = UIColor(red: 50 / 255, green: 123 / 255, blue:  255 / 255, alpha: 1)
        jumpBtn.setTitleColor(UIColor.white, for: .normal)
        //按钮绑定事件，点击时执行
        jumpBtn.addTarget(self, action: #selector(pageJump), for: .touchDown)
        self.view.addSubview(jumpBtn)
        let imageView = UIImageView(image:UIImage(named:"IMG_6282.JPG"))
        
        imageView.frame = CGRect(x:0, y:180, width:300, height:200)
        imageView.center.x = view.center.x
        self.view.addSubview(imageView)
    }
    @objc func pageJump() {
             //创建一个页面
         let destination = SecondViewController()
             //取目标页面的一个变量进行赋值，以属性的方式进行传值。
             //跳转
         print("1-F test begins!")
         self.present(destination, animated: true, completion: nil)
         }
}
