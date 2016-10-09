


fetch_explicasdb <- function(query, dbname = "explicas_db", user = "explicas", password = "explicas_pass"){
    require(RMySQL)
    con <- dbConnect(RMySQL::MySQL(), dbname = dbname, user = user, password = password)
    query_result <- dbSendQuery(con, query)
    res <- dbFetch(query_result, n = -1) 
    dbHasCompleted(query_result)
    dbClearResult(query_result)
    dbDisconnect(con)
    res
}
    
    


searches <- fetch_explicasdb("select * from registo_pesquisas")
searches_backup <- searches

backoffice <- fetch_explicasdb("SELECT proposta_explicacao.id, data, UserRem.nome as NomeRemetente, UserDest.nome as NomeDestino, preco, disciplina.disciplina, escolaridade.escolaridade 
 FROM explicas_db.proposta_explicacao
 inner join disciplinas_novas as disciplina on disciplina.id = proposta_explicacao.id_disciplina
 inner join escolaridade on escolaridade.id = disciplina.id_escolaridade
inner join user as UserRem on UserRem.id = proposta_explicacao.id_rem
inner join user as UserDest on UserDest.id = proposta_explicacao.id_destino;")
backoffice_backup <- backoffice




