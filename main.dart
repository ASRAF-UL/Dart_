var name = 'Voyager I';
  int year = 1997;
  var antennaDiameter = 3.7;
  var flyByObject = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags' : ['Saturn'],
    'url' : 'https://specials-images.forbesimg.com/imageserve/5f083e8dd6aee1000672717a/960x0.jpg?cropX1=357&cropX2=1800&cropY1=376&cropY2=1053'
  };
  
  if(year >= 2001){
    print('21st century');
}else if(year >= 1901){
  print('20th century');
  }
  for(var object in flyByObject) {
    print(object);
  }
  for(int month = 1; month <= 12; month++) {
    print(month);
  }
  while (year < 2016) {
    year += 1;
 }
 int fibonacci(int n) {
    if(n == 0 || n == 1) {
      return n;
    }
    return fibonacci(n -1) + fibonacci(n -2);
  }
  var result = fibonacci(20);
  print(result);
  
  
  var name = 'Voyager I';
  var flyByObject = ['Jupiter', 'Saturn', 'Uranus', 'Neptune', 'Uturn', 'Hashturn'];
  flyByObject.where((name) => name.contains('turn')
                   ).forEach(print);
