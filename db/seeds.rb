# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Sections
sections_file = Rails.root.join("db", "seeds", "sections.yml")

sections_array = YAML::load_file(sections_file)

sections_array.each do | s |
  se = Section.new
  se.title = s["title"]
  s["questions"].each do | f |
    q = se.questions.build
    q.header = f["header"]
    q.kind = f["kind"]
    q.option_a = f["option_a"]
    q.option_b = f["option_b"]
    q.section_id = f["section_id"]
    f["options"].each do | o |
      op = q.options.build
      op.body = o["body"]
      op.value = o["value"]
    end
  end
  se.save!
end


# Teams
teams_file = Rails.root.join("db", "seeds", "teams.yml")

teams_array = YAML::load_file(teams_file)

Team.create!(teams_array)

# Users
users_file = Rails.root.join("db", "seeds", "users.yml")

users_array = YAML::load_file(users_file)

User.create!(users_array)


# teams = Team.create([{name: 'Equipo #1' }, {name: 'Equipo #2' }])
#
# users = User.create([{name: 'Carolina', password: '12345', email: 'carolina@gmail.com', team: teams.first},
#                       {name: 'Mateo', password: '12345', email: 'mateo@gmail.com', team: teams.first}])
#
# sections = Section.create([{title: 'Autoesquema'},
#                            {title: 'Apertura Mental'}])
#
# questions = Question.create([{header: 'Después de dedicar varios dias a desarrollar un proyecto, estás conforme con el resultado.
#                                        Debes entregarlo a tu jefe quien te está esperando en la oficina. De camino se lo muestras
#                                        a un compañero de trabajo y éste te dice que le hagas unos cambios al documentos.
#                                        Qué decides hacer:',
#                              option_a: 'Posponer la entrega hasta hacer los cambios que el compañero te dijo, con el riesgo
#                                        de que él no tenga la razón',
#                              option_b: 'Entregar el trabajo corriendo el riesgo de que el compañero esté en lo correcto',
#                              kind: Question::YES_NO_QUESTION,
#                              section: sections.first},
#                             {header: 'Llegas a un nuevo pusto de trabajo, en el que tus compañeros son muy diferentes a ti, en
#                                       opinion,creencias y comportamiento, lo cual puede afectar tu puesto de trabajo y tu relacion
#                                       con los compañeros, pasado unos dias la situacion no mejora, que decidirias:',
#                              option_a: 'Actuar como ellos y desprenderte de tu identidad par ser aceptado por no colocar en riesgo tu trabajo',
#                              option_b: 'Actuas tal y como eres, aunque no seas aceptado en el grupo y corriendo el riesgo de que afecte tu trabajo',
#                              kind: Question::YES_NO_QUESTION,
#                              section: sections.first},
#                             {header: 'Eres el líder de un proyecto con un equipo de trabajo de 6 integrantes.  El plan de trabajo lo has diseñado
#                                       completamente y todo te está saliendo según lo planeado.  A última hora, uno de los integrantes del equipo
#                                       te propone hacer unos cambios que reorientan casi por completo tu diseño.
#                                       Qué haces:',
#                              option_a: 'Decides hacerle caso a tu miembro del equipo corriendo el riesgo de estar equivocado',
#                              option_b: 'Conservar los objetivos que inicialmente diseñaste, corriendo el riesgo de que estés equivocado',
#                              kind: Question::YES_NO_QUESTION,
#                              section: sections.last},
#                             {header: 'Llevas 4 años trabajando en una empresa, al dia de hoy renuncia el jefe de recursos humanos quien participaba
#                                       en un proyecto importante y tu eres una de las seleccionadas para asumir el cargo, tu jefe te llama para
#                                       entrevistarte y contarte la situacion, sabes que es un area nueva y que no lo manejas muy bien. Qué harias:',
#                              option_a: 'Negarte a asumir el cargo apesar de la necesidad de la empreas',
#                              option_b: 'Aceptas el cargo y te ezfuerzas para sacar el proyecto adelante',
#                              kind: Question::YES_NO_QUESTION,
#                              section: sections.last}])
#
# options = Option.create([{body: Option::DEFINITELY_OPTION_A, question: questions.first},
#                           {body: Option::MAYBE_OPTION_A, question: questions.first},
#                           {body: Option::NEUTRAL, question: questions.first},
#                           {body: Option::MAYBE_OPTION_B, question: questions.first},
#                           {body: Option::DEFINITELY_OPTION_B, question: questions.first},
#                           {body: Option::DEFINITELY_OPTION_A, question: questions.second},
#                           {body: Option::MAYBE_OPTION_A, question: questions.second},
#                           {body: Option::NEUTRAL, question: questions.second},
#                           {body: Option::MAYBE_OPTION_B, question: questions.second},
#                           {body: Option::DEFINITELY_OPTION_B, question: questions.second},
#                           {body: Option::DEFINITELY_OPTION_A, question: questions.third},
#                           {body: Option::MAYBE_OPTION_A, question: questions.third},
#                           {body: Option::NEUTRAL, question: questions.third},
#                           {body: Option::MAYBE_OPTION_B, question: questions.third},
#                           {body: Option::DEFINITELY_OPTION_B, question: questions.third},
#                           {body: Option::DEFINITELY_OPTION_A, question: questions.fourth},
#                           {body: Option::MAYBE_OPTION_A, question: questions.fourth},
#                           {body: Option::NEUTRAL, question: questions.fourth},
#                           {body: Option::MAYBE_OPTION_B, question: questions.fourth},
#                           {body: Option::DEFINITELY_OPTION_B, question: questions.fourth}])
