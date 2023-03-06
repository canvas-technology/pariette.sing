# table information
## website
  - locale: tr-TR // aktif dil
  - locales: ["tr-TR","en-US","de-DE"] // kullanılabilir diller listesi
  - mail_... : hizmet veren mail sağlayıcının vereceği özel bilgiler.
  - mail_password : güvenlik için application_password kullanmaya özen gösterin.
  - cdn_url: görsel sunucusu kök dizin adresi
  - status: 0 pasif kullanılamaz, 1: aktif.
  - publish: site aktif ancak bakımda olduğu için publish false olabilir.
## seo
  - where : site, canvas, vs
  ---
  aşağıdaki 3 tip ve karşılığında seçilebilecek değerler ile özel tanımlar yapılır.
  - type:
  - - link
  - - - rel
  - - - type
  - - - href
  - - meta // label: "name={}", content: "content={}",
  - - - name
  - - - content
  - - script
  - - - type
  - - - src
## users
  default
## canvas
  navigasyon, blog, içerik, carousel, vb her şey için önce canvas üretilir. sonra içerikler ilişkilendirilir.
  - type: ["homepage", "content", "blog", "singlepage", "carousel", ...]
  - publish 1/0 yayına girmeden görüntülemek için status = 1, publish = 0 yapılır. doğrudan linke erişim sağlanır
## content
  - type: canvas.type = homepage olabilir. bu sadece sorgu için geçerli. post.type = içerik tipi olacak.
  - publish: content update edilmez. orjinali publish:2 yapılır ve saklanır. yenisi üretilir ve publish: 1 yapılır. dilendiği zaman publish:2 sorgusu göndererek update geçmişi görüntülenir.
## ticket
  - type: ["destek", "üyelik", "soru", "işlem hatası", ...]
  - user: destek gönderen kullanıcının telefon, isim veya mail adresi
  - content: ticketı oluşturan ilk mesaj.
  - status: 1: aktif, 2: cevaplandı, 3: kapandı - olumlu, 4: kapandı - olumsuz, 5: uzun süredir cevap alınamadı, 0: iptal edildi
## ticket_post
  - writer: cevap verenin telefon, isim veya mail adresi
  - rate: verilen cevaba kullanıcının verdiği tepki
## lookup
  default
## lookup_item
  default
## attachment
  default
## navigation
  default
## navigation_item
  default