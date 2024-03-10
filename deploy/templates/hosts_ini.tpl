[migratorydata]
%{ for i, ip in migratorydata_public_ips ~}
${ ip } ansible_user=${ ssh_user } ansible_become=True ansible_ssh_private_key_file=${ ssh_private_key } migratorydata_private_ip=${ migratorydata_private_ips[i] }
%{ endfor ~}

%{ if enable_monitoring }

[monitor]
${ monitor_public_ip } ansible_user=${ ssh_user } ansible_become=True ansible_ssh_private_key_file=${ ssh_private_key }
%{ endif }