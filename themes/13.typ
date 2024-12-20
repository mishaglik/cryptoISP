#import "../conf.typ": *

= О генераторах псевдослучайных перестановок

#definition[
  *Псевдослучайным семейством перестановок* называется псевдослучайное семейство функций, все функции которого являются биекциями.

  Также от них требуется неотличимость от раномерно случайной перестановки, а не от произвольной функции.
]

#proposition[
  Существует *преобразование Файстеля* $Phi$, которое превращает произвольную функцию, сохраняющую длину, в перестановку
]

#proof[
  Давайте определим преобразование $forall n in NN$ в явном виде, пусть $f: BB^n -> BB^n$.

  Тогда её преобразованием Файстеля, а также обратное к нему:
  #eq[
    $forall x,y,u,v in BB^n:
      cases(Phi_f (x times y) = y times (x plus.circle f(y)), Phi_f^(-1) (u v) = (v plus.circle f(u)) times u)$
  ]
]

#definition[
  $F$ называется *полиномиально инвертируемым семейством перестановок*, если полиномиально вычислима функция $(1^n; i, y) |-> f_(n, i)^(-1) (y)$.
]

#theorem("Луби-Ракоффа, без доказательства")[
  Если существует псевдослучайное семейство функций, сохраняющих длину, то существует полиномиально инвертируемое псевдослучайное семейство перестановок.
]
