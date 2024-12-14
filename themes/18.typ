#import "../conf.typ": *

#let view = $op("view")$

= О нулевых разглашениях
#note[
  Предположим, что Алиса знает доказательство некоторой теоремы и желает убедить Боба, что теорема верна, так, чтобы не сообщить ему никакой информации, на основании которой он научился бы доказывать эту теорему самостоятельно.

  Этим двум противоречивым требованиям удовлетворяют *протоколы с нулевым разглашением*.
]

#definition[
  *Интерактивной парой машин Тьюринга* называется пара $algo (A, B)$, соединённые между собой коммуникационной лентой:

  #image("../assets/intpair.png")
]

#note("Особенности интерактивной пары машин Тьюринга")[
  - Вход может быть общим у обеих машин, но они могут иметь и свои частные входы.
  - *Раунд* -- период активности однйо машины с записью слова на коммуникационную ленту.
  - Если раунд только один, то соответствующий протокол называется *неинтерактивным*.
  - Выход пары $(A, B)$ -- это $(y_A, y_B)$ или только $y_B$, если машина $B$ останавливается первой.
  - Интерактивная машина *полиномиальна*, если время её работы при совместном вычислении с любой другой машиной Тьюринга на общем входе $x$ ограничено величиной $poly(abs(x))$. В этом случае число раундов также полиномиально, но размер входящих сообщений -- вообще говоря, необязательно.
]

#note[
  Введём обозначения
  - $P$ -- *доказывающий*
  - $V$ -- *проверяющий*, выдающий 1 или 0 (доказательство принимается или нет)
  - $L subset.eq BB^*$ -- язык, соответствующий некоторой распознавательной задаче.
]

#definition[
  *Интерактивной доказательство* для языка $L$ -- это интерактивная пара машин Тьюринга $(P, V)$ с полиномиальной $V$, для которых выполнены условия:
  - Полнота
  #eq[
    $forall x in L : mu({(P, V)(x) = 1}) >= 2 / 3$
  ]
  - Корректность
  #eq[
    $forall "интерактивной в.м.Т." P' : forall x in.not L : mu({(P', V)(x) = 1}) <= 1 / 3$
  ]
]

#definition[
  Рассмотрим выполнение интерактивной пары машин Тьюринга $(P, V)$ и обозначим через $view_V^P (x)$ *транскрипцию этого выполнения*, состоящую из использованного префикса случайной строки машины $V$, последовательности пересылаемых сообщений в хронологическом порядке и выхода пары.
]

#definition[
  Интерактивной доказательство $(P, V)$ для бесконечного языка $L$ называется *доказательством с абсолютно нулевым разглашением*, если для любой интерактивной $algo V'$ существует $algo S$, такая, что семейства ${view_(V')^P (x)}_(x in L)$ и ${S(x)}_(x in L)$ распределены одинаково, а точкее, для любого $x in L$:
  - $mu({S(x) != bot}) >= 1 / poly(abs(x))$
  - При условии $S(x) != bot$: $mu({S(x) = z}) = mu({view_(V')^P (x) = z})$
  Это определение значит, что наличие честного "доказывателя" никак не поможет нечестному "проверяющему" доказывать.
]

#definition[
  Пусть $xi, zeta$ -- случайные величины со значениями в конечном или счётном множестве $X$.

  *Статистическим расстоянием* между $xi$ и $zeta$ называют
  #eq[
    $Delta(xi, zeta) = max_(Z subset.eq X) abs(mu({xi in Z}) - mu({zeta in Z}))$
  ]
]

#definition[
  Семейства ${xi_x}_(x in L), {zeta_x}_(x in L)$ называются *статистически неразличимыми*, если $Delta(xi_x, zeta_x) = negl(abs(x))$
]

#definition[
  Интерактивное доказательство $(P, V)$ для бесконечного языка $L$ называется *доказательством со статистически нулевым разглашением*, если для любой интерактивной $algo V'$ существует $algo S$ такая, что семейства ${view_(V')^P (x)}_(x in L)$ и ${S(x)}_(x in L)$ статистически неразличимы
]

#definition[
  Семейства ${xi_x}_(x in L), {zeta_x}_(x in L)$ называются *вычислительно неразличимыми*, если для любой $algo D$:
  #eq[
    $abs(mu({D(x, xi_x) = 1}) - mu({D(x, zeta_x) = 1})) = negl(abs(x))$
  ]
]

#definition[
  Интерактивное доказательство $(P, V)$ для бесконечного языка $L$ называется *доказательством с вычислительно нулевым разглашением*, если для любой интерактивной $algo V'$ существует $algo S$ такая, что семейства ${view_(V')^P (x)}_(x in L)$ и ${S(x)}_(x in L)$ вычислительно неразличимы
]

#example("Протокол доказательства с абсолютно нулевым разглашением для языка пар изоморфных графов")[
  Общий вход: $(G_0, G_1)$, где $G_0 = (U, E_0), G_1 = (U, E_1)$.

  Пусть $abs(U) = n$, причём $abs(E_0) = abs(E_1)$.

  - Prover выбирает случайную n-перестановку $pi in_cal(U) S_n$ и случайный бит $c in_cal(U) BB$
  - Prover создаёт новый граф $H = pi(G_c)$, изоморфный изначальным, посылает его Verifier
  - Verifier выбирает случайный бит $b in_cal(U) BB$, посылает его Prover
  - Prover создаёт новую перестановку $psi = cases(pi\, b = c, phi compose phi\, b != c)$, где $phi$ -- известная только ему перестановка, такая, что $G_c = phi(G_(not c))$. Посылает полученную перестановку $psi$ Verifier.
  - Verifier проверяет $phi(G_b) overset(=, ?) H$
  Описанный выше алгоритм запускается в цикле $abs(E_1)$ раз и результатом проверки на изоморфизм будет 1 $<=>$ во всех итерациях проверка Verifier была пройдена успешна.
]