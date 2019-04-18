docker build -t jmahernandez/multi-cllient:latest -t jmahernandez/multi-cllient:$SHA -f ./client/Dockerfile ./client
docker build -t jmahernandez/multi-server:latest -t jmahernandez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmahernandez/multi-worker:latest -t jmahernandez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jmahernandez/multi-client:latest
docker push jmahernandez/multi-server:latest
docker push jmahernandez/multi-worker:latest

docker push jmahernandez/multi-client:$SHA
docker push jmahernandez/multi-server:$SHA
docker push jmahernandez/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jmahernandez/multi-client:$SHA
kubectl set image deployments/server-deployment server=jmahernandez/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jmahernandez/multi-worker:$SHA