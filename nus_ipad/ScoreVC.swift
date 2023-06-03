//
//  ScoreVC.swift
//  nus_ipad
//
//  Created by mac on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ScoreVC: UIViewController {
    var btn1:UIButton?
    @IBOutlet weak var lb: UILabel!
    var temp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lb.text = temp
        lb.textAlignment = .center
        initBtn()
        
        // Do any additional setup after loading the view.
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //初始化按钮，点击按钮跳转页面
    func initBtn() {
        
        let screenSize = UIScreen.main.bounds.size
        let jumpBtn = UIButton(type: .system)
        jumpBtn.setTitle("next task", for: .normal)
        jumpBtn.frame = CGRect(x: screenSize.width / 2 - 50, y: view.frame.size.height - 70, width: 100, height: 30)
        jumpBtn.backgroundColor = UIColor(red: 50 / 255, green: 123 / 255, blue:  255 / 255, alpha: 1)
        jumpBtn.setTitleColor(UIColor.white, for: .normal)
        //按钮绑定事件，点击时执行
        jumpBtn.addTarget(self, action: #selector(pageJump), for: .touchDown)
        self.view.addSubview(jumpBtn)
    }


    @objc func pageJump() {
             //创建一个页面
        if num==1{
            let destination = ThirdViewController()
             //取目标页面的一个变量进行赋值，以属性的方式进行传值。
             //跳转
            print("1-S test begins!")
            self.present(destination, animated: true, completion: nil)
        }else if num==2
        {
            let destination = FourthViewController()
             //取目标页面的一个变量进行赋值，以属性的方式进行传值。
             //跳转
            print("1-A test begins!")
            self.present(destination, animated: true, completion: nil)
        }else if num==3
        {
            let destination = FifthViewController()
             //取目标页面的一个变量进行赋值，以属性的方式进行传值。
             //跳转
            print("2-A test begins!")
            self.present(destination, animated: true, completion: nil)
        }else if num==4{
            let destination = SixthViewController()
             //取目标页面的一个变量进行赋值，以属性的方式进行传值。
             //跳转
            print("2-V test begins!")
            self.present(destination, animated: true, completion: nil)
        }

        
    }
}
