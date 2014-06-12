Mingle API HMAC Ruby Example
============================

simple command line ruby app that lets you do a GET or POST using HMAC authentication instead of basic auth

This is much safer than using basic auth

use it as an example to make your own app!


Instructions with rbenv
-----------------------

`> bundle`

Edit the client.rb with your favorite text editor.

Replace `ACCESS_KEY_ID` with the value from credentials.csv downloaded from Mingle.

Replace `SECRET_ACCESS_KEY` with the value from credentials.csv

Replace `API_ENDPOINT` with the value from

Replace `PROJECT_IDENTIFIER` with the project identifier from the URL.

Or, alternatively, set ENV variables with the same names as above.

`> ruby client.rb get` will request murmurs and print out their authors and content

`> ruby client.rb post hello` will post a new murmur 'hello'

Please send feedback about this example to mingle.feedback@thoughtworks.com

Thanks!

The Mingle Team

[getmingle.io](http://getmingle.io)

[@thatsmingle](https://twitter.com/thatsmingle)