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
      question: "What is the capital city of India?",
      choices: ["New Delhi", "Mumbai", "Kolkata", "Chennai"],
      answer: "New Delhi",
      isUnlocked: true,
      hint: "It is a city located in the northern part of India.",
      explanation:
          "New Delhi is the capital city of India, located in the northern part of the country. It is home to many government buildings and landmarks, such as the Parliament House and India Gate."),
  Question(
      question: "Who was the first European to discover a sea route to India?",
      choices: [
        "Christopher Columbus",
        "Ferdinand Magellan",
        "Vasco da Gama",
        "Marco Polo"
      ],
      answer: "Vasco da Gama",
      hint: "He was a Portuguese explorer.",
      explanation:
          "Vasco da Gama was a Portuguese explorer who discovered a sea route from Europe to India in 1498. His discovery opened up the sea route to India, which became a major trading route for European powers for several centuries."),
  Question(
      question: "Who is known as the “Iron Man” of India?",
      choices: [
        "Mahatma Gandhi",
        "Jawaharlal Nehru",
        "Sardar Vallabhbhai Patel",
        "Subhas Chandra Bose"
      ],
      answer: "Sardar Vallabhbhai Patel",
      hint: "He was a prominent figure in India's independence movement.",
      explanation:
          "Sardar Vallabhbhai Patel was a leader in India's independence movement and played a key role in integrating the princely states of India after independence. He was known as the 'Iron Man' of India for his strong leadership and unwavering determination."),
  Question(
      question: "Which state is also known as the 'fruit bowl' of India?",
      choices: [
        "Himachal Pradesh",
        "Uttar Pradesh",
        "Punjab",
        "Jammu and Kashmir"
      ],
      answer: "Himachal Pradesh",
      hint:
          "It is located in the northern part of India and is known for its scenic beauty.",
      explanation:
          "Himachal Pradesh is a state located in the northern part of India and is known for its scenic beauty and fertile land. It is also known as the 'fruit bowl' of India as it produces a variety of fruits including apples, apricots, peaches, and cherries."),
  Question(
      question: "Which is the national sport of India?",
      choices: ["Cricket", "Hockey", "Football", "Kabaddi"],
      answer: "Hockey",
      hint: "It is played on a field and involves hitting a ball with a stick.",
      explanation:
          "Hockey is the national sport of India and is played on a field with two teams of 11 players each. The objective is to score goals by hitting a small, hard ball with a stick into the opposing team's goalpost."),
  Question(
      question: "Which state is also known as the 'land of rising sun'?",
      choices: ["Manipur", "Mizoram", "Arunachal Pradesh", "Nagaland"],
      answer: "Arunachal Pradesh",
      hint: "It is located in the northeastern part of India.",
      explanation:
          "Arunachal Pradesh is a state located in the northeastern part of India and is known as the 'land of rising sun' due to its easternmost location in India. It is also known for its scenic beauty and diverse culture."),
  Question(
      question: "Where is the Taj Mahal located?",
      choices: ["Jaipur", "Delhi", "Agra", "Mumbai"],
      answer: "Agra",
      hint: "It is located in the northern part of India.",
      explanation:
          "The Taj Mahal is located in the city of Agra, which is in the northern part of India. It is a white marble mausoleum that was built in the 17th century by the Mughal emperor Shah Jahan in memory of his wife, Mumtaz Mahal."),
  Question(
      question: "Which Indian state has the smallest coastline?",
      choices: ["Karnataka", "Goa", "Kerala", "Maharashtra"],
      answer: "Goa",
      hint: "It is located on the western coast of India.",
      explanation:
          "Goa is a state located on the western coast of India and has the smallest coastline of any Indian state. It is known for its beaches, nightlife, and Portuguese heritage."),
  Question(
      question: "What is the national heritage animal of India?",
      choices: ["Lion", "Tiger", "Elephant", "Rhinoceros"],
      answer: "Elephant",
      hint: "It is a large mammal with a long trunk.",
      explanation:
          "The elephant is the national heritage animal of India and has been a symbol of Indian culture and tradition for centuries. It is revered for its intelligence, strength, and majesty."),
  Question(
      question: "In which state is the International Kite Festival celebrated?",
      choices: ["Maharashtra", "Gujarat", "Rajasthan", "Uttar Pradesh"],
      answer: "Gujarat",
      hint: "It is located in the western part of India.",
      explanation:
          "The International Kite Festival is celebrated in the state of Gujarat, which is located in the western part of India. The festival is held every year on January 14th and attracts kite enthusiasts from all over the world."),
  Question(
      question: "What is the name of India's national flower?",
      choices: ["Lotus", "Rose", "Jasmine", "Marigold"],
      answer: "Lotus",
      hint: "It is a water plant with large, showy flowers.",
      explanation:
          "The lotus is the national flower of India. It is a water plant with large, showy flowers that are often used in religious ceremonies and festivals."),
  Question(
      question: "What is the name of India's national bird?",
      choices: ["Peacock", "Eagle", "Parrot", "Owl"],
      answer: "Peacock",
      hint: "It is a bird with colorful feathers and a distinctive crest.",
      explanation:
          "The peacock is the national bird of India. It is known for its colorful feathers and distinctive crest, which is displayed during courtship."),
  Question(
      question: "Who is known as the 'Father of White Revolution' in India?",
      choices: [
        "M. S. Swaminathan",
        "Dr. Verghese Kurien",
        "Jagdish Chandra Bose",
        "Norman Borlaug"
      ],
      answer: "Dr. Verghese Kurien",
      hint: "He is the founder of Amul, the largest milk cooperative in India.",
      explanation:
          "Dr. Verghese Kurien is known as the 'Father of White Revolution' in India for his contribution to the country's dairy industry. He is the founder of Amul, the largest milk cooperative in India, and was instrumental in the development of Operation Flood, a program that transformed India from a milk-deficient country to the world's largest milk producer."),
  Question(
      question:
          "In which year was C.V. Raman awarded the Nobel Prize in Physics?",
      choices: ["1928", "1930", "1942", "1956"],
      answer: "1930",
      hint: "He won the prize for his work on the scattering of light.",
      explanation:
          "C.V. Raman was awarded the Nobel Prize in Physics in 1930 for his work on the scattering of light, a phenomenon now known as the Raman effect. He was the first Indian to win a Nobel Prize in science."),
  Question(
      question:
          "When was the first general election held in independent India?",
      choices: ["1947", "1949", "1951", "1953"],
      answer: "1951",
      hint:
          "It was held a few years after India gained independence from British rule.",
      explanation:
          "The first general election in independent India was held in 1951-52, a few years after India gained independence from British rule. It was the largest democratic exercise in the world at that time, with over 173 million people eligible to vote."),
  Question(
      question: "When was the first passenger train run in India?",
      choices: ["1849", "1833", "1853", "1862"],
      answer: "1853",
      hint: "It was between Bombay (Mumbai) and Thane.",
      explanation:
          "The first passenger train in India ran on April 16, 1853, between Bombay (Mumbai) and Thane. It was a 14-carriage train drawn by three steam locomotives named Sahib, Sindh, and Sultan. The journey took about 45 minutes."),
  Question(
      question: "In which year did the massacre of Jallianwala Bagh occur?",
      choices: ["1917", "1918", "1919", "1920"],
      answer: "1919",
      hint: "It was a tragic incident that occurred in Punjab.",
      explanation:
          "The Jallianwala Bagh Massacre, also known as the Amritsar Massacre, took place on 13 April 1919 in Jallianwala Bagh, Amritsar, Punjab. British Indian Army soldiers under the command of Colonel Reginald Dyer fired rifles into a crowd of unarmed Indian civilians who had gathered for a peaceful protest against British rule. The exact number of casualties is not known, but it is estimated that hundreds of people were killed and thousands injured. The incident is considered one of the darkest chapters in the history of Indian independence movement."),
  Question(
      question:
          "Who was the first Indian woman to win a medal at the Olympics?",
      choices: ["P.T. Usha", "Saina Nehwal", "Mary Kom", "Karnam Malleswari"],
      answer: "Karnam Malleswari",
      hint: "She won the medal in weightlifting.",
      explanation:
          "Karnam Malleswari won the bronze medal in weightlifting at the 2000 Summer Olympics held in Sydney, Australia. She became the first Indian woman to win a medal at the Olympics."),
  Question(
      question: "Who is the first Indian to win a Nobel Prize?",
      choices: [
        "C.V. Raman",
        "Rabindranath Tagore",
        "Amartya Sen",
        "S. Chandrasekhar"
      ],
      answer: "Rabindranath Tagore",
      hint: "He was a renowned poet and writer.",
      explanation:
          "Rabindranath Tagore was awarded the Nobel Prize in Literature in 1913 for his work 'Gitanjali'. He became the first Indian and Asian to win a Nobel Prize."),
  Question(
      question:
          "What is the name of the oldest known civilization found in the Indian subcontinent?",
      choices: [
        "Harappa Civilization",
        "Mauryan Empire",
        "Mughal Empire",
        "Gupta Empire"
      ],
      answer: "Indus Valley Civilization",
      hint: "It flourished during the Bronze Age.",
      explanation:
          "The Indus Valley Civilization is the oldest known civilization found in the Indian subcontinent. It flourished during the Bronze Age from around 3300 BCE to 1300 BCE."),
  Question(
      question:
          "Who is the first Indian woman to become a botanist? This person also made sugarcanes taste sweeter.",
      choices: [
        "Anna Mani",
        "Asima Chatterjee",
        "Janaki Ammal",
        "Kamal Ranadive"
      ],
      answer: "Janaki Ammal",
      hint: "She was a pioneering plant geneticist.",
      explanation:
          "Janaki Ammal was the first Indian woman to become a botanist. She made significant contributions to the field of genetics and is credited with developing a hybrid of sugarcane that is sweeter than its predecessors."),
  Question(
      question:
          "Which Indian airport uses only solar power to run its operations?",
      choices: [
        "Indira Gandhi International Airport",
        "Chhatrapati Shivaji Maharaj International Airport",
        "Cochin International Airport",
        "Rajiv Gandhi International Airport"
      ],
      answer: "Cochin International Airport",
      hint:
          "This airport is located in Kerala, a state in southern India, and became the world's first fully solar-powered airport in 2015.",
      explanation:
          "Cochin International Airport, located in the southern state of Kerala, became the world's first fully solar-powered airport in 2015. The airport has a 12 MWp solar power plant, which is spread across 45 acres near the cargo complex. The solar plant consists of 46,150 solar panels and can generate up to 60,000 units of electricity per day. This generates more than enough power to meet the airport's daily energy requirements, making it completely self-sufficient in terms of power generation."),
  Question(
      question:
          "Which Indian cities are the cleanest according to Swachh Survekshan 2018?",
      choices: [
        "Mumbai, Bangalore, and Hyderabad",
        "Indore, Bhopal, and Chandigarh",
        "Delhi, Chennai, and Kolkata",
        "Jaipur, Ahmedabad, and Pune"
      ],
      answer: "Indore, Bhopal, and Chandigarh",
      hint: "These cities are all located in different regions of India.",
      explanation:
          "In 2018, the cities of Indore, Bhopal, and Chandigarh were ranked as the top three cleanest cities in India according to Swachh Survekshan, a survey conducted by the Indian government to assess the cleanliness and sanitation of cities and towns across the country. These cities were recognized for their innovative waste management practices, effective sanitation infrastructure, and cleanliness awareness programs."),
  Question(
      question: "Who is the current Governor of the Reserve Bank of India?",
      choices: [
        "Urjit Patel",
        "Raghuram Rajan",
        "Shaktikanta Das",
        "D. Subbarao"
      ],
      answer: "Shaktikanta Das",
      hint: "He was appointed as Governor of the RBI in 2018.",
      explanation:
          "Shaktikanta Das is the current Governor of the Reserve Bank of India (RBI), having taken office in December 2018. Prior to his appointment as Governor, Das served as a member of the Fifteenth Finance Commission of India and as Secretary of the Department of Economic Affairs in the Ministry of Finance."),
  Question(
      question:
          "According to the Air Quality Index report released by Central Pollution Control Board in 2018, which is the most polluted city in India?",
      choices: ["Delhi", "Mumbai", "Kolkata", "Patna"],
      answer: "Patna",
      hint: "This city is the capital of Bihar.",
      explanation:
          "According to the Air Quality Index (AQI) report released by the Central Pollution Control Board (CPCB) in 2018, the most polluted city in India was Patna, the capital of the northern Indian state of Bihar. The report assessed the air quality in 94 Indian cities based on the concentration of pollutants such as PM2.5, PM10, nitrogen dioxide, and ozone."),
  Question(
      question: "When is the National Girl Child Day celebrated in India?",
      choices: ["8 March", "24 January", "11 October", "21 June"],
      answer: "24 January",
      hint:
          "This day is celebrated annually to raise awareness about the importance of gender equality and the rights of the girl child.",
      explanation:
          "National Girl Child Day is celebrated on 24 January every year in India to raise awareness about the importance of gender equality and the rights of the girl child. The day was first observed in 2008 and is intended to promote the empowerment of girls and to work towards eliminating discrimination and violence against them."),
  Question(
      question: "When is National Farmer's Day celebrated in India?",
      choices: ["15 August", "2 October", "23 December", "26 January"],
      answer: "23 December",
      hint:
          "This day is celebrated on the birth anniversary of a former Prime Minister of India, who was known for his pro-farmer policies.",
      explanation:
          "National Farmer's Day, also known as Kisan Diwas, is celebrated in India on 23 December every year to mark the birth anniversary of Chaudhary Charan Singh, a former Prime Minister of India who was known for his pro-farmer policies. The day is dedicated to honoring and celebrating the contributions of farmers to the country's economy and society. Various events and programs are organized across the country to mark the day and raise awareness about the challenges faced by farmers and their importance to the nation's development."),
  Question(
      question:
          "Who was the first person to be awarded The Rajiv Gandhi Khel Ratna Award?",
      choices: [
        "Sachin Tendulkar",
        "Leander Paes",
        "Vishwanathan Anand",
        "Pullela Gopichand"
      ],
      answer: "Vishwanathan Anand",
      hint: "He is a world-renowned chess player.",
      explanation:
          "Vishwanathan Anand was the first person to be awarded The Rajiv Gandhi Khel Ratna Award, India's highest sporting honour. He received the award in 1991-92 for his achievements in the game of chess. Anand is a five-time world chess champion and has won numerous other titles and awards throughout his career."),
  Question(
      question: "Who is known as the 'father of the nation' in India?",
      choices: [
        "Mahatma Gandhi",
        "Jawaharlal Nehru",
        "Sardar Vallabhbhai Patel",
        "B. R. Ambedkar"
      ],
      answer: "Mahatma Gandhi",
      hint: "He played a key role in India's freedom struggle.",
      explanation:
          "Mahatma Gandhi is known as the 'father of the nation' in India. He played a key role in India's freedom struggle and is remembered for his principles of non-violence and peaceful protest."),
  Question(
      question: "Who is known as the missile woman of India?",
      choices: [
        "Tessy Thomas",
        "Indira Gandhi",
        "Kalpana Chawla",
        "Mithali Raj"
      ],
      answer: "Tessy Thomas",
      hint:
          "She is a scientist and played a key role in India's missile development program.",
      explanation:
          "Tessy Thomas is a scientist and engineer who played a key role in India's missile development program. She is known as the 'Missile Woman of India' for her contributions to the development of ballistic missile technology. Tessy Thomas was the project director for the Agni-IV missile program and also played a key role in the development of the Agni-V missile. She is a role model for women in science and technology in India."),
  Question(
      question: "What is the national animal of India?",
      choices: ["Lion", "Tiger", "Elephant", "Leopard"],
      answer: "Tiger",
      hint: "It is an endangered species.",
      explanation:
          "The national animal of India is the tiger. It is an endangered species and is found in various wildlife reserves and national parks across the country."),
  Question(
      question: "What is the name of the Indian currency?",
      choices: ["Dollar", "Rupee", "Euro", "Pound"],
      answer: "Rupee",
      hint: "It is abbreviated as INR.",
      explanation:
          "The name of the Indian currency is the rupee. It is abbreviated as INR and is divided into 100 paise."),
  Question(
      question:
          "What is the name of the Indian festival that marks the end of the winter season?",
      choices: ["Holi", "Diwali", "Navratri", "Basant Panchami"],
      answer: "Holi",
      hint: "It is also known as the festival of colors.",
      explanation:
          "Holi is an Indian festival that marks the end of the winter season. It is also known as the festival of colors and is celebrated by people throwing colored powder and water on each other."),
  Question(
      question: "What is the official language of India?",
      choices: ["Hindi", "English", "Urdu", "Tamil"],
      answer: "Hindi",
      hint: "It is the most widely spoken language in India.",
      explanation:
          "Hindi is the official language of India and is spoken by a majority of the population. However, English is also widely used in official and business contexts."),
  Question(
      question: "What is the largest state in India by area?",
      choices: ["Maharashtra", "Rajasthan", "Uttar Pradesh", "Madhya Pradesh"],
      answer: "Rajasthan",
      hint:
          "It is located in the northwestern part of India and is known for its desert landscape.",
      explanation:
          "Rajasthan is the largest state in India by area, covering over 342,000 square kilometers. It is known for its desert landscape, palaces, and forts."),
  Question(
      question: "Who is the current Prime Minister of India?",
      choices: ["Manmohan Singh", "Rahul Gandhi", "Amit Shah", "Narendra Modi"],
      answer: "Narendra Modi",
      hint: "He has been in office since 2014.",
      explanation:
          "Narendra Modi is the current Prime Minister of India, having been in office since 2014. He is a member of the Bharatiya Janata Party (BJP)."),
  Question(
      question:
          "Who became the first woman president of the United Nations General Assembly?",
      choices: [
        "Indira Gandhi",
        "Golda Meir",
        "Vijaya Lakshmi Pandit",
        "Margaret Thatcher"
      ],
      answer: "Vijaya Lakshmi Pandit",
      hint:
          "She was an Indian diplomat and politician who served as the first female President of the United Nations General Assembly.",
      explanation:
          "Vijaya Lakshmi Pandit was elected as the first woman President of the United Nations General Assembly in 1953. She was also the first woman to hold a cabinet post in India as the Minister of Local Self Government and Public Health in the government of Jawaharlal Nehru."),
  Question(
      question: "Who was the first Miss Universe from India?",
      choices: [
        "Aishwarya Rai",
        "Sushmita Sen",
        "Priyanka Chopra",
        "Lara Dutta"
      ],
      answer: "Sushmita Sen",
      hint: "She won the title in 1994.",
      explanation:
          "Sushmita Sen became the first Indian woman to win the Miss Universe title in 1994. She was only 18 years old at the time of her victory."),
  Question(
      question: "Who was the first Miss World from India?",
      choices: [
        "Reita Faria",
        "Aishwarya Rai",
        "Priyanka Chopra",
        "Manushi Chhillar"
      ],
      answer: "Reita Faria",
      hint: "She won the title in 1966.",
      explanation:
          "Reita Faria became the first Indian woman to win the Miss World title in 1966. After winning the pageant, she focused on her medical studies and became a doctor."),
  Question(
      question: "Who was the first female IAS officer in India?",
      choices: [
        "Anna Rajam Malhotra",
        "Vijaya Lakshmi Pandit",
        "Sarojini Naidu",
        "Indira Gandhi"
      ],
      answer: "Anna Rajam Malhotra",
      hint:
          "She was born in Kerala and served as an IAS officer from 1951 to 1979.",
      explanation:
          "Anna Rajam Malhotra was the first female IAS officer in India. She was born in Kerala and joined the civil services in 1951. During her career as an IAS officer, she held various positions including that of the District Collector of Madras (now Chennai). Malhotra served in the civil services until 1979, when she retired as the Secretary in the Ministry of Welfare."),
  Question(
      question: "Who is known as the Flying Sikh of India?",
      choices: [
        "P.T. Usha",
        "Dhyan Chand",
        "Milkha Singh",
        "Viswanathan Anand"
      ],
      answer: "Milkha Singh",
      hint:
          "He was a former Indian track and field sprinter, and won several international awards during his career.",
      explanation:
          "Milkha Singh was a former Indian track and field sprinter, who was known as the 'Flying Sikh'. He won several international awards during his career, including the gold medal in the 400m race at the 1958 Commonwealth Games. Singh also represented India in the 1960 Summer Olympics in Rome, where he finished fourth in the 400m final. His life story was later made into a biographical film called 'Bhaag Milkha Bhaag'."),
  Question(
      question: "Which was India’s first mission to the Moon?",
      choices: ["Chandrayaan – 1", "Mangalyaan", "Aditya-L1", "Shukrayaan-1"],
      answer: "Chandrayaan – 1",
      hint:
          "It was launched in 2008 by the Indian Space Research Organisation (ISRO).",
      explanation:
          "Chandrayaan – 1 was India's first mission to the Moon. It was launched in 2008 by the Indian Space Research Organisation (ISRO) and was designed to study the lunar surface in detail, including the presence of water. The mission was a success, and it discovered evidence of water molecules on the Moon's surface. India later launched its second lunar mission, Chandrayaan-2, in 2019."),
  Question(
      question: "When was the first telegraph line started in India?",
      choices: ["1851", "1876", "1901", "1925"],
      answer: "1851",
      hint: "It was during the British colonial period.",
      explanation:
          "The first telegraph line in India was established in 1851, connecting Calcutta (now Kolkata) with Diamond Harbour. This was during the British colonial period, when telegraph technology was rapidly spreading across the world."),
  Question(
      question: "When was the PIN System first introduced in India?",
      choices: ["1985", "1998", "2005", "1972"],
      answer: "1972",
      hint: "It is related to postal services.",
      explanation:
          "The Postal Index Number (PIN) system was introduced in India in 1972 to simplify and expedite the sorting and delivery of mail. It is a six-digit code used to identify post offices and their locations across the country."),
  Question(
      question: "Who was the first Indian to win an Oscar award?",
      choices: ["Bhanu Athaiya", "Satyajit Ray", "A.R. Rahman", "Gulzar"],
      answer: "Bhanu Athaiya",
      hint: "She won the award for costume design.",
      explanation:
          "Bhanu Athaiya became the first Indian to win an Oscar award in 1983 for Best Costume Design in the film 'Gandhi'. She shared the award with John Mollo, a British costume designer."),
  Question(
      question:
          "Who was the first woman to become a judge of the Supreme Court of India?",
      choices: ["Leila Seth", "Fathima Beevi", "Ruma Pal", "Sujata V. Manohar"],
      answer: "Fathima Beevi",
      hint:
          "She was also the first woman to be appointed to the Supreme Court of India.",
      explanation:
          "Fathima Beevi was the first woman judge of the Supreme Court of India. She was appointed to the position in 1989, after serving as a judge in the Kerala High Court and the Supreme Court of India."),
  Question(
      question: "Who was the first and only woman Prime Minister of India?",
      choices: [
        "Sonia Gandhi",
        "Sushma Swaraj",
        "Indira Gandhi",
        "Pratibha Patil"
      ],
      answer: "Indira Gandhi",
      hint:
          "She served as the Prime Minister of India from 1966 to 1977, and again from 1980 until her assassination in 1984.",
      explanation:
          "Indira Gandhi was the first and only woman Prime Minister of India. She was the daughter of India's first Prime Minister, Jawaharlal Nehru, and served as the Prime Minister of India for a total of 15 years."),
  Question(
      question: "Who was the first woman governor of any Indian state?",
      choices: [
        "Sarojini Naidu",
        "Sucheta Kriplani",
        "Vijaya Lakshmi Pandit",
        "Annie Besant"
      ],
      answer: "Sarojini Naidu",
      hint: "She was also a noted poet and political activist.",
      explanation:
          "Sarojini Naidu was the first woman governor of any Indian state. She was appointed as the Governor of Uttar Pradesh in 1947, and served in the position until her death in 1949. Naidu was also a prominent leader in the Indian independence movement, and a celebrated poet."),
  Question(
      question: "Which is the highest rank of the Indian Army?",
      choices: ["General", "Colonel", "Brigadier", "Field Marshal"],
      answer: "Field Marshal",
      hint:
          "This is an honorary rank, and has been given to only two individuals in Indian history.",
      explanation:
          "Field Marshal is the highest rank in the Indian Army. It is an honorary rank, and has been given to only two individuals in Indian history - Sam Manekshaw and Kodandera Madappa Cariappa."),
  Question(
      question:
          "Who was the first Indian to become a member of the British parliament?",
      choices: [
        "Mahatma Gandhi",
        "Rabindranath Tagore",
        "Jawaharlal Nehru",
        "Dadabhai Naoroji"
      ],
      answer: "Dadabhai Naoroji",
      hint: "He was also known as the 'Grand Old Man of India'.",
      explanation:
          "Dadabhai Naoroji was the first Indian to become a member of the British parliament. He was elected as the Liberal Party MP for Finsbury Central in 1892, and served in the British parliament for three terms. Naoroji was a prominent leader in the Indian independence movement, and was also a noted economist."),
  Question(
      question: "Who was the first recipient of the Aadhaar Card?",
      choices: [
        "Nandan Nilekani",
        "Amitabh Bachchan",
        "Ranjana Sonawane",
        "Narendra Modi"
      ],
      answer: "Ranjana Sonawane",
      hint: "She was a resident of Maharashtra.",
      explanation:
          "Ranjana Sonawane was the first person to receive the Aadhaar Card, which is a unique identification number issued by the Government of India. She was a resident of Tembhli village in Nandurbar district of Maharashtra, and was issued the first Aadhaar Card on September 29, 2010."),
  Question(
      question: "Who won the first Dadasaheb Phalke Award in 1969?",
      choices: ["Devika Rani", "Prithviraj Kapoor", "Dilip Kumar", "Bimal Roy"],
      answer: "Devika Rani",
      hint: "She was also known as the 'First Lady of Indian Cinema'.",
      explanation:
          "Devika Rani was the first recipient of the Dadasaheb Phalke Award, the highest award for lifetime achievement in Indian cinema. She was a popular actress in the 1930s and 1940s, and was known for her work in films like 'Achhut Kanya' and 'Jeevan Naiya'."),
  Question(
      question:
          "Jivraj Narayan Mehta was the first Chief Minister of India in which state?",
      choices: ["Gujarat", "Maharashtra", "Kerala", "Punjab"],
      answer: "Gujarat",
      hint: "He served as the Chief Minister of the state from 1960 to 1963.",
      explanation:
          "Jivraj Narayan Mehta was the first Chief Minister of Gujarat, which was created after the partition of the state of Bombay in 1960. Mehta was a noted social worker and educationist, and played a key role in the development of Gujarat as a separate state."),
  Question(
      question:
          "What is the name of the river that flows through Varanasi, a holy city in India?",
      choices: ["Ganges", "Yamuna", "Brahmaputra", "Indus"],
      answer: "Ganges",
      hint: "It is considered a sacred river by Hindus.",
      explanation:
          "The Ganges is a sacred river in India that flows through Varanasi, a holy city for Hindus. The river is considered to be a goddess and is worshipped by many."),
  Question(
      question: "What is the name of the iconic mausoleum in Agra, India?",
      choices: ["Red Fort", "Qutub Minar", "Charminar", "Taj Mahal"],
      answer: "Taj Mahal",
      hint:
          "It was built in the 17th century by Emperor Shah Jahan as a tribute to his wife.",
      explanation:
          "The Taj Mahal is an iconic mausoleum in Agra, India that was built in the 17th century by Emperor Shah Jahan as a tribute to his wife, Mumtaz Mahal. It is considered one of the greatest examples of Mughal architecture."),
  Question(
      question:
          "What is the name of the famous Indian monument that was built by Emperor Ashoka in the 3rd century BCE?",
      choices: [
        "Qutub Minar",
        "Ajanta Caves",
        "Sanchi Stupa",
        "Khajuraho Temple"
      ],
      answer: "Sanchi Stupa",
      hint:
          "It is located in the state of Madhya Pradesh and is a UNESCO World Heritage Site.",
      explanation:
          "The Sanchi Stupa is a famous Indian monument that was built by Emperor Ashoka in the 3rd century BCE. It is located in the state of Madhya Pradesh and is a UNESCO World Heritage Site. It is considered to be one of the oldest stone structures in India."),
  Question(
      question:
          "What is the name of the Indian dance form that originated in the state of Kerala?",
      choices: ["Bharatanatyam", "Kathakali", "Kuchipudi", "Manipuri"],
      answer: "Kathakali",
      hint:
          "It is a highly stylized dance form that involves elaborate makeup and costumes.",
      explanation:
          "Kathakali is a popular Indian dance form that originated in the state of Kerala. It is known for its highly stylized movements, elaborate makeup, and costumes. The dance form often tells stories from Hindu mythology."),
  Question(
      question: "What is the name of the Indian film industry based in Mumbai?",
      choices: ["Tollywood", "Bollywood", "Kollywood", "Sandalwood"],
      answer: "Bollywood",
      hint: "It is one of the largest film industries in the world.",
      explanation:
          "Bollywood is the popular name for the Indian film industry based in Mumbai. It is known for producing a large number of films each year and is one of the largest film industries in the world."),
  Question(
      question: "What is the name of the Indian space agency?",
      choices: ["ISRO", "NASA", "ESA", "JAXA"],
      answer: "ISRO",
      hint:
          "It has been responsible for numerous space missions, including the Chandrayaan and Mangalyaan missions.",
      explanation:
          "ISRO, or the Indian Space Research Organization, is the national space agency of India. It has been responsible for numerous space missions, including the Chandrayaan and Mangalyaan missions. It is known for its low-cost approach to space exploration."),
  Question(
      question: "What is the name of the highest mountain peak in India?",
      choices: ["Kanchenjunga", "Nanda Devi", "Mount Everest", "K2"],
      answer: "Kanchenjunga",
      hint: "It is located on the border between India and Nepal.",
      explanation:
          "Kanchenjunga is the highest mountain peak in India, with an elevation of 8,586 meters. It is located on the border between India and Nepal and is considered to be one of the most challenging peaks to climb in the world."),
  Question(
      question: "What is the name of the Indian festival of lights?",
      choices: ["Holi", "Diwali", "Eid al-Fitr", "Dussehra"],
      answer: "Diwali",
      hint:
          "It is celebrated by lighting lamps and candles and is associated with the triumph of good over evil.",
      explanation:
          "Diwali, also known as the festival of lights, is one of the most popular festivals in India. It is celebrated by lighting lamps and candles and is associated with the triumph of good over evil. The festival is celebrated by Hindus, Sikhs, and Jains all over the world."),
  Question(
      question:
          "What is the name of the Indian classical dance form that originated in the state of Manipur?",
      choices: ["Kathakali", "Bharatanatyam", "Kuchipudi", "Manipuri"],
      answer: "Manipuri",
      hint:
          "It is characterized by graceful movements and is usually performed in temples.",
      explanation:
          "Manipuri is a classical dance form that originated in the state of Manipur. It is characterized by graceful movements and is usually performed in temples. The dance form is often associated with the worship of Lord Krishna and Radha."),
  Question(
      question:
          "What is the name of the Indian state that is known for its backwaters and houseboat cruises?",
      choices: ["Kerala", "Goa", "Tamil Nadu", "Maharashtra"],
      answer: "Kerala",
      hint: "It is located on the southwestern coast of India.",
      explanation:
          "Kerala is a state located on the southwestern coast of India. It is known for its backwaters, which are a network of interconnected canals, lagoons, and lakes, and its houseboat cruises. The state is also known for its beaches, hill stations, and wildlife sanctuaries."),
  Question(
      question:
          "What is the name of the Indian classical dance form that originated in the state of Andhra Pradesh?",
      choices: ["Kathakali", "Bharatanatyam", "Kuchipudi", "Manipuri"],
      answer: "Kuchipudi",
      hint: "It is known for its fast footwork and graceful movements.",
      explanation:
          "Kuchipudi is a classical dance form that originated in the state of Andhra Pradesh. It is known for its fast footwork and graceful movements. The dance form often tells stories from Hindu mythology and is performed with live music and singing."),
  Question(
      question: "What is the name of the highest civilian award in India?",
      choices: [
        "Padma Bhushan",
        "Padma Vibhushan",
        "Bharat Ratna",
        "Padma Shri"
      ],
      answer: "Bharat Ratna",
      hint:
          "It is awarded for exceptional service towards advancement of art, literature and science, and in recognition of public service of the highest order.",
      explanation:
          "Bharat Ratna is the highest civilian award in India. It is awarded for exceptional service towards advancement of art, literature and science, and in recognition of public service of the highest order. The award was instituted in 1954 and is given by the President of India."),
  Question(
      question: "What is the motto of the Indian National Emblem?",
      choices: [
        "Satyameva Jayate",
        "Jai Hind",
        "Vande Mataram",
        "Sarve Bhavantu Sukhinah"
      ],
      answer: "Satyameva Jayate",
      hint: "It is a Sanskrit phrase which means 'truth alone triumphs'.",
      explanation:
          "Satyameva Jayate is the motto of the Indian National Emblem. It is a Sanskrit phrase which means 'truth alone triumphs'. The emblem is an adaptation of the Lion Capital of Ashoka, which was originally erected in the third century BCE by the Mauryan emperor Ashoka. The emblem is used by the Government of India for official purposes and also appears on Indian currency notes and coins."),
  Question(
      question: "Who was the first Law and Justice Minister of India?",
      choices: [
        "Dr. B. R. Ambedkar",
        "Sardar Vallabhbhai Patel",
        "Jawaharlal Nehru",
        "Rajendra Prasad"
      ],
      answer: "Dr. B. R. Ambedkar",
      hint:
          "He was a key architect of the Indian Constitution and played a prominent role in Indian politics.",
      explanation:
          "Dr. B. R. Ambedkar was the first Law and Justice Minister of India. He was a key architect of the Indian Constitution and played a prominent role in Indian politics. As the Law and Justice Minister, he was responsible for drafting several important laws, including the Hindu Code Bill, which aimed to reform Hindu personal law. Ambedkar was also the first Dalit (formerly known as untouchable) to be appointed to a senior government position in India."),
  Question(
      question: "Who was the first Chief Minister of Himachal Pradesh?",
      choices: [
        "Virbhadra Singh",
        "Shanta Kumar",
        "Yashwant Singh Parmar",
        "Prem Kumar Dhumal"
      ],
      answer: "Yashwant Singh Parmar",
      hint: "He is also known as the 'Architect of Himachal Pradesh'.",
      explanation:
          "Yashwant Singh Parmar was the first Chief Minister of Himachal Pradesh. He served as the Chief Minister of the state from 1952 to 1956 and again from 1963 to 1977. Parmar is also known as the 'Architect of Himachal Pradesh', as he played a key role in the formation of the state and the development of its infrastructure. He was a prominent leader of the Indian National Congress and also served as a Member of Parliament."),
  Question(
      question: "Who was India’s longest serving Prime Minister?",
      choices: [
        "Indira Gandhi",
        "Jawaharlal Nehru",
        "Morarji Desai",
        "Manmohan Singh"
      ],
      answer: "Jawaharlal Nehru",
      hint:
          "He was the first Prime Minister of India and served for over 17 years.",
      explanation:
          "Jawaharlal Nehru was India's longest serving Prime Minister. He was the first Prime Minister of India and served in that role from 1947 until his death in 1964. Nehru played a key role in shaping modern India and was instrumental in establishing many of the country's key institutions, including the Indian Institutes of Technology (IITs) and the Indian Institutes of Management (IIMs). He was also a prominent international figure and played a leading role in the Non-Aligned Movement."),
  Question(
      question: "Who was the first Chief Election Commissioner of India?",
      choices: [
        "Sukumar Sen",
        "T. N. Seshan",
        "S. Y. Quraishi",
        "N. Gopalaswami"
      ],
      answer: "Sukumar Sen",
      hint: "He was appointed to this position in 1950.",
      explanation:
          "Sukumar Sen was the first Chief Election Commissioner of India. He served in this position from 1950 to 1958. Sen was responsible for overseeing the first two general elections in India, which were held in 1951-52 and 1957. He played a crucial role in establishing the Election Commission of India as an independent and impartial body."),
  Question(
      question: "Who was the first US president to visit India?",
      choices: [
        "Dwight D. Eisenhower",
        "John F. Kennedy",
        "Richard Nixon",
        "Jimmy Carter"
      ],
      answer: "Dwight D. Eisenhower",
      hint: "He visited India in 1959.",
      explanation:
          "Dwight D. Eisenhower was the first US president to visit India. He visited India in 1959 as part of a global tour. During his visit, he met with Indian Prime Minister Jawaharlal Nehru and discussed issues related to US-India relations, world peace, and security. The visit was seen as an important milestone in the relationship between the two countries."),
  Question(
      question:
          "For which book Rabindranath Tagore won the Nobel prize in Literature?",
      choices: [
        "Gitanjali",
        "The Home and the World",
        "The Post Office",
        "The Hungry Stones"
      ],
      answer: "Gitanjali",
      hint: "It is a collection of poems.",
      explanation:
          "Rabindranath Tagore won the Nobel prize in Literature in 1913 for his collection of poems called Gitanjali. The book was published in English in 1912 and contained 103 poems. The poems are written in a lyrical and devotional style and deal with themes such as love, nature, and spirituality. The Nobel prize brought Tagore international recognition and helped to establish him as a major literary figure."),
  Question(
      question: "In which field Amartya Sen received the Nobel Prize in 1998?",
      choices: ["Economics", "Physics", "Chemistry", "Medicine"],
      answer: "Economics",
      hint: "He was awarded the Nobel Memorial Prize in Economic Sciences.",
      explanation:
          "Amartya Sen received the Nobel Prize in Economics in 1998 for his contributions to welfare economics and social choice theory. Sen's work focuses on how economic policies and institutions can be designed to promote the well-being of individuals and communities. He has also been a prominent advocate for human rights and development issues, and has written extensively on topics such as famine, poverty, and gender inequality."),
  Question(
      question:
          "What is the name of the famous Indian monument that was built by Mughal Emperor Shah Jahan in memory of his wife Mumtaz Mahal?",
      choices: ["Red Fort", "Hawa Mahal", "Qutub Minar", "Taj Mahal"],
      answer: "Taj Mahal",
      hint:
          "It is located in the city of Agra in the northern Indian state of Uttar Pradesh.",
      explanation:
          "Taj Mahal is a famous monument located in the city of Agra in the northern Indian state of Uttar Pradesh. It was built by Mughal Emperor Shah Jahan in memory of his wife Mumtaz Mahal. The monument is regarded as one of the greatest examples of Mughal architecture and is a UNESCO World Heritage Site."),
  Question(
      question:
          "What is the name of the Indian state that shares a border with Myanmar?",
      choices: ["Manipur", "Assam", "Nagaland", "Mizoram"],
      answer: "Mizoram",
      hint: "It is located in the northeastern part of India.",
      explanation:
          "Mizoram is an Indian state located in the northeastern part of the country. It shares a border with Myanmar and is known for its natural beauty and rich culture."),
  Question(
      question:
          "What is the name of the Indian dance form that originated in the state of Kerala?",
      choices: ["Kathakali", "Bharatanatyam", "Kuchipudi", "Manipuri"],
      answer: "Kathakali",
      hint: "It is known for its elaborate makeup and costumes.",
      explanation:
          "Kathakali is an Indian dance form that originated in the state of Kerala. It is known for its elaborate makeup and costumes, and it often tells stories from Hindu mythology."),
  Question(
      question: "What is the name of the Indian space agency?",
      choices: ["NASA", "ESA", "Roscosmos", "ISRO"],
      answer: "ISRO",
      hint: "It is headquartered in the city of Bengaluru.",
      explanation:
          "ISRO (Indian Space Research Organisation) is the space agency of India. It is headquartered in the city of Bengaluru and is responsible for India's space programme. The agency has successfully launched a number of satellites and space missions, including the Chandrayaan-1 and Mars Orbiter Mission."),
  Question(
      question:
          "What is the name of the Indian state that is known for its one-horned rhinoceros?",
      choices: ["Assam", "Karnataka", "Uttar Pradesh", "Gujarat"],
      answer: "Assam",
      hint: "It is located in the northeastern part of India.",
      explanation:
          "Assam is a state located in the northeastern part of India. It is known for its one-horned rhinoceros, which is found in the Kaziranga National Park. The state is also known for its tea plantations, wildlife sanctuaries, and national parks."),
  Question(
      question:
          "What is the name of the Indian sport that involves hitting a small leather ball with a curved stick?",
      choices: ["Cricket", "Hockey", "Badminton", "Polo"],
      answer: "Polo",
      hint:
          "It was originally played by the royalty and is often referred to as the sport of kings.",
      explanation:
          "Polo is a sport that involves hitting a small leather ball with a curved stick. It was originally played by the royalty and is often referred to as the sport of kings. The sport is played on horseback and is popular in several countries, including India."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'land of the rising sun'?",
      choices: ["Arunachal Pradesh", "Sikkim", "Mizoram", "Manipur"],
      answer: "Arunachal Pradesh",
      hint: "It is located in the northeastern part of India.",
      explanation:
          "Arunachal Pradesh is a state located in the northeastern part of India. It is known as the 'land of the rising sun' because it is the first place in India where the sun rises. The state is known for its natural beauty, diverse tribal culture, and Buddhist monasteries."),
  Question(
      question:
          "What is the name of the Indian festival that celebrates the victory of good over evil?",
      choices: ["Diwali", "Holi", "Dussehra", "Eid"],
      answer: "Dussehra",
      hint: "It is celebrated in the month of October or November.",
      explanation:
          "Dussehra is a Hindu festival that celebrates the victory of good over evil. It is celebrated in the month of October or November and marks the end of the Navratri festival. The festival is celebrated by burning effigies of the demon king Ravana and is also known as Vijayadashami."),
  Question(
      question:
          "What is the name of the Indian city that is known as the 'city of pearls'?",
      choices: ["Hyderabad", "Mumbai", "Chennai", "Kolkata"],
      answer: "Hyderabad",
      hint: "It is located in the southern part of India.",
      explanation:
          "Hyderabad is a city located in the southern part of India. It is known as the 'city of pearls' because it is a major centre for the pearl trade. The city is also known for its rich history, architecture, and cuisine, and is home to several historical monuments, including the Charminar and the Golconda Fort."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'land of festivals'?",
      choices: ["Punjab", "Maharashtra", "Uttar Pradesh", "Odisha"],
      answer: "Odisha",
      hint: "It is located on the eastern coast of India.",
      explanation:
          "Odisha is a state located on the eastern coast of India. It is known as the 'land of festivals' because it is home to several colourful and vibrant festivals, including the Rath Yatra, Durga Puja, and Konark Dance Festival. The state is also known for its temples, beaches, and wildlife sanctuaries."),
  Question(
      question:
          "What is the name of the Indian philosopher and teacher who is believed to have written the 'Yoga Sutras'?",
      choices: [
        "Swami Vivekananda",
        "Mahatma Gandhi",
        "Patanjali",
        "Sri Aurobindo"
      ],
      answer: "Patanjali",
      hint: "He is considered the father of modern yoga.",
      explanation:
          "Patanjali is an ancient Indian philosopher and teacher who is believed to have written the 'Yoga Sutras'. He is considered the father of modern yoga and his teachings on yoga and meditation have had a profound influence on the practice of yoga worldwide."),
  Question(
      question:
          "What is the name of the largest river island in the world, located in India?",
      choices: ["Andaman", "Nicobar", "Majuli", "Lakshadweep"],
      answer: "Majuli",
      hint: "It is located in the northeastern state of Assam.",
      explanation:
          "Majuli is the largest river island in the world, located in the northeastern state of Assam. It is formed by the Brahmaputra River and is known for its rich biodiversity and unique culture of the Mishing tribe."),
  Question(
      question: "What is the name of the highest mountain peak in India?",
      choices: ["Kangchenjunga", "Mount Everest", "Nanda Devi", "K2"],
      answer: "Kangchenjunga",
      hint: "It is located in the northeastern state of Sikkim.",
      explanation:
          "Kangchenjunga is the highest mountain peak in India, located in the northeastern state of Sikkim. It is the third-highest peak in the world and is considered sacred by the local people."),
  Question(
      question:
          "What is the name of the Indian state that is known for its backwaters and houseboat tourism?",
      choices: [
        "Tamil Nadu",
        "Andhra Pradesh",
        "Karnataka",
        "Kerala",
      ],
      answer: "Kerala",
      hint: "It is located in the southwestern part of India.",
      explanation:
          "Kerala is an Indian state located in the southwestern part of the country. It is known for its backwaters and houseboat tourism, which are a popular tourist attraction in the state."),
  Question(
      question:
          "What is the name of the Indian state that is known for its diamond mines?",
      choices: ["Madhya Pradesh", "Andhra Pradesh", "Karnataka", "Telangana"],
      answer: "Andhra Pradesh",
      hint: "It is located in the southeastern part of India.",
      explanation:
          "Andhra Pradesh is an Indian state located in the southeastern part of the country. It is known for its diamond mines, which are located in the town of Guntur."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'land of black pagoda'?",
      choices: ["West Bengal", "Assam", "Odisha", "Tripura"],
      answer: "Odisha",
      hint: "It is located in the eastern part of India.",
      explanation:
          "Odisha is an Indian state located in the eastern part of the country. It is known as the 'land of black pagoda' because of the famous Sun Temple located in Konark, which is made of black granite and is dedicated to the Hindu sun god, Surya."),
  Question(
      question:
          "What is the name of the Indian state that is known for its ancient Ajanta and Ellora caves?",
      choices: ["Maharashtra", "Gujarat", "Rajasthan", "Uttar Pradesh"],
      answer: "Maharashtra",
      hint: "It is located in the western part of India.",
      explanation:
          "Maharashtra is an Indian state located in the western part of the country. It is known for its ancient Ajanta and Ellora caves, which are a UNESCO World Heritage Site and are famous for their rock-cut sculptures and paintings."),
  Question(
      question:
          "What is the name of the Indian state that is home to the famous hill station of Darjeeling?",
      choices: ["West Bengal", "Sikkim", "Assam", "Meghalaya"],
      answer: "West Bengal",
      hint: "It is located in the eastern part of India.",
      explanation:
          "West Bengal is an Indian state located in the eastern part of the country. It is home to the famous hill station of Darjeeling, which is known for its tea plantations and beautiful views of the Himalayas."),
  Question(
      question:
          "What is the name of the Indian city that is known as the 'pink city'?",
      choices: ["Jodhpur", "Jaipur", "Udaipur", "Jaisalmer"],
      answer: "Jaipur",
      hint: "It is located in the northern part of India.",
      explanation:
          "Jaipur is an Indian city located in the northern part of the country. It is known as the 'pink city' because many of its buildings are painted a pinkish color."),
  Question(
      question: "Who was the first Indian to win the Man Booker Prize?",
      choices: [
        "Salman Rushdie",
        "Vikram Seth",
        "Kiran Desai",
        "Arundhati Roy"
      ],
      answer: "Arundhati Roy",
      hint:
          "The winner of the prize in 1997 for her debut novel 'The God of Small Things'.",
      explanation:
          "Arundhati Roy is a renowned Indian author, activist, and recipient of numerous awards, including the prestigious Man Booker Prize in 1997. She won the award for her debut novel 'The God of Small Things', which is a story about the tragic fate of a pair of twins in Kerala, India. Roy's win made her the first Indian woman to win the prize and brought her international fame and recognition."),
  Question(
      question: "Who was awarded the first Param Vir Chakra?",
      choices: [
        "Major Somnath Sharma",
        "Captain Vikram Batra",
        "Subedar Joginder Singh",
        "Havildar Abdul Hamid"
      ],
      answer: "Major Somnath Sharma",
      hint:
          "He was awarded the medal posthumously for his bravery in the Indo-Pak War of 1947.",
      explanation:
          "The Param Vir Chakra is India's highest military decoration, awarded for acts of conspicuous gallantry in the presence of the enemy. Major Somnath Sharma of the Indian Army was the first recipient of this award. He was awarded the medal posthumously for his bravery in the Indo-Pak War of 1947. Sharma was commanding a company of the Kumaon Regiment when he was killed in action while defending the strategic Srinagar airfield from Pakistani raiders."),
  Question(
      question: "Who was the first Indian woman to be awarded the Nobel Prize?",
      choices: [
        "Mother Teresa",
        "Annie Besant",
        "Sarojini Naidu",
        "Amartya Sen"
      ],
      answer: "Annie Besant",
      hint: "She was awarded the prize in 1907 for her humanitarian work.",
      explanation:
          "Annie Besant was a British socialist, women's rights activist, and theosophist who made India her home in the later part of her life. In 1907, she was awarded the Nobel Prize for Peace for her humanitarian work, especially her efforts to improve the lives of women and children in India. Besant was the first Indian woman to be awarded a Nobel Prize, paving the way for other Indian women to make their mark on the world stage."),
  Question(
      question: "Who was the first female Indian Astronaut?",
      choices: [
        "Sunita Williams",
        "Ritu Karidhal",
        "Kalpana Chawla",
        "Moumita Dutta"
      ],
      answer: "Kalpana Chawla",
      hint: "She was a crew member on the Space Shuttle Columbia.",
      explanation:
          "Kalpana Chawla was an Indian-American astronaut and the first woman of Indian origin to go to space. She was a crew member on the Space Shuttle Columbia and flew into space in 1997 as part of the STS-87 mission. Chawla was known for her passion for flying and her dedication to space exploration. She tragically lost her life in 2003, along with the rest of the crew, when the Space Shuttle Columbia disintegrated during re-entry into the Earth's atmosphere."),
  Question(
      question: "Who appoints the Chief Justice of the Supreme Court of India?",
      choices: [
        "Prime Minister",
        "President",
        "Attorney General",
        "Chief Justice of India"
      ],
      answer: "President",
      hint:
          "The appointment is made by the President of India, based on the recommendation of the outgoing Chief Justice of India and consultation with other judges of the Supreme Court.",
      explanation:
          "The Chief Justice of India is the head of the judiciary in India and is appointed by the President of India. The appointment is made based on the recommendation of the outgoing Chief Justice of India and consultation with other judges of the Supreme Court. The Chief Justice of India holds office until the age of 65 years or until he or she resigns or is removed from office by impeachment, as per the provisions of the Constitution of India."),
  Question(
      question: "Which popular cricketer is known as ‘Haryana Hurricane‘?",
      choices: ["MS Dhoni", "Sachin Tendulkar", "Kapil Dev", "Rahul Dravid"],
      answer: "Kapil Dev",
      hint:
          "He captained the Indian cricket team to victory in the 1983 Cricket World Cup.",
      explanation:
          "Kapil Dev is a former Indian cricketer and one of the greatest all-rounders in the history of the game. He was born in Haryana and was given the nickname 'Haryana Hurricane' for his explosive batting and fast bowling. Kapil Dev is also known for leading the Indian cricket team to its first-ever World Cup victory in 1983, a feat that remains one of the greatest moments in Indian cricket history."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'land of black diamonds'?",
      choices: ["Jharkhand", "Chhattisgarh", "Madhya Pradesh", "Maharashtra"],
      answer: "Jharkhand",
      hint: "It is located in the eastern part of India.",
      explanation:
          "Jharkhand is a state located in the eastern part of India. It is known as the 'land of black diamonds' because it is rich in mineral resources, including coal, iron ore, and copper. The state is also known for its waterfalls, forests, and wildlife sanctuaries."),
  Question(
      question: "Who was the first Speaker of the Lok Sabha?",
      choices: [
        "Dr. Rajendra Prasad",
        "Sardar Hukam Singh",
        "Gopal Swarup Pathak",
        "Ganesh Vasudev Mavalankar",
      ],
      answer: "Ganesh Vasudev Mavalankar",
      hint: "He served as the Speaker of the Lok Sabha from 1952 to 1956.",
      explanation:
          "Ganesh Vasudev Mavalankar was an Indian independence activist and the first Speaker of the Lok Sabha, the lower house of the Indian Parliament. He was elected as the Speaker of the Lok Sabha in 1952 and served in the position until 1956. Mavalankar was also a member of the Constituent Assembly of India and played a significant role in drafting the Constitution of India."),
  Question(
      question: "Where is the Indian Military Academy located?",
      choices: ["Dehradun", "New Delhi", "Pune", "Chennai"],
      answer: "Dehradun",
      hint: "It is located in the foothills of the Himalayas.",
      explanation:
          "The Indian Military Academy is located in Dehradun, Uttarakhand, and is the premier officer training institute of the Indian Army. Established in 1932, the academy trains officers for the Indian Army and is located in the foothills of the Himalayas, providing a conducive environment for training in mountaineering and other outdoor activities."),
  Question(
      question:
          "The Indian Institute of Science is located in which Indian city?",
      choices: ["Mumbai", "Chennai", "Bangalore", "New Delhi"],
      answer: "Bangalore",
      hint:
          "It is a public research university for scientific and technological research.",
      explanation:
          "The Indian Institute of Science (IISc) is a public research university for scientific and technological research located in Bangalore, Karnataka. It was established in 1909 and is regarded as one of the top research institutions in India. The institute offers undergraduate, postgraduate, and doctoral programs in various fields of science, engineering, design, and management."),
  Question(
      question:
          "What is the name of the Indian festival that celebrates the birth of Lord Krishna?",
      choices: ["Diwali", "Holi", "Janmashtami", "Eid"],
      answer: "Janmashtami",
      hint: "It is celebrated in the month of August or September.",
      explanation:
          "Janmashtami is a Hindu festival that celebrates the birth of Lord Krishna. It is celebrated in the month of August or September and is observed by fasting, singing devotional songs, and performing religious rituals. The festival is especially popular in the state of Uttar Pradesh, where Lord Krishna is believed to have been born."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'land of the white desert'?",
      choices: ["Gujarat", "Rajasthan", "Haryana", "Punjab"],
      answer: "Gujarat",
      hint: "It is located in the western part of India.",
      explanation:
          "Gujarat is a state located in the western part of India. It is known as the 'land of the white desert' because it is home to the Rann of Kutch, a vast salt marsh that turns white during the dry season. The state is also known for its rich history, culture, and cuisine."),
  Question(
      question:
          "What is the name of the Indian city that is known as the 'silicon valley of India'?",
      choices: ["Mumbai", "Bengaluru", "Chennai", "Hyderabad"],
      answer: "Bengaluru",
      hint: "It is located in the southern part of India.",
      explanation:
          "Bengaluru, also known as Bangalore, is a city located in the southern part of India. It is known as the 'silicon valley of India' because it is a major hub for the Indian technology industry. The city is also known for its pleasant weather, parks, and gardens."),
  Question(
      question:
          "What is the name of the Indian festival that is dedicated to the Hindu god Lord Ganesha?",
      choices: ["Diwali", "Holi", "Ganesh Chaturthi", "Navratri"],
      answer: "Ganesh Chaturthi",
      hint: "It is celebrated in the month of August or September.",
      explanation:
          "Ganesh Chaturthi is a Hindu festival that is dedicated to the god Lord Ganesha. It is celebrated in the month of August or September and is particularly popular in the state of Maharashtra. During the festival, large idols of Lord Ganesha are installed in public places and homes, and later immersed in water bodies."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'God's own country'?",
      choices: ["Karnataka", "Tamil Nadu", "Kerala", "Andhra Pradesh"],
      answer: "Kerala",
      hint: "It is located in the southern part of India.",
      explanation:
          "Kerala is a state located in the southern part of India. It is known as the 'God's own country' because of its scenic beauty, backwaters, beaches, and greenery. The state is also known for its unique cuisine, traditional arts, and culture."),
  Question(
      question:
          "What is the name of the Indian city that is known as the 'city of joy'?",
      choices: ["Kolkata", "Mumbai", "Chennai", "Bengaluru"],
      answer: "Kolkata",
      hint: "It is located in the eastern part of India.",
      explanation:
          "Kolkata is a city located in the eastern part of India. It is known as the 'city of joy' because of its vibrant culture, literature, and art scene. The city is also known for its colonial architecture and delicious street food."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'land of festivals'?",
      choices: ["Uttar Pradesh", "Madhya Pradesh", "Odisha", "West Bengal"],
      answer: "Odisha",
      hint: "It is located in the eastern part of India.",
      explanation:
          "Odisha is a state located in the eastern part of India. It is known as the 'land of festivals' because it celebrates a large number of festivals throughout the year, including the famous Rath Yatra, Durga Puja, and Konark Dance Festival."),
  Question(
      question:
          "What is the name of the Indian state that is known as the 'spice garden of India'?",
      choices: ["Karnataka", "Andhra Pradesh", "Kerala", "Assam"],
      answer: "Kerala",
      hint: "It is located in the southern part of India.",
      explanation:
          "Kerala is a state located in the southern part of India. It is known as the 'spice garden of India' because of its rich production of spices, including pepper, cardamom, ginger, and cinnamon. The state's cuisine is also known for its use of aromatic spices."),
  Question(
      question: "Which Indian State is known as the Land of Five Rivers?",
      choices: ["Punjab", "Haryana", "Uttar Pradesh", "Madhya Pradesh"],
      answer: "Punjab",
      hint: "The five rivers are Sutlej, Beas, Ravi, Chenab and Jhelum.",
      explanation:
          "Punjab is a state in northern India that is known as the Land of Five Rivers. The five rivers that flow through the state are the Sutlej, Beas, Ravi, Chenab, and Jhelum. These rivers provide water for irrigation and contribute to the agricultural productivity of the state. Punjab is also known for its rich culture, music, and cuisine."),
  Question(
      question:
          "The world-famous Howrah Bridge is located in which city in India?",
      choices: ["Kolkata", "Mumbai", "New Delhi", "Chennai"],
      answer: "Kolkata",
      hint: "It is a cantilever bridge that spans over the Hooghly River.",
      explanation:
          "The Howrah Bridge is a world-famous bridge located in Kolkata, West Bengal. It is a cantilever bridge that spans over the Hooghly River, connecting the cities of Kolkata and Howrah. The bridge is one of the busiest in the world, carrying a daily traffic of around 100,000 vehicles and more than 150,000 pedestrians. The Howrah Bridge is a symbol of Kolkata's engineering and architectural excellence and is an important landmark of the city."),
  Question(
      question:
          "Indian Standard Time (IST) is taken from which place in India?",
      choices: ["Mumbai", "Chennai", "Naini", "Kolkata"],
      answer: "Naini",
      hint: "It is located in the state of Uttar Pradesh.",
      explanation:
          "Indian Standard Time (IST) is the time zone used in India and is taken from the Naini observatory near Allahabad in the state of Uttar Pradesh. The observatory is located at a longitude of 82.5 degrees east and is responsible for keeping track of time in India. IST is 5 hours and 30 minutes ahead of Coordinated Universal Time (UTC+5:30)."),
  Question(
      question: "Which is the oldest mountain range in India?",
      choices: [
        "Aravalli Range",
        "Himalayas",
        "Western Ghats",
        "Eastern Ghats"
      ],
      answer: "Aravalli Range",
      hint: "It is located in western India and extends from Gujarat to Delhi.",
      explanation:
          "The Aravalli Range is the oldest mountain range in India and is located in western India, extending from Gujarat to Delhi. The range is believed to be more than 350 million years old and has been an important source of minerals such as copper, zinc, and lead. The Aravalli Range is also an important ecological zone and is home to several wildlife species including leopards, hyenas, and Indian striped hyenas."),
  Question(
      question: "Who opened the first school for girls in India?",
      choices: [
        "Rani Lakshmi Bai",
        "Mother Teresa",
        "Indira Gandhi",
        "Savitribai Phule"
      ],
      answer: "Savitribai Phule",
      hint: "She was a social reformer and women's rights activist.",
      explanation:
          "Savitribai Phule was a social reformer and women's rights activist who, along with her husband Jyotirao Phule, opened the first school for girls in India in Pune in 1848. The school was started with the aim of providing education to girls who were otherwise excluded from the formal education system. Savitribai Phule was also a poet and a strong advocate of women's education and empowerment."),
  Question(
      question: "Who was the first Indian woman to become a pilot?",
      choices: [
        "Sarla Thakral",
        "Captain Prem Mathur",
        "Bhawana Kanth",
        "Avani Chaturvedi"
      ],
      answer: "Captain Prem Mathur",
      hint: "She was a commercial pilot and aviation pioneer.",
      explanation:
          "Captain Prem Mathur was the first Indian woman to become a pilot. She earned her commercial pilot's license in 1947 and went on to become a pioneering figure in Indian aviation. She served as the chief pilot for the Deccan Airways and was also the first Indian woman to fly the Hawker Hurricane fighter plane. Captain Prem Mathur was a trailblazer for women in aviation and inspired many others to follow in her footsteps."),
  Question(
      question:
          "Who was the first Indian to become the president of the UN General Assembly?",
      choices: [
        "Sushma Swaraj",
        "Shashi Tharoor",
        "Vijaya Lakshmi Pandit",
        "Jawaharlal Nehru"
      ],
      answer: "Vijaya Lakshmi Pandit",
      hint: "She was a diplomat and a member of India's first cabinet.",
      explanation:
          "Vijaya Lakshmi Pandit was a diplomat and a member of India's first cabinet. She was the first woman to hold the position of the president of the United Nations General Assembly in 1953. She was also the first woman to be appointed as India's ambassador to the United States and the United Kingdom. Vijaya Lakshmi Pandit was a trailblazer for women in diplomacy and paved the way for many others to follow."),
  Question(
      question: "Which language was thought to be spoken by Buddha?",
      choices: ["Pali", "Sanskrit", "Prakrit", "Magadhi"],
      answer: "Pali",
      hint: "It is an ancient language used in Buddhist scriptures.",
      explanation:
          "Pali is an ancient language that is used in Buddhist scriptures and is believed to be the language spoken by the Buddha. Pali is a language of the Theravada Buddhist tradition and is still used in some countries, such as Sri Lanka and Myanmar, as a liturgical language. The Pali language is known for its concise and precise grammar and is an important part of Buddhist scholarship."),
  Question(
      question: "Who founded Indian Academy of Science?",
      choices: [
        "Homi J. Bhabha",
        "Dr. APJ Abul Kalam",
        "Sir Chandrasekhara Venkata Raman"
      ],
      answer: "Sir Chandrasekhara Venkata Raman",
      hint: "He was a Nobel Prize-winning physicist.",
      explanation:
          "Sir C V Raman founded the Indian Academy of Sciences (IAS) Bangalore was founded on 27 April 1934. He registered it as a society with the aim of promoting the progress and upholding the cause of science, in both pure and applied branches."),
  Question(
      question: "Who is known as the 'Father of Indian Nuclear Programme'?",
      choices: ["Narendra Modi", "Homi J. Bhabha", "Sir CV Raman"],
      answer: "Homi J. Bhabha",
      hint: "He founded the Bhabha Atomic Research Centre.",
      explanation:
          "Homi Jehangir Bhabha is known as the 'Father of Indian Nuclear Programme'. An Indian nuclear physicist who founded Bhabha Atomic Research Centre."),
  Question(
      question: "Who is known as the 'Father of the Indian Space Programme'?",
      choices: ["Devendra Lal", "Dr. Manmohan Singh", "Dr. Vikram Sarabhai"],
      answer: "Dr. Vikram Sarabhai",
      hint: "He established a large number of institutions in diverse fields.",
      explanation:
          "Dr. Vikram Sarabhai is considered the Father of the Indian space program. A great institution builder who established or helped to establish a large number of institutions in diverse fields."),
  Question(
      question: "What is the discovery of CV Raman?",
      choices: ["Raman Effect", "Accordion effect", "Additive genetic effects"],
      answer: "Raman Effect",
      hint: "It was the discovery that won him the Nobel Prize in Physics.",
      explanation:
          "The Raman Effect was the discovery that won physicist Sir CV Raman his Nobel Prize in 1930."),
  Question(
      question: "National Science Day is dedicated to?",
      choices: ["Dr. APJ Abul Kalam", "Vikram Sarabhai", "Sir C.V. Raman"],
      answer: "Sir C.V. Raman",
      hint: "It is celebrated on February 28th each year.",
      explanation:
          "National Science Day is celebrated in India on February 28th each year to mark the discovery of the Raman effect by Indian physicist Sir CV Raman on 28 February 1928, for his discovery, he was awarded the Nobel Prize in Physics in 1930."),
  Question(
      question: "When did Sir CV Raman pass away?",
      choices: ["November 21, 1970", "November 21, 1972", "October 21, 1988"],
      answer: "November 21, 1970",
      hint: "He passed away in Bangalore",
      explanation:
          "Raman died of natural causes on 21 November 1970 aged 82 in Bangalore."),
  Question(
      question: "Where was Sir CV Raman born?",
      choices: ["Karnataka", "Tamil Nadu", "Kolkata"],
      answer: "Tamil Nadu",
      hint: "He was born in Southern India",
      explanation:
          "Chandrasekhara Venkata Raman was born at Tiruchirappalli in Southern India Tamil Nadu on November 7th,"),
  Question(
      question: "In which year was the Raman Effect discovered?",
      choices: ["2001", "1928", "1947"],
      answer: "1928",
      hint: "It was discovered on a boat trip back from England",
      explanation:
          "February 1928: Raman scattering discovered. On a boat trip back from England in 1921."),
  Question(
      question: "When was Sir C V Raman Born?",
      choices: ["7 November 1888", "7 October 1888", "7 August 1888"],
      answer: "7 November 1888",
      hint: "He was born in Southern India",
      explanation:
          "Chandrasekhara Venkata Raman was born at Tiruchirappalli in Southern India on November 7th, 1888."),
  Question(
      question: "What is the theme of National Science Day 2023?",
      choices: [
        "Future of Science, Technology and Innovation",
        "Global Physics for Global Wellbeing",
        "Global Science for Global Wellbeing"
      ],
      answer: "Global Science for Global Wellbeing",
      hint: "It emphasizes the importance of science on a global scale",
      explanation:
          "The theme of National Science Day 2023 is 'Global Science for Global Wellbeing'"),
  Question(
    question: "What is related to the 'Operation Green' mission?",
    choices: [
      "Production of tomato, onion and potatoes",
      "Production of tomato, chilli and potatoes",
      "Production of pulses, onion and potatoes",
      "Production of tomato, pulses and rice",
    ],
    answer: "Production of tomato, onion and potatoes",
    hint:
        "The 'Operation Green' mission is a Government of India initiative to promote the production and processing of tomato, onion, and potato crops. The scheme aims to stabilize the supply of these crops and ensure remunerative prices to the growers.",
    explanation:
        "'Operation Green' mission is related to the production of tomato, onion and potatoes. The scheme was launched by the Government of India in 2018 to promote the processing and production of these crops to ensure stability in their supply and ensure better prices for the growers.",
  ),
  Question(
      question:
          "Which policy (Yojna) aims to bring 5 lakh acres under organic farming?",
      choices: [
        "Shyama Prasad Mukherji Rurban Mission",
        "Paramparagat Krishi Vikas Yojana",
        "Pradhan Mantri Krishi Sinchai Yojana",
        "Pradhan Mantri Fasal Bima Yojana",
      ],
      answer: "Paramparagat Krishi Vikas Yojana",
      hint:
          "The Government of India has launched several initiatives to promote organic farming in the country. This particular scheme aims to bring 5 lakh acres of land under organic farming in a phased manner.",
      explanation:
          "The Paramparagat Krishi Vikas Yojana (PKVY) aims to promote and support organic farming across the country. Under this scheme, the government plans to bring 5 lakh acres of land under organic farming in a phased manner. The scheme also provides financial assistance to farmers for the use of organic inputs and natural resources for crop production."),
  Question(
      question:
          "Which Bill was proposed to be passed to solve problems in infrastructure contracts, PPP and Public Utilities?",
      choices: [
        "Skill Development Programme",
        "Companies Amendment Bill",
        "Public Utility Resolution of Disputes Bill",
        "Goods & Services Tax"
      ],
      answer: "Public Utility Resolution of Disputes Bill",
      hint:
          "This bill aims to provide a mechanism for the resolution of disputes related to public utility contracts, PPP contracts, and infrastructure contracts.",
      explanation:
          "The Public Utility Resolution of Disputes Bill was proposed to resolve disputes in infrastructure contracts, PPP, and Public Utilities."),
  Question(
      question:
          "Service Tax to be exempted on general insurance schemes under which scheme:",
      choices: [
        "Companies Amendment Bill",
        "Shyama Prasad Mukherji Rurban Mission",
        "Customer Act",
        "NIRMAYA Scheme"
      ],
      answer: "NIRMAYA Scheme",
      hint:
          "This scheme aims to provide health insurance coverage to persons with disabilities and is named after a Sanskrit word meaning free from illness.",
      explanation:
          "Service tax is exempted on general insurance schemes under the NIRMAYA Scheme, which is a health insurance scheme for persons with disabilities and the economically weaker sections of society."),
  Question(
      question:
          "Who said one of the most powerful slogans of India's freedom struggle, 'Do or Die?'",
      choices: [
        "Gandhiji",
        "Jawahar Lal Nehru",
        "Bal Gangadhar Tilak",
        "Subhash Chandra Bose"
      ],
      answer: "Gandhiji",
      hint:
          "This slogan was given by a prominent leader of India's freedom struggle who is widely known for his philosophy of non-violent resistance.",
      explanation:
          "The slogan 'Do or Die' was given by Mahatma Gandhi during the Quit India Movement in 1942. This slogan was a call to Indians to rise up in non-violent resistance against British colonial rule and to fight for their freedom."),
  Question(
      question: "Who founded the Madras Labour Union?",
      choices: [
        "Subodh Banerjee",
        "B.P. Wadia",
        "Lala Lajpat Rai",
        "Bharat Bhushan Pandey"
      ],
      answer: "B.P. Wadia",
      hint:
          "This person was a social worker and trade unionist who was involved in the Indian freedom struggle and played an important role in the labour movement in India.",
      explanation:
          "B.P. Wadia founded the Madras Labour Union in 1918. He was a social worker and trade unionist who was actively involved in the Indian freedom struggle and played a significant role in the labour movement in India."),
  Question(
      question: "Who among these was the first Indian lady to head Congress?",
      choices: [
        "Raj Kumari Amrit Kaur",
        "Annie Besant",
        "Vijayalakshmi Pandit",
        "Sarojini Naidu"
      ],
      answer: "Annie Besant",
      hint:
          "This person was a British socialist, women's rights activist, and supporter of Indian self-rule who played an important role in the Indian freedom struggle.",
      explanation:
          "Annie Besant was the first woman to head the Indian National Congress in 1917. She was a British socialist, women's rights activist, and supporter of Indian self-rule who played an important role in the Indian freedom struggle."),
  Question(
      question:
          "Whose death coincided with the launch of the Non-cooperation Movement in 1920?",
      choices: [
        "Dadabhai Naoroji",
        "Lokmanya Tilak",
        "GK Gokhale",
        "Motilal Nehru"
      ],
      answer: "Lokmanya Tilak",
      hint:
          "This person was a prominent Indian nationalist, social reformer, and freedom fighter who played an important role in the Indian freedom struggle.",
      explanation:
          "The Non-cooperation Movement was launched by Mahatma Gandhi in 1920. It was a peaceful protest against British colonial rule and aimed at achieving swaraj or self-rule for India. The launch of the movement coincided with the death of Lokmanya Tilak, who was a prominent Indian nationalist, social reformer, and freedom fighter who played an important role in the Indian freedom struggle."),
  Question(
      question:
          "Who among the following played a dominant role in the famous Vaikom Satyagraha of 1924–25?",
      choices: [
        "A. T. K. Madhavan",
        "B. Muloor S.Padmanabha Panicker",
        "C. Balarama Varma",
        "D. K. Kelappan"
      ],
      answer: "D. K. Kelappan",
      hint:
          "This person was also a leader of the Guruvayur Satyagraha in 1932.",
      explanation:
          "Kelappan was a prominent social reformer and Indian nationalist from Kerala. He played a significant role in the Vaikom Satyagraha, which was a movement for the eradication of untouchability and the right of the lower castes to use public roads around the temple town of Vaikom in Kerala."),
  Question(
      question:
          "Which of the following newspapers was started by Motilal Nehru in 1919?",
      choices: [
        "A. Voice of India",
        "B. The Leader",
        "C. Young India",
        "D. The Independent"
      ],
      answer: "D. The Independent",
      hint: "This newspaper was based in Allahabad.",
      explanation:
          "Motilal Nehru, the father of India's first Prime Minister, Jawaharlal Nehru, founded The Independent, an English-language newspaper based in Allahabad in 1919. It was a prominent nationalist publication and was forced to shut down by British authorities in 1922."),
  Question(
      question:
          "The British established their first factory in India in which Indian city?",
      choices: ["A. Surat", "B. Patna", "C. Delhi", "D. Bombay"],
      answer: "A. Surat",
      hint: "This city is located in the state of Gujarat.",
      explanation:
          "The first English factory in India was established by the British East India Company in Surat, Gujarat, in 1613. Surat was an important port city in the 17th century and was a major center of trade with European powers."),
  Question(
      question: "Who was the founder of the first newspaper in India?",
      choices: [
        "A. Raja Rammohan Roy",
        "B. James Augustus Hickey",
        "C. Mahatma Gandhi",
        "D. Bal Gangadhar Tilak"
      ],
      answer: "B. James Augustus Hickey",
      hint: "This person was an Irishman who settled in India.",
      explanation:
          "James Augustus Hickey, an Irishman who settled in Calcutta in the late 18th century, founded the Bengal Gazette in 1780. It was the first newspaper to be published in India, and Hickey is considered the father of Indian journalism."),
  Question(
      question:
          "With which of the following Organisation was Shaheed Bhagat Singh associated?",
      choices: [
        "The Swaraj Party",
        "Indian National Congress",
        "Hindustan Socialist Republican Association",
        "Both Indian National Congress and Hindustan Socialist Republican Association (HSRA)"
      ],
      answer: "Hindustan Socialist Republican Association (HSRA)",
      hint: "Bhagat Singh was a prominent member of which organisation?",
      explanation:
          "Bhagat Singh was a prominent member of the Hindustan Republican Association (HRA) and was also probably responsible, in large part, for its change of name to the Hindustan Socialist Republican Association (HSRA) in 1928."),
  Question(
      question:
          "Whose death coincided with the launch of the non-cooperation movement in 1920?",
      choices: [
        "GK Gokhale",
        "Motilal Nehru",
        "Dadabhai Naoroji",
        "Lokmanya Tilak"
      ],
      answer: "Lokmanya Tilak",
      hint: "Who passed away on August 1, 1920?",
      explanation:
          "Lokmanya Tilak passed away on August 1, 1920, at the age of 64. His death coincides with the launch of the non-cooperation movement in India on September 4, 1920. It was a political campaign by Mahatma Gandhi to have Indians revoke their cooperation with the British Government."),
  Question(
      question:
          "Which of the three freedom fighters of India were hanged to death in the Kakori Train Conspiracy in 1925?",
      choices: [
        "Roshan Singh, Ram Prasad Bismil and Ashfaqulla Khan",
        "Bhagat Singh, Sukhdev, Rajguru",
        "Sardar Udham Singh, Ram Prasad Bismil, Ashfaqulla Khan",
        "Ram Prasad Bismil, Bhagat Singh, Ashfaqulla Khan"
      ],
      answer: "Ram Prasad Bismil, Ashfaqulla Khan, Roshan Singh",
      hint:
          "Who were the freedom fighters involved in the Kakori Train Conspiracy?",
      explanation:
          "Ram Prasad Bismil, Ashfaqulla Khan, and Roshan Singh were hanged to death on December 19, 1927, by the British Government for their involvement in the Kakori train robbery conspiracy."),
  Question(
      question:
          "Which of the Indian activists was popularly known as ‘Lokhitwadi’?",
      choices: [
        "Gopal Hari Deshmukh",
        "Gopal Krishna Gokhale",
        "Pherozshah Mehta",
        "Bal Gangadhar Tilak"
      ],
      answer: "Gopal Hari Deshmukh",
      hint:
          "Who composed articles on the social change in Maharashtra in the weekly paper Prabhakar using the pen name ‘Lokhitwadi’?",
      explanation:
          "Gopal Hari Deshmukh was an Indian activist, social reformer, thinker, and a writer from Maharashtra. He composed articles on the social change in Maharashtra in the weekly paper Prabhakar using the pen name ‘Lokhitwadi’."),
  Question(
      question:
          "What was the name of the British Officer who was shot by Udham Singh?",
      choices: [
        "Colonel Reginald Edward Harry Dyer",
        "John Saunders",
        "Sir Michael Frances O’Dwyer",
        "None of these"
      ],
      answer: "Sir Michael Frances O’Dwyer",
      hint:
          "The assassination was done during the Jallianwala Bagh Massacre in Amritsar in 1919 for which he was responsible.",
      explanation:
          "Sardar Udham Singh was an Indian revolutionary who assassinated Sir Michael Frances O’Dwyer, the former lieutenant governor of Punjab, India on March 13, 1940. The assassination was done during the Jallianwala Bagh Massacre in Amritsar in 1919 for which O’Dwyer was responsible."),
  Question(
      question:
          "Which of the following newspapers was started in 1919 by Motilal Nehru?",
      choices: [
        "Young India",
        "The Independent",
        "Voice of India",
        "The Leader"
      ],
      answer: "The Independent",
      hint:
          "The newspaper was started to counter the moderate political line adopted by the then leading Allahabad daily ‘The Leader’.",
      explanation:
          "The Independent was an Allahabad-based newspaper that was started by Motilal Nehru in 1919. The paper was later closed down under the British repression two years later. The paper was started with an aim of countering the moderate political line adopted by the then leading Allahabad daily ‘The Leader’."),
  Question(
      question: "Annie Besant was associated with?",
      choices: [
        "Khilafat Movement",
        "Non-Cooperation Movement",
        "Civil Disobedience Movement",
        "Home Rule Movement"
      ],
      answer: "Home Rule Movement",
      hint:
          "The Indian Home Rule Movement was a movement in British India on the lines of the Irish Home Rule movement and other Home Rule Movements.",
      explanation:
          "The Indian Home Rule Movement was a movement in British India on the lines of the Irish Home Rule movement and other Home Rule Movements. It lasted around two years between 1916-1918 and is believed to have set the stage for India’s Independence Movement under the leadership of Annie Besant and Bal Gangadhar Tilak."),
  Question(
      question:
          "Who of the following was called by the British to be the ‘Father of Indian Unrest’?",
      choices: [
        "Lala Lajpat Rai",
        "Gopal Krishna Gokhale",
        "Lokmanya Tilak",
        "Madan Mohan Malviya"
      ],
      answer: "Lokmanya Tilak",
      hint:
          "Tilak mainly contributed through his newspaper ‘Kesari’, which motivated people to take part in the freedom struggle.",
      explanation:
          "Lokmanya Tilak was called the Father of Indian Unrest as he proved how words play a role in challenging the establishments and inspiring the masses. Tilak mainly contributed through his newspaper ‘Kesari’, which motivated people to take part in the freedom struggle.")
];
