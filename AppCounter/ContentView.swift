//
//  ContentView.swift
//  AppCounter
//
//  Created by Otávio Pontes on 25/07/23.
//

import SwiftUI

class Counter: ObservableObject{
    
   @Published var seconds = 0
    @Published var minutes = 0
    @Published var hours = 0
    @Published var days = 0
  
    var selectedDate = Date()
    
    init() {
        let calendar = Calendar.current
        Timer.scheduledTimer(withTimeInterval:1.0,  repeats: true){
            timer in
            
            let selectedComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.selectedDate
            )
            
            let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: Date.now
            )
            
           
            
            let currentDate = calendar.date(from: components)
            
            
            
            var eventDateComponents = DateComponents()
            
            eventDateComponents.year = selectedComponents.year
            eventDateComponents.month = selectedComponents.month
            eventDateComponents.day = selectedComponents.day
            eventDateComponents.hour = selectedComponents.hour
            eventDateComponents.minute = selectedComponents.minute
            eventDateComponents.second = selectedComponents.second
            
            let eventDate = calendar.date(from: eventDateComponents)
            
            let timeLeft = calendar.dateComponents([.day,.hour,.minute,.second], from: currentDate!, to: eventDate!)
            
            
            if(timeLeft.second! >= 0){
                self.seconds = timeLeft.second!
                self.minutes = timeLeft.minute!
                self.hours = timeLeft.hour!
                self.days = timeLeft.day!
            }
            
        }
    }
}


struct ContentView: View {
    
  @StateObject  var counter = Counter()
    var body: some View {
        VStack {
            
            DatePicker(selection: $counter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute,.date],label: {
                Text("Selecione a data:")
            })
            Spacer()
                    .frame(height: 50)
            HStack{

                Text("\(counter.days) dias")
                Text("\(counter.hours) horas")
                Text("\(counter.minutes) min")
                Text("\(counter.seconds) seg")
            }
        }
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
