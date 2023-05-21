//
//  ContentView.swift
//  Shared
//
//  Created by Dean Nunis
//
//  Panther Buddy App
// Who are the users?
// -Chapman Students
// What is the problem they would like to solve?
// -Mental health within students after the pandemic
// What is a scenario when users are going to use your app?
// -All the time, to chat with people, to find people to get lunch with, to get help and get directed to the correct people when you have an emergency
//Define what is the user (Personas)
//Define a scenario and aim of the project
//
//This is A tab view app with 4 sections.
//HomePage: To Do List, Words Of Affermation, and Meditation
//
import SwiftUI
//App Page View
struct ContentView: View {
    //Variables
    
    //todo veiws
    @State private var selection = 1
    @State public var showAddTodoView = false
    
    //Text color
    @State private var colorCategory = 0
    var colors: [Color] = [.black, .red, .cyan, .orange, .blue]
    var colornames = ["black", "red", "cyan", "orange", "blue"]
    @State private var colorIndex = 0
    
    //button color
    var buttonsColor: [Color] = [.green, .yellow, .purple]
    var buttonNames = ["green", "yellow", "purple"]
    @State private var buttonIndex = 0
    
    //words of affermation array
    let array = ["Have an awesome day", "You are beautiful", "You are loved", "Don't be afraid to talk to others", "Today you will acomplish more than u ever expected"]
    //words of affermation
    @State public var currentWords = "Today you will acomplish more than u ever expected"
    
    //group chats
    @State public var eatingArray = ["Annonymous: Anyone want someone to eat with at caf?"]
    @State public var openArray = ["Annonymous: Hosting a volley ball game at dorms today at 2pm!"]
    @State public var anxietyArray = ["Annonymous: Anyone want to study calculus together?"]
    @State public var gamerArray = ["Annonymous: Anyone play Forza Horizion?"]
    
    
    //Meditation timers
    @State var minutes5: Int = 5
    @State var minutes10: Int = 10
    @State var minutes20: Int = 20
    @State var secondsFive: Int = 0
    @State var secondsTen: Int = 0
    @State var secondsTwenty: Int = 0
    @State var timerFivePaused: Bool = true
    @State var timerTenPaused: Bool = true
    @State var timerTwentyPaused: Bool = true
    @State var timerFive: Timer? = nil
    @State var timerTen: Timer? = nil
    @State var timerTwenty: Timer? = nil
    
    //user information
    @State public var person = "Dean"
    @State public var annonymous = false
    @State public var username = "Deano12"
    @State public var pantherEmail = "deannunis@chapman.edu"
    @State private var nickName = "Deano"
    @State private var birthday = "02/12/2002"
    @State private var pass = "Monkey2282"
    @State private var struggle = "Anxiety"
    
    //chat message user types
    @State public var messageToSend = ""
    
    //list of items in Home list
    @State private var users = [
            User(user: "Dean", annonymous: false),
            User(user: "Kevin", annonymous: false),
            User(user: "Shelby", annonymous: false)
    ]
    
    //list of items in ToDo list
    @State public var todos = [
            Todo(name:"Meditate", discription:"Use The Meditation App And Relax Your Self"),
            Todo(name:"Get HomeWork Done", discription:"I have Assignment 3 for math and i have a essay to write"),
            Todo(name:"Eat", discription:"don't forget to eat, whether that be a meal or a snack. Also hydrate!"),
            Todo(name:"Set Alarm", discription:"Set an alarm on your phone so you can wake up tommorow for class"),
            Todo(name:"Get Some Sleep!", discription:"get some sleep so you dont fall asleep in class")
        ]
    
    //list of Items in Let's Talk Tab
    @State public var chats = [
        Chat(person:"Miles", conversations: ["Dean: Hello there!", "Annonymous: Hi Dean"]),
        Chat(person:"Annonymous", conversations: ["Dean: Hello there!", "Annonymous: Hi Dean"]),
        Chat(person:"Kevin", conversations: ["Dean: Hello there!", "Annonymous: Hi Dean"]),
        Chat(person:"Fay", conversations: ["Dean: Hello there!", "Annonymous: Hi Dean"]),
        Chat(person:"Annonymous", conversations: ["Dean: Hello there!", "Annonymous: Hi Dean"])
        ]
    
    //content in the app view
    var body: some View{
        
    //creates the tab view
    TabView(selection: $selection) {
        
        //tab view "Home Page"
        NavigationView{
            //list of items
            List{
                Text("Welcome \(person)")
                    .foregroundColor(colors[colorIndex])
                    .bold()
                if annonymous {
                    Text("Currently Annonymous")
                        .foregroundColor(colors[colorIndex])
                        .bold()
                }else{
                    Text("Currently Not Annonymous")
                        .foregroundColor(colors[colorIndex])
                        .bold()
                }
                //todo list
                NavigationLink(destination:
                    VStack{
                        List{
                        //Shows through each item in list using there id(name)
                            ForEach(todos, id:\.name){ (todo) in
                            //creates a link to the information in the Hstack using the Vstack as a front
                                NavigationLink(destination:
                                //what the link displays
                                    VStack{
                                        Text(todo.name)
                                        Spacer()
                                        Text(todo.discription)
                                        Spacer()
                                    }
                                ){
                                //what links displays
                                    HStack{
                                        Text(todo.name)
                                    }
                                }
                            }
                            .onDelete(perform: { indexSet in
                                todos.remove(atOffsets: indexSet)
                            })
                            .onMove(perform: { indices, newOffset in
                                todos.move(fromOffsets: indices, toOffset: newOffset)
                            })
                        }.navigationBarTitle("Todo Items")
                            .navigationBarItems(
                                leading: Button("Add"){
                                    self.showAddTodoView.toggle()
                                }.sheet(isPresented: $showAddTodoView){
                                    AddTodoView(showAddTodoView: self.$showAddTodoView, todos:self.$todos)
                                },
                                trailing: EditButton()
                            
                            )
                    }
                ){
                    HStack{
                        Text("To Do List")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 120)
                            .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //words of Affirmation
                NavigationLink(destination:
                    VStack{
                        let randomElement = array.randomElement()!
                        Text("Todays Words:")
                            .foregroundColor(colors[colorIndex])
                        Spacer()
                        Text(randomElement)
                            .foregroundColor(colors[colorIndex])
                        Spacer()
                    }
                ){
                    HStack{
                        Text("Words Of Affirmation")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 120)
                            .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //meditation
                NavigationLink(destination:
                    VStack{
                        Text("Meditation for:")
                        .foregroundColor(colors[colorIndex])
                    Spacer()
                    //five minute timer: Dean
                    NavigationLink(destination:
                                    VStack {
                                       Text("\(minutes5):\(secondsFive)")
                                        if timerFivePaused {
                                            HStack {
                                                Button(action:{
                                                    self.restartFiveTimer()
                                                }){
                                                    Image(systemName: "arrow.clockwise")
                                                        .padding(.all)
                                                }
                                                .padding(.all)
                                                Button(action:{
                                                    self.startFiveTimer()
                                                }){
                                                    Image(systemName: "play.fill")
                                                        .padding(.all)
                                                }
                                                .padding(.all)
                                            }
                                        } else {
                                            Button(action:{
                                                print("STOP")
                                                self.stopFiveTimer()
                                            }){
                                                Image(systemName: "stop.fill")
                                                    .padding(.all)
                                            }
                                            .padding(.all)
                                        }
                                    }
                    ){
                        HStack{
                            Text("5 mins")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 120)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    Spacer()
                    //10min Timer
                    NavigationLink(destination:
                                    VStack {
                                       Text("\(minutes10):\(secondsTen)")
                                        if timerTenPaused {
                                            HStack {
                                                Button(action:{
                                                    self.restartTenTimer()
                                                }){
                                                    Image(systemName: "arrow.clockwise")
                                                        .padding(.all)
                                                }
                                                .padding(.all)
                                                Button(action:{
                                                    self.startTenTimer()
                                                }){
                                                    Image(systemName: "play.fill")
                                                        .padding(.all)
                                                }
                                                .padding(.all)
                                            }
                                        } else {
                                            Button(action:{
                                                print("STOP")
                                                self.stopTenTimer()
                                            }){
                                                Image(systemName: "stop.fill")
                                                    .padding(.all)
                                            }
                                            .padding(.all)
                                        }
                                    }
                    ){
                        HStack{
                            Text("10 mins")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 120)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    Spacer()
                    //20 minute timer
                    NavigationLink(destination:
                                    VStack {
                                       Text("\(minutes20):\(secondsTwenty)")
                                        if timerTwentyPaused {
                                            HStack {
                                                Button(action:{
                                                    self.restartTwentyTimer()
                                                }){
                                                    Image(systemName: "arrow.clockwise")
                                                        .padding(.all)
                                                }
                                                .padding(.all)
                                                Button(action:{
                                                    self.startTwentyTimer()
                                                }){
                                                    Image(systemName: "play.fill")
                                                        .padding(.all)
                                                }
                                                .padding(.all)
                                            }
                                        } else {
                                            Button(action:{
                                                print("STOP")
                                                self.stopTwentyTimer()
                                            }){
                                                Image(systemName: "stop.fill")
                                                    .padding(.all)
                                            }
                                            .padding(.all)
                                        }
                                    }
                    ){
                        HStack{
                            Text("20 mins")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 120)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    Spacer()
                    }
                ){
                    HStack{
                        Text("Meditation")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 120)
                            .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
            }.navigationBarTitle("Panther Buddy Home")
        }
            .tabItem {//end of tab 1/home page
                Image(systemName: "1.circle")
                Text("Home Page")
                
            }.tag(1)
        //tab view "Let's Talk"
        NavigationView{
            //list of items
            List{
                //Existing conversations
                NavigationLink(destination:
                    VStack{
                        List{
                            //Shows through each item in list using there id(person)
                            ForEach(chats, id:\.person){ (chat) in
                                NavigationLink(destination:
                                    VStack{
                                        Text(chat.person)
                                            .foregroundColor(colors[colorIndex])
                                        List{
                                            ForEach(chat.conversations, id: \.self) { (sentance) in
                                                Text(sentance)
                                                    .foregroundColor(colors[colorIndex])
                                            }
                                        }
                                        HStack{
                                            TextField("Chat Here", text: $messageToSend)
                                                .foregroundColor(colors[colorIndex])
                                            Button("Send") {
                                                let wonder = chat.person
                                                var number = 0
                                                if(wonder == "miles"){
                                                    number = 0
                                                }
                                                if(wonder == "Annonymouse"){
                                                    number = 1
                                                }
                                                if(wonder == "Kevin"){
                                                    number = 2
                                                }
                                                if(wonder == "Fay"){
                                                    number = 3
                                                }
                                                if(wonder == "Annonymouse"){
                                                    number = 4
                                                }
                                                if(annonymous){
                                                    chats[number].conversations.append("Annonymous: \(messageToSend)")
                                                }else{
                                                    chats[number].conversations.append("\(person): \(messageToSend)")
                                                }
                                                messageToSend = ""
                                            }
                                        }
                                    }
                                ){
                                    HStack{
                                        Text(chat.person)
                                            .foregroundColor(colors[colorIndex])
                                    }
                                }
                            }
                            .onDelete(perform: { indexSet in
                                    todos.remove(atOffsets: indexSet)
                            })
                            .onMove(perform: { indices, newOffset in
                                    todos.move(fromOffsets: indices, toOffset: newOffset)
                            })
                        }.navigationBarTitle("Existing Conversations")
                        .navigationBarItems(trailing: EditButton())
                    }
                ){
                    HStack{
                        Text("Existing Conversation")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 240, height: 160)
                            .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //finding someone anonymous
                NavigationLink(destination:
                    VStack{
                        Text("Find Someone To Chat With")
                        .foregroundColor(colors[colorIndex])
                        .padding()
                        NavigationLink(destination:
                            VStack{
                                Text("A new anonymous person will be added to your existing conversations!")
                                    .foregroundColor(colors[colorIndex])
                                Button("Press To Add Pserson") {
                                    chats.append(Chat(person: "Anoymous", conversations: ["Anonymous: Hello!"]))
                                }
                                    .foregroundColor(colors[colorIndex])
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 240, height: 160)
                                    .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                            }
                        ){
                            HStack{
                                Text("Find New Anonymous person")
                                    .foregroundColor(colors[colorIndex])
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 240, height: 160)
                                    .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                            }
                        }
                    //add new person
                    NavigationLink(destination:
                        VStack{
                            Text("A new non-anonymous person will be added to your existing conversation")
                                .foregroundColor(colors[colorIndex])
                            Button("Press To Add Pserson") {
                                let nameArray = ["Steve","Jenna","Sips","Ronan","Lily","Micheal","Devon"]
                                let randomElement = nameArray.randomElement()!
                                chats.append(Chat(person: randomElement, conversations: ["\(randomElement): Hello!"]))
                            }
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 240, height: 160)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    ){
                        HStack{
                            Text("Find New Non-Annonymous person")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 240, height: 160)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    }
                ){
                    HStack{
                        Text("Find Someone To Chat With")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 160)
                            .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //chat rooms
                NavigationLink(destination:
                    VStack{
                        Text("Chat Rooms")
                            .foregroundColor(colors[colorIndex])
                            .bold()
                        Text("These are ment for you to")
                            .foregroundColor(colors[colorIndex])
                        Text("talk with others and ask")
                            .foregroundColor(colors[colorIndex])
                        Text("for help as well as just chat")
                            .foregroundColor(colors[colorIndex])
                    NavigationLink(destination:
                        VStack{
                            Text("Eating Disorders")
                                .foregroundColor(colors[colorIndex])
                            List{
                                ForEach(eatingArray, id: \.self){ arr in
                                    Text(arr)
                                }
                            }
                            HStack{
                                TextField("Chat Here", text: $messageToSend)
                                    .foregroundColor(colors[colorIndex])
                                Button("Send") {
                                    if(annonymous){
                                        eatingArray.append("Annonymous: \(messageToSend)")
                                    }else{
                                        eatingArray.append("\(person): \(messageToSend)")
                                    }
                                    messageToSend = ""
                                }
                            }
                        }
                    ){
                        HStack{
                            Text("Eating Disorders")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 160)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    NavigationLink(destination:
                        VStack{
                            Text("Open Chat Room")
                                .foregroundColor(colors[colorIndex])
                            List{
                                ForEach(openArray, id: \.self){ arr in
                                    Text(arr)
                                }
                            }
                            HStack{
                                TextField("Chat Here", text: $messageToSend)
                                    .foregroundColor(colors[colorIndex])
                                Button("Send") {
                                    if(annonymous){
                                        openArray.append("Annonymous: \(messageToSend)")
                                    }else{
                                        openArray.append("\(person): \(messageToSend)")
                                    }
                                    messageToSend = ""
                                }
                            }
                        }
                    ){
                        HStack{
                            Text("Open Chat Room")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 160)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    NavigationLink(destination:
                        VStack{
                            Text("Anxiety Help Room")
                                .foregroundColor(colors[colorIndex])
                            List{
                                ForEach(anxietyArray, id: \.self){ arr in
                                    Text(arr)
                                }
                            }
                            HStack{
                                TextField("Chat Here", text: $messageToSend)
                                    .foregroundColor(colors[colorIndex])
                                Button("Send") {
                                    if(annonymous){
                                        anxietyArray.append("Annonymous: \(messageToSend)")
                                    }else{
                                        anxietyArray.append("\(person): \(messageToSend)")
                                    }
                                    messageToSend = ""
                                }
                            }
                        }
                    ){
                        HStack{
                            Text("Anxiety Help Room")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 160)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    NavigationLink(destination:
                        VStack{
                            Text("Gamers Room")
                                .foregroundColor(colors[colorIndex])
                            List{
                                ForEach(gamerArray, id: \.self){ arr in
                                    Text(arr)
                                }
                            }
                            HStack{
                                TextField("Chat Here", text: $messageToSend)
                                    .foregroundColor(colors[colorIndex])
                                Button("Send") {
                                    if(annonymous){
                                        gamerArray.append("Annonymous: \(messageToSend)")
                                    }else{
                                        gamerArray.append("\(person): \(messageToSend)")
                                    }
                                    messageToSend = ""
                                }
                            }
                        }
                    ){
                        HStack{
                            Text("Gamers Room")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 160)
                                .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    }
                ){
                    HStack{
                        Text("Chat Rooms")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 160)
                            .background(Capsule().fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                
            }.navigationBarTitle("Chats")
        }
            .tabItem {//end of tab 2
                Image(systemName: "2.circle")
                Text("Lets Talk")
                    .foregroundColor(colors[colorIndex])
            }.tag(2)
        //tab three, prifile and customization
        //User Information
        NavigationView{
            List{
                NavigationLink(destination:
                    VStack{
                        List{
                            //username
                            HStack{
                                Text("User:")
                                    .foregroundColor(colors[colorIndex])
                                TextField("Username", text: $username)
                                    .foregroundColor(colors[colorIndex])
                            }
                            //password
                            HStack{
                                Text("Pass:")
                                    .foregroundColor(colors[colorIndex])
                                TextField("Password", text: $pass)
                                    .foregroundColor(colors[colorIndex])
                            }
                            //birthday
                            HStack{
                                Text("Birthday:")
                                    .foregroundColor(colors[colorIndex])
                                TextField("Birthday", text: $birthday)
                                    .foregroundColor(colors[colorIndex])
                            }
                            //nickname
                            HStack{
                                Text("Nickname:")
                                    .foregroundColor(colors[colorIndex])
                                TextField("NickName", text: $nickName)
                                    .foregroundColor(colors[colorIndex])
                            }
                            //email
                            HStack{
                                Text("Email:")
                                    .foregroundColor(colors[colorIndex])
                                TextField("Panther Email", text: $pantherEmail)
                                    .foregroundColor(colors[colorIndex])
                            }
                            //mental health problem
                            HStack{
                                Text("Struggle:")
                                    .foregroundColor(colors[colorIndex])
                                TextField("Struggle", text: $struggle)
                                    .foregroundColor(colors[colorIndex])
                            }
                        }.navigationBarTitle("User Information")
                    }
                ){
                    HStack{
                        Text("User Information")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 120)
                            .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //color customization
                NavigationLink(destination:
                    VStack{
                    Text("Color Customizaation")
                        .foregroundColor(colors[colorIndex])
                    NavigationLink(destination:
                        VStack{
                            Text("Changing Text Color")
                            .foregroundColor(colors[colorIndex])
                        Picker(selection: $colorIndex, label: Text("Color")){
                                ForEach(0 ..< colornames.count){
                                    Text(colornames[$0])
                                        .foregroundColor(colors[$0])
                                }
                        }.pickerStyle(.wheel)
                        }
                    ){
                        HStack{
                            Text("Change Text Color")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 120)
                                .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    NavigationLink(destination:
                        VStack{
                            Text("Changing Button Color")
                                .foregroundColor(colors[colorIndex])
                            Picker(selection: $buttonIndex, label: Text("Color")){
                                ForEach(0 ..< buttonNames.count){
                                    Text(buttonNames[$0])
                                        .foregroundColor(buttonsColor[$0])
                                            }
                            }.pickerStyle(.wheel)
                        }
                    ){
                        HStack{
                            Text("Change Button color")
                                .foregroundColor(colors[colorIndex])
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 220, height: 120)
                                .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                        }
                    }
                    }
                ){
                    HStack{
                        Text("Color Customization")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 250, height: 120)
                            .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //change if anonymous
                NavigationLink(destination:
                    VStack{
                        if annonymous{
                            Text("Annonymous")
                                .foregroundColor(colors[colorIndex])
                        }else{
                            Text(person)
                                .foregroundColor(colors[colorIndex])
                        }
                        Button("Press Me To Become Annonymous") {
                            if(annonymous == false){
                                annonymous = true
                            }
                        }
                        .padding()
                        .padding()
                        Button("Press Me To Become not Annonymous") {
                            if(annonymous == true){
                                annonymous = false
                            }
                        }
                    }
                ){
                    HStack{
                        Text("Annonymous")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 230, height: 120)
                            .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
            }.navigationBarTitle("Profile/Customization")
        }
            .tabItem {//End of tab 3
                Image(systemName: "3.circle")
                Text("Profile/Customization")
                    .foregroundColor(colors[colorIndex])
            }.tag(3)
        //tab four
        NavigationView{
            //list of items
            List{
                //privacy policy
                NavigationLink(destination:
                    VStack{
                        Text("Privacy Policy")
                        .foregroundColor(colors[colorIndex])
                            .bold()
                        Spacer()
                        Text("Some Privacy Policy")
                        .foregroundColor(colors[colorIndex])
                        Spacer()
                    }
                ){
                    HStack{
                        Text("Privacy Policy")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 120)
                            .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //Crisis Button
                NavigationLink(destination:
                    VStack{
                        Text("Crisis Button")
                        .foregroundColor(colors[colorIndex])
                            .bold()
                        Spacer()
                        Text("If you are having a crisis")
                        .foregroundColor(colors[colorIndex])
                        Text("call the suicide hotline at:")
                        .foregroundColor(colors[colorIndex])
                        .padding()
                        Text("800-273-talk(8255))")
                        .foregroundColor(colors[colorIndex])
                        .padding()
                        Text("(800) 273-8255")
                        .foregroundColor(Color.blue)
                        Spacer()
                    }
                ){
                    HStack{
                        Text("Crisis Button")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 220, height: 120)
                            .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
                //contact chapman
                NavigationLink(destination:
                    VStack{
                        Text("Contact Chapman Psychological Services")
                        .foregroundColor(colors[colorIndex])
                            .bold()
                        Text("Link to Student Psychological Counseling Services:")
                        .foregroundColor(colors[colorIndex])
                        .padding()
                        Text("https://www.chapman.edu/students/health-and-safety/psychological-counseling/index.aspx")
                        .foregroundColor(Color.blue)
                        .padding()
                        Text("After Hours number:")
                        .foregroundColor(colors[colorIndex])
                            .bold()
                        Text("(714) 997-6778")
                        .foregroundColor(Color.blue)
                        Text("Campus Safety Phone Number:")
                        .foregroundColor(colors[colorIndex])
                            .bold()
                        Text("(714) 997-6763")
                        .foregroundColor(Color.blue)
                    }
                ){
                    HStack{
                        Text("Contact Chapman Psychological Services")
                            .foregroundColor(colors[colorIndex])
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 240, height: 160)
                            .background(RoundedRectangle(cornerRadius: CGFloat(20)).fill(buttonsColor[buttonIndex]).shadow(radius: 3))
                    }
                }
            }.navigationBarTitle("Resorces")
        }
            .tabItem {//end of tab 4
                Image(systemName: "4.circle")
                Text("Resorces")
                    .foregroundColor(colors[colorIndex])
            }.tag(4)
    }.font(.largeTitle)
    }
    //5min tiemr
    func startFiveTimer(){
     timerFivePaused = false
     timerFive = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
         if self.secondsFive == 0 {
             self.secondsFive = 59
             if self.minutes5 == 0 {
                 self.minutes5 = 0
             } else {
                 self.minutes5 = self.minutes5 - 1
             }
         } else {
             self.secondsFive = self.secondsFive - 1
         }
     }
    }
    //10min timer
    func startTenTimer(){
     timerTenPaused = false
     timerTen = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
         if self.secondsTen == 0 {
             self.secondsTen = 59
             if self.minutes10 == 0 {
                 self.minutes10 = 0
             } else {
                 self.minutes10 = self.minutes10 - 1
             }
         } else {
             self.secondsTen = self.secondsTen - 1
         }
     }
    }
    //20min timer
    func startTwentyTimer(){
     timerTwentyPaused = false
     timerTwenty = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
         if self.secondsTwenty == 0 {
             self.secondsTwenty = 59
             if self.minutes20 == 0 {
                 self.minutes20 = 0
             } else {
                 self.minutes20 = self.minutes20 - 1
             }
         } else {
             self.secondsTwenty = self.secondsTwenty - 1
         }
     }
    }
    
    //stop 5min meditation timers
    func stopFiveTimer(){
        timerFivePaused = true
        timerFive?.invalidate()
        timerFive = nil
    }
    //stop 10min meditation timers
    func stopTenTimer(){
        timerTenPaused = true
        timerTen?.invalidate()
        timerTen = nil
    }
    //stop 20min  meditation timers
    func stopTwentyTimer(){
        timerTwentyPaused = true
        timerTwenty?.invalidate()
        timerTwenty = nil
    }
    
    //reset 5min meditation timers
    func restartFiveTimer(){
        minutes5 = 5
        secondsFive = 0
    }
    //reset 10min meditation timers
    func restartTenTimer(){
        minutes10 = 10
        secondsTen = 0
    }
    //reset 20min meditation timers
    func restartTwentyTimer(){
        minutes20 = 20
        secondsTwenty = 0
    }
}
//for Todo wiring
struct Todo: Identifiable{
    let id = UUID()
    let name: String
    let discription: String
}
//for Chat wiring
struct Chat {
    var person: String
    var conversations: [String] = []
}
//for user wiring
struct User {
    let user: String
    let annonymous: Bool
}
//for adding todos
struct AddTodoView: View {
    @Binding var showAddTodoView: Bool
    @State private var name: String = ""
    @State private var discription: String = ""
    @State private var selectedCategory = 0
    @Binding var todos: [Todo]
    var body: some View{
        VStack{
            Text("Add Todo").font(.largeTitle)
            TextField("To Do name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black).padding()
            Text("Write a description")
            TextField("discription", text: $discription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black).padding()
        }.padding()
        Button("Done"){
            self.showAddTodoView = false
            todos.append(Todo(name: name, discription: discription))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
