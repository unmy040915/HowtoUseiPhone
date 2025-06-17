import SwiftUI
import TipKit

struct phoneCallView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var task: String
    @Binding var tasks: [Task]
    let name: String
    @State private var showCompletePopup = false
    
    var body: some View {
        VStack{
            TaskView(task: $task)
            ZStack{
                //                    Color(red: 128 / 255, green: 131 / 255, blue: 148 / 255)
                //                        .ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Text(name)
                        .font(.title)
                        .foregroundColor(.black)
                    Text("通話中...")
                        .foregroundColor(.gray)
                    Spacer()
                        .frame(height: 40)
                    
                    VStack {
                        HStack(spacing: 30) {
                            CallFunctionButton(icon: "mic.slash.fill", label: "消音")
                            CallFunctionButton(icon: "circle.grid.3x3.fill", label: "キーパッド")
                            CallFunctionButton(icon: "speaker.wave.2.fill", label: "スピーカー")
                        }
                        HStack(spacing: 30) {
                            CallFunctionButton(icon: "plus", label: "通話を追加")
                            CallFunctionButton(icon: "questionmark.circle", label: "FaceTime")
                            CallFunctionButton(icon: "person.crop.circle", label: "連絡先")
                        }
                    }
                    
                    
                    
                    Button(action: {
                        dismiss()
                        if task == "電話を切ろう" {
                            markTaskDone(with: task)
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 80, height: 80)
                            Image(systemName: "phone.down.fill")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        .popoverTip(hungUpTip())
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showCompletePopup) {
                TaskCompletePopupView()
            }
            
            
            
        }
        .task {
            try? Tips.configure([
                .datastoreLocation(.applicationDefault)
            ])
            if task == "電話を切ろう" && tasks[2].isDone == false{
                hungUpTip.isHungUp = true
                try? Tips.resetDatastore()
            }else {
                hungUpTip.isHungUp = false
            }
            
        }
    }
    public func markTaskDone(with title: String) {
        if let index = tasks.firstIndex(where: { $0.title == title }) {
            tasks[index].isDone = true
            showCompletePopup = true
        }
    }
    
    
    struct CallFunctionButton: View {
        let icon: String
        let label: String
        
        var body: some View {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 80)
                    Image(systemName: icon)
                        .font(.system(size: 32))
                    //                    .foregroundColor(.white)
                }
                Text(label)
                    .font(.caption2)
                //                .foregroundColor(.white)
            }
        }
    }
}
