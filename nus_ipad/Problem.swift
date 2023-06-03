oc 代码：
 params例如：
 {"sn":1,"ls":true,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"白日","sc":0}]},{"bg":0,"cw":[{"w":"依山","sc":0}]},{"bg":0,"cw":[{"w":"尽","sc":0}]},{"bg":0,"cw":[{"w":"黄河入海流","sc":0}]},{"bg":0,"cw":[{"w":"。","sc":0}]}]}
 ****/
+ (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }

    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];

    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];

        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];

            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}


Swift 代码：

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
    
