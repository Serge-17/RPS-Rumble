//
//  ContentView.swift
//  RPS Rumble




import SwiftUI


struct CustomButtonStyle: ViewModifier {
    var isPressed: Bool

    func body(content: Content) -> some View {
        if isPressed {
            content
                .font(.system(size: 70))
                .padding(.horizontal, 13)
                .background(Color.blue)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
        } else {
            content
                .font(.system(size: 70))
                .padding(.horizontal, 13)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
        }
    }
}

struct GameStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(.primary)
            .padding(10)
            .padding(.horizontal, 50)
            .frame(maxWidth: 350, maxHeight: 30)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 35))
            .shadow(radius: 2, y: 1)
    }
}

struct BlockStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(.primary)
            .padding(10)
            .frame(maxWidth: 350, maxHeight: 30)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 35))
            .shadow(radius: 2, y: 1)
    }
}

struct ContentView: View {
    
    @State private var rpsChoices = ["Камень", "Бумага", "Ножницы"]
    @State private var playerGameStyle = ""
    @State private var computerChoice = ""
    @State private var playerChoice: String = ""
    @State private var isWinner = false
    @State private var isLose = false
    @State private var isPressedRock = false
    @State private var isPressedPaper = false
    @State private var isPressedScissors = false
    
    @State private var correctAttempts = 0
    @State private var incorrectAttempts = 0
    @State private var totalAttempts = 0
    @State private var gameOver = false
    @State private var message = ""
    @State private var isButtonPressed = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack() {
                        Section() {
                            HStack {
                                VStack {
                                    Section("Игрок \u{1F64D}") {
                                        Text(playerChoice)
                                            .modifier(BlockStyle())
                                    }
                                }
                                VStack {
                                    Section("Компьютер \u{1F4BB} ") {
                                        Text(computerChoice)
                                            .modifier(BlockStyle())
                                    }
                                }
                                VStack {
                                    Section("Победа") {
                                        Text(playerGameStyle)
                                            .modifier(BlockStyle())
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    
                    Section("Выиграть или Проиграть") {
                        HStack {
                            Button(action: {
                                playerGameStyle = "Выиграть"
                                isWinner = true
                                isLose = false
                            }) {
                                Text("\u{1F3C6}")
                                    .modifier(CustomButtonStyle(isPressed: isWinner))
                            }
                            
                            Button(action: {
                                playerGameStyle = "Проиграть"
                                isWinner = false
                                isLose = true
                            }) {
                                Text("\u{1F926}")
                                    .modifier(CustomButtonStyle(isPressed: isLose))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .font(.title2.weight(.heavy))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                    
                    
                    Section("Выбирете жест для игры:") {
                        HStack {
                            Button(action: {
                                playerChoice = "Камень"
                                computerChoice = rpsChoices.randomElement() ?? ""
                                isPressedRock = true
                                isPressedPaper = false
                                isPressedScissors = false
                            }) {
                                Text("\u{270A}")
                                    .modifier(CustomButtonStyle(isPressed: isPressedRock))
                            }
                            
                            Button("\u{270B}") {
                                playerChoice = "Бумага"
                                computerChoice = rpsChoices.randomElement() ?? ""
                                isPressedRock = false
                                isPressedPaper = true
                                isPressedScissors = false
                            }
                            .modifier(CustomButtonStyle(isPressed: isPressedPaper))
                            
                            
                            Button("\u{270C}") {
                                playerChoice = "Ножницы"
                                computerChoice = rpsChoices.randomElement() ?? ""
                                isPressedRock = false
                                isPressedPaper = false
                                isPressedScissors = true
                            }
                            .modifier(CustomButtonStyle(isPressed: isPressedScissors))
                            
                        }
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .font(.title2.weight(.heavy))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)

                    VStack(spacing: 10) {
                        Section() {
                            Button("Проверить результат") {
                                gameOverStatus()
                                changeButtonColorTemporarily()
                                isPressedRock = false
                                isPressedPaper = false
                                isPressedScissors = false
                                playerChoice = ""
                                computerChoice = ""
                                
                            }
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.primary)
                            .padding(10)
                            .padding(.horizontal, 50)
                            .frame(maxWidth: 350, maxHeight: 30)
                            .background(.blue.gradient.opacity(0.8))
                            .clipShape(.rect(cornerRadius: 35))
                            .shadow(radius: 2, y: 1)
                            
                            
                            
                        }
                        .alert(isPresented: $gameOver) {
                            Alert(
                                title: Text("Важное сообщение!"),
                                message: Text("Игра завершена, желаете повторить?"),
                                primaryButton: .default(Text("Да")),
                                secondaryButton: .destructive(Text("Нет"))
                                
                            )
                        }
                    }
                    VStack(spacing: 10) {
                        Section("Результаты игры:") {
                            Text("Всего попыток: \(totalAttempts)")
                                .modifier(GameStyle())
                            Text("Выигранных попыток: \(correctAttempts)")
                                .modifier(GameStyle())
                            Text("Проигранных попыток: \(incorrectAttempts)")
                                .modifier(GameStyle())
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.regularMaterial)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    
                }
                .padding(10)
            }
            .navigationTitle("Game Rock Paper Scissors")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Game Rock Paper Scissors")
                        .font(.system(size: 24, weight: .bold)) // Настройка шрифта заголовка
                }
            }
           
        }
        
    }
    
    func gameStatus( _ winorlose: Bool, _ player: String, _ computer: String) -> (Int, Int) {
        switch(winorlose, player, computer) {

        case (true,"Камень", "Ножницы"):
            correctAttempts += 1
        case (true,"Ножницы", "Бумага"):
            correctAttempts += 1
        case (true,"Бумага", "Камень"):
            correctAttempts += 1
            
        case (false,"Ножницы", "Камень"):
            correctAttempts += 1
        case (false,"Бумага", "Ножницы"):
            correctAttempts += 1
        case (false,"Камень", "Бумага"):
            correctAttempts += 1
 
        default:
            incorrectAttempts += 1
        }
        return (correctAttempts, incorrectAttempts)
    }
    
    func gameOverStatus() {
        totalAttempts = correctAttempts + incorrectAttempts
        if totalAttempts == 10 {
            message = "Игра звершена"
            totalAttempts = 0
            correctAttempts = 0
            incorrectAttempts = 0
            gameOver = true
        } else {
            gameStatus(isWinner, playerChoice, computerChoice)
            gameOver = false
        }
    }
    
    func changeButtonColorTemporarily() {
        isButtonPressed = true // Меняем цвет кнопки

        // Возвращаем цвет кнопки обратно через 2 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isButtonPressed = false
        }
    }
    
}

#Preview {
    ContentView()
}
