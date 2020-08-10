//
//  ContentView.swift
//  PageControllerApp
//
//  Created by Ipung Dev Center on 10/08/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Subview(imageString: "potrait1")
        OnboardingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//1 buat kerangka view tampilan image
struct Subview : View {
    var imageString: String
    var body : some View {
        Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}

//2 Komponen utama menampung data dengan Page Controller yang bisa ditap gesture
struct OnboardingView: View {
    
    //10 state untuk mengecek posisi index page
    @State var currentPageIndex = 0
    
    //15 var titles = ["Take some time out", "Conquer personal hindrances", "Create a peaceful mind"]
    var captions =  ["Take your time out and bring awareness into your everyday life", "Meditating helps you dealing with anxiety and other psychic problems", "Regular medidation sessions creates a peaceful inner mind"]
    
    var subviews = [
        //UIHosting controller untuk menggabungkan SwiftUI ke dalam UIKit
        UIHostingController(rootView: Subview(imageString: "potrait1")),
        UIHostingController(rootView: Subview(imageString: "potrait2")),
        UIHostingController(rootView: Subview(imageString: "potrait3"))
    ]
    
    var body: some View {
        //3 Buat file PageViewController.swift
        //4. Masukan PageViewController ke OnBoardingView
        
        //11 implementasi dalam Vstack
        VStack{
            //            PageViewController(viewControllers: subviews)
            //                .frame(height: 200)
            
            
             //19 Sekarang kita harus memperbarui inisialisasi PageViewController di dalam OnboardingView dengan mengikatnya ke Status currentPageIndex dari OnboardingView:
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
            .frame(height: 600)
            
            
            //16 tambahkan data text
//            Text(titles[currentPageIndex])
//                .font(.title)
//            Text(captions[currentPageIndex])
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                .frame(width: 300, height: 50, alignment: .leading)
//                .lineLimit(nil)
            
            //13 aksi button
            Button(action: {
                if self.currentPageIndex+1 == self.subviews.count {
                    self.currentPageIndex = 0
                } else {
                    self.currentPageIndex += 1
                }
            }) {
                ButtonContent()
            }
            
            //14 teks sementara
            Text("Currently shown page: \(currentPageIndex)")
            PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
        }
        
        
        //        Hebat, kami berhasil menerapkan UIPageViewController ke dalam tampilan SwiftUI! Tetapi saat menjalankan aplikasi dalam mode langsung, Anda melihat bahwa saat ini kami tidak dapat menggeser maju dan mundur. Ini karena kami belum menerapkan pola sumber data untuk memberi tahu Pengontrol Tampilan Halaman kami subview apa yang harus ditampilkan ketika pengguna menggeser maju atau mundur.
        
        //Let’s change this by implementing a Coordinator!
        //5 pergi ke PageViewController dan ke Coordinator
    }
}

//12 Button Content
struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .padding()
            .background(Color.orange)
            .cornerRadius(30)
    }
}
