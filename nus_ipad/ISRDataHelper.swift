//
//  ISRDataHelper.swift
//  nus_ipad
//
//  Created by apple on 2020/8/13.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
func string(fromJson params: String?) -> String? {
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
