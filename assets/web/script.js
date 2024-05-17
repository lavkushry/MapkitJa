const jwtToken = 'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlAzNU5XVEc1MkoifQ.eyJpc3MiOiI3NDQyMjhKRFQ0IiwiaWF0IjoxNzE1NjczMDk3LCJleHAiOjE3MTU3NTk0OTd9.AA9-CBzFBa5TtChQaZGKjYlv_IpnQAJLw1BS4Fc605zkCmYAdzxypqHXZyxf8-oFprEkrPwBSY47VTtrdXm72w';

const CAMERA_DISTANCE_MIN = 1000;
const CAMERA_DISTANCE_INCREMENT = 1000;

mapkit.init({
  authorizationCallback: function(done) {
    done(jwtToken);
  }
});

const center = new mapkit.Coordinate(37.7749, -122.4194); // San Francisco coordinates
const map = new mapkit.Map('map', {
  center: center,
  cameraDistance: 10000 // Adjust the zoom level
});

function addAnnotation(coordinate, title, subtitle) {
  const annotation = new mapkit.MarkerAnnotation(coordinate, {
    title: title,
    subtitle: subtitle,
    color: "#ff0000"
  });
  map.addAnnotation(annotation);
}

addAnnotation(center, "San Francisco", "California");

document.getElementById('zoom-in').addEventListener('click', function() {
  map.cameraDistance = Math.max(map.cameraDistance -