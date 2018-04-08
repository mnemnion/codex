









- /genesis
  - /orb
  - /src
  - /doc
  - /lib
  - /etc  
  - genesis













































































- /numbers
  - /orb
  - /src
    - numbers.ext
  - /doc
  - /lib
  - /etc
  - numbers






ln -s ./numbers/src/ ./genesis/lib/numbers





- /genesis
  - /orb
  - /src
    - /lib ↻
      - /numbers
        - numbers.ext
  - /doc
  - /lib
    - /numbers
      - numbers.ext
  - /etc
  - genesis















- /genesis
  - /orb
  - /src
  - /doc
  - /lib
    - /numbers ↻
      - /lib ↻
      - numbers.ext
  - /etc
  - genesis
