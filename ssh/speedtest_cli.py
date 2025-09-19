import speedtest

st = speedtest.Speedtest()
st.get_best_server()
download_speed = st.download() / 1_000_000  # Mengonversi ke Mbps
upload_speed = st.upload() / 1_000_000  # Mengonversi ke Mbps
ping = st.results.ping

print(f"Kecepatan download: {download_speed:.2f} Mbps")
print(f"Kecepatan upload: {upload_speed:.2f} Mbps")
print(f"Ping: {ping} ms")