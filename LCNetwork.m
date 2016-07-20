//
//  LCNetwork.m
//  TinyFortune
//
//  Created by lc on 16/7/19.
//  Copyright © 2016年 lc. All rights reserved.
//

#import "LCNetwork.h"
#import  <AFNetworking.h>
@interface LCNetwork ()

@end

@implementation LCNetwork

#pragma mark - Private
+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL
                        sessionConfiguration:(BOOL)isconfiguration {
  NSURLSessionConfiguration *configuration =
      [NSURLSessionConfiguration defaultSessionConfiguration];
  AFHTTPSessionManager *manager = nil;
  NSURL *url = [NSURL URLWithString:baseURL];
  if (isconfiguration) {
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url
                                       sessionConfiguration:configuration];
  } else {
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
  }
  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     //在序列化器中追加一个类型text/html(原本只支持text/json,application/json)
  manager.responseSerializer.acceptableContentTypes =
      [manager.responseSerializer.acceptableContentTypes
          setByAddingObject:@"text/html"];
  return manager;
}

+ (id)resopnseConfiguration:(id)responseObject {
  NSString *string = [[NSString alloc] initWithData:responseObject
                                           encoding:NSUTF8StringEncoding];
  string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
  NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
  // FIXME:可能存在错误
  NSDictionary *dic =
      [NSJSONSerialization JSONObjectWithData:data
                                      options:NSJSONReadingMutableContainers
                                        error:nil];
  return dic;
}

#pragma mark - get
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(LCResponseSuccess)success
       fail:(LCResponseFail)fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:nil sessionConfiguration:NO];
  [manager GET:url
      parameters:params
      progress:nil
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        id dic = [LCNetwork resopnseConfiguration:responseObject];
        success(task, dic);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        fail(task, error);
      }];
}

+ (void)GET:(NSString *)url
    baseUrl:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(LCResponseSuccess)success
       fail:(LCResponseFail)fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:baseUrl sessionConfiguration:NO];
  [manager GET:url
      parameters:params
      progress:nil
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        id dic = [LCNetwork resopnseConfiguration:responseObject];
        success(task, dic);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        fail(task, error);
      }];
}
#pragma mark - post
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(LCResponseSuccess)success
        fail:(LCResponseFail)fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:nil sessionConfiguration:NO];
  [manager POST:url
      parameters:params
      progress:nil
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        id dic = [LCNetwork resopnseConfiguration:responseObject];
        success(task, dic);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        fail(task, error);
      }];
}
+ (void)POST:(NSString *)url
     baseUrl:(NSString *)baseUrl
      params:(NSDictionary *)params
     success:(LCResponseSuccess)success
        fail:(LCResponseFail)fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:baseUrl sessionConfiguration:NO];
  [manager POST:url
      parameters:params
      progress:nil
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        id dic = [LCNetwork resopnseConfiguration:responseObject];
        success(task, dic);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        fail(task, error);
      }];
}

#pragma mark - upload

+ (void)uploadWithUrl:(NSString *)url
               params:(NSDictionary *)paramas
             filedata:(NSData *)filedata
                 name:(NSString *)name
             filename:(NSString *)filename
             mimeType:(NSString *)mimeType
             progress:(LCProgress)progress
              success:(LCResponseSuccess)success
                 fail:(LCResponseFail)fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:nil sessionConfiguration:NO];
  [manager POST:url
      parameters:paramas
      constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileData:filedata
                                    name:name
                                fileName:filename
                                mimeType:mimeType];
      }
      progress:^(NSProgress *_Nonnull uploadProgress) {
        progress(uploadProgress);
      }
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        id dic = [LCNetwork resopnseConfiguration:responseObject];
        success(task, dic);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        fail(task, error);
      }];
}

+ (void)uploadWith:(NSString *)url
           baseUrl:(NSString *)baseUrl
            params:(NSDictionary *)params
          filedata:(NSData *)filedata
              name:(NSString *)name
          filename:(NSString *)filename
          mimeType:(NSString *)mimeType
          progress:(LCProgress)progress
           success:(LCResponseSuccess)success
              fail:(LCResponseFail)fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:baseUrl sessionConfiguration:YES];

  [manager POST:url
      parameters:params
      constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileData:filedata
                                    name:name
                                fileName:filename
                                mimeType:mimeType];
      }
      progress:^(NSProgress *_Nonnull uploadProgress) {
        progress(uploadProgress);
      }
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nullable responseObject) {
        id dic = [LCNetwork resopnseConfiguration:responseObject];
        success(task, dic);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        fail(task, error);
      }];
}

#pragma mark - download

+ (NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                  savePathURL:(NSURL *)fileUrl
                                     progress:(LCProgress)progress
                                      success:(void (^)(NSURLResponse *,
                                                        NSURL *))success
                                         fail:(void (^)(NSError *))fail {
  AFHTTPSessionManager *manager =
      [LCNetwork managerWithBaseURL:nil sessionConfiguration:YES];
  NSURL *urlPath = [NSURL URLWithString:url];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlPath];
  NSURLSessionDownloadTask *downloadTask = [manager
      downloadTaskWithRequest:urlRequest
      progress:^(NSProgress *_Nonnull downloadProgress) {
        progress(downloadProgress);
      }
      destination:^NSURL *_Nonnull(NSURL *_Nonnull targetPath,
                                   NSURLResponse *_Nonnull response) {
        return
            [fileUrl URLByAppendingPathComponent:[response suggestedFilename]];
      }
      completionHandler:^(NSURLResponse *_Nonnull response,
                          NSURL *_Nullable filePath, NSError *_Nullable error) {
        if (error) {
          fail(error);
        } else {
          success(response, filePath);
        }
      }];
  [downloadTask resume];
  return downloadTask;
}
@end
