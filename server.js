const http = require('http');
const fs = require('fs');
const path = require('path');
const os = require('os');

const PORT = 3000;

// Tipos MIME soportados
const MIME_TYPES = {
  '.html': 'text/html; charset=UTF-8',
  '.js': 'text/javascript; charset=UTF-8',
  '.json': 'application/json; charset=UTF-8',
  '.css': 'text/css; charset=UTF-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon'
};

// Obtener la IP local en la red Wi-Fi / LAN
function getLocalIpAddress() {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      // Ignorar 127.0.0.1 y direcciones internas
      if (iface.family === 'IPv4' && !iface.internal) {
        return iface.address;
      }
    }
  }
  return 'localhost';
}

const server = http.createServer((req, res) => {
  let reqPath = req.url.split('?')[0];
  if (reqPath === '/' || reqPath === '') {
    reqPath = '/index.html';
  }

  const filePath = path.join(__dirname, reqPath);

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404, { 'Content-Type': 'text/plain; charset=UTF-8' });
      res.end('404 - Archivo no encontrado');
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    res.writeHead(200, {
      'Content-Type': contentType,
      'Cache-Control': 'no-cache',
      'Access-Control-Allow-Origin': '*'
    });

    const stream = fs.createReadStream(filePath);
    stream.pipe(res);
  });
});

server.listen(PORT, '0.0.0.0', () => {
  const localIp = getLocalIpAddress();
  console.log('\n======================================================');
  console.log('   ☕ SERVIDOR MÓVIL BARISTA PRO INICIADO CON ÉXITO');
  console.log('======================================================');
  console.log(`\n1. En tu computadora puedes abrir:`);
  console.log(`   👉 http://localhost:${PORT}`);
  console.log(`\n2. Para abrirlo y guardarlo en tu TELÉFONO:`);
  console.log(`   (Asegúrate de que tu teléfono esté conectado a la misma red Wi-Fi)`);
  console.log(`   👉 Abre el navegador en tu celular y entra a:`);
  console.log(`      http://${localIp}:${PORT}`);
  console.log('\n3. Para guardarlo como App permanente:');
  console.log('   • iPhone (Safari): Botón Compartir ⎋ -> "Agregar a pantalla de inicio" ➕');
  console.log('   • Android (Chrome): Menú tres puntos ⋮ -> "Instalar aplicación" 📲');
  console.log('======================================================\n');
});
