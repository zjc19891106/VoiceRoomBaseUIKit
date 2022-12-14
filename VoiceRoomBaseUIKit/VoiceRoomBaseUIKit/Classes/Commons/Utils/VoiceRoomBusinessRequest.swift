//
//  VoiceRoomBusinessRequest.swift
//  VoiceRoomBaseUIKit-VoiceRoomBaseUIKit
//
//  Created by 朱继超 on 2022/8/29.
//

import UIKit
import VoiceRoomRequest
import ZSwiftBaseLib


@objc public class VoiceRoomBusinessRequest: NSObject {
    
    @UserDefault("VoiceRoomBusinessUserToken", defaultValue: "") var userToken
    
    @objc public static let shared = VoiceRoomBusinessRequest()
    
    /// Description send a request contain generic
    /// - Parameters:
    ///   - method: VoiceRoomRequestHTTPMethod
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params: body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    public func sendRequest<T:Codable>(
        method: VoiceRoomRequestHTTPMethod,
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((T?,Error?) -> Void)) -> URLSessionTask? {
        let headers = ["Authorization:"+self.userToken:"Content-Type:application/json"]
        let task = VoiceRoomRequest.shared.constructRequest(method: method, uri: uri, params: params, headers: headers) { data, response, error in
            if error == nil,response?.statusCode ?? 0 == 200 {
                var item: T?
                var parserError: Error?
                if let data = data {
                    do {
                        item = try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        parserError = error
                    }
                }
                callBack(item,parserError)
            } else {
                callBack(nil,error)
            }
        }
        return task
    }
    /// Description send a request
    /// - Parameters:
    ///   - method: VoiceRoomRequestHTTPMethod
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params: body params
    ///   - callBack: response callback the tuple that made of dictionary and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    public func sendRequest(
        method: VoiceRoomRequestHTTPMethod,
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String,Any>?,Error?) -> Void)) -> URLSessionTask? {
        let headers = ["Authorization:"+self.userToken:"Content-Type:application/json"]
        let task = VoiceRoomRequest.shared.constructRequest(method: method, uri: uri, params: params, headers: headers) { data, response, error in
            if error == nil,response?.statusCode ?? 0 == 200 {
                callBack(data?.z.toDictionary(),nil)
            } else {
                callBack(nil,error)
            }
        }
        return task
    }

}

//MARK: - rest request
public extension VoiceRoomBusinessRequest {
    
    //MARK: - generic uri request
    
    /// Description send a get request contain generic
    /// - Parameters:
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendGETRequest<U:Codable>(
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .get, uri: uri, params: params, callBack: callBack)
    }
    
    /// Description send a post request contain generic
    /// - Parameters:
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendPOSTRequest<U:Codable>(
        uri: String,params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .post, uri: uri, params: params, callBack: callBack)
    }
    
    /// Description send a put request contain generic
    /// - Parameters:
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendPUTRequest<U:Codable>(
        uri: String,params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .put, uri: uri, params: params, callBack: callBack)
    }
    
    /// Description send a delete request contain generic
    /// - Parameters:
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendDELETERequest<U:Codable>(
        uri: String,params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .delete, uri: uri, params: params, callBack: callBack)
    }
    
    //MARK: - generic api request
    /// Description send a get request contain generic
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendGETRequest<U:Codable>(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .get, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description send a post request contain generic
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendPOSTRequest<U:Codable>(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .post, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description send a put request contain generic
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendPUTRequest<U:Codable>(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .put, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description send a delete request contain generic
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendDELETERequest<U:Codable>(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((U?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .delete, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    //MARK: - no generic uri request
    /// Description send a get request
    /// - Parameters:
    ///   - method: VoiceRoomRequestHTTPMethod
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params: body params
    ///   - callBack: response callback the tuple that made of dictionary and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    @objc
    func sendGETRequest(
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .get, uri: uri, params: params, callBack: callBack)
    }
    /// Description send a post request
    /// - Parameters:
    ///   - method: VoiceRoomRequestHTTPMethod
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params: body params
    ///   - callBack: response callback the tuple that made of dictionary and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    @objc
    func sendPOSTRequest(
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .post, uri: uri, params: params, callBack: callBack)
    }
    /// Description send a put request
    /// - Parameters:
    ///   - method: VoiceRoomRequestHTTPMethod
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params: body params
    ///   - callBack: response callback the tuple that made of dictionary and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    @objc
    func sendPUTRequest(
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .put, uri: uri, params: params, callBack: callBack)
    }
    /// Description send a delete request
    /// - Parameters:
    ///   - method: VoiceRoomRequestHTTPMethod
    ///   - uri: The part spliced after the host.For example,"/xxx/xxx"
    ///   - params: body params
    ///   - callBack: response callback the tuple that made of dictionary and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    @objc
    func sendDELETERequest(
        uri: String,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .delete, uri: uri, params: params, callBack: callBack)
    }
    
    //MARK: - no generic api request
    /// Description send a get request
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendGETRequest(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .get, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description send a post request
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendPOSTRequest(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .post, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description send a put request
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendPUTRequest(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .put, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description send a delete request
    /// - Parameters:
    ///   - api: The part spliced after the host.For example,"/xxx/xxx".Package with VoiceRoomBusinessApi.
    ///   - params:  body params
    ///   - callBack: response callback the tuple that made of generic and error.
    /// - Returns: Request task,what if you can determine its status or cancel it .
    @discardableResult
    func sendDELETERequest(
        api: VoiceRoomBusinessApi,
        params: Dictionary<String, Any>,
        callBack:@escaping ((Dictionary<String, Any>?,Error?) -> Void)) -> URLSessionTask? {
        self.sendRequest(method: .delete, uri: self.convertApi(api: api), params: params, callBack: callBack)
    }
    
    /// Description convert api to uri
    /// - Parameter api: VoiceRoomBusinessApi
    /// - Returns: uri string
    func convertApi(api: VoiceRoomBusinessApi) -> String {
        var uri = "/"
        switch api {
        case let .fetchRoomList(cursor,pageSize):
            uri += "list?limit=\(pageSize)&cursor=\(cursor)"
        case .createRoom(_):
            uri += "create"
        case let .fetchRoomInfo(roomId):
            uri += roomId
        case let .deleteRoom(roomId):
            uri += roomId
        case let .modifyRoomInfo(roomId):
            uri += roomId
        case let .fetchRoomMembers(roomId, cursor, pageSize):
            uri += roomId + "/members/list?limit=\(pageSize)&cursor=\(cursor)"
        case let .joinRoom(roomId):
            uri += roomId + "/members/join"
        case let .leaveRoom(roomId):
            uri += roomId + "/members/leave"
        case let .kickUser(roomId):
            uri += roomId + "/members/kick"
        case let .fetchGiftContribute(roomId, cursor, pageSize):
            uri += roomId + "/gift/list?limit=\(pageSize)&cursor=\(cursor)"
        case let .giftTo(roomId):
            uri += roomId + "/gift/add"
        case let .fetchApplyMembers(roomId, cursor, pageSize):
            uri += roomId + "/mic/apply?limit=\(pageSize)&cursor=\(cursor)"
        case let .submitApply(roomId):
            uri += roomId + "/mic/apply"
        case let .cancelApply(roomId):
            uri += roomId + "/mic/apply"
        case let .agreeApply(roomId):
            uri += roomId + "/mic/agree/apply"
        case let .fetchMicsInfo(roomId):
            uri += roomId + "/mic"
        case let .closeMic(roomId):
            uri += roomId + "/mic/close"
        case let .cancelCloseMic(roomId):
            uri += roomId + "/mic/close"
        case let .leaveMic(roomId):
            uri += roomId + "/mic/leave"
        case let .muteMic(roomId):
            uri += roomId + "/mic/mute"
        case let .unmuteMic(roomId):
            uri += roomId + "/mic/mute"
        case let .exchangeMic(roomId):
            uri += roomId + "/mic/exchange"
        case let .kickMic(roomId):
            uri += roomId + "/mic/kick"
        case let .lockMic(roomId):
            uri += roomId + "/mic/lock"
        case let .unlockMic(roomId):
            uri += roomId + "/mic/lock"
        case let .inviteUserToMic(roomId):
            uri += roomId + "/mic/invite"
        }
        return uri
    }
}


