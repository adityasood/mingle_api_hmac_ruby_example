Mingle API HMAC Ruby Example
============================

simple command line ruby app that lets you do a GET or POST using HMAC authentication instead of basic auth

This is much safer than using basic auth

use it as an example to make your own app!


Instructions with rbenv
-----------------------

`> bundle`


`export MINGLE_LOGIN=admin`

`export SECRET_ACCESS_KEY=your-hmac-key-from-credentials.csv`

`export API_ENDPOINT=https://your-site-name.mingle-api.thoughtworks.com`

`export PROJECT_IDENTIFIER=my_proj`

`> ruby client.rb get` will request murmurs and print out their authors and content

`> ruby client.rb post hello` will post a new murmur 'hello'

Please send feedback about this example to mingle.feedback@thoughtworks.com

Thanks!

The Mingle Team

[getmingle.io](http://getmingle.io)

[@thatsmingle](https://twitter.com/thatsmingle)
