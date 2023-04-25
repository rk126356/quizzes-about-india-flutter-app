class Question {
  final String question;
  final List<String> choices;
  final String answer;
  bool isCompleted;
  bool isUnlocked;
  final String hint;
  final String explanation;
  bool isHintShowed;
  bool isAnswerShowed;
  bool isSkipped;

  Question({
    required this.question,
    required this.choices,
    required this.answer,
    this.isCompleted = false,
    this.isUnlocked = false,
    this.isHintShowed = false,
    this.isAnswerShowed = false,
    this.isSkipped = false,
    required this.hint,
    required this.explanation,
  });

  void markCompleted() {
    isCompleted = true;
  }

  void markUnlocked() {
    isUnlocked = true;
  }

  void markIncomplete() {
    isCompleted = false;
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'choices': choices,
      'answer': answer,
      'hint': hint,
      'explanation': explanation,
      'isCompleted': isCompleted,
      'isUnlocked': isUnlocked,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      choices: List<String>.from(json['choices']),
      answer: json['answer'],
      hint: json['hint'],
      explanation: json['explanation'],
      isCompleted: json['isCompleted'],
      isUnlocked: json['isUnlocked'],
    );
  }
}

List<Question> questionsList = [
  Question(
    question: "What is the capital of India?",
    choices: ["Mumbai", "New Delhi", "Kolkata", "Chennai"],
    answer: "New Delhi",
    hint:
        "It is a city in northern India and serves as the center of government for the country.",
    explanation:
        "New Delhi is the capital city of India and is located in the northern part of the country. It is the seat of the executive, legislative, and judiciary branches of the government of India.",
    isUnlocked: true,
  ),
  Question(
    question: "What is the largest city in India by population?",
    choices: ["Mumbai", "Delhi", "Bangalore", "Kolkata"],
    answer: "Mumbai",
    hint:
        "It is located on the west coast of India and is known for its film industry.",
    explanation:
        "Mumbai is the largest city in India by population, with over 20 million people. It is a major center of finance, commerce, and entertainment, and is home to the famous Bollywood film industry.",
  ),
  Question(
      question: "Which river is considered the most sacred in India?",
      choices: ["Ganges", "Yamuna", "Brahmaputra", "Indus"],
      answer: "Ganges",
      hint:
          "It is a trans-boundary river flowing through India and Bangladesh.",
      explanation:
          "The Ganges river is considered the most sacred in India and is worshipped by Hindus as a goddess. It is also an important source of water for irrigation, transportation, and hydroelectric power generation."),
  Question(
      question: "Who is known as the 'Father of the Nation' in India?",
      choices: [
        "Jawaharlal Nehru",
        "Mahatma Gandhi",
        "Sardar Vallabhbhai Patel",
        "B. R. Ambedkar"
      ],
      answer: "Mahatma Gandhi",
      hint:
          "He was a leader of the Indian independence movement and is known for his philosophy of nonviolent resistance.",
      explanation:
          "Mahatma Gandhi is known as the 'Father of the Nation' in India for his role in the country's struggle for independence from British colonial rule. He advocated for nonviolent civil disobedience and is widely regarded as one of the most influential figures in modern Indian history."),
  Question(
      question: "What is the national emblem of India ok?",
      choices: ["Lotus", "Peacock", "Lion", "Tiger"],
      answer: "Lion",
      hint:
          "It is also the emblem of the Government of India and is prominently featured on official documents and currency.",
      explanation:
          "The national emblem of India is an adaptation of the Lion Capital of Ashoka, which was originally erected around 250 BCE. The emblem features four lions standing back to back, symbolizing power, courage, pride, and confidence. It also includes the motto 'Satyameva Jayate' (Truth Alone Triumphs) in Devanagari script."),
  Question(
      question: "What is the highest mountain peak in India?",
      choices: ["Kangchenjunga", "Nanda Devi", "Mount Everest", "K2"],
      answer: "Kangchenjunga",
      hint:
          "It is located on the border of India and Nepal, in the Himalayan mountain range.",
      explanation:
          "Kangchenjunga is the highest mountain peak in India, with an elevation of 8,586 meters (28,169 feet). It is located on the border of India and Nepal and is part of the Himalayan mountain range. Kangchenjunga is considered a sacred mountain by the local people and is revered as a guardian deity."),
  Question(
      question: "Which state in India is known as the 'Land of Seven Sisters'?",
      choices: ["Manipur", "Nagaland", "Assam", "Meghalaya"],
      answer: "Assam",
      hint:
          "It is located in the northeastern part of India and is known for its tea and wildlife.",
      explanation:
          "Assam is known as the 'Land of Seven Sisters' because it is home to seven northeastern states of India. It is located in the northeastern part of the country and is known for its tea plantations, wildlife reserves, and national parks."),
  Question(
      question: "Which Indian city is known as the 'Pink City'?",
      choices: ["Jaipur", "Agra", "Udaipur", "Jodhpur"],
      answer: "Jaipur",
      hint:
          "It is the capital city of Rajasthan and is known for its palaces and forts.",
      explanation:
          "Jaipur is known as the 'Pink City' because of the distinctive pink color of many of its buildings. It is the capital city of Rajasthan and is known for its palaces, forts, and vibrant culture."),
  Question(
      question:
          "Which Indian festival is also known as the 'Festival of Lights'?",
      choices: ["Diwali", "Holi", "Dussehra", "Eid"],
      answer: "Diwali",
      hint:
          "It is celebrated by lighting diyas (lamps) and candles and is a major festival in India.",
      explanation:
          "Diwali, also known as the 'Festival of Lights', is a major festival in India and is celebrated by lighting diyas (lamps) and candles. It is a Hindu festival but is also celebrated by people of other religions and cultures."),
  Question(
      question: "Which Indian state is the largest by area?",
      choices: ["Rajasthan", "Madhya Pradesh", "Maharashtra", "Uttar Pradesh"],
      answer: "Rajasthan",
      hint:
          "It is located in the western part of India and is known for its deserts and palaces.",
      explanation:
          "Rajasthan is the largest Indian state by area, covering an area of 342,239 square kilometers (132,139 square miles). It is located in the western part of the country and is known for its desert landscapes, colorful culture, and historic palaces and forts."),
  Question(
      question:
          "Which Indian festival celebrates the victory of good over evil?",
      choices: ["Diwali", "Holi", "Dussehra", "Ganesh Chaturthi"],
      answer: "Dussehra",
      hint: "It is celebrated in the autumn season.",
      explanation:
          "Dussehra is an important festival in India that celebrates the victory of good over evil. It is celebrated in the autumn season and is marked by the burning of effigies of the demon king Ravana, who was defeated by Lord Rama according to Hindu mythology."),
  Question(
      question: "Which Indian state is the largest producer of tea?",
      choices: ["Assam", "West Bengal", "Kerala", "Tamil Nadu"],
      answer: "Assam",
      hint: "It is located in the northeastern part of India.",
      explanation:
          "Assam is the largest producer of tea in India, accounting for over 50% of the country's total tea production. It is located in the northeastern part of India and is known for its scenic beauty and rich biodiversity."),
  Question(
      question: "What is the name of the highest civilian award in India?",
      choices: [
        "Padma Vibhushan",
        "Padma Bhushan",
        "Bharat Ratna",
        "Arjuna Award"
      ],
      answer: "Bharat Ratna",
      hint:
          "This award is given for exceptional service in the fields of art, literature, science, and public services.",
      explanation:
          "Bharat Ratna is the highest civilian award in India, and is awarded for exceptional service in the fields of art, literature, science, and public services. It was instituted in 1954 and is awarded by the President of India."),
  Question(
      question: "Which state in India has the largest area?",
      choices: ["Rajasthan", "Madhya Pradesh", "Maharashtra", "Uttar Pradesh"],
      answer: "Rajasthan",
      hint:
          "It is located in the northern part of India and is known for its desert landscape and historical sites.",
      explanation:
          "Rajasthan is the largest state in India by area, with a total area of 342,239 square kilometers. It is located in the northern part of the country and is known for its desert landscape, historical sites, and vibrant culture."),
  Question(
      question: "Which river in India is also known as the 'South Ganges'?",
      choices: ["Godavari", "Krishna", "Cauvery", "Narmada"],
      answer: "Krishna",
      hint:
          "It is one of the longest rivers in India and flows through several states in the southern part of the country.",
      explanation:
          "Krishna is a major river in India that originates in the Western Ghats and flows through several states in the southern part of the country. It is one of the longest rivers in India and is sometimes referred to as the 'South Ganges'."),
  Question(
      question:
          "What is the name of the famous Indian monument that is also one of the Seven Wonders of the World?",
      choices: ["Hawa Mahal", "Taj Mahal", "Qutub Minar", "Red Fort"],
      answer: "Taj Mahal",
      hint:
          "It is located in the northern part of India and is a mausoleum built by a Mughal emperor.",
      explanation:
          "The Taj Mahal is a famous Indian monument and is one of the Seven Wonders of the World. It is located in the northern part of India in the city of Agra and was built by the Mughal emperor Shah Jahan in memory of his wife Mumtaz Mahal."),
  Question(
      question: "Which Indian state is known as the 'Land of the Gods'?",
      choices: [
        "Uttarakhand",
        "Himachal Pradesh",
        "Jammu and Kashmir",
        "Arunachal Pradesh"
      ],
      answer: "Uttarakhand",
      hint:
          "It is located in the northern part of India and is known for its scenic beauty and religious sites.",
      explanation:
          "Uttarakhand is a state in northern India that is known as the 'Land of the Gods' due to its numerous religious sites and pilgrimage centers. It is located in the foothills of the Himalayas and is known for its scenic beauty and adventure tourism."),
  Question(
      question: "What is the name of the largest desert in India?",
      choices: [
        "Thar Desert",
        "Sahara Desert",
        "Gobi Desert",
        "Arabian Desert"
      ],
      answer: "Thar Desert",
      hint:
          "It is located in the northwestern part of India and is also known as the Great Indian Desert.",
      explanation:
          "The Thar Desert, also known as the Great Indian Desert, is the largest desert in India. It covers an area of about 200,000 square kilometers and is located in the northwestern part of the country. The Thar Desert is known for its extreme climate and unique wildlife."),
  Question(
      question: "Which Indian state is known as 'God's Own Country'?",
      choices: ["Kerala", "Tamil Nadu", "Karnataka", "Andhra Pradesh"],
      answer: "Kerala",
      hint:
          "It is located on the southwestern coast of India and is known for its backwaters, beaches, and cuisine.",
      explanation:
          "Kerala, located on the southwestern coast of India, is known as 'God's Own Country' because of its natural beauty and diverse culture. It is known for its backwaters, beaches, palm-lined shores, and traditional cuisine."),
  Question(
      question:
          "What is the name of the highest battlefield in the world, located on the Indo-China border?",
      choices: [
        "Siachen Glacier",
        "Kargil War Memorial",
        "Nathu La",
        "Daulat Beg Oldi"
      ],
      answer: "Siachen Glacier",
      hint: "It is located in the eastern Karakoram range in the Himalayas.",
      explanation:
          "The Siachen Glacier is the highest battlefield in the world, located on the Indo-China border in the eastern Karakoram range of the Himalayas. The glacier is over 70 kilometers long and is known for its extreme climate and altitude."),
  Question(
      question:
          "What is the name of the Indian version of chess, which is played on a board of 64 squares?",
      choices: ["Chaturanga", "Pachisi", "Snakes and Ladders", "Carrom"],
      answer: "Chaturanga",
      hint:
          "It is an ancient game that originated in India and was later adapted into the modern game of chess.",
      explanation:
          "Chaturanga is the name of the ancient Indian game that is believed to be the predecessor of the modern game of chess. The game was played on a board of 64 squares and involved four players, with each player controlling an army of soldiers, elephants, horses, and chariots."),
  Question(
      question: "Which Indian state has the highest population?",
      choices: ["Maharashtra", "Uttar Pradesh", "Bihar", "West Bengal"],
      answer: "Uttar Pradesh",
      hint:
          "It is located in the northern part of India and is home to several important historical sites.",
      explanation:
          "Uttar Pradesh is the Indian state with the highest population, with over 200 million people. It is located in the northern part of the country and is home to several important historical sites, including the Taj Mahal and the ancient city of Varanasi."),
  Question(
      question: "What is the name of India's highest civilian award?",
      choices: [
        "Bharat Ratna",
        "Padma Shri",
        "Padma Vibhushan",
        "Padma Bhushan"
      ],
      answer: "Bharat Ratna",
      hint: "It is named after a word which means 'gem of India'",
      explanation:
          "Bharat Ratna is India's highest civilian award, given for exceptional service towards advancement of Art, Literature and Science, and in recognition of public service of the highest order. The award was instituted in 1954 and the name 'Bharat Ratna' literally means 'Gem of India'."),
  Question(
      question: "Which Indian city is known as the 'Silicon Valley of India'?",
      choices: ["Mumbai", "Bangalore", "Hyderabad", "Chennai"],
      answer: "Bangalore",
      hint: "It is the capital of Karnataka state",
      explanation:
          "Bangalore, officially known as Bengaluru, is the capital of Karnataka state in southern India. It is called the 'Silicon Valley of India' because it is the country's leading information technology (IT) exporter and is home to many major IT companies."),
  Question(
      question: "What is the name of the Indian national anthem?",
      choices: [
        "Vande Mataram",
        "Jana Gana Mana",
        "Saare Jahan Se Achha",
        "Sare Jahan Se Aage"
      ],
      answer: "Jana Gana Mana",
      hint: "It was written by Rabindranath Tagore",
      explanation:
          "Jana Gana Mana is the national anthem of India. It was written by the Nobel laureate Rabindranath Tagore in 1911 and was adopted by the Constituent Assembly as the national anthem on January 24, 1950."),
  Question(
      question: "What is the name of India's first satellite?",
      choices: ["Aryabhata", "Rohini", "Chandrayaan", "Mangalyaan"],
      answer: "Aryabhata",
      hint: "It was launched in 1975",
      explanation:
          "Aryabhata was India's first satellite, named after the famous Indian astronomer of the same name. It was launched by the Soviet Union on April 19, 1975 from Kapustin Yar using a Kosmos-3M launch vehicle."),
  Question(
      question: "Who was the first President of India?",
      choices: [
        "Dr. Rajendra Prasad",
        "Jawaharlal Nehru",
        "S. Radhakrishnan",
        "Zakir Hussain"
      ],
      answer: "Dr. Rajendra Prasad",
      hint: "He was also the longest-serving President of India",
      explanation:
          "Dr. Rajendra Prasad was the first President of India, serving from 1950 to 1962. He was a freedom fighter and one of the architects of the Indian Constitution. He was also the longest-serving President of India, having been elected to the office twice."),
  Question(
      question: "Who wrote the Indian National Anthem 'Jana Gana Mana'?",
      choices: [
        "Rabindranath Tagore",
        "Mahatma Gandhi",
        "Jawaharlal Nehru",
        "Subhash Chandra Bose"
      ],
      answer: "Rabindranath Tagore",
      hint:
          "He was a Bengali poet, philosopher, and polymath who reshaped Bengali literature and music in the late 19th and early 20th centuries.",
      explanation:
          "Jana Gana Mana is the national anthem of India. It was written by the Bengali poet, philosopher, and polymath Rabindranath Tagore."),
  Question(
      question: "Which river is known as the 'Sorrow of Bihar'?",
      choices: ["Ganga", "Yamuna", "Kosi", "Sutlej"],
      answer: "Kosi",
      hint:
          "It is a tributary of the Ganges and is known for its unpredictable nature and frequent floods.",
      explanation:
          "The Kosi River is known as the 'Sorrow of Bihar' because of its unpredictable nature and frequent floods that have caused widespread damage and loss of life in the state."),
  Question(
      question: "What is the name of the highest mountain peak in India?",
      choices: ["Nanda Devi", "Mt. Everest", "Kangchenjunga", "K2"],
      answer: "Kangchenjunga",
      hint:
          "It is located in the Himalayas and is the third highest mountain peak in the world.",
      explanation:
          "Kangchenjunga, located in the Himalayas, is the highest mountain peak in India and the third highest peak in the world. It has an elevation of 8,586 meters (28,169 feet) and is located on the border between India and Nepal."),
  Question(
      question: "Which Indian state is known as the 'Land of the Rising Sun'?",
      choices: ["Arunachal Pradesh", "Assam", "Nagaland", "Manipur"],
      answer: "Arunachal Pradesh",
      hint:
          "It is the easternmost state of India and is located in the northeastern part of the country.",
      explanation:
          "Arunachal Pradesh is known as the 'Land of the Rising Sun' because it is the easternmost state of India and is the first to receive the morning sun's rays in the country."),
  Question(
      question: "Which Indian state has the highest population density?",
      choices: ["Bihar", "West Bengal", "Kerala", "Uttar Pradesh"],
      answer: "West Bengal",
      hint:
          "It is located in the eastern part of the country and is known for its rich cultural heritage and intellectual legacy.",
      explanation:
          "West Bengal has the highest population density among all Indian states, with a population of over 91 million people living in an area of just 88,752 square kilometers."),
  Question(
      question: "Which Indian city is known as the 'City of Joy'?",
      choices: ["Mumbai", "Kolkata", "Chennai", "Bengaluru"],
      answer: "Kolkata",
      hint:
          "It is located in the eastern part of the country and is the capital city of the state of West Bengal.",
      explanation:
          "Kolkata is known as the 'City of Joy' because of its rich cultural heritage, literary history, and warm and welcoming people. It is also known for its delicious cuisine, especially sweets like rasgulla and sandesh."),
  Question(
      question:
          "Which Indian state has the highest number of seats in the Lok Sabha?",
      choices: [
        "Uttar Pradesh",
        "Maharashtra",
        "West Bengal",
        "Andhra Pradesh"
      ],
      answer: "Uttar Pradesh",
      hint:
          "It is located in the northern part of the country and is the most populous state in India.",
      explanation:
          "Uttar Pradesh has the highest number of seats in the Lok Sabha, the lower house of the Indian parliament, with 80 seats. The state is also known for its rich cultural heritage and historical monuments like the Taj Mahal."),
  Question(
      question: "What is the name of the largest freshwater lake in India?",
      choices: ["Dal Lake", "Vembanad Lake", "Wular Lake", "Chilika Lake"],
      answer: "Wular Lake",
      hint:
          "It is located in the northern part of India and is surrounded by the Himalayan mountain range.",
      explanation:
          "Wular Lake is the largest freshwater lake in India, with a surface area of around 260 square kilometers. It is located in the state of Jammu and Kashmir and is an important habitat for migratory birds and other wildlife."),
  Question(
      question:
          "What is the name of the famous Indian mathematician who is also known as the 'father of modern Indian mathematics'?",
      choices: [
        "Srinivasa Ramanujan",
        "Aryabhata",
        "Brahmagupta",
        "Shakuntala Devi"
      ],
      answer: "Srinivasa Ramanujan",
      hint:
          "He was born in Erode, Tamil Nadu, and made significant contributions to number theory, infinite series, and continued fractions.",
      explanation:
          "Srinivasa Ramanujan was a self-taught Indian mathematician who made substantial contributions to mathematical analysis, number theory, and continued fractions. He is considered to be one of the most brilliant mathematicians of the 20th century."),
  Question(
      question:
          "What is the name of the world's largest school, which is located in India?",
      choices: [
        "La Martiniere College",
        "Doon School",
        "City Montessori School",
        "Welham Girls' School"
      ],
      answer: "City Montessori School",
      hint: "It is located in Lucknow and has over 55,000 students.",
      explanation:
          "The City Montessori School in Lucknow, India, is recognized by the Guinness Book of World Records as the largest school in the world. It was founded in 1959 by Dr. Jagdish Gandhi and his wife Bharti Gandhi, and currently has over 55,000 students across 20 campuses."),
  Question(
      question: "Which Indian state is known as the 'Spice Garden of India'?",
      choices: ["Kerala", "Karnataka", "Tamil Nadu", "Andhra Pradesh"],
      answer: "Kerala",
      hint:
          "It is located on the southwestern coast of India and is known for its scenic beauty, backwaters, and beaches.",
      explanation:
          "Kerala is known as the 'Spice Garden of India' because of its significant contribution to the spice trade in the country. The state produces a variety of spices, including pepper, cardamom, cinnamon, and cloves."),
  Question(
      question:
          "What is the name of the largest river island in the world, which is located in India?",
      choices: [
        "Majuli Island",
        "Sriharikota Island",
        "Andaman Island",
        "Little Andaman Island"
      ],
      answer: "Majuli Island",
      hint: "It is located in the Brahmaputra River in the state of Assam.",
      explanation:
          "Majuli Island is the largest river island in the world and is located in the Brahmaputra River in the state of Assam. The island is known for its unique culture, traditions, and Vaishnavite monasteries."),
  Question(
      question: "What is the national animal of India?",
      choices: ["Lion", "Tiger", "Leopard", "Elephant"],
      answer: "Tiger",
      hint: "It is also the name of a popular Indian sports team",
      explanation:
          "The national animal of India is the Royal Bengal Tiger. It is found mainly in India, but also in other Southeast Asian countries. The Bengal Tiger is considered as an endangered species and is protected by the Wildlife Protection Act of India."),
  Question(
      question: "Which is the smallest state in India by area?",
      choices: ["Goa", "Sikkim", "Nagaland", "Tripura"],
      answer: "Goa",
      hint: "It is a popular tourist destination known for its beaches",
      explanation:
          "Goa is the smallest state in India by area. It is located on the west coast of India and is known for its beautiful beaches, colonial architecture, and vibrant nightlife. The state has a population of approximately 1.5 million people and is famous for its seafood, feni, and cashew nuts."),
  Question(
      question:
          "India is a federal union comprising twenty-eight states and how many union territories?",
      choices: ["6", "7", "8", "9"],
      answer: "8",
      hint:
          "The total number of states and union territories in India is 28 and 8, respectively.",
      explanation:
          "Presently, India comprises 28 States and 8 Union Territories. India is a democratic country and came into being on 15 August 1947, upon gaining independence."),
  Question(
      question: "Which of the following is the capital of Arunachal Pradesh?",
      choices: ["Itanagar", "Dispur", "Imphal", "Panaji"],
      answer: "Itanagar",
      hint: "The name of the capital is made up of two words 'Ita' and 'Nagar'",
      explanation:
          "Itanagar is the capital of Arunachal Pradesh and is named after Ita fort which means fort of bricks, build around the 14 century AD."),
  Question(
      question: "What are the major languages spoken in Andhra Pradesh?",
      choices: [
        "Odia and Telugu",
        "Telugu and Urdu",
        "Telugu and Kannada",
        "All of the above languages"
      ],
      answer: "Telugu and Urdu",
      hint: "Telugu is the most spoken language in Andhra Pradesh.",
      explanation:
          "Major languages spoken in Andhra Pradesh are Telugu, Urdu, Hindi, Banjara, and English followed by Tamil, Kannada, Marathi, and Odia."),
  Question(
      question: "What is the state flower of Haryana?",
      choices: ["Lotus", "Rhododendron", "Golden Shower", "Not Declared"],
      answer: "Lotus",
      hint: "The state flower of Haryana is a beautiful aquatic plant.",
      explanation:
          "Lotus or Water Lily is the state flower of Haryana. It is an aquatic plant with broad floating green leaves and bright fragrant flowers that grow only in shallow waters."),
  Question(
      question: "Which of the following states is not located in the North?",
      choices: [
        "Jharkhand",
        "Jammu and Kashmir",
        "Himachal Pradesh",
        "Haryana"
      ],
      answer: "Jharkhand",
      hint: "Jharkhand is a state located in the eastern part of India.",
      explanation:
          "Jharkhand state is not located in the North. It is located in the northeastern part of the country. It is bordered by the states of Bihar to the north, West Bengal to the east, Odisha to the south, Chhattisgarh to the west, and Uttar Pradesh to the northwest. The capital of Jharkhand is Ranchi."),
  Question(
      question: "In which of the following state, the main language is Khasi?",
      choices: ["Mizoram", "Nagaland", "Meghalaya", "Tripura"],
      answer: "Meghalaya",
      hint:
          "Khasi language is primarily spoken in a state known for its beautiful hills.",
      explanation:
          "Khasi language is primarily spoken in Meghalaya state in India by the Khasi people. It is also spoken by some of the population in Assam and Bangladesh."),
  Question(
      question:
          "Which state of India celebrates Hunter Holi, an 800-year tradition?",
      choices: ["Punjab", "Haryana", "Delhi", "Uttar Pradesh"],
      answer: "Haryana",
      hint: "The state is located in Northern India and is adjacent to Delhi.",
      explanation:
          "Haryana is known for its unique tradition of celebrating Hunter Holi, which is an 800-year-old tradition."),
  Question(
      question:
          "Which city is known as the 'summer capital' of Jammu and Kashmir?",
      choices: ["Jammu", "Srinagar", "Shimla", "Anantnag"],
      answer: "Srinagar",
      hint: "It is also the largest city in Jammu and Kashmir.",
      explanation:
          "Srinagar is known as the 'summer capital' of Jammu and Kashmir because the government moves to this city during the summer months due to its cooler climate."),
  Question(
      question: "Yakshagana is the folk dance of which state?",
      choices: ["Kerala", "Tamil Nadu", "Karnataka", "Telangana"],
      answer: "Karnataka",
      hint: "It is a state located in the southern part of India.",
      explanation:
          "Yakshagana is a traditional folk dance drama that is popular in the state of Karnataka.")
];
