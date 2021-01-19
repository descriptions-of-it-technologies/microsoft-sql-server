# Microsoft SQL Server.





## Contents at a Glance.
* [About](#about)
* [Documentation.](#documentation)
* [Pros.](#pros)
* [Cons.](#cons)
* [Help](#help)





## About.
`docker run -it --rm -v $PWD/entrypoint.sh:/entrypoint.sh --entrypoint=/entrypoint.sh -p 1433:1433 --name=sql mcr.microsoft.com/mssql/server:2019-latest`
`docker exec -it sql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword' -Q "select name from sys.databases where name = 'demo'"`





## Documentation.





## Pros.





## Cons.





## Help.
