trim(L, N, S) :-
    length(P, N),
    append(P, S, L).

convert_to_sortable([], []).

convert_to_sortable(['(' | As], List) :-
    unifyp(As, Ns),
    length(Ns, Int),
    Int1 is Int + 2,
    trim(['(' | As], Int1, NewAs),
    append([['(' | As]], NewAs, L),
    convert_to_sortable(L, List).

convert_to_sortable([A | As], List) :-
    \+(number(A)),
    atom_number(A,_),
    !,
    unifyns([A | As], Ns),
    length(Ns, Int),
    trim([A | As], Int, NewAs),
    number_chars(Number, Ns),
    append([Number], NewAs, L),
    convert_to_sortable(L, List).

convert_to_sortable([A | As], [A | List]) :-
    convert_to_sortable(As, List).

unifyp([], []).

unifyp([')' | _],[]) :-
    !.

unifyp([A | As], [A | Ns]) :-
    unifyp(As,  Ns).

unifyns([], []).

unifyns([A | As], [A | Ns]) :-
    atom_number(A, _),
    !,
    unifyns(As,  Ns).

unifyns(['.' | As], ['.' | Ns]) :-
    unifyns(As,  Ns).

unifyns(_, []) :-
    !.

expand_all(D, DR) :-
    is_dimension(D),
    D =.. [*, A, B],
    atom(A),
    siu_base_expansion(A, DA),
    compound(B),
    expand_all(B, DB),
    DR =.. [*, DA, DB].

expand_all(D, DR) :-
    is_dimension(D),
    D =.. [*, A, B],
    compound(A),
    expand_all(A, DA),
    atom(B),
    siu_base_expansion(B, DB),
    DR =.. [*, DA, DB].

expand_all(D, DR) :-
    is_dimension(D),
    D =.. [*, A, B],
    atom(A),
    siu_base_expansion(A, DA),
    atom(B),
    siu_base_expansion(B, DB),
    DR =.. [*, DA, DB].

expand_all(D, DR) :-
    is_dimension(D),
    D =.. [*, A, B],
    compound(A),
    expand_all(A, DA),
    compound(B),
    expand_all(B, DB),
    DR =.. [*, DA, DB].

is_base_siu(kg).
is_base_siu(m).
is_base_siu(s).
is_base_siu('A').
is_base_siu('K').
is_base_siu(cd).
is_base_siu(mol).


is_siu('Bq').
is_siu(dc).
is_siu('C').
is_siu('F').
is_siu(g).
is_siu('Gy').
is_siu('Hz').
is_siu('H').
is_siu('J').    
is_siu(kat).
is_siu(lm).
is_siu(lx).
is_siu('N').
is_siu('Omega').
is_siu('Pa').
is_siu(rad).
is_siu('S').
is_siu('Sv').
is_siu(sr).
is_siu('T').
is_siu('V').
is_siu('W').
is_siu('Wb').
is_siu(X) :-
    atom(X),
    !,
    is_base_siu(X),
    !.


siu_name(kg, kilogram).
siu_name(m, metre).
siu_name(s, second).
siu_name('A', 'Ampere').
siu_name('K', 'Kelvin').
siu_name(cd, candela).
siu_name(mol, mole).
siu_name('Bq', 'Becquerel').
siu_name(dc, degreecelsius).
siu_name('C', 'Coulomb').
siu_name('F', 'Farad').
siu_name('Gy', 'Gray').
siu_name('Hz', 'Hertz').
siu_name('H', 'Henry').
siu_name('J', 'Joule').
siu_name(kat, 'Katal').
siu_name(lm, lumen).
siu_name(lx, lux).
siu_name('N', 'Newton').
siu_name('Omega', 'Ohm').
siu_name('Pa', 'Pascal').
siu_name(rad, radian).
siu_name('S', 'Siemens').
siu_name('Sv', 'Sievert').
siu_name(sr, steradian).
siu_name('T', 'Tesla').
siu_name('V', 'Volt').
siu_name('W', 'Watt').
siu_name('Wb', 'Weber').


siu_symbol(N, S) :-
    siu_name(S, N).

siu_base_expansion(S, S) :-
    is_base_siu(S),
    !.

siu_base_expansion('Bq', (s ** -1)).
siu_base_expansion(dc, 'K').
siu_base_expansion('C', s * 'A').
siu_base_expansion('F', (kg  ** -1) * (m  ** -2) * (s ** 4) * ('A' ** 2)).
siu_base_expansion('Gy', (m ** 2) * (s  ** -2)).
siu_base_expansion('Hz', (s  ** -1)).
siu_base_expansion('H', kg * (m ** 2) * (s  ** -2) * ('A'  ** -2)).
siu_base_expansion('J', kg * (m ** 2) * (s  ** -2)).
siu_base_expansion(kat, mol * (s  ** -1)).
siu_base_expansion(lm, cd * (m ** 2) * (m ** -2)).
siu_base_expansion(lx, cd * (m ** 2) * (m ** -4)).
siu_base_expansion('N', kg * m * (s  ** -2)).
siu_base_expansion('Omega', kg * (m ** 2) * (s  ** -3) * ('A'  ** -2)).
siu_base_expansion('Pa', kg * (m  ** -1) * (s  ** -2)).
siu_base_expansion(rad, m * (m ** -1)).
siu_base_expansion('S', (kg  ** -1) * (m  ** -2) * (s ** 3) * ('A' ** 2)).
siu_base_expansion('Sv', (m ** 2) * (s  ** -2)).
siu_base_expansion(sr, (m ** 2) * (m ** -2)).
siu_base_expansion('T', kg * (s  ** -2) * ('A'  ** -1)).
siu_base_expansion('V', kg * (m ** 2) * (s  ** -3) * ('A'  ** -1)).
siu_base_expansion('W', kg * (m ** 2) * (s  ** -3)).
siu_base_expansion('Wb', kg * (m ** 2) * s  ** -2 * ('A'  ** -1)).

prefix_expansion(kg,g*10**3):-!.

prefix_expansion(Final, Exp) :-
    atom_length(Final,L),
    L>1,
    atom_concat(k,Unit,Final),
    is_siu(Unit),
    Exp =.. [*,Unit,10**3],!.

prefix_expansion(Final, Exp) :-
    atom_length(Final,L),
    L>1,
    atom_concat(h,Unit,Final),
    is_siu(Unit),
    Exp =.. [*,Unit,10**2],!.

prefix_expansion(Final, Exp) :-
    atom_length(Final,L),
    L>2,
    atom_concat(da,Unit,Final),
    is_siu(Unit),
    Exp =.. [*,Unit,10**1],!.

prefix_expansion(Final, Exp) :-
    atom_length(Final,L),
    L>1,
    atom_concat(d,Unit,Final),
    is_siu(Unit),
    Exp =.. [*,Unit,10**(-1)],!.

prefix_expansion(Final, Exp) :-
    atom_length(Final,L),
    L>1,
    atom_concat(c,Unit,Final),
    is_siu(Unit),
    Exp =.. [*,Unit,10**(-2)],!.

prefix_expansion(Final, Exp) :-
    atom_length(Final,L),
    L>1,
    atom_concat(m,Unit,Final),
    is_siu(Unit),
    Exp =.. [*,Unit,10**(-3)],!.

expansion(k,10**3).
expansion(h,10**2).
expansion(da,10).
expansion(d,10**(-1)).
expansion(c,10**(-2)).
expansion(m,10**(-3)).


is_dimension([*, A, B]) :-
    is_dimension(A),
    is_dimension(B).

is_dimension([**, A, B]) :-
    is_siu(A),
    number(B).

is_dimension(D) :-
    atom(D),
    !,
    is_siu(D).

is_dimension(D) :-
    compound(D),
    D =.. List,
    is_dimension(List).

is_quantity(q(N, D)) :-
    number(N),
    is_dimension(D).

compare_units(=, U, U):-!.

compare_units(<,'C',dc).
compare_units(>,dc,'C').

compare_units(>, U1, U2) :-
    is_base_siu(U1),
    \+is_base_siu(U2).

compare_units(>, U1, U2) :-
    is_base_siu(U1),
    is_base_siu(U2),
    siu_name(U1, N1),
    siu_name(U2, N2),
    N1 @< N2,
    !.

compare_units(<, U1, U2) :-
    is_base_siu(U1),
    is_base_siu(U2),
    !.

compare_units(<, U1, U2) :-
    \+is_base_siu(U1),
    is_base_siu(U2).

compare_units(<, U1, U2) :-
\+is_base_siu(U1),
\+is_base_siu(U2),
siu_name(U1, N1),
siu_name(U2, N2),
N1 @> N2,
!.

compare_units(>, U1, U2) :-
    \+is_base_siu(U1),
    \+is_base_siu(U2).

norm([], []).

/*norm(Dim, Dim):-
    atom(Dim),
    is_siu(Dim).

norm(['(', A, '*', B | Rest], ['(', A, '*', B | RestOut]);
norm([A, '*', B | Rest], [A, '*', B | RestOut]) :-
    compare_units(>, A, B),
    norm(Rest, RestOut).

norm(['(', A, '*', B | Rest], ['(', (A ** 2) | RestOut]);
norm([A, '*', B | Rest], [(A ** 2) | RestOut]) :-
    compare_units(=, A, B),
    norm(Rest, RestOut).

norm(['(', A, '*', B | Rest], ['(', B, '*', A | RestOut]);
norm([A, '*', B | Rest], [B, '*', A | RestOut]) :-
    compare_units(<, A, B),
    norm(Rest, RestOut).

norm(Dim, NewDim) :-
    is_dimension(Dim),
    with_output_to(chars(C), write(Dim)),
    convert_to_sortable(C, SemiDim),
    norm(SemiDim, NewDim).*/

qsum(q(N1, D1), q(N2, D1), q(NR, DR)) :-
    is_quantity(q(N1, D1)),
    number(N2),
    norm(D1, DR),
    NR is N1 + N2.

qsum(q(N1, D1), q(N2, D2), q(NR, DC)) :-
    is_quantity(q(N1, D1)),
    norm(D2, D2C),
    norm(D1, D1C),
    expand_all(D2C, DC),
    expand_all(D1C, DC),
    number(N2),
    NR is N1 + N2.

qsub(q(N1, D1), q(N2, D1), q(NR, DR)) :-
    is_quantity(q(N1, D1)),
    number(N2),
    norm(D1, DR),
    NR is N1 - N2.

qsub(q(N1, D1), q(N2, D2), q(NR, D1)) :-
    is_quantity(q(N1, D1)),
    is_quantity(q(N2, D2)),
    norm(D2, DC),
    siu_base_expansion(D1, DC),
    NR is N1 - N2.

qsub(q(N1, D2), q(N2, D1), q(NR, D1)) :-
    is_quantity(q(N1, D2)),
    is_quantity(q(N2, D1)),
    norm(D2, DC),
    siu_base_expansion(D1, DC),
    NR is N1 - N2.

/*qtimes(q(N1, D1), q(N2, D1), q(NR, DR)) :-
    is_quantity(q(N1, D1)),
    number(N2),
    qexpt(q(N1, D1), 2, DR),
    NR is N1 * N2.

qtimes(q(N1, D1), q(N2, D2), q(NR, DR)) :-
    is_quantity(q(N1, D1)),
    is_quantity(q(N1, D1)),
    siu_base_expansion(D1, DC1),
    siu_base_expansion(D2, DC2),*/



qexpt(q(Number,U), N, q(NR, UR)):-
    is_quantity(q(Number,U)),
    integer(N),
    NR is Number ** N,
    uexpt(U, N, URN),
    norm(URN, UR).

uexpt(SI ** E, N, SI ** N1):-
    is_siu(SI),
    number(N),
    number(E),
    N1 is N*E.

uexpt(SI, N, SI ** N):-
    is_siu(SI),
    number(N).

uexpt(U, N, UR):-
    is_dimension(U),
    integer(N),
    U =.. [*, X, Y],
    uexpt(X, N, UR1),
    uexpt(Y, N, UR2),
    UR = [*, UR1, UR2].



unify_units([], []).
unify_units([X],[X]).
unify_units([X, X | Rest],[(X ** 2) | NRest]):-
    !,
    is_siu(X),
    unify_units(Rest, NRest).

unify_units([X ** N, X | Rest],[(X ** N1) | NRest]):-
    !,
    is_siu(X),
    N1 is N + 1,
    unify_units(Rest, NRest).

unify_units([X, X ** N | Rest],[(X ** N1) | NRest]):-
    !,
    is_siu(X),
    N1 is N + 1,
    unify_units(Rest, NRest).

unify_units([X ** N1, X ** N2 | Rest],NRest):-
    is_siu(X),
    0 is N1 + N2,
    !,
    unify_units(Rest, NRest).

unify_units([X ** N1, X ** N2 | Rest],[(X ** NR) | NRest]):-
    !,
    is_siu(X),
    NR is N1 + N2,
    unify_units(Rest, NRest).

unify_units([X, Y | Rest], [X, Y | NRest]) :-
    unify_units(Rest, NRest).



% Merge Sort Base
merge_sort([], []). 
merge_sort([A], [A]).

merge_sort([A, B | Rest], S) :-
  divide([A, B | Rest], L1, L2),
  merge_sort(L1, S1),
  merge_sort(L2, S2),
  my_merge(S1, S2, S).

divide([], [], []).
divide([A], [A], []).

divide([A, B | R], [A | Ra], [B | Rb]) :-  
  divide(R, Ra, Rb).

my_merge(A, [], A).
my_merge([], B, B).

my_merge([A | Ra], [B | Rb], [A | M]) :-
  compare_units(>, A, B),
  my_merge(Ra, [B | Rb], M).

my_merge([A | Ra], [B | Rb], [B | M]) :-
  compare_units(<, A, B),
  my_merge([A | Ra], Rb, M).

my_merge([A | Ra], [A | Rb], [A | M]) :-
  my_merge(Ra, [A | Rb], M).


% Predicato per ordinare una moltiplicazione mantenendo le parentesi
sort_multiplication(Expr, SortedExpr) :-
    expression_to_list(Expr, FactorList),
    merge_sort(FactorList, SortedFactorList),
    unify_units(SortedFactorList, UnifiedList),
    list_to_expression(UnifiedList, SortedExpr).

% Predicato per convertire un'espressione in una lista di fattori
expression_to_list(Expr, [Expr]) :-
    atomic(Expr),!.
expression_to_list(Expr, FactorList) :-
    compound(Expr),
    Expr =.. [*, X, Y],
    expression_to_list(X, XList),
    expression_to_list(Y, YList),
    append(XList, YList, FactorList).

% Predicato per convertire una lista di fattori in un'espressione
list_to_expression([Factor], Factor):-!.
list_to_expression([Factor1, Factor2 | Rest], (Expr)) :-
    list_to_expression([Factor1 * Factor2 | Rest], SubExpr),
    Expr = SubExpr.
