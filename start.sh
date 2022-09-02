docker build . -t locald && docker run -v `pwd`:/code -w /code -ti locald bash
