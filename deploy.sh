docker build -t ddavisjr/multi-client:latest -t ddavisjr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ddavisjr/multi-server:latest -t ddavisjr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ddavisjr/multi-worker:latest -t ddavisjr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ddavisjr/multi-client:latest
docker push ddavisjr/multi-server:latest
docker push ddavisjr/multi-worker:latest

docker push ddavisjr/multi-client:$SHA
docker push ddavisjr/multi-server:$SHA
docker push ddavisjr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ddavisjr/multi-server:$SHA
kubectl set image deployments/client-deployment client=ddavisjr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ddavisjr/multi-worker:$SHA
