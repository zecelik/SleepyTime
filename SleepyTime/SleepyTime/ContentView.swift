//
//  ContentView.swift
//  SleepyTime
//
//  Created by Zehra on 21.01.2025.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
        @State private var isAlarmEnabled: Bool = false
        @State private var sleepTime = Date()
        @State private var wakeTime = Date()
        @State private var isNotificationsEnabled = false
        @State private var sleepDuration: TimeInterval = 0
        @State private var showAlert: Bool = false
     
        @State private var showSuccessMessage = false
        @State private var successMessage = ""
      

      
        
        var body: some View {
            ZStack {
       
                Image("stars3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                    .ignoresSafeArea()
                LinearGradient(
                    colors: [
                        Color(#colorLiteral(red: 0.231333077, green: 0.2144328952, blue: 0.6228075027, alpha: 1)).opacity(0.5),
                        Color(#colorLiteral(red: 0.7350915074, green: 0.5298137069, blue: 0.6990841031, alpha: 1)).opacity(0.6)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
              
                
                
                VStack(spacing: -5) {
       
                    VStack(spacing: 5) {
                        
                        
                        HStack(spacing: 2) {
                            Text("Sleepy")
                                .font(.custom("Avenir-Black", size: 30))
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                            Text("T")
                                .font(.custom("Avenir-Black", size: 35))
                                .foregroundColor(Color.purple)
                                .shadow(color: Color.purple.opacity(0.6), radius: 10, x: 0, y: 0)
                            Text("ime")
                                .font(.custom("Avenir-Black", size: 30))
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        }
                        .kerning(1)
                        .padding(.top, 30)
                        
                        
                    }
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    .padding(.top, 40)
                    .padding(.bottom, 0.01)
                    
                    TimePickerView(sleepTime: $sleepTime, wakeTime: $wakeTime, sleepDuration: $sleepDuration)
                        .frame(height: UIScreen.main.bounds.width + 40)
                        .padding(.horizontal, 52)
                    
                    VStack(spacing: 15) {
                        TimeInfoView(title: "Uyku Zamanı", time: sleepTime)
                        TimeInfoView(title: "Uyanma Zamanı", time: wakeTime)
                        
                      
                        HStack(alignment: .center, spacing: 3) {
                            Text("\(Int(sleepDuration / 3600))")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .frame(width: 50, alignment: .trailing)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [
                                            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                                            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )

                            Text("s")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                             

                            Text("\(Int((sleepDuration.truncatingRemainder(dividingBy: 3600)) / 60))")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .frame(width: 50, alignment: .trailing)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [
                                            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                                            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                        
                                    )
                                    
                                )
                               

                            Text("dk")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
    
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                  
                                  
                    }
                    
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    
                    Button(action: {
                        requestNotificationPermission()
                    }) {
                        HStack(spacing: 25) {
                        
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: isNotificationsEnabled ? "bell.badge.fill" : "bell.badge")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black
                                    )
                            }
                            if showSuccessMessage {
                                Text(successMessage)
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    .foregroundColor(.green)
                                         
                                         
                                          .transition(.scale)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation {
                                                showSuccessMessage = false
                                            }
                                        }
                                    }
                            }
                            
                            Text("Bildirimleri güncelle")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.black)

                            Spacer()
 
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                               
                            
                        }
                        
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .padding(.horizontal, 20)
                        .background(Color.white.opacity(0.8))
                        
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.8))
                            
                         )
                        
                        
                    }
            
                    .padding(.horizontal, 25)
                    .padding(.top, 7)
                    
                    Spacer()
                    Spacer()
                    
                    
                    
                }
            }
            .onChange(of: sleepTime) { _ in
                updateSleepDuration()
            }
            .onChange(of: wakeTime) { _ in
                updateSleepDuration()
            }
            
          
        }
  
  
    
        private func requestNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                DispatchQueue.main.async {
                    isNotificationsEnabled = granted
                    if granted {
                                scheduleNotifications()
                                if isNotificationsEnabled {
                                    successMessage = "başarılı!"
                                }
                                showSuccessMessage = true
                            }
                  
                }
            }
        }
        
        private func scheduleNotifications() {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            
    
            let sleepNotification = createNotification(
                time: sleepTime.addingTimeInterval(-15 * 60),
                title: "İyi Geceler",
                body: "Uyku zamanı yaklaşıyor🌙"
            )

            let wakeNotification = createNotification(
                time: wakeTime.addingTimeInterval(15 * 60),
                title: "Günaydın!",
                body: "Güneş senin için doğdu, her yeni gün bir umut taşıyor☀️"
            )
            
            center.add(sleepNotification) { error in
                if let error = error {
                    print("Uyku bildirimi hatası: \(error)")
                }
            }
            
            center.add(wakeNotification) { error in
                if let error = error {
                    print("Uyanma bildirimi hatası: \(error)")
                }
            }
        }
      
        private func createNotification(time: Date, title: String, body: String) -> UNNotificationRequest {
            let components = Calendar.current.dateComponents([.hour, .minute], from: time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default
            
            return UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
        }
        
        private func updateSleepDuration() {
            let sleepComponents = Calendar.current.dateComponents([.hour, .minute], from: sleepTime)
            let wakeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeTime)
            
            var duration = wakeTime.timeIntervalSince(sleepTime)
            

            if duration < 0 {
                duration = duration + (24 * 3600)
            }
            

            if wakeComponents.hour! < sleepComponents.hour! ||
                (wakeComponents.hour! == sleepComponents.hour! && wakeComponents.minute! < sleepComponents.minute!) {
                duration = duration + (24 * 3600)
            }
            
           
            if duration > (24 * 3600) {
                duration = duration - (24 * 3600)
            }
            
  
            if duration < 3600 {
                duration = 3600
            } else if duration > (20 * 3600) {
                duration = 20 * 3600
            }
            
            sleepDuration = duration
        }
    }
    
    struct TimeInfoView: View {
        let title: String
        let time: Date
        
        var body: some View {
            HStack(spacing: 10) {
                Image(systemName: title.contains("Uyku") ? "moon.stars.fill" : "sun.max.fill")
                    .font(.system(size: 18))
                    .foregroundColor(title.contains("Uyku") ? Color(red: 0.3, green: 0.1, blue: 0.2) : Color.orange)
                
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text(time.formatted(date: .omitted, time: .shortened))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .frame(maxWidth: 300)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    )
            )
            
        }
        
    }
    
    struct TimePickerView: View {
        @Binding var sleepTime: Date
        @Binding var wakeTime: Date
        @Binding var sleepDuration: TimeInterval
        @State private var isDraggingArc = false
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                   
                    Circle()
                        .stroke(Color.black.opacity(0.5), lineWidth: 49)
                    
    
                    ArcShape(startAngle: startAngle, endAngle: endAngle)
                        .stroke(Color.white.opacity(0.6), lineWidth: 49)
                    
                        .contentShape(ArcShape(startAngle: startAngle, endAngle: endAngle))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let vector = CGVector(dx: value.location.x - geometry.size.width / 2,
                                                          dy: value.location.y - geometry.size.height / 2)
                                    let angle = atan2(vector.dy, vector.dx)
                                    let normalizedAngle = (angle + .pi / 2)
                                    
                                    if !isDraggingArc {
                                        isDraggingArc = true
                                    }
                                    
                                    let hours = ((normalizedAngle + 2 * .pi).truncatingRemainder(dividingBy: 2 * .pi)) / (2 * .pi) * 24
                                    
                                    let calendar = Calendar.current
                                    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: sleepTime)
                                    components.hour = Int(hours)
                                    components.minute = Int((hours.truncatingRemainder(dividingBy: 1)) * 60)
                                    
                                    if let newSleepTime = calendar.date(from: components) {
                              
                                        let currentDuration = wakeTime.timeIntervalSince(sleepTime)
                                        sleepTime = newSleepTime
                                        wakeTime = newSleepTime.addingTimeInterval(currentDuration)
                                    }
                                }
                                .onEnded { _ in
                                    isDraggingArc = false
                                }
                        )
                    
       
                    ForEach(0..<24) { hour in
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 2, height: hour % 6 == 0 ? 10 : 5)
                            .offset(y: -geometry.size.width/2 + 40)
                            .rotationEffect(.degrees(Double(hour) * 15))
                    }
                    
            
                    ForEach(0..<12) { i in
                        let hour = i * 2
                        let angle = Double(hour) * 15
                        let radius = geometry.size.width/2 - 60
                        let xPosition = radius * sin(angle * .pi / 180)
                        let yPosition = -radius * cos(angle * .pi / 180)
                        
                        Text("\(hour)")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .position(x: geometry.size.width/2 + xPosition,
                                      y: geometry.size.height/2 + yPosition)
                    }
                    
              
                    TimeHandle(time: $sleepTime, sleepTime: $sleepTime, wakeTime: $wakeTime, color: .blue, radius: geometry.size.width / 2 - 30)
                    TimeHandle(time: $wakeTime, sleepTime: $sleepTime, wakeTime: $wakeTime, color: .orange, radius: geometry.size.width / 2 - 30)
                }
            }
        }
        
        private var startAngle: Angle {
            Angle(degrees: Double(Calendar.current.component(.hour, from: sleepTime)) * 15 +
                  Double(Calendar.current.component(.minute, from: sleepTime)) * 0.25 - 90)
        }
        
        private var endAngle: Angle {
            Angle(degrees: Double(Calendar.current.component(.hour, from: wakeTime)) * 15 +
                  Double(Calendar.current.component(.minute, from: wakeTime)) * 0.25 - 90)
        }
    }
    
    struct ArcShape: Shape {
        let startAngle: Angle
        let endAngle: Angle
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            
            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
            
            return path
        }
    }
    
    struct TimeHandle: View {
        @Binding var time: Date
        @Binding var sleepTime: Date
        @Binding var wakeTime: Date
        let color: Color
        let radius: CGFloat
        
        var body: some View {
            let isWakeHandle = time == wakeTime
            
            ZStack {
   
                if isWakeHandle {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                } else {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                        .frame(width: 32, height: 32)
                }
                
                if isWakeHandle {

                    ZStack {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .shadow(color: .orange.opacity(0.5), radius: 2, x: 0, y: 0)
                    }
                } else {
                
                    Image(systemName: "moon.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }
            .background(
                Circle()
                    .fill(isWakeHandle ? Color.orange.opacity(0.3) : Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3))
                    .frame(width: isWakeHandle ? 42 : 35, height: isWakeHandle ? 42 : 35)
                    .blur(radius: 8)
            )
            .offset(y: -radius)
            .rotationEffect(.degrees(360 * normalizedTime(time)))
            .gesture(
                DragGesture(minimumDistance: -100)
                    .onChanged { value in
                        updateTime(value: value)
                    }
            )
        }
        
        private func normalizedTime(_ date: Date) -> Double {
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)
            let hours = Double(components.hour ?? 0)
            let minutes = Double(components.minute ?? 0)
            return (hours * 60 + minutes) / (24 * 60)
        }
        
        private func updateTime(value: DragGesture.Value) {
            let vector = CGVector(dx: value.location.x, dy: value.location.y)
            let angle = atan2(vector.dy, vector.dx) + .pi/2
            let normalizedAngle = (angle < 0 ? angle + 2 * .pi : angle) / (2 * .pi)
            
            let totalMinutes = normalizedAngle * 24 * 60
          
            let roundedMinutes = round(totalMinutes / 5) * 5
            
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: Date())
            components.hour = Int(roundedMinutes) / 60
            components.minute = Int(roundedMinutes) % 60
            
            if let newTime = calendar.date(from: components) {
                let isSleepTime = time == sleepTime
                let minimumDuration: TimeInterval = 3600
                let maximumDuration: TimeInterval = 20 * 3600
                
                if isSleepTime {
              
                    let wakeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeTime)
                    let newComponents = Calendar.current.dateComponents([.hour, .minute], from: newTime)
                    
                    var timeDifference = wakeTime.timeIntervalSince(newTime)
                    if wakeComponents.hour! < newComponents.hour! {
                        timeDifference = timeDifference + (24 * 3600)
                    }
                    
                
                    if timeDifference >= minimumDuration && timeDifference <= maximumDuration {
                        time = newTime
                    }
                } else {
                 
                    let sleepComponents = Calendar.current.dateComponents([.hour, .minute], from: sleepTime)
                    let newComponents = Calendar.current.dateComponents([.hour, .minute], from: newTime)
                    
                    var timeDifference = newTime.timeIntervalSince(sleepTime)
                    if newComponents.hour! < sleepComponents.hour! {
                        timeDifference = timeDifference + (24 * 3600)
                    }
                    
           
                    if timeDifference >= minimumDuration && timeDifference <= maximumDuration {
                        time = newTime
                    }
                }
            }
            
        }
        
        
    }
    

#Preview {
    ContentView()
}
