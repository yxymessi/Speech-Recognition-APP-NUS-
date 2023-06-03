//
//  AppDelegate.swift
//  nus_ipad
//
//  Created by apple on 2020/8/7.
//  Copyright © 2020 apple. All rights reserved.
//


import UIKit
//import iflyMSC

       

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IFlySetting.setLogFile(LOG_LEVEL.LVL_ALL) 

        //Set whether to output log messages in Xcode console
        IFlySetting.showLogcat(false)

        //Set the local storage path of SDK
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).map(\.path)
        let cachePath = paths[0]
        IFlySetting.setLogFilePath(cachePath)

        //Set APPID
        let initString = "appid=\("5f213952")"
        print("5f213952")
        //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
        IFlySpeechUtility.createUtility(initString)

        return true
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

