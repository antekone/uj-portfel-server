# Wirtualny Portfel - server 

Obsługa portfela - część serwerowa.

## Użytkownicy  
* ### rejestracja nowego użytkownika  
  Po rejestracji tworzony jest profil użytkownika oraz konto podstawowe z domyślną walutą PLN.
  Zwracany jest również TOKEN, który posłuży do autentykacji każdego żądania w systemie. Ważność TOKENa to 2h.  
  Dostępne atrybuty:
    * email
    * phone
    * password
    * password_confirmation
  
  `curl -v -X POST -d "user[email]=foo@bar.com&user[phone]=123456&user[password]=abc123&user[password_confirmation]=abc123" http://localhost:3000/users.json`
  
  __Poprawny rezultat__
    * Status HTTP: 201
    * Zawartość:  
      `{"created_at":"2012-06-18T10:25:36Z",
        "email":"foo@bar.com",
        "id":1,
        "phone":"123456",
        "updated_at":"2012-06-18T10:25:36Z",
        "token":TOKEN}`
  
  __Błędy walidacji__
    * Status HTTP: 422
    * Zawartość:  
      `{"errors":{"email":["has already been taken"]}}` - wykorzystany e-mail  
      `{"errors":{"phone":["has already been taken"]}}` - wykorzystany telefon  
      `{"errors":{"password":["doesn't match confirmation"]}}` - niepoprawne powtórzenie hasła  
      `{"errors":{"password_digest":["can't be blank"]}}` - brak hasła  

* ### aktualizacja użytkownika  
  Można aktualizować tylko konto na którym jest się zalogowanym.  
  `curl -v -X PUT -d "user[email]=foo.baz@bar.com" http://localhost:3000/users/ID.json?token=TOKEN`
  
  __Poprawny rezultat__
    * Status HTTP: 204
    
  __Błędy walidacji__ - identyczne jak przy tworzeniu użytkownika.
    
* ### usuwanie użytkownika
  Można usunąć tylko konto na którym jest się zalogowanym. Usuwane są wszystkie informacje o użytkowniku, jego profil, transakcje. 
  `curl -v -X DELETE http://localhost:3000/users/ID.json?token=TOKEN`
  
  __Poprawny rezultat__
    * Status HTTP: 204

## Sesje
* ### logowanie  
  Aby zalogować się do systemu trzeba podać swój e-mail i hasło.
  Zwracany jest TOKEN, który posłuży do autentykacji każdego żądania w systemie. Ważność TOKENa to 2h.  
  Wysyłane atrybuty:
    * email
    * password
  
  `curl -v -X POST -d "email=foo@bar.com&password=abc123" http://localhost:3000/login.json`
  
  __Poprawny rezultat__
    * Status HTTP: 200
    * Zawartość:  
      `{"result":"1", "token":TOKEN}`
  
  __Błędy walidacji__
    * Status HTTP: 401
    * Zawartość:  
      `{"result":"0"}`

* ### wylogowanie  
  Można wylogować tylko konto na którym jest się zalogowanym. Po wylogowaniu usuwana jest aktywna sesja.  
  `curl -v -X GET http://localhost:3000/logout.json?token=TOKEN`
  
  __Poprawny rezultat__
    * Status HTTP: 200
    * Zawartość:  
      `{"result":"1"}`
      
* ### status
  Jeśli upłynął termin ważności tokena lub gdy użytkownik poda niepoprawny token każde żądanie zostanie odrzucone.
  
  __Rezultat__
    * Status HTTP: 401
    * Zawartość:  
      `{"result":"0"}`

## Konta
* ### lista wszystkich kont  
  Pobieranie listy kont zalogowanego użytkownika
  `curl -v -X GET http://localhost:3000/accounts.json?token=TOKEN`
  
  __Poprawny rezultat__
    * Status HTTP: 200
    * Zawartość (tablica):  
      `[{"balance_in_cents":0,  "created_at":"2012-06-18T11:14:07Z",  "currency":"PLN",  "id":5,  "public":true,  "updated_at":"2012-06-18T11:14:07Z",  "user_id":3,  "balance":0.0}]`

* ### podgląd jednego konta  
  Pobieranie parametrów 1 konta zalogowanego użytkownika
  `curl -v -X GET http://localhost:3000/accounts/ID.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 200
    * Zawartość:  
      `{"balance_in_cents":0,  "created_at":"2012-06-18T11:14:07Z",  "currency":"PLN",  "id":5,  "public":true,  "updated_at":"2012-06-18T11:14:07Z",  "user_id":3,  "balance":0.0}`  
  
  __Błędny status__ - brak konta o danym ID dla zalogowanego użytkownika
    * Status HTTP: 404

* ### dodawanie nowego  
  Utworzenie nowego konta spowoduje przypisanie go do zalogowanego użytkownika.  
  `curl -v -X POST -d "account[currency]=PLN&account[public]=true&account[balance]=0.0" http://localhost:3000/accounts.json?token=TOKEN`
  Dostępne atrybuty:
    * public - flaga true/false
    * balance - bilans konta, dla nowych kont może mieć wartość początkową inną niż 0.0, dla edycji brak możliwości zmiany
    * currency - dostępne waluty: "PLN", "USD", "EUR"
  
  __Poprawny rezultat__
    * Status HTTP: 201
    * Zawartość:  
      `{"created_at":"2012-06-18T10:25:36Z",
        "public":"true",
        "id":2,
        "balance":"0.0",
        "balance_in_cents":"0",
        "updated_at":"2012-06-18T10:25:36Z",
        "currency":"PLN"}`
  
  __Błędy walidacji__
    * Status HTTP: 422
    * Zawartość:  
      `{"errors":{"user_id":["can't be blank"]}}` - brak użytkownika  
      `{"errors":{"currency":["can't be blank"]}}` - brak wybranej waluty
      
* ### edycja  
  `curl -v -X PUT -d "account[currency]=PLN" http://localhost:3000/accounts/ID.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 204

  __Błędy walidacji__ - identyczne jak przy tworzeniu.
      
* ### usuwanie
  `curl -v -X DELETE http://localhost:3000/accounts/ID.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 204
  
## Transakcje
* ### lista wszystkich transakcji  
  Pobieranie listy dla zalogowanego użytkownika
  `curl -v -X GET http://localhost:3000/transactions.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 200
    * Zawartość (tablica):  
      `[{"account_id":5,  "attachment_content_type":null,  "attachment_file_name":null,  "attachment_file_size":null,  "attachment_updated_at":null,  "created_at":"2012-06-18T12:36:19Z",  "date":"2012-06-18", "description":"",  "id":5,  "updated_at":"2012-06-18T12:36:19Z",  "user_id":3,  "value_in_cents":55500,  "value":555.0}]`

* ### podgląd jednej transakcji  
  Pobieranie parametrów transakcji o wskazanym ID zalogowanego użytkownika
  `curl -v -X GET http://localhost:3000/transactions/ID.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 200
    * Zawartość:  
      `{"account_id":5,  "attachment_content_type":null,  "attachment_file_name":null,  "attachment_file_size":null,  "attachment_updated_at":null,  "created_at":"2012-06-18T12:36:19Z",  "date":"2012-06-18", "description":"",  "id":5,  "updated_at":"2012-06-18T12:36:19Z",  "user_id":3,  "value_in_cents":55500,  "value":555.0}`
      
  __Błędny status__ - brak transakcji o danym ID dla zalogowanego użytkownika
    * Status HTTP: 404

* ### dodawanie nowego  
  Utworzenie nowej transakcji spowoduje przypisanie go do zalogowanego użytkownika oraz uaktualni bilans konta.  
  Dostępne atrybuty:
    * account_id - ID konta do którego ma być przypisana transakcja, obsługuje własnościowe oraz dzielone konta użytkownika
    * date - data transakcji, format np. 01-01-2012 lub 2012-02-02
    * description - opis tekstowy (opcjonalny)
    * value - wartość, podana z przecinkiem dla groszy
    * tag_names - słowa kluczowe, wstawianie wielu po przecinku
    * attachment - załącznik, plik bez walidacji formatu, do obrazków/dźwięków i itd
    
  `curl -v -X POST -d "transaction[account_id]=ID&transaction[date]=2011-11-11&transaction[description]=Foo bar baz&transaction[value]=19.99&transaction[tag_names]=foo,bar,baz" http://localhost:3000/transactions.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 201
    * Zawartość:
        {"account_id":5,  "attachment_content_type":null,  "attachment_file_name":null,  "attachment_file_size":null,  "attachment_updated_at":null,  "created_at":"2012-06-18T12:36:19Z",  "date":"2012-06-18", "description":"",  "id":5,  "updated_at":"2012-06-18T12:36:19Z",  "user_id":3,  "value_in_cents":55500,  "value":555.0}

  __Błędy walidacji__
    * Status HTTP: 422
    * Zawartość:  
      `{"errors":{"user_id":["can't be blank"]}}` - brak użytkownika  
      `{"errors":{"account_id":["can't be blank"]}}` - brak wybranego konta

* ### edycja  
  `curl -v -X PUT -d "transaction[value]=299.99" http://localhost:3000/transactions/ID.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 204

  __Błędy walidacji__ - identyczne jak przy tworzeniu.

* ### usuwanie
  `curl -v -X DELETE http://localhost:3000/transactions/ID.json?token=TOKEN`

  __Poprawny rezultat__
    * Status HTTP: 204