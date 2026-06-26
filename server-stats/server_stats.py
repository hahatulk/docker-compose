from flask import Flask
import psutil
import time
import threading

app = Flask(__name__)

current_stats = {
    'cpu': 0.0,
    'ram_percent': 0.0,
    'ram_used_gb': 0.0,
    'ram_total_gb': 0.0,
    'net_recv_mbps': 0.0,
    'net_sent_mbps': 0.0
}

def stats_collector():
    global current_stats
    last_net = psutil.net_io_counters()
    last_time = time.time()

    while True:
        # CPU
        current_stats['cpu'] = psutil.cpu_percent(interval=None)

        # RAM
        mem = psutil.virtual_memory()
        current_stats['ram_percent'] = mem.percent
        current_stats['ram_used_gb'] = round(mem.used / (1024 ** 3), 1)
        current_stats['ram_total_gb'] = round(mem.total / (1024 ** 3), 1)

        # Сеть (отдельно recv и sent)
        current_net = psutil.net_io_counters()
        current_time = time.time()
        time_diff = current_time - last_time

        if time_diff > 0:
            recv_mbps = ((current_net.bytes_recv - last_net.bytes_recv) / time_diff) * 8 / 1000000
            sent_mbps = ((current_net.bytes_sent - last_net.bytes_sent) / time_diff) * 8 / 1000000
            current_stats['net_recv_mbps'] = round(recv_mbps, 1)
            current_stats['net_sent_mbps'] = round(sent_mbps, 1)

        last_net = current_net
        last_time = current_time
        time.sleep(1)

@app.route('/stats')
def stats():
    return (f"CPU:{current_stats['cpu']};"
            f"RAM:{current_stats['ram_percent']};"
            f"RAM_USED:{current_stats['ram_used_gb']};"
            f"RAM_TOTAL:{current_stats['ram_total_gb']};"
            f"NET_RECV:{current_stats['net_recv_mbps']};"
            f"NET_SENT:{current_stats['net_sent_mbps']}")

if __name__ == '__main__':
    t = threading.Thread(target=stats_collector, daemon=True)
    t.start()

    app.run(host='0.0.0.0', port=5000)
