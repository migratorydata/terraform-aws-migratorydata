server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://${ monitor_private_ip }:3100/loki/api/v1/push

scrape_configs:
  - job_name: migratorydata
    static_configs:
      - targets:
          - localhost
        labels:
          job: migratorydata
          __path__: "/var/log/migratorydata/all/{out.log,gc-*}"
          private_ip: "{{ ansible_default_ipv4.address }}"