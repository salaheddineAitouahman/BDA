import itertools

def afficherDependances(F):
    for alpha, beta in F:
        print("\t", alpha, "-->", beta)

def afficherRelations(T):
    for R in T:
        print("\t", R)

def ensemblePuissance(entree):
    resultat = []
    for r in range(1, len(entree) + 1):
        resultat += list(map(set, itertools.combinations(entree, r)))
    return resultat

def fermetureAttributs(F, K):
    fermeture = set(K)
    change = True
    while change:
        change = False
        for alpha, beta in F:
            if alpha.issubset(fermeture) and not beta.issubset(fermeture):
                fermeture |= beta
                change = True
    return fermeture

def fermetureDependances(F, R):
    resultat = []
    parties = ensemblePuissance(R)
    for X in parties:
        Xplus = fermetureAttributs(F, X)
        for A in Xplus:
            if A not in X:
                resultat.append([X, {A}])
    return resultat

def determine(F, alpha, beta):
    return beta.issubset(fermetureAttributs(F, alpha))

def estSuperCle(F, R, K):
    return fermetureAttributs(F, K) == R

def estCleCandidate(F, R, K):
    if not estSuperCle(F, R, K):
        return False
    for sous in ensemblePuissance(K):
        if sous != K and estSuperCle(F, R, sous):
            return False
    return True

def clesCandidates(F, R):
    resultat = []
    for sous in ensemblePuissance(R):
        if estCleCandidate(F, R, sous):
            resultat.append(sous)
    return resultat

def superCles(F, R):
    resultat = []
    for sous in ensemblePuissance(R):
        if estSuperCle(F, R, sous):
            resultat.append(sous)
    return resultat

def uneCleCandidate(F, R):
    for sous in ensemblePuissance(R):
        if estCleCandidate(F, R, sous):
            return sous
    return None

def estBCNF(F, R):
    for alpha, beta in F:
        if not estSuperCle(F, R, alpha):
            return False
    return True

def schemaBCNF(T, F):
    for R in T:
        if not estBCNF(F, R):
            return False
    return True

def decompositionBCNF(F, T):
    resultat = list(T)
    change = True
    while change:
        change = False
        nouveau = []
        for R in resultat:
            trouve = False
            for alpha, beta in F:
                if alpha.issubset(R) and not estSuperCle(F, R, alpha):
                    R1 = alpha | beta
                    R2 = R - (beta - alpha)
                    nouveau.append(R1)
                    nouveau.append(R2)
                    change = True
                    trouve = True
                    break
            if not trouve:
                nouveau.append(R)
        resultat = nouveau
    return resultat
