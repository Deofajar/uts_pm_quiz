import '../models/question.dart';

// Bank soal (data lokal, tanpa database).
// Key = id mapel di subject_data.dart, value = 10 soal mapel tersebut.
// correctIndex: 0 = A, 1 = B, 2 = C, 3 = D.
const Map<String, List<Question>> questionBank = {
  // ======================= MATEMATIKA =======================
  'matematika': [
    Question(
      question: 'Berapakah hasil dari 3² + 4²?',
      options: ['7', '12', '25', '49'],
      correctIndex: 2,
      explanation: '3² + 4² = 9 + 16 = 25.',
    ),
    Question(
      question: 'Jika 2x + 5 = 17, berapakah nilai x?',
      options: ['6', '11', '7', '8,5'],
      correctIndex: 0,
      explanation: '2x = 17 − 5 = 12, sehingga x = 12 : 2 = 6.',
    ),
    Question(
      question: 'Berapakah 15% dari 200?',
      options: ['15', '20', '25', '30'],
      correctIndex: 3,
      explanation: '15% × 200 = 15/100 × 200 = 30.',
    ),
    Question(
      question: 'Akar kuadrat dari 144 adalah ...',
      options: ['11', '12', '14', '16'],
      correctIndex: 1,
      explanation: '12 × 12 = 144, jadi √144 = 12.',
    ),
    Question(
      question: 'Jumlah besar sudut dalam sebuah segitiga adalah ...',
      options: ['90°', '360°', '180°', '270°'],
      correctIndex: 2,
      explanation: 'Jumlah ketiga sudut dalam segitiga selalu 180°.',
    ),
    Question(
      question: 'Luas lingkaran berjari-jari 7 cm (π = 22/7) adalah ...',
      options: ['44 cm²', '154 cm²', '49 cm²', '22 cm²'],
      correctIndex: 1,
      explanation: 'L = πr² = 22/7 × 7 × 7 = 154 cm².',
    ),
    Question(
      question: 'Suku ke-10 dari barisan 3, 7, 11, 15, ... adalah ...',
      options: ['40', '43', '35', '39'],
      correctIndex: 3,
      explanation: 'a = 3 dan b = 4, maka U10 = 3 + 9 × 4 = 39.',
    ),
    Question(
      question: 'Nilai dari 2⁵ adalah ...',
      options: ['32', '10', '25', '64'],
      correctIndex: 0,
      explanation: '2⁵ = 2 × 2 × 2 × 2 × 2 = 32.',
    ),
    Question(
      question: 'Peluang muncul mata dadu genap pada satu kali lemparan adalah ...',
      options: ['1/6', '1/2', '1/3', '2/3'],
      correctIndex: 1,
      explanation: 'Mata genap ada 3 (2, 4, 6) dari 6, jadi peluangnya 3/6 = 1/2.',
    ),
    Question(
      question: 'Gradien garis y = 3x − 2 adalah ...',
      options: ['−2', '2', '3', '−3'],
      correctIndex: 2,
      explanation: 'Pada bentuk y = mx + c, gradiennya m, yaitu 3.',
    ),
  ],

  // ========================= FISIKA =========================
  'fisika': [
    Question(
      question: 'Satuan SI untuk gaya adalah ...',
      options: ['Joule', 'Newton', 'Watt', 'Pascal'],
      correctIndex: 1,
      explanation: 'Gaya diukur dalam newton (N), yaitu kg·m/s².',
    ),
    Question(
      question: 'Benda bermassa 2 kg diberi percepatan 3 m/s². Besar gayanya adalah ...',
      options: ['6 N', '1,5 N', '5 N', '0,67 N'],
      correctIndex: 0,
      explanation: 'F = m × a = 2 × 3 = 6 N.',
    ),
    Question(
      question: 'Mobil menempuh 120 km dalam 2 jam. Kecepatan rata-ratanya adalah ...',
      options: ['240 km/jam', '40 km/jam', '120 km/jam', '60 km/jam'],
      correctIndex: 3,
      explanation: 'v = jarak : waktu = 120 : 2 = 60 km/jam.',
    ),
    Question(
      question: 'Percepatan gravitasi di permukaan Bumi kira-kira sebesar ...',
      options: ['9,8 m/s²', '1,6 m/s²', '3,7 m/s²', '98 m/s²'],
      correctIndex: 0,
      explanation: 'Gravitasi Bumi sekitar 9,8 m/s²; 1,6 m/s² adalah gravitasi Bulan.',
    ),
    Question(
      question: 'Energi kinetik benda 4 kg yang bergerak dengan kecepatan 3 m/s adalah ...',
      options: ['12 J', '36 J', '18 J', '6 J'],
      correctIndex: 2,
      explanation: 'Ek = ½ × m × v² = ½ × 4 × 9 = 18 J.',
    ),
    Question(
      question: 'Gaya aksi sama besar dan berlawanan arah dengan gaya reaksi. Ini bunyi Hukum Newton ...',
      options: ['II', 'III', 'I', 'Gravitasi Umum'],
      correctIndex: 1,
      explanation: 'Hukum III Newton membahas pasangan gaya aksi dan reaksi.',
    ),
    Question(
      question: 'Arus 2 A mengalir pada hambatan 5 Ω. Besar tegangannya adalah ...',
      options: ['2,5 V', '7 V', '0,4 V', '10 V'],
      correctIndex: 3,
      explanation: 'Menurut hukum Ohm, V = I × R = 2 × 5 = 10 V.',
    ),
    Question(
      question: 'Bunyi tidak dapat merambat melalui ...',
      options: ['Ruang hampa', 'Air', 'Udara', 'Besi'],
      correctIndex: 0,
      explanation: 'Bunyi butuh medium untuk merambat, sedangkan ruang hampa tidak punya medium.',
    ),
    Question(
      question: 'Alat untuk mengukur kuat arus listrik adalah ...',
      options: ['Voltmeter', 'Amperemeter', 'Ohmmeter', 'Barometer'],
      correctIndex: 1,
      explanation: 'Amperemeter mengukur kuat arus dalam satuan ampere.',
    ),
    Question(
      question: 'Kalor untuk menaikkan suhu 1 kg air sebesar 1°C (c = 4.200 J/kg°C) adalah ...',
      options: ['42.000 J', '420 J', '4.200 J', '42 J'],
      correctIndex: 2,
      explanation: 'Q = m × c × ΔT = 1 × 4.200 × 1 = 4.200 J.',
    ),
  ],

  // ========================= BIOLOGI ========================
  'biologi': [
    Question(
      question: 'Organel sel yang menjadi tempat respirasi sel adalah ...',
      options: ['Ribosom', 'Mitokondria', 'Lisosom', 'Badan Golgi'],
      correctIndex: 1,
      explanation: 'Mitokondria menghasilkan energi (ATP) melalui respirasi sel.',
    ),
    Question(
      question: 'Proses tumbuhan membuat makanan dengan bantuan cahaya matahari disebut ...',
      options: ['Respirasi', 'Transpirasi', 'Fotosintesis', 'Fermentasi'],
      correctIndex: 2,
      explanation: 'Fotosintesis mengubah air dan CO2 menjadi glukosa dengan energi cahaya.',
    ),
    Question(
      question: 'Pigmen hijau yang menyerap cahaya untuk fotosintesis adalah ...',
      options: ['Klorofil', 'Karoten', 'Melanin', 'Hemoglobin'],
      correctIndex: 0,
      explanation: 'Klorofil memberi warna hijau dan menyerap cahaya untuk fotosintesis.',
    ),
    Question(
      question: 'Sel darah yang berperan dalam proses pembekuan darah adalah ...',
      options: ['Eritrosit', 'Leukosit', 'Plasma darah', 'Trombosit'],
      correctIndex: 3,
      explanation: 'Trombosit (keping darah) membantu menutup luka dengan membekukan darah.',
    ),
    Question(
      question: 'Molekul pembawa informasi genetik pada makhluk hidup adalah ...',
      options: ['ATP', 'Glukosa', 'DNA', 'Lipid'],
      correctIndex: 2,
      explanation: 'DNA menyimpan informasi genetik yang diwariskan ke keturunan.',
    ),
    Question(
      question: 'Hewan yang dapat hidup di air dan di darat termasuk kelas ...',
      options: ['Reptil', 'Amfibi', 'Mamalia', 'Aves'],
      correctIndex: 1,
      explanation: 'Amfibi, seperti katak, hidup di dua alam: air dan darat.',
    ),
    Question(
      question: 'Bagian bunga yang menghasilkan serbuk sari adalah ...',
      options: ['Kepala putik', 'Mahkota', 'Kelopak', 'Kepala sari'],
      correctIndex: 3,
      explanation: 'Serbuk sari dihasilkan oleh kepala sari pada benang sari.',
    ),
    Question(
      question: 'Organ yang menyaring darah dan menghasilkan urine adalah ...',
      options: ['Ginjal', 'Hati', 'Paru-paru', 'Lambung'],
      correctIndex: 0,
      explanation: 'Ginjal menyaring zat sisa dari darah dan mengeluarkannya sebagai urine.',
    ),
    Question(
      question: 'Pembelahan sel yang menghasilkan sel kelamin (gamet) adalah ...',
      options: ['Mitosis', 'Meiosis', 'Amitosis', 'Fragmentasi'],
      correctIndex: 1,
      explanation: 'Meiosis menghasilkan gamet dengan jumlah kromosom setengah dari sel induk.',
    ),
    Question(
      question: 'Dalam rantai makanan, tumbuhan hijau berperan sebagai ...',
      options: ['Konsumen I', 'Pengurai', 'Produsen', 'Konsumen II'],
      correctIndex: 2,
      explanation: 'Tumbuhan hijau membuat makanannya sendiri sehingga disebut produsen.',
    ),
  ],

  // ========================= SEJARAH ========================
  'sejarah': [
    Question(
      question: 'Proklamasi Kemerdekaan Indonesia dibacakan pada tanggal ...',
      options: ['17 Agustus 1945', '1 Juni 1945', '28 Oktober 1928', '10 November 1945'],
      correctIndex: 0,
      explanation: 'Proklamasi dibacakan Soekarno–Hatta pada 17 Agustus 1945 di Jakarta.',
    ),
    Question(
      question: 'Sumpah Pemuda diikrarkan pada tahun ...',
      options: ['1908', '1945', '1928', '1926'],
      correctIndex: 2,
      explanation: 'Sumpah Pemuda diikrarkan pada Kongres Pemuda II, 28 Oktober 1928.',
    ),
    Question(
      question: 'Organisasi Budi Utomo didirikan pada tahun ...',
      options: ['1928', '1912', '1945', '1908'],
      correctIndex: 3,
      explanation: 'Budi Utomo berdiri 20 Mei 1908, kini diperingati sebagai Hari Kebangkitan Nasional.',
    ),
    Question(
      question: 'Pertempuran 10 November 1945 terjadi di kota ...',
      options: ['Bandung', 'Surabaya', 'Semarang', 'Ambarawa'],
      correctIndex: 1,
      explanation: 'Pertempuran Surabaya menjadi dasar peringatan Hari Pahlawan.',
    ),
    Question(
      question: 'Kerajaan Hindu tertua di Indonesia adalah ...',
      options: ['Majapahit', 'Tarumanegara', 'Kutai', 'Sriwijaya'],
      correctIndex: 2,
      explanation: 'Kerajaan Kutai di Kalimantan Timur berdiri sekitar abad ke-4 Masehi.',
    ),
    Question(
      question: 'Mahapatih Majapahit yang terkenal dengan Sumpah Palapa adalah ...',
      options: ['Hayam Wuruk', 'Gajah Mada', 'Ken Arok', 'Raden Wijaya'],
      correctIndex: 1,
      explanation: 'Gajah Mada bersumpah menyatukan Nusantara melalui Sumpah Palapa.',
    ),
    Question(
      question: 'Perang Dunia II berakhir pada tahun ...',
      options: ['1939', '1918', '1950', '1945'],
      correctIndex: 3,
      explanation: 'Perang Dunia II berlangsung 1939–1945 dan berakhir setelah Jepang menyerah.',
    ),
    Question(
      question: 'Konferensi Asia Afrika tahun 1955 diselenggarakan di kota ...',
      options: ['Bandung', 'Jakarta', 'Bogor', 'Yogyakarta'],
      correctIndex: 0,
      explanation: 'Konferensi Asia Afrika digelar di Gedung Merdeka, Bandung, April 1955.',
    ),
    Question(
      question: 'Kongsi dagang Belanda, VOC, didirikan pada tahun ...',
      options: ['1511', '1602', '1799', '1619'],
      correctIndex: 1,
      explanation: 'VOC berdiri pada 1602 dan dibubarkan pada 1799.',
    ),
    Question(
      question: 'Naskah Proklamasi Kemerdekaan Indonesia diketik oleh ...',
      options: ['Soekarno', 'Mohammad Hatta', 'Sayuti Melik', 'Ahmad Soebardjo'],
      correctIndex: 2,
      explanation: 'Sayuti Melik mengetik naskah proklamasi dari tulisan tangan Soekarno.',
    ),
  ],

  // ===================== BAHASA INGGRIS =====================
  'bahasa_inggris': [
    Question(
      question: 'Choose the correct sentence.',
      options: ['She go to school.', 'She goes to school.', 'She going to school.', 'She gone to school.'],
      correctIndex: 1,
      explanation: 'Subjek "she" pada simple present memakai verb + s/es, yaitu "goes".',
    ),
    Question(
      question: 'The past tense of "buy" is ...',
      options: ['buyed', 'brought', 'bought', 'buys'],
      correctIndex: 2,
      explanation: '"Buy" adalah irregular verb; bentuk lampaunya "bought" ("brought" dari "bring").',
    ),
    Question(
      question: 'What is the opposite of "ancient"?',
      options: ['old', 'modern', 'huge', 'quiet'],
      correctIndex: 1,
      explanation: '"Ancient" berarti sangat kuno, lawan katanya "modern".',
    ),
    Question(
      question: 'I have lived here ___ 2015.',
      options: ['for', 'at', 'during', 'since'],
      correctIndex: 3,
      explanation: '"Since" dipakai sebelum titik waktu awal, seperti tahun 2015.',
    ),
    Question(
      question: 'They ___ playing football when it started to rain.',
      options: ['was', 'are', 'were', 'is'],
      correctIndex: 2,
      explanation: 'Past continuous dengan subjek "they" memakai "were".',
    ),
    Question(
      question: 'The word "quickly" is a/an ...',
      options: ['adverb', 'adjective', 'noun', 'verb'],
      correctIndex: 0,
      explanation: '"Quickly" menerangkan cara melakukan sesuatu, jadi termasuk adverb.',
    ),
    Question(
      question: 'If I ___ rich, I would travel around the world.',
      options: ['am', 'were', 'will be', 'been'],
      correctIndex: 1,
      explanation: 'Conditional tipe 2 memakai "were" untuk semua subjek.',
    ),
    Question(
      question: '"Can you help me, please?" This sentence expresses a ...',
      options: ['promise', 'warning', 'complaint', 'request'],
      correctIndex: 3,
      explanation: 'Kalimat itu meminta bantuan, jadi termasuk request (permintaan).',
    ),
    Question(
      question: 'What is the plural form of "child"?',
      options: ['childs', 'childes', 'children', 'childrens'],
      correctIndex: 2,
      explanation: '"Child" adalah irregular noun; bentuk jamaknya "children".',
    ),
    Question(
      question: 'The synonym of "begin" is ...',
      options: ['start', 'finish', 'stop', 'end'],
      correctIndex: 0,
      explanation: '"Begin" dan "start" sama-sama berarti memulai.',
    ),
  ],

  // ==================== PENGETAHUAN UMUM ====================
  'pengetahuan_umum': [
    Question(
      question: 'Planet terbesar di tata surya adalah ...',
      options: ['Saturnus', 'Bumi', 'Jupiter', 'Neptunus'],
      correctIndex: 2,
      explanation: 'Jupiter adalah planet terbesar, diameternya sekitar 11 kali Bumi.',
    ),
    Question(
      question: 'Ibu kota negara Jepang adalah ...',
      options: ['Tokyo', 'Osaka', 'Kyoto', 'Seoul'],
      correctIndex: 0,
      explanation: 'Tokyo adalah ibu kota Jepang; Seoul adalah ibu kota Korea Selatan.',
    ),
    Question(
      question: 'Gunung tertinggi di dunia (diukur dari permukaan laut) adalah ...',
      options: ['K2', 'Kilimanjaro', 'Puncak Jaya', 'Everest'],
      correctIndex: 3,
      explanation: 'Everest di Pegunungan Himalaya tingginya sekitar 8.849 m.',
    ),
    Question(
      question: 'Rumus kimia air adalah ...',
      options: ['CO2', 'H2O', 'O2', 'NaCl'],
      correctIndex: 1,
      explanation: 'Satu molekul air terdiri atas 2 atom hidrogen dan 1 atom oksigen.',
    ),
    Question(
      question: 'Benua terluas di dunia adalah ...',
      options: ['Afrika', 'Amerika', 'Asia', 'Eropa'],
      correctIndex: 2,
      explanation: 'Asia adalah benua terluas sekaligus berpenduduk terbanyak.',
    ),
    Question(
      question: 'Lambang negara Indonesia adalah ...',
      options: ['Garuda Pancasila', 'Elang Jawa', 'Komodo', 'Bendera Merah Putih'],
      correctIndex: 0,
      explanation: 'Garuda Pancasila adalah lambang negara; Merah Putih adalah bendera negara.',
    ),
    Question(
      question: 'Alat musik angklung berasal dari daerah ...',
      options: ['Bali', 'Jawa Barat', 'Sumatra Barat', 'Papua'],
      correctIndex: 1,
      explanation: 'Angklung adalah alat musik bambu khas Sunda, Jawa Barat.',
    ),
    Question(
      question: 'Satu tahun kabisat terdiri dari ... hari.',
      options: ['365', '364', '367', '366'],
      correctIndex: 3,
      explanation: 'Tahun kabisat punya 29 hari di bulan Februari, jadi totalnya 366 hari.',
    ),
    Question(
      question: 'Samudra terluas di dunia adalah ...',
      options: ['Hindia', 'Pasifik', 'Atlantik', 'Arktik'],
      correctIndex: 1,
      explanation: 'Samudra Pasifik adalah samudra terluas dan terdalam di dunia.',
    ),
    Question(
      question: 'Hewan yang dijuluki "kapal padang pasir" adalah ...',
      options: ['Kuda', 'Gajah', 'Unta', 'Keledai'],
      correctIndex: 2,
      explanation: 'Unta tahan lama tanpa minum sehingga cocok untuk menyeberangi gurun.',
    ),
  ],
};
