//
//  ThirdViewController.swift
//  nus_ipad
//
//  Created by apple on 2020/10/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,AVAudioRecorderDelegate {
    //不带界面的识别对象
    lazy var iFlySpeechRecognizer: IFlySpeechRecognizer = {
        let iFlySpeechRecognizer = IFlySpeechRecognizer.sharedInstance()!
        //设置识别参数
        //设置为听写模式
        iFlySpeechRecognizer.setParameter("iat", forKey: IFlySpeechConstant.ifly_DOMAIN())
        //asr_audio_path 是录音文件名，设置 value 为 nil 或者为空取消保存，默认保存目录在 Library/cache 下。
        iFlySpeechRecognizer.setParameter("iat.pcm", forKey: IFlySpeechConstant.asr_AUDIO_PATH())
        //设置最长录音时间:60秒
        iFlySpeechRecognizer.setParameter("100000", forKey: IFlySpeechConstant.speech_TIMEOUT())
        //设置语音后端点:后端点静音检测时间，即用户停止说话多长时间内即认为不再输入， 自动停止录音
        iFlySpeechRecognizer.setParameter("10000", forKey: IFlySpeechConstant.vad_EOS())
        //设置语音前端点:静音超时时间，即用户多长时间不说话则当做超时处理
        iFlySpeechRecognizer.setParameter("50000", forKey: IFlySpeechConstant.vad_BOS())
        //网络等待时间
        iFlySpeechRecognizer.setParameter("2000", forKey: IFlySpeechConstant.net_TIMEOUT())
        //设置采样率，推荐使用16K
        iFlySpeechRecognizer.setParameter("16000", forKey: IFlySpeechConstant.sample_RATE())
        //设置语言
        iFlySpeechRecognizer.setParameter("en_us", forKey: IFlySpeechConstant.language())
        //设置方言
        iFlySpeechRecognizer.setParameter("mandarin", forKey: IFlySpeechConstant.accent())
        //设置是否返回标点符号
        iFlySpeechRecognizer.setParameter("0", forKey: IFlySpeechConstant.asr_PTT())
        //设置代理
        iFlySpeechRecognizer.delegate = self
        
        return iFlySpeechRecognizer
    }()
    ///生成的字符
    private var resultStringFromJson: String = ""
    ///当前是否可以进行录音
    private var isStartRecord = true
    ///是否已经开始播放
    private var ishadStart = false
    
    var btn1:UIButton?
    var timer:Timer?
    var label:UILabel?
    var letterlabel:UILabel?
    var a = 0.0
    let btn = UIButton(frame: CGRect(x: 140, y: 200, width: 100, height: 100))
    let screenSize = UIScreen.main.bounds.size
    var current_length=0
    var count=0
    
    var chatHUD = MCRecordHUD(type: .bar)
        
    /// 录音器
    private var recorder: AVAudioRecorder!
    /// 录音器设置
    private let recorderSetting = [AVSampleRateKey : NSNumber(value: Float(44100.0)),//声音采样率
                                     AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),//编码格式
                             AVNumberOfChannelsKey : NSNumber(value: 1),//采集音轨
                          AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]//声音质量
    /// 录音计时器
    private var timer1: Timer?
    /// 波形更新间隔
    private let updateFequency = 0.05
    /// 声音数据数组
    private var soundMeters: [Float]!
    /// 声音数据数组容量
    private let soundMeterCount = 20
    /// 录音时间
    private var recordTime = 0.00
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        num=num+1
        btn.backgroundColor = UIColor.orange
        btn.setTitle("task2", for: .normal)
        btn.center.x = view.center.x
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(startCLick), for: .touchUpInside)
        btn.center.y = view.center.y
        let lab = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.size.width , height: 50))
         lab.textAlignment = .center
         lab.font = .systemFont(ofSize: 18)
         lab.backgroundColor = .red
         lab.textColor = .white
         view.addSubview(lab)
         label = lab
         lab.text = "1-S  timer"
        let instructlabel = UILabel(frame:CGRect(x:20, y:UIScreen.main.bounds.height-200, width:600, height:100))
         instructlabel.font = UIFont(name:"Optima", size:20)
        instructlabel.numberOfLines = 2
        instructlabel.text = "Great! The second letter is S ."
        self.view.addSubview(instructlabel);
        letterlabel = UILabel(frame:CGRect(x:0, y:300, width:UIScreen.main.bounds.size.width, height:100))
        letterlabel?.textAlignment = .center
        letterlabel?.font = UIFont(name:"Zapfino", size:30)
        letterlabel?.text = "S"
        self.view.addSubview(letterlabel!);
        
        luyin()
        
    }
    
    
    @objc func timerIntervalx() {
        a+=1;
        label?.text = "timer \(a)"
        if a >= thres {
            iFlySpeechRecognizer.stopListening()
        }
    }
    
    @objc func startCLick() {
        
        if isStartRecord {
            timeStart()
            //btn.setTitle("结束录音", for: .normal)
            btn.isHidden=true
            letterlabel?.text = "Please speaking"
            resultStringFromJson = ""
            //启动识别服务
            iFlySpeechRecognizer.startListening()
            isStartRecord = false
            ishadStart = true
            //开始声音动画
            //[self TipsViewShowWithType:@"start"];
        } else {
            iFlySpeechRecognizer.stopListening()
        }
        view.addSubview(chatHUD)
        chatHUD.startCounting()
        soundMeters = [Float]()
        recorder.record()
        timer1 = Timer.scheduledTimer(timeInterval: updateFequency, target: self, selector: #selector(updateMeters), userInfo: nil, repeats: true)
    }
    
    func timeStart() {
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerIntervalx), userInfo: nil, repeats: true)
        }
    }
    
    func timePause() {
        timer?.invalidate()
        timer = nil
    }
    
}


extension ThirdViewController: IFlySpeechRecognizerDelegate {
    func onCompleted(_ errorCode: IFlySpeechError!) {
        if resultStringFromJson.count == 0 {
            return
        }
        a = 0
        request()
        timePause()
        isStartRecord = true
        btn.setTitle("task1", for: .normal)
        label?.text = "timer"
        print("completed")
    }
    
    func request() {
        var temp = (resultStringFromJson as NSString).replacingOccurrences(of: " ", with: ",")
        temp.removeFirst()
        let dict = ["code":"1-S","data": temp.components(separatedBy: ",")] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonStr = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        let url = URL.init(string: "http://18.141.166.205")!
        
        var req = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 5)
        req.httpMethod = "POST"
        req.httpBody = jsonData
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: req) { (data, resp, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let r = try JSONSerialization.jsonObject(with: data , options: .mutableContainers) as! NSDictionary
                        print(r)
                        let vc = ScoreVC()
                        let temp = r["data"] as! [String]
                        vc.temp = "\((r["score"] as! Int))" + "\n\n" + "\(temp.joined(separator: ","))"
                        self.present(vc, animated: true, completion: nil)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    func onResults(_ results: [Any]!, isLast: Bool) {
        let dic = (results![0] as! NSDictionary).allKeys[0]
        resultStringFromJson = resultStringFromJson + jsonstring(fromJson: dic as! String)!
        print("resultStringFromJson = \(String(describing: resultStringFromJson))")
        
    }
    func jsonstring(fromJson params: String?) -> String? {
        if params == nil {
            return nil
        }
        var tempStr = ""
        var resultDic: [AnyHashable : Any]? = nil
        do {
            if let data = params?.data(using: .utf8) {
                resultDic = try JSONSerialization.jsonObject(
                    with: data,
                    options: []) as? [AnyHashable : Any]
            }
        } catch {
        }
        
        if resultDic != nil {
            let wordArray = resultDic?["ws"] as? [AnyHashable]
            for i in 0..<(wordArray?.count ?? 0) {
                let wsDic = wordArray?[i] as? [AnyHashable : Any]
                let cwArray = wsDic?["cw"] as? [AnyHashable]
                
                for j in 0..<(cwArray?.count ?? 0) {
                    let wDic = cwArray?[j] as? [AnyHashable : Any]
                    let str = wDic?["w"] as? String
                    tempStr += str ?? ""
                }
            }
        }
        return tempStr
    }
    
    func onEndOfSpeech() {
        isStartRecord = true
    }
    func onBeginOfSpeech() {
        print("begin")
        resultStringFromJson = ""
    }
    func onCancel() {
        print("cancel")
    }
}


extension ThirdViewController {
    
    func luyin() {
        configRecord()
        chatHUD.center.x = view.center.x
        chatHUD.frame.origin.y = 400
    }
    
    private func configRecord() {
        AVAudioSession.sharedInstance().requestRecordPermission { (allowed) in
            if !allowed {
                return
            }
        }
        let session = AVAudioSession.sharedInstance()
        do { try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker) }
        catch { print("session config failed") }
        do {
            self.recorder = try AVAudioRecorder(url: self.directoryURL()!, settings: self.recorderSetting)
            self.recorder.delegate = self
            self.recorder.prepareToRecord()
            self.recorder.isMeteringEnabled = true
        } catch {
            print(error.localizedDescription)
        }
        do { try AVAudioSession.sharedInstance().setActive(true) }
        catch { print("session active failed") }
    }
    
    private func directoryURL() -> URL? {
        //定义并构建一个url来保存音频，音频文件名为recording-yyyy-MM-dd-HH-mm-ss.m4a
        //根据时间来设置存储文件名
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        let currentFileName = "recording-\(format.string(from: Date())).m4a"
        print(currentFileName)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let soundFileURL = documentsDirectory.appendingPathComponent(currentFileName)
        return soundFileURL
    }
    
    @objc private func updateMeters() {
        recorder.updateMeters()
        recordTime += updateFequency
        addSoundMeter(item: recorder.averagePower(forChannel: 0))
        if recordTime >= 60.0 {
            endRecordVoice()
        }
    }
    
    private func addSoundMeter(item: Float) {
        if soundMeters.count < soundMeterCount {
            soundMeters.append(item)
        } else {
            for (index, _) in soundMeters.enumerated() {
                if index < soundMeterCount - 1 {
                    soundMeters[index] = soundMeters[index + 1]
                }
            }
            // 插入新数据
            soundMeters[soundMeterCount - 1] = item
            NotificationCenter.default.post(name: NSNotification.Name.init("updateMeters"), object: soundMeters)
        }
    }
    
    @objc private func endRecordVoice() {
        recorder.stop()
        timer1?.invalidate()
        chatHUD.stopCounting()
        chatHUD.removeFromSuperview()
        soundMeters.removeAll()
    }
}
