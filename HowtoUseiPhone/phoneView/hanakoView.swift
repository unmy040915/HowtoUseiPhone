import SwiftUI

struct hanakoView: View {
    @State private var isPhoneCallActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                VStack {
                    VStack(spacing: 16) {
                        Spacer().frame(height: 40)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)

                        Text("ヤマダハナコ")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("山田花子")
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer().frame(height: 24)

                        HStack(spacing: 20) {
                            ContactButton(icon: "message.fill", label: "メッセージ")
                            ContactButton(icon: "phone.fill", label: "発信", disabled: false, action: {
                                isPhoneCallActive = true
                            })
                            ContactButton(icon: "video.fill", label: "ビデオ通話", disabled: true)
                            ContactButton(icon: "envelope.fill", label: "メール", disabled: true)
                        }
                    }
                    .padding()
                    List {}
                }

                // 遷移先
                NavigationLink(destination: phoneCallView(), isActive: $isPhoneCallActive) {
                    EmptyView()
                }
            }
        }
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

#Preview {
    hanakoView()
}
