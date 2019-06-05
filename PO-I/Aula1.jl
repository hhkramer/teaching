using JuMP

modelo = Model()

# Criacao das variaveis
@variable(modelo, x_al >= 0)
@variable(modelo, x_mad >= 0)

# Criacao da FO
@objective(modelo, Max, 3000 * x_al + 5000 * x_mad)

# Criacao das restricoes
@constraint(modelo, F1, x_al <= 4)
@constraint(modelo, F2, 2 * x_mad <= 12)
@constraint(modelo, F3, 3 * x_al + 2 * x_mad <= 18)

print(modelo)
