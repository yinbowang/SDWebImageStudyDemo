/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIView+WebCacheOperation.h"
#import "objc/runtime.h"

static char loadOperationKey;

// key is strong, value is weak because operation instance is retained by SDWebImageManager's runningOperations property
// we should use lock to keep thread-safe because these method may not be acessed from main queue
typedef NSMapTable<NSString *, id<SDWebImageOperation>> SDOperationsDictionary;

@implementation UIView (WebCacheOperation)

//获取任务字典NSMapTable,将NSMapTable关联对象到UIView
- (SDOperationsDictionary *)sd_operationDictionary {
    @synchronized(self) {
        //如果取到operations就返回否则就创建,保证线程安全
        SDOperationsDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
        if (operations) {
            return operations;
        }
        //https://www.jianshu.com/p/cf4e15b26f64
        //NSHashTable与NSMapTable
        //用NSMapTable保存operation,NSMapTable可以设置value为弱引用,key为强引用
        operations = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
        objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return operations;
    }
}

//通过key去拿operation
- (nullable id<SDWebImageOperation>)sd_imageLoadOperationForKey:(nullable NSString *)key  {
    id<SDWebImageOperation> operation;
    if (key) {
        SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
        @synchronized (self) {
            operation = [operationDictionary objectForKey:key];
        }
    }
    return operation;
}

//设置key和value
- (void)sd_setImageLoadOperation:(nullable id<SDWebImageOperation>)operation forKey:(nullable NSString *)key {
    if (key) {
        //先把之前的key对应的operation给删除了
        [self sd_cancelImageLoadOperationWithKey:key];
        //然后添加新的operation
        if (operation) {
            SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
            @synchronized (self) {
                [operationDictionary setObject:operation forKey:key];
            }
        }
    }
}

//通过key把operation给取出来,然后调用cancel方法,取消下载
- (void)sd_cancelImageLoadOperationWithKey:(nullable NSString *)key {
    if (key) {
        // Cancel in progress downloader from queue
        SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
        id<SDWebImageOperation> operation;
        
        @synchronized (self) {
            operation = [operationDictionary objectForKey:key];
        }
        if (operation) {
            if ([operation conformsToProtocol:@protocol(SDWebImageOperation)]) {
                [operation cancel];
            }
            @synchronized (self) {
                [operationDictionary removeObjectForKey:key];
            }
        }
    }
}

- (void)sd_removeImageLoadOperationWithKey:(nullable NSString *)key {
    if (key) {
        SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
        @synchronized (self) {
            [operationDictionary removeObjectForKey:key];
        }
    }
}

@end
