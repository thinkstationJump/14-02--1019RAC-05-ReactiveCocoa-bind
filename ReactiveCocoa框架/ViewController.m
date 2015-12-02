//
//  ViewController.m
//  ReactiveCocoa框架
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

#import "GlobeHeader.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 每次只要文本框的文字一改变,在前面拼接xmg
    
    // bind:绑定信号
//    [_textField.rac_textSignal subscribeNext:^(id x) {
//       
//        NSLog(@"xmg%@",x);
//    }];
    
    //  RACStream * (^RACStreamBindBlock)(id value, BOOL *stop)
    //  RACStream *(^)(id value, BOOL *stop)
    RACSignal *bindSignal = [_textField.rac_textSignal bind:^RACStreamBindBlock{
        // block调用时刻:只要一个信号被绑定就会调用.表示信号绑定完成
        // block做事情:
        
        NSLog(@"源信号被绑定");
        return ^RACStream *(id value, BOOL *stop){
            // RACStreamBindBlock什么时候调用:每次源信号发出内容,就会调用这个block
            // value:源信号发出的内容
            NSLog(@"源信号发出的内容:%@",value);
            
            // RACStreamBindBlock作用:在这个block处理源信号的内容
            value = [NSString stringWithFormat:@"xmg%@",value];
            
            // block返回值:信号(把处理完的值包装成一个信号,返回出去)
            
            
            
            // 创建一个信号,并且这个信号的传递的值是我们处理完的值,value
            return [RACReturnSignal return:value];
        };
        
    }];
    
    // 订阅绑定信号,不在是源信号
    [bindSignal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
    }];
    
}



- (void)signal
{
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"123"];
        return nil;
    }] ;
    
    // 2.订阅信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
