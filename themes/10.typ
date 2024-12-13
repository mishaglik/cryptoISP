#import "../conf.typ": *

= О стойкости криптосистем

#definition[
  *Стойкость* криптосистемы определяется относительно конкретного противника.
]

#note("Модель противника")[
  - Вычислительные ресурсы = п.в.м.Т.
  - Атака -- возможность получения исходных данных
  - Угроза -- цель противника
]

#note("Основные типы атак")[
  + *Атака с известными шифртекстами*: #eq[
    $c_1, c_2, ..., c_l$
  ]
  + *Атака с известными открытыми текстами*: #eq[
    $(m_1, c_1), (m_2, c_2), ..., (m_l, c_l); quad c_i = E(1^n; k, m_i)$
  ]
  + *Атака с выбором открытых текстов*: #eq[
    $m_1, ..., m_l |-> (m_1, c_1), ..., (m_l, c_l); quad c_i = E(1^n; k, m_i)$
  ]
  + *Атака с выбором шифртекстов*: #eq[
    $c_1, ..., c_l |-> (m_1, c_1), ..., (m_l, c_l); quad m_i = D(1^n; k, c_i)$
  ]
  + *Атака с выбором текстов* -- комбинация 3 и 4.

  Атаки 3-5 бывают:
  - *Неадаптивными*, когда противник получает весь набор данных разом
  - *Адаптивными*, когда пары к выбранным данным он получает последовательно по $i$, то есть выбор следующего запроса может зависеть от результатов предыдущего.
]

#note("Основные типы угроз")[
  + *Полное раскрытие* -- найти использованный ключ
  + *Извлечение открытого текста* -- по известной информации и случайному значению $E(1^n; k, m)$ найти сообщение $m$
  + *Извлечение частичной информации об открытом тексте*: для некоторой функции $f: BB^* -> BB^*$ по известной информации и случайному значению $E(1^n; k, m)$ найти $f(m)$
  + *Различие двух шифртекстов* -- при подходящей выборке $m^0, m^1$ открытых сообщений, не появлявшихся при атаке, по криптограмме $E(1^n; k, m^b)$ для случайного $b in_cal(U) {0, 1}$ определить $b$, то есть какое из двух сообщений было зашифровано
]
