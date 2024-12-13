#import "../conf.typ": *

= Введение
== Предмет математической криптографии
#definition[
  *Криптографические средства защиты информации (КСЗИ)* -- основанные на математических методах преобразования защищаемой информации.
]

#definition[
  *Теоретическая криптография (математическая криптография, криптология)* -- раздел дискретной математики, изучающий математические модели КСЗИ с научной точки зрения.

  Основной предмет теоритической криптографии -- криптографический протокол. (о нём в следующей главе).
]

== Криптографический протоколы
#example[
  *Прикладные КП*:
  - Системы шифрования
  - Подбрасование монеты по телефону
  - Схемы электронной подписи
  - Протоколы аутентификации
  - Системы электронных платежей
]

#example[
  *Примитивные КП*:
  - bit-commitment (схема обязательства)
  - oblivious transfer (протокол с забыванием)
]

== Криптографические примитивы
#example[
  *Криптографические примитивы*:
  - *Односторонняя функция* -- эффективно вычислимая функция, задача инвертирования которой вычислительно трудна.
  - *Псевдослучайный генератор* -- эффективный алгоритм, генерирующий длинные последовательности, которые никакой эффективный алгоритм не отличит от чисто случайных.
  - *Криптографическая хэш-функция* -- эффективно вычислимое семейство функций, уменьшающих длину аргумента, для которого задача поиска коллизий вычислительно трудна. 
]

== Модель противника
#definition[
  *Атака* -- совокупность предположений о возможностях противника, о том, какие действия ему доступны (помимо вычислений).
]

#definition[
  *Угроза* -- цель противника, состоящая в нарушении одного или нескольких из трёх условий (задач) криптографического протокола. 
]
