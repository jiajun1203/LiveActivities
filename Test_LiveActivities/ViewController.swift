//
//  ViewController.swift
//  Test_LiveActivities
//
//  Created by Mr.C on 2022/11/8.
//

import UIKit
import ActivityKit
import SwiftUI
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func live_Start(_ sender: Any) {
        startDeliveryPizza()
    }
    
    @IBAction func live_Update(_ sender: Any) {
        updateDeliveryPizza()
    }
    
    
    @IBAction func live_End(_ sender: Any) {
        stopDeliveryPizza()
    }
    
    
    func startDeliveryPizza() {
        //初始化静态数据
        let pizzaDeliveryAttributes = PizzaDeliveryAttributes(numberOfPizzas: 5, totalAmount:"￥99", orderNumber: "23456")
        //初始化动态数据
        let initialContentState = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "快递小哥 🚴🏻", deliveryTimer: Date()...Date().addingTimeInterval(15 * 60))
                                                  
        do {
            //启用灵动岛
            //灵动岛只支持Iphone，areActivitiesEnabled用来判断设备是否支持，即便是不支持的设备，依旧可以提供不支持的样式展示
            if ActivityAuthorizationInfo().areActivitiesEnabled == true{
                
            }
            let deliveryActivity = try Activity<PizzaDeliveryAttributes>.request(
                attributes: pizzaDeliveryAttributes,
                contentState: initialContentState,
                pushType: nil)
            //判断启动成功后，获取推送令牌 ，发送给服务器，用于远程推送Live Activities更新
            //不是每次启动都会成功，当已经存在多个Live activity时会出现启动失败的情况
            if deliveryActivity.activityState == .active{
                _ = deliveryActivity.pushToken
            }
            print("Current activity id -> \(deliveryActivity.id)")
        } catch (let error) {
            print("Error info -> \(error.localizedDescription)")
        }
    }
    
    func updateDeliveryPizza() {
        Task {
            let updatedDeliveryStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "快递小哥 🚴🏻", deliveryTimer: Date()...Date().addingTimeInterval(60 * 60))
            //此处只有一个灵动岛，当一个项目有多个灵动岛时，需要判断更新对应的activity
            for activity in Activity<PizzaDeliveryAttributes>.activities{
                await activity.update(using: updatedDeliveryStatus)
            }
        }
    }
    
    func stopDeliveryPizza() {
        Task {
            for activity in Activity<PizzaDeliveryAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
    
    
    func showAllDeliveries() {
        Task {
            for activity in Activity<PizzaDeliveryAttributes>.activities {
                print("Pizza delivery details: \(activity.id) -> \(activity.attributes)")
            }
        }
    }
}
//ActivityAuthorizationInfo().areActivitiesEnabled
//ActivityAuthorizationInfo().activityEnablementUpdates
