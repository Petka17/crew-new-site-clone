# CrewNew Site Clone

## How to run

Development:

```
elm-live src/Main.elm -p 8888 -H -s index.html -u -- --debug --output=elm.js
```

Testing:

```
elm-live src/Main.elm -p 8888 -s index.html -u -- --output=elm.js
```

## TODO:

1. Skills Page

- Table
- Custom Dropdown
- Custom Dropdown with search

2. Form validation
3. Http requests

- get country list
- get skills
- send data

4. Authentication
5. Responsive UI (get window size through subscriptions)
