//
//  PageViewController.swift
//  PageControllerApp
//
//  Created by Ipung Dev Center on 10/08/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//agar UIPageView Controller dapat diembed ke SwiftUi (OnBoardning View) harus dengan Protokol UIViewControllerRepresentable

//Protokol UIViewControllerRepresentable memiliki tiga metode wajib:
//1. makeUIViewController: Metode ini digunakan untuk membuat UIViewController yang ingin kami sajikan.
//2. updateUIViewController: Metode ini mengupdate UIViewController ke konfigurasi terbaru setiap kali dipanggil.
//3. makeCoordinator: Metode ini menginisialisasi Koordinator yang berfungsi sebagai semacam pelayan untuk menangani pola delegasi dan sumber data serta masukan pengguna. Kami akan membicarakan ini lebih detail nanti.

struct PageViewController : UIViewControllerRepresentable{
    
    //17 hubungan dengan binding
    @Binding var currentPageIndex: Int
    
    var viewControllers: [UIViewController]

    
    //6 Sekarang kita dapat menginisialisasi Koordinator dengan memanggil metode makeCoordinator dari protokol UIViewControllerRepresentable.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    //Buat fungsi untuk membuat page controller
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        //9 Karena subkelas Koordinator kami sekarang sesuai dengan protokol UIPageViewControllerDataSource, kami dapat menetapkannya sebagai sumber data PageViewControllers di dalam metode makeViewController kami.

        pageViewController.dataSource = context.coordinator
        
        //21 Metode dipanggil ketika gesekan pengguna selesai. Jika demikian, kami kemudian mengambil subview yang ditampilkan dan menemukan posisinya di dalam array viewControllers. Bergantung pada nilai itu, kita kemudian bisa memperbarui pengikatan currentPageIndex yang juga memperbarui Status saatPageIndex dari OnboardingView.

//        Mirip seperti yang kita lakukan dengan pola sumber data di tutorial terakhir, mari tetapkan Koordinator sebagai delegasi PageViewController di dalam fungsi makeUIViewController.
        pageViewController.delegate = context.coordinator
        
        //22 go to file PageControl.Swift

        //balikan nilai adalah pageViewController
        return pageViewController
    }

    
    //UpdateUIViewController akan dipanggil setiap kali UIPageViewController diperbarui, misalnya saat jumlah tampilan kontennya berubah. Karena kita menggunakan sejumlah statis pengontrol tampilan untuk PageViewController kita, fungsi ini hanya akan dipanggil sekali, yaitu ketika UIPageViewController sedang dirender pertama kali. Ketika ini terjadi, kita harus mengkonfigurasi PageViewController kita dengan mengatur pengontrol tampilan pertama dari array viewControllers untuk ditampilkan terlebih dahulu. Kami melakukan ini dengan menggunakan metode setViewController.

    //    Pada titik ini, PageViewController kita siap untuk disematkan! Kita sekarang bisa memasukkannya ke OnboardingView dengan meneruskan Subview kita. Mari kita juga menambahkan bingkai ke dalamnya. => Cek OnBoarding View
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        print("OK")
        pageViewController.setViewControllers(
//            [viewControllers[0]], direction: .forward, animated: true)
            
            
            //18 update page sesuai binding yaitu berubah sesuai current page
        [viewControllers[currentPageIndex]], direction: .forward, animated: true)
        
    }

   
    
    //5 Koordinator diimplementasikan dengan membuat subclass di dalam PageViewController, yang kemudian bisa kita gunakan untuk mengimplementasikan fungsi sumber data umum yang kita perlukan untuk memberi tahu PageViewController subview mana yang akan ditampilkan saat pengguna menggeser.
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        //7 Seperti yang dikatakan, kami dapat menggunakan Koordinator kami untuk menerapkan pola Kakao umum, seperti delegasi, sumber data, dan menanggapi masukan pengguna. Kami ingin Koordinator kami bertindak sebagai sumber data untuk *UIPageViewController* kami. Jadi, mari sesuaikan Subkelas Koordinator dengan protokol UIPageViewControllerDataSource.

        var parent: PageViewController

        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        
        //20 update state jika ada swipes. Memperbarui currentPageIndex bisa dilakukan dengan pola delegasi. Metode yang tepat untuk digunakan adalah fungsi didFinishAnimating. Karena, seperti yang Anda pelajari di bagian terakhir, tempat yang tepat untuk menyisipkan metode delegasi adalah subkelas Koordinator, mari kita menyesuaikan kelas ini dengan protokol UIPageViewControllerDelegate dan menyisipkan metode didFinishAnimating di sana:
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.viewControllers.firstIndex(of: visibleViewController)
            {
                parent.currentPageIndex = index
            }
        }
        
        

        //8 Protokol ini membutuhkan satu fungsi untuk mengembalikan ViewController kanan setelah ViewController yang sedang ditampilkan dalam larik viewControllers dan satu fungsi untuk mengembalikan ViewController kanan sebelum ViewController yang ditampilkan saat ini dari larik viewControllers kita.

//        Jadi, mari tambahkan metode viewControllerBefore dan viewControllerAfter untuk memberi tahu PageViewController kita tentang pengontrol tampilan dari larik viewControllers yang akan ditampilkan saat pengguna menggeser.
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

            // mengambil indeks dari pengontrol tampilan yang sedang ditampilkan
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }

            // menampilkan pengontrol tampilan terakhir saat pengguna menggeser kembali dari pengontrol tampilan pertama
            if index == 0 {
                return parent.viewControllers.last
            }

            // tunjukkan pengontrol tampilan sebelum pengontrol tampilan yang sedang ditampilkan
            return parent.viewControllers[index - 1]

        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

            // mengambil indeks dari pengontrol tampilan yang sedang ditampilkan
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }

            // menampilkan pengontrol tampilan pertama saat pengguna menggeser lebih jauh dari pengontrol tampilan terakhir
            if index + 1 == parent.viewControllers.count {
                return parent.viewControllers.first
            }

            // tampilkan pengontrol tampilan setelah pengontrol tampilan yang sedang ditampilkan
            return parent.viewControllers[index + 1]
        }
    }
}
