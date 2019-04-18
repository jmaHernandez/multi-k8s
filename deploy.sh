docker build -t jmahernandez/multi_client:latest -t jmahernandez/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t jmahernandez/multi_server:latest -t jmahernandez/multi_server:$SHA -f ./server/Dockerfile ./server
docker build -t jmahernandez/multi_worker:latest -t jmahernandez/multi_worker:$SHA -f ./worker/Dockerfile ./worker

docker push jmahernandez/multi_client:latest
docker push jmahernandez/multi_server:latest
docker push jmahernandez/multi_worker:latest

docker push jmahernandez/multi_client:$SHA
docker push jmahernandez/multi_server:$SHA
docker push jmahernandez/multi_worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jmahernandez/multi_client:$SHA
kubectl set image deployments/server-deployment server=jmahernandez/multi_server:$SHA
kubectl set image deployments/worker-deployment worker=jmahernandez/multi_worker:$SHA