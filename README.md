# ibkr-gateway

IBKR Client Portal Gateway para deploy no Render.

## Deploy no Render

1. Vai a https://render.com
2. Cria um novo **Web Service**
3. Liga ao repositório `ibkr-gateway`
4. Em Environment escolhe: **Docker**
5. Em Port coloca: **5000**
6. Faz deploy

Depois do deploy, copia o URL do Render (ex: https://ibkr-gateway.onrender.com)
e coloca-o no ficheiro `config/live_runtime.json` do NEXUS:

"cpg_base_url": "https://teu-url-render.com"
