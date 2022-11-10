//
//  testLiveActivityBundle.swift
//  testLiveActivity
//
//  Created by Mr.C on 2022/11/8.
//

import WidgetKit
import SwiftUI
import ActivityKit


//灵动岛界面配置
struct PizzaDeliveryActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PizzaDeliveryAttributes.self) { context in
            // 创建显示在锁定屏幕上的演示，并在不支持动态岛的设备的主屏幕上作为横幅。
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("你的 \(context.state.driverName) 已在配送中!")
                            .font(.headline)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.secondary)
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.blue)
                                    .frame(width: 50)
                                Image(systemName: "shippingbox.circle.fill")
                                    .foregroundColor(.white)
                                    .padding(.leading, -25)
                                Image(systemName: "arrow.forward")
                                    .foregroundColor(.white.opacity(0.5))
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.white.opacity(0.5))
                                Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                                    .bold()
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.white.opacity(0.5))
                                Image(systemName: "arrow.forward")
                                    .foregroundColor(.white.opacity(0.5))
                                Image(systemName: "house.circle.fill")
                                    .foregroundColor(.green)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        Text("\(context.attributes.numberOfPizzas) 🍕")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                }.padding(5)
                Text("你已付费: \(context.attributes.totalAmount) + ￥3.0 跑腿费💸")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 5)
            }.padding(15)

        } dynamicIsland: { context in
            // 创建显示在动态岛中的内容。
            DynamicIsland {
                //这里创建拓展内容（长按灵动岛）
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.attributes.numberOfPizzas) 煎饼果子", systemImage: "bag")
                        .font(.caption2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                            .font(.caption2)
                    } icon: {
                        Image(systemName: "timer")
                    }
                    .font(.title2)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) 正在配送中!")
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // 点击事件响应在SecneDelegate中
                     Link(destination: URL(string: "livetest://TIM")!) {
                         Label("联系小哥", systemImage: "phone").padding()
                     }.background(Color.accentColor)
                     .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            //下面是紧凑展示内容区（只展示一个时的视图）
            compactLeading: {
                Label {
                    Text("\(context.attributes.numberOfPizzas) 煎饼果子")

                } icon: {
                    Image(systemName: "bag")
                }
                .font(.caption2)
            } compactTrailing: {
                Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            }
            //当多个Live Activities处于活动时，展示此处极小视图
            minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "timer")
                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                    
                }
            }
            .keylineTint(.accentColor)
        }
    }
}
