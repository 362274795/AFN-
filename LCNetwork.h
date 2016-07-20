//
//  LCNetwork.h
//  TinyFortune
//
//  Created by lc on 16/7/19.
//  Copyright © 2016年 lc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求成功的方法
 *
 *  @param response 请求返还的数据
 */
typedef void (^LCResponseSuccess)(NSURLSessionDataTask *task,
                                  id responseObject);

/**
 *  请求失败的方法
 *
 *  @param response 请求错误返还的信息
 */
typedef void (^LCResponseFail)(NSURLSessionDataTask *task, NSError *error);

typedef void (^LCProgress)(NSProgress *progress);

@interface LCNetwork : NSObject

/**
 *  普通的get方法
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(LCResponseSuccess)success
       fail:(LCResponseFail)fail;

/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)GET:(NSString *)url
    baseUrl:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(LCResponseSuccess)success
       fail:(LCResponseFail)fail;

/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(LCResponseSuccess)success
        fail:(LCResponseFail)fail;

/**
 *  含有baseURL的post方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

+ (void)POST:(NSString *)url
     baseUrl:(NSString *)baseUrl
      params:(NSDictionary *)params
     success:(LCResponseSuccess)success
        fail:(LCResponseFail)fail;
/**
 *  普通路径上传文件
 *
 *  @param url      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */

+ (void)uploadWithUrl:(NSString *)url
               params:(NSDictionary *)paramas
             filedata:(NSData *)filedata
                 name:(NSString *)name
             filename:(NSString *)filename
             mimeType:(NSString *)mimeType
             progress:(LCProgress)progress
              success:(LCResponseSuccess)success
                 fail:(LCResponseFail)fail;

/**
 *  含有跟路径的上传文件
 *
 *  @param url      请求网址路径
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */

+ (void)uploadWith:(NSString *)url
           baseUrl:(NSString *)baseUrl
            params:(NSDictionary *)params
          filedata:(NSData *)filedata
              name:(NSString *)name
          filename:(NSString *)filename
          mimeType:(NSString *)mimeType
          progress:(LCProgress)progress
           success:(LCResponseSuccess)success
              fail:(LCResponseFail)fail;

/**
 *  下载文件
 *
 *  @param url      请求网络路径
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return
 * 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                  savePathURL:(NSURL *)fileUrl
                                     progress:(LCProgress)progress
                                      success:(void (^)(NSURLResponse *,
                                                        NSURL *))success
                                         fail:(void (^)(NSError *))fail;

@end
