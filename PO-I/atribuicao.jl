using JuMP
using Cbc

# Leitura do arquivo da instancia (dados) e armazenamento na matriz dadosInstancia
dadosInstancia = readdlm("instAtribuicao")

# Pega o numero de pessoas/tarefas na posicao [1,1] da matriz dadosInstancia
n = dadosInstancia[1,1]

# Cria uma matriz vazia para os beneficios
beneficio = Array{Int}(n,n)

# Preenche a matriz de beneficios com os dados lidos no arquivo e armazenados em dadosInstancia
for i=1:n
    for j=1:n
        beneficio[i,j] = dadosInstancia[i+1,j]
    end
end

# Imprime na tela os dados da instancia
println("Numero de pessoas e tarefas: ", n)
for i = 1:n
    println("Beneficios da pessoa $i: ", beneficio[i,:]
end
    
# Cria um modelo vazio
atribuicao = Model(solver = CbcSolver())

# Cria as variáveis de decisão
@variable(atribuicao, x[i=1:n,j=1:n], Bin)

# Cria a funcao objetivo
@objective(atribuicao, sum(beneficio[i,j] * x[i,j] for i=1:n, j=1:n))

# Cria a restricao de que cada pessoa deve realizar uma tarefa
@constraint(atribuicao, restricao_pessoa[i=1:n], sum(x[i,j] for j=1:n) == 1)

# Cria a restricao de que cada tarefa deve ser alocada a uma pessoa
@constraint(atribuicao, restricao_tarefa[j=1:n], sum(x[i,j] for i=1:n) == 1)

# Imprime o modelo na tela
print(atribuicao)
    
# Resolve o modelo
status = solve(atribuicao)
    
# Imprime o valor da funcao objetivo da solucao encontrada
println("Valor da solucao: ", getobjectivevalue(atribuicao))
    
    
# Imprime a solucao encontrada
for i = 1:n
    for j = 1:n
        if getvalue(x[i,j]) == 1
            println("A pessoa $i executa a tarefa $j")
        end
    end        
end
    
