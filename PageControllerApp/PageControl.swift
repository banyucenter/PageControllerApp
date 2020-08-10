//
//  PageControl.swift
//  PageControllerApp
//
//  Created by Ipung Dev Center on 10/08/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

//22 Indikator page
struct PageControl : UIViewRepresentable {
    
    //23 Kontrol halaman kita perlu mengetahui berapa banyak halaman yang dimiliki PageViewController. Ia juga perlu mengetahui halaman mana yang sedang ditampilkan. Jadi mari kita buat properti numberOfPages dan buat Binding ke status currentPageIndex dari OnboardingView.
    
    var numberOfPages: Int
    @Binding var currentPageIndex: Int
    
    //24 Mirip dengan protokol UIViewControllerRepresentable, protokol UIViewRepresentable memiliki dua fungsi wajib yang perlu diimplementasikan. Fungsi makeUIView dan updateUIView. Fungsi makeUIView digunakan untuk menginisialisasi UIView untuk pertama kalinya. Fungsi updateUIView dipanggil setiap kali UIView diperbarui.
    
    // Mari kita mulai dengan membuat fungsi makeUIView (pastikan Anda menunjukkan untuk mengembalikan objek UIPageControl setelah panah):
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor.orange
        control.pageIndicatorTintColor = UIColor.gray
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
    
    
    
}
