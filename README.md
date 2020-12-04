
# Лабораторная 2

Использовался первый алгоритм. Тема - Выжиываемость на Титанике. В качестве данных брался датасет https://www.kaggle.com/c/titanic/overview. Для тренировочной выборки использовались первые 375 строк таблицы train, параметрической - с 376 по 750, для теста - оставшиеся. Использовались признаки: стоимость билета, его класс, пол пассажира, количество супругов, детей, родителей, братьев и сестёр на борту. Предсказывалось выжил ли человек на Титанике, или нет. В качестве меры близости d использовалось евклидово расстояние. Объекту присваивался класс, если сумма расстояний до k ближайших к нему объектов данного класса была минимальной из всех классов.  Процесс увеличения k происходил до достижения точности в 0.75 на тренирововчной выборке. Приложение доступно по [ссылке](https://kopotchel-iis-2.herokuapp.com/). Лог обучения приведён ниже.\
![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3c3yfcIlY-JtfP6Mm8PzO5HhPPn1TbeegAlmGxQPhu-t8QqlUkW1Np5XTP6tDFun2Gxmy_k4IS4XIGlOA1BwmbP3y4epcI5T0-6rJjwIJqxaMUBxFnMsGPmcTzb69diu1B7mwLedN4NZhFzXNytruaL=w794-h225-no?authuser=0)
