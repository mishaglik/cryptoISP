#import "../conf.typ": *

#let Sign(m) = $S(1^n, hat(k), m)$
#let Valid(m, s) = $V(1^n, k, m, s)$
= O электронной подписи.

== Определения

#definition[
  Схемой электронной подписи называется следующую тройку алгоритмов $(G, S, V)$ вместе с процедурой $A$: 
  1. Генератор ключей $G - algo: G(1^n) = (hat(k), k)$ - пара секретный/открытый ключ. $K_n = supp(G(1^n))-$ пространство ключей.
  2. Генератор подписей $S - algo: m in M_n, (hat(k), k) in K_n => Sign(m) = s -$ подпись для сообщения $m$.
  3. Алгоритм проверки $detAlgo V: V(1^n, k, m, s) in BB$ - принимается ли подпись. Причём $Valid(m, Sign(m)) = 1$. То есть правильная подпись всегда принимается.
  4. $A$ - процедура арбитража (разрешения споров). Арбитр - кто-то кому все участники доверяют, и он может получить доступ к секретам. 
]

#definition[
  Схема аутентификации сообщений (*MAC*).
  
  Строится аналогично, только без открытого ключа
  - $hat(k)$ известен обоим участникам
  - Оба могут как подписывать так и проверять подпись. 
  - Нет задачи убедить в чём‐то третью сторону. MAC предназначен для сети из небольшого числа доверяющих друг другу участников

]

#note[
  Считаем, что противнику по умолчанию известна схема, то есть $(G, S, V)$, параметр $n$, а так же открытый ключ. 
]

#note[ Основные типы атак
  + Атака с известным открытым ключом - *KKA*. 
    - Знаем только открытый ключ
  + Атака с известными сообщениями - *KMA*
    - Известен набор сообщений с подписями ${(m_i, s_i)}_(i=0..l)$
  + Атака с выбором сообщений - *CMA*.
    - Противник может подписывать некоторые сообщения. ${m_i} ~> {(m_i, s_i)}$
    - Может быть с априорным знанием $k$ (направленная) или нет (простая).
    - Может быть адаптивной или неадаптивной. (Зависит ли $m_i$, от ответов на предыдущие запросы). 
]

#note[ Основные типы угроз 
  + Полное раскрытие (total breaking).
  + Универсальная подделка (universal forgery)
    - Найти $algo S': forall m in M_n Valid(m, S'(1^n, k, m))=1$. То есть научиться подписывать без приватного ключа $hat(k)$.
  + Селективная подделка Selective forgery
    - Найти подпись для какого то конкретного сообщения $m$. (Здесь и далее всегда неявно подразумевается, что подпись сообщения которое хочет подписать атакующий ему не была известна заранее / сказана оракулом).
  + Экзистенциальная подделка.
    - Найти пару $(m', s'): Valid(m', s')=1$. 
]

#definition[
  Если никакой эффективный алгоритм не может осуществить угрозу
экзистенциальной подделки с существенной вероятностью, то схема электронной
подписи называется EU‐стойкой.
]

#definition[ EU-CMA стойкость

  Оракул-подписант: $cal(O): cal(O)(m) = S(1^n, hat(k), m)$.

  Схема $(G, S, V)$ EU-CMA стойкая если 

  $forall algo A^cal(O): space mu {A^cal(O)(1^n, k)=(m, s), space Valid(m, s) = 1} = negl(n)$
]

#theorem[*Rompel*
  Если существует односторонняя функция, то существует EU-CMA стойкая схема электронной подписи.
]

#note[
  В обратную сторону тоже верно. Предположим противное, тогда можно эффективно обратить генератор ключей, и тем самым по открытому ключу получить секретный. 
  Другими словами $f(r) = k <=> G(r, 1^n) = (k, hat(k))$ должна быть односторонней. 
]

== Примеры схем 


=== RSA

$N = p q, space p, q in PP$\
$ gcd(e, phi(N)) = 1, e d equiv 1 mod phi(N)$
- $G: k = (N, e), space hat(k) = (N, d)$
- $S: s = m^d mod N$ 
- $V: s^e overset(=, ?) m mod N. space m^(d e) equiv m^(1 + l phi(N)) equiv m mod N$

#note[
  RSA НЕ является ни EU-KKA стойкой ни UU-CMA стойкой.    
]
=== Схема Лемпорта (одноразовая)

Пусть $f: BB^n -> BB^n$ односторонняя функция сохраняющая длину.
Сообщение $m in M_n = BB^n. space m = m^[1]m^[2]...m^[n]$
- G. Нагенериваем $2n$ случайных последовательностей: ${x^0_i, x^1_i}_(i=0)^n$. Они будут нашим секретным ключом. Ко всем ним применяем $f$. Получаем ${y^0_i, y^1_i}_(i=0)^n$ это публичный ключ. 
- S. В зависимости от значения i-го бита в числе выбираем либо $x^0_i$ либо $x^1_i$. Формально $s=s^[1]s^[2]...s^[n] = x_0^m^[0]x_1^m^[1]...x_n^m^[n]$
- V. Применяем $f$ к подписи и сверяемся что все сходится: $y_i^m^[i] = f(s_i)$. 

#note[ 
Эта схема EU‐CMA1‐стойкая — при условии, что противнику доступно только
одно обращение к оракулу (l = 1).
]

#note[
  Чтобы снять ограничение на длину сообщения, достаточно подписывать хеш от сообщения. Далее это будет считаться стратегией по умолчанию.  
]
//TODO - Улучшения этой схемы.