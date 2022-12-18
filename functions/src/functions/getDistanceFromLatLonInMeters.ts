export function getDistanceFromLatLonInMeters(
  lat1: number,
  lon1: number,
  lat2: number,
  lon2: number
) {
  //TODO: quelle
  const R = 6371; // Radius der Erde in km
  const dLat = deg2rad(lat2 - lat1); // deg2rad unten
  const dLon = deg2rad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) *
      Math.cos(deg2rad(lat2)) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const d = R * c * 1000; // Distanz in Metern
  return d;
}

function deg2rad(deg: number) {
  return deg * (Math.PI / 180);
}