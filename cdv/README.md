# Teste Técnico — Engenheiro de Dados | Clube do Valor

Projeto dbt que transforma os arquivos brutos `transactions.csv` e
`clients.csv` em modelos analíticos com camadas de staging, intermediate
e marts, testes e documentação.

Adapter: **dbt-duckdb** (banco em arquivo local, sem servidor).

## Como rodar

Pré-requisitos: Python 3.11+ e Git.

```bash
git clone <url-do-repo> cdv && cd cdv

python -m venv .venv
# Windows
.venv\Scripts\activate
# macOS/Linux
source .venv/bin/activate

pip install dbt-duckdb

# profiles.yml está versionado na raiz do projeto
# Windows (PowerShell)
$env:DBT_PROFILES_DIR = "."
# macOS/Linux / Git Bash
export DBT_PROFILES_DIR=.

dbt seed
dbt run
dbt test
```

Após o `dbt run` o banco fica disponível como `cdv.duckdb` na raiz.
