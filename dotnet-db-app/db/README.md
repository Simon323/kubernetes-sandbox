### Run from db dir
```bash
dotnet ef migrations script --idempotent -o idempotent_script.sql --project ../src/WebApiWithDb/WebApiWithDb.csproj
```