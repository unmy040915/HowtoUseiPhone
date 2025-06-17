import SwiftUI

struct hanakoView: View {
    @State private var isPhoneCallActive = false
    @Binding var task: String
    let name: String
    @Binding var tasks: [Task]
    @State private var showCompletePopup = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                VStack {
                    VStack(spacing: 16) {
                        TaskView(task: $task)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)

                        Text(katakanaName(from: name))
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(name)
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer().frame(height: 24)

                        HStack(spacing: 20) {
                            ContactButton(icon: "message.fill", label: "メッセージ")
                            ContactButton(icon: "phone.fill", label: "発信", disabled: false, action: {
                                isPhoneCallActive = true
                                if task == "電話をかけよう" {
                                    markTaskDone(with: task)
                                }
                            })
                            ContactButton(icon: "video.fill", label: "ビデオ通話", disabled: true)
                            ContactButton(icon: "envelope.fill", label: "メール", disabled: true)
                        }
                    }
                    .padding()
                    List {}
                }

                NavigationLink(destination: phoneCallView(task: $task, tasks: $tasks, name: name), isActive: $isPhoneCallActive) {
                    EmptyView()
                }
            }
            .sheet(isPresented: $showCompletePopup) {
                TaskCompletePopupView()
            }
        }
        
    }

    // 名前に応じたカタカナ表記（仮）
    func katakanaName(from name: String) -> String {
        switch name {
        case "山田太郎":
            return "ヤマダタロウ"
        case "山田花子":
            return "ヤマダハナコ"
        default:
            return "ヤマダ"
        }
    }
    public func markTaskDone(with title: String) {
        if let index = tasks.firstIndex(where: { $0.title == title }) {
            tasks[index].isDone = true
            showCompletePopup = true
        }
    }

    struct ContactButton: View {
        let icon: String
        let label: String
        var disabled: Bool = false
        var action: (() -> Void)? = nil
        
        var body: some View {
            VStack {
                Button(action: {
                    if !disabled {
                        action?()
                    }
                }) {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(disabled ? Color(red: 153 / 255, green: 155 / 255, blue: 168 / 255) : .white)
                }
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(disabled ? Color(red: 153 / 255, green: 155 / 255, blue: 168 / 255) : .white)
            }
            .frame(width: 70, height: 70)
            .background(Color(red: 128 / 255, green: 131 / 255, blue: 148 / 255))
            .cornerRadius(12)
            .shadow(radius: 1)
        }
    }
}
