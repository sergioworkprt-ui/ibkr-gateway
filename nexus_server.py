import os
import httpx
from fastapi import FastAPI, Request, Response
import uvicorn

app = FastAPI()
GATEWAY = "http://localhost:5000"

HOP_BY_HOP = {
    "connection", "keep-alive", "proxy-authenticate", "proxy-authorization",
    "te", "trailers", "transfer-encoding", "upgrade", "content-encoding",
}

@app.api_route("/{path:path}", methods=["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS", "HEAD"])
async def proxy(request: Request, path: str):
    url = f"{GATEWAY}/{path}"
    headers = {k: v for k, v in request.headers.items() if k.lower() != "host"}
    body = await request.body()
    async with httpx.AsyncClient(verify=False, timeout=30.0) as client:
        resp = await client.request(
            method=request.method,
            url=url,
            params=request.query_params,
            headers=headers,
            content=body,
            follow_redirects=True,
        )
    resp_headers = {k: v for k, v in resp.headers.items() if k.lower() not in HOP_BY_HOP}
    return Response(content=resp.content, status_code=resp.status_code, headers=resp_headers)

if __name__ == "__main__":
    port = int(os.environ["PORT"])
    uvicorn.run(app, host="0.0.0.0", port=port)
