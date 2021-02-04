#!/usr/bin/env bash

echo "****************************************************************"
echo "Install required"
echo "****************************************************************"

echo "****************************************************************"
echo "Predefine variables"
echo "****************************************************************"
export MSSQL_PID=Developer
export ACCEPT_EULA=Y
export MSSQL_SA_PASSWORD=37Y5Nb8uTo2
export TZ=Europe/Kiev

function import {
    sleep 1
    echo "****************************************************************"
    echo "Waiting till SQL Server is up and running"
    echo "****************************************************************"
    sleep 10
    for i in {1..50}
    do
        /opt/mssql-tools/bin/sqlcmd -l 1 -t 1 -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -Q "SELECT @@VERSION"
        if [ $? -eq 0 ]
        then
            echo "****************************************************************"
            echo "SQL Server started"
            echo "****************************************************************"
            break
        else
            echo "****************************************************************"
            echo "not ready yet..."
            echo "****************************************************************"
            sleep 1
        fi
    done
    sleep 1
    echo "****************************************** Database creation begins ******************************************"
#    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -Q "CREATE DATABASE SkarbNgoDB"
#    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -Q "CREATE DATABASE SkarbNgoDB COLLATE Cyrillic_General_CI_AS;"     #RU
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -Q "CREATE DATABASE SkarbNgoDB COLLATE Ukrainian_CI_AS;"             #UA
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d SkarbNgoDB -Q "CREATE LOGIN [user] WITH PASSWORD = '$MSSQL_SA_PASSWORD', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d SkarbNgoDB -Q "CREATE USER [user] FOR LOGIN [user]"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d SkarbNgoDB -Q "EXEC sp_addrolemember 'db_owner', 'user';"

    echo "****************************************** Show Database Collation *******************************************"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -Q "SELECT name, collation_name FROM sys.databases;"

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DONE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
}

import &

echo "Starting SQL Server"
exec /opt/mssql/bin/sqlservr
