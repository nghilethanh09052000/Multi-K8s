docker build -t nghilt19411/multi-client:latest -t nghilt19411/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nghilt19411/multi-server:latest -t nghilt19411/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nghilt19411/multi-worker:latest -t nghilt19411/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nghilt19411/multi-client:latest
docker push nghilt19411/multi-server:latest
docker push nghilt19411/multi-worker:latest

docker push nghilt19411/multi-client:$SHA
docker push nghilt19411/multi-server:$SHA
docker push nghilt19411/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-config server=nghilt19411/multi-server:$SHA
kubectl set image deployments/client-config client=nghilt19411/multi-client:$SHA
kubectl set image deployments/worker-config worker=nghilt19411/multi-worker:$SHA

