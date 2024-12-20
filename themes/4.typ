#import "../conf.typ": *

= Об односторонних функциях
#definition[
  Функция $nu: NN -> RR^+$ называется *пренебрежимо малой*, если
  #eq[
    $forall "полинома" p : exists n_0 in NN : forall n >= n_0 : nu(n) <= 1 / (p(n))$
  ]

  Обозначение: $negl(n)$.
]

#definition[
  Функция $f: X -> Y; X, Y subset.eq BB^*$ называется *полиномиально вычислимой*, если существует полиномиальная (детерминированная) машина Тьюринга М такая, что
  #eq[
    $forall x in X: M(x) = f(x)$
  ]
]

#note("Используемые обозначения")[
  - $cal(U)$ -- равномерное распределение вероятностей
  - $x in_cal(U) Z$ значит, что $x$ выбран случайно из множества $Z$ в соответствии с равномерным распределением вероятностей на этом множестве
  - $y <- M(x)$ значит, что $y$ -- случайный выход в.м.Т. М, на вход которой был подан $x$.
  - Под возведением в степень нуля или единицы имеется в виду декартово умножение
  - В качестве $abs(dot): BB^* -> NN$ понимается длина битовой последовательности.
]

#definition[
  Функция $f: BB^* -> BB^*$ называется *(сильно) односторонней*, если
  + $f$ полиномиально вычислима
  +
  #eq[
    $forall "п.в.м.Т." A : mu_(x in_cal(U) BB^n)({A(1^n; f(x)) in f^(-1)(f(x))}) = negl(n)$
  ]
]

#definition[
  Функция $f: BB^* -> BB^*$ называется *слабо односторонней*, если
  + $f$ полиномиально вычислима
  +
  #eq[
    $exists "полином" p: forall "п.в.м.Т." A : exists n_0 in NN : forall n >= n_0: \ mu_(x in_cal(U) BB^n)(
        {A(1^n; f(x)) in f^(-1)(f(x))}
      ) <= 1 - 1 / p(n)$
  ]
]

#note[

  В презентациях односторонняя функция определялась на следующем множестве:
  берем некоторое разрешимое $N subset.eq NN, |N| = infinity$. И определяем $f$ на $union_(n in N) BB^n$.

  Тогда 
  #eq[$
    f'(x) = cases(
      f(x)\, |x| in N,
      f(x')x''\, |x| in.not N\, x=x'x''\, |x'| = max{n in N : |n| < |x| }
    )
  $]
  Это продление $f$ на $BB^*$, причем сохраняющее сильную/слабую односторонность.
  
  Такое определение удобно для некоторых доказательств.
]

#note[Напоминание 

$N$ разрешимо, если $exists detAlgo$, которая отвечает, принадлежит ли число этому множеству. 
]

#lemma[
  Любую полиномиально вычислимую, а значит и (сильно/слабо) одностороннюю функцию можно преобразовать так, чтобы она сохраняла длину аргумента.
]

#proof[
  - Выберем какой-нибудь полином $m$, существующий в силу полиномиальной вычислимости функции $f$:
  #eq[
    $forall x : abs(f(x)) <= m(abs(x))$
  ]
  это верно, так как машина Тьюринга совершит не более некоторого полиномиального числа тактов, а за такт она может прибавить максимум 1 к длине вывода.
  - Определим функцию $h$ на множестве $union_(n in NN) BB^(m(n) + 1)$, для чего представим каждый $x$ из этого множества в виде $x = x'x''$, где $x' in BB^n, x'' in BB^(m(n) + 1 - n)$, и положим
  #eq[
    $h(x) = f(x') times 1 times 0^(m(abs(x')) - abs(f(x')))$
  ]
  Заметим, что вывод теперь имеет такую же длину, как и вход. 

  - Получившаяся $h$ тоже (слабо) односторонняя. Заметим, что ввиду определения, каждому $h(x)$ однозначно соответствует $f(x')$ (Находим младшую единицу в числе и убираем её и все что правее. Для этого собственно и дописывали её). А значит, если можно легко обратить $h(x)$, то можно легко обратить и $f(x')$, что противоречит односторонности $f$.     
]

#theorem("Яо")[
  Если существует слабо односторонняя функция, то существует и сильно односторонняя функция.
]

#proof[
  Пусть $f$ -- слабо односторонняя функция, БОО предположим, что мы уже преобразовали её к виду, сохраняющему длину входа, то есть
  #eq[
    $forall n in NN : f(BB^n) subset.eq BB^n$
  ]
  Зафиксируем некоторый полином $p$ из определения слабой односторонности.

  Для любой п.в.м.Т. $A$ и для всех достаточно больших $n$:
  #eq[
    $mu_(x in_cal(U) BB^n)({A(1^n; f(x)) in f^(-1)(f(x))}) <= 1 - 1 / p(n)$
  ]

  Введём функцию
  #eq[
    $g(x_1, ..., x_t) := (f(x_1), ..., f(x_t)); quad x_i in BB^n, t(n) := n dot p(n)$
  ]

  Предположим, что $g$ -- не односторонняя, тогда для некоторого полинома $q$ существует п.в.м.Т. $B$ и бесконечное множество $N subset.eq NN$, что
  #eq[
    $forall n in N : mu_(x in_cal(U) BB^(n t(n)))({B(1^(n t(n)); g(x)) in g^(-1)(g(x))}) > 1 / q(n t(n))$
  ]

  Определим вероятностную машину $C_0$ на входе $y in BB^n$:
  + for i in [1..t]
  + let z = $B(f(x_1), ..., f(x_(i - 1)), y, f(x_(i + 1)), ..., f(x_t)), x_j <- cal(U)$
  + if $f(z_i) = y$: return $z_i$

  Также определим вероятностный алгоритм $C$ на входе $y$, выполняющий алгоритм $C_0$ на этом входе $k(n) := 2 dot n dot t(n) dot q(n dot t(n))$ раз.

  Если на некоторой итерации алгоритм $C_0$ что-то вернул, то это будет результатом $C$, иначе $C$ заканчивает работу без выходного значения.

  Для произвольного $n in NN$ положим
  #eq[
    $E_n = {x in BB^n | mu({C_0(1^n; f(x)) in f^(-1)(f(x))}) > n / k(n)}$
  ]
  Где берём те $x$, при которых вероятность (теперь $x$ фиксирован, случайность осталась лишь в случайном векторе $1^n$) обращения $f$ отделима от нуля.

  #lemma[
    #eq[
      $forall n in NN : forall x in E^n : mu({C(1^n; f(x)) in f^(-1)(f(x))}) > 1 - e^(-n)$
    ]
    Эта лемма показывает, что ограниченная на $E^n$ $f$ обратима на "слишком большом" множестве событий.
  ]
  #proof[
    Зная, что:
    - $C$ -- применение алгоритма $C_0$ $k$ раз, а значит если $C$ не угадал прообраз, то и $k$ раз применённый $C_0$ тоже не угадал. (Оценка вероятности)
    - Мы взяли $x in E_n$, в котором вероятность угадать прообраз алгоритмом $C_0$ $> n / k$, а значит вероятность не угадать $< 1 - n / k$
    - $forall r: ln r <= r - 1$
    получим:
    #eq[
      $mu({C(1^n; f(x)) in.not f^(-1)(f(x))}) < (1 - n / k)^k = e^(k ln (1 - n / k)) <= e^(-n)$
    ]
  ]
  #lemma[
    #eq[
      $exists N_0 in NN : forall n > N_0 : mu(E_n) > 1 - 1 / (2 p(n))$
    ]
    Этой леммой мы хотим показать, что с какого-то момента $E_n$ достаточно большое.
  ]
  #proof[
    Пока скип, большое
  ]
  Из доказанных лемм вытекает, что
  #eq[
    $mu({C(1^n; f(x)) in f^(-1)(f(x))}) &>= \
      mu({C(1^n; f(x)) in f^(-1)(f(x)) | E_n})mu(E_n) &> (1 - e^(-n))(1 - 1 / (2 p(n)))$
  ]
  Но если вспомним, что $f$ слабо односторонняя, то получим неравенство:
  #eq[
    $1 - 1 / p(n) > (1 - e^(-n))(1 - 1 / (2 p(n)))$
  ]
  Раскрыв скобки в правой части получим, что
  #eq[
    $1 / p(n) < e^(-n) + 1 / (2 p(n)) - e^(-n) / (2 p(n)) < e^(-n) + 1 / (2 p(n))$
  ]
  Что неверно при достаточно больших $n$, так как $e^(-n)$ убывает быстрее $1 / (2 p(n))$.
]
