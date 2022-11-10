# LiveActivities

手把手实现IOS灵动岛教程。

Live Activities 依赖于 Widget 实现 函数和页面，而与Widget不同，Live Activities无法访问网络或接收位置更新，更新Live Activities可以使用ActivityKit和远程推送，同时ActivityKit可以控制Live Activities的开始，更新和结束。

灵动岛的启用由我们进行控制，且一个程序可以实现多个灵动岛，但启用最多展示两个

**灵动岛一共有三种样式展示：**

1. 只有一个Live Activities活动时，在灵动岛的左右两个部分显示信息（紧凑级），点击打开App查看详细信息

2. 同时有多个Live Activities活动时，系统最多展示只两个最小级Live Activities活动，一个将紧贴灵动岛，一个单独展示在圆圈内
​
3. 手指按中其中任何一个，系统将展示拓展视图

##一个Live Activities可以运行12小时，灵动到运行8小时，到达8小时系统将自动结束并移到锁屏界面，在锁屏界面可以保持4小时，这是涌用户可以移除或达到4小时系统自动移除。

灵动岛页面需要实现的部分有4个

不支持灵动岛的机型 或 锁屏时的 显示

紧凑级展示（即左右贴合灵动岛的展示）

多Live activity时的展示（即极小视图，左贴合，右分离）

拓展视图（长按时触发）

4. 灵动岛界面需要实现4个部分。
    ① 紧凑级   （紧贴灵动岛的左右部分）
    ② 极小级   （紧贴在灵动岛左侧展示 或 右侧分离展示）
    ③ 拓展视图  （长按紧凑级或极小级时，展示拓展视图）
    ④ 锁屏视图  （锁定屏幕时在屏幕底部展示的视图）

5. 完成上面步骤，Live activity 已经创建好了，启动调用： request(attributes:contentState:pushType:)

    灵动岛的活动状态一共有3种：

    active  处于活动中

    ended 已经终止且不会有任何更新，但依旧在锁屏界面展示

    dismissed 结束且不再展示

6. 更新灵动岛数据（更新的就是在ActivityAttributes中声明的动态数据）：
    方法：update(using:alertConfiguration:)

    Live activity也支持远程推送更新，根据文档以下9点要求实现

        ① 确保主程序已经开通了远程推送功能

        ② 确保启动activity时request(attributes:contentState:pushType:)传入pushType参数（.token）

        ③ 获取启动后的activity的推送令牌pushToken，传给服务端用来推送更新activity

        ④ 服务端推送的更新内容字段需要和ActivityAttributes的ContentState 中定义的动态数据字段对应

        ⑤ 设置推送的报头apns-push-type的值为liveactivity

        ⑥ 设置推送的报头apns-topic的值为<your bundleID>.push-type.liveactivity

        ⑦ 正确的推送对应的内容和状态ba8babsssba

        ⑧ 使用pushTokenUpdates监听pushToken变化，如有变化，就令牌失效，需要将新的令牌传给服务器

        ⑨ 当Activity结束时，服务器端的pushToken将失效

        下面是官方提供的示例：


          {
            "aps": {
                "timestamp": 1168364460,
                "event": "update",
                "content-state": {
                    "driverName": "Anne Johnson",
                    "estimatedDeliveryTime": 1659416400
                },
                "alert": {
                    "title": "Delivery Update",
                    "body": "Your pizza order will arrive soon.",
                    "sound": "example.aiff" 
                }
            }
        }
        可以在aps内设置dissall -date 字段来告诉系统在什么时候移除activity ，eg:  “dismissal-date”: 1663177260

* 不用为推送提供声音 , 如果推送延迟，在activity结束后收到时将被忽略，avtivity每小时有通知预算(数量未明确)，超出后系统将关闭通知*


7. 结束Activity：
     方法：end(using:dismissalPolicy:)

    结束分为两种:

    .default  系统默认，结束后在锁屏界面保留4小时

    .immediate  立即结束，不会在锁屏界面停留



