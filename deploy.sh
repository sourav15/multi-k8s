docker build -t sourav15/multi-client:latest -t sourav15/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sourav15/multi-server:latest -t sourav15/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sourav15/multi-worker:latest -t sourav15/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sourav15/multi-client:latest
docker push sourav15/multi-server:latest
docker push sourav15/multi-worker:latest

docker push sourav15/multi-client:$SHA
docker push sourav15/multi-server:$SHA
docker push sourav15/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sourav15/multi-server:$SHA
kubectl set image deployments/client-deployment client=sourav15/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sourav15/multi-worker:$SHA