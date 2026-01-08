# Supabase ve Flutter ile Gerçek Zamanlı Todo Listesi

Bu proje, **Supabase** ve **Flutter** kullanarak gerçek zamanlı todo listesi geliştirmeyi göstermektedir.  
Supabase’in `stream` özelliği sayesinde veriler anlık olarak güncellenir ve Flutter tarafında **StreamBuilder** ile kolayca görselleştirilir.

---

## 🚀 Başlangıç

### 1. Paket Kurulumu
![Paket Kurulumu Görseli](images/flutter_pub_add.png)

---

### 2. Supabase Bağlantısı
![Supabase Bağlantısı Görseli](images/main.dart.png)

> Not: Ben projeyi WSL Ubuntu üzerinde çalıştırdım. Siz Docker Desktop, [supabase.com](https://supabase.com) veya kendi sunucunuz üzerinden bağlanabilirsiniz.

---

## 📝 Todo Fonksiyonları
![Fonksiyonlar Görseli](images/todo_functions.png)

- **_addTodo** → Yeni todo ekler  
- **_toggleTodo** → Todo’nun tamamlanma durumunu değiştirir  
- **_deleteTodo** → Todo’yu siler  

---

## 📡 Gerçek Zamanlı Veri Akışı
![StreamBuilder Görseli](images/streambuilder.png)

Bu kısımda iki kritik nokta var:  
- **Stream tanımı** → `todos` tablosunu `primaryKey` üzerinden dinler.  
- **ListView.builder** → Verileri ekrana basar.

---

## 🎨 Demo
![Demo GIF](demo.gif)  
📹 [Demo Videosu]([videos/demo.mp4](https://vimeo.com/1152366163?fl=ip&fe=ec))

---

## ⚙️ Kurulum
1. Repoyu klonlayın:  
   `git clone https://github.com/kullaniciadi/repo-adi.git`  
2. Paketleri yükleyin:  
   `flutter pub get`  
3. Uygulamayı çalıştırın:  
   `flutter run`  

---

## 📌 Notlar
- API anahtarlarını `.env` dosyasında saklayın, repoya eklemeyin.  
- Tasarım basit tutulmuştur, odak gerçek zamanlı veri akışıdır.  

---

## 🤝 Katkı
Pull request’lere açıktır. Hataları veya geliştirme önerilerini **Issues** bölümünden paylaşabilirsiniz.
