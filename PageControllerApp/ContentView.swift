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
    
    var subviews = [
        //UIHosting controller untuk menggabungkan SwiftUI ke dalam UIKit
        UIHostingController(rootView: Subview(imageString: "potrait1")),
        UIHostingController(rootView: Subview(imageString: "potrait2")),
        UIHostingController(rootView: Subview(imageString: "potrait3"))
    ]
    
    var body: some View {
        //3 Buat file PageViewController.swift
        //4. Masukan PageViewController ke OnBoardingView
        
        PageViewController(viewControllers: subviews)
        .frame(height: 200)
        
//        Hebat, kami berhasil menerapkan UIPageViewController ke dalam tampilan SwiftUI! Tetapi saat menjalankan aplikasi dalam mode langsung, Anda melihat bahwa saat ini kami tidak dapat menggeser maju dan mundur. Ini karena kami belum menerapkan pola sumber data untuk memberi tahu Pengontrol Tampilan Halaman kami subview apa yang harus ditampilkan ketika pengguna menggeser maju atau mundur.
        
        //Let’s change this by implementing a Coordinator!
        //5 pergi ke PageViewController dan ke Coordinator
    }
}
