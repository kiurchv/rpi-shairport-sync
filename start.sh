#!/bin/sh

name=${AIRPLAY_NAME+"name = \"${AIRPLAY_NAME}\";"}
password=${AIRPLAY_PASSWORD+"password = \"${AIRPLAY_PASSWORD}\";"}
volume_range=${VOLUME_RANGE+"volume_range_db = ${VOLUME_RANGE};"}
drift_tolerance=${DRIFT_TOLERANCE+"drift_tolerance_in_seconds = ${DRIFT_TOLERANCE};"}
output_device=${ALSA_OUTPUT_DEVICE+"output_device = \"${ALSA_OUTPUT_DEVICE}\";"}
mixer_control_name=${ALSA_MIXER_CONTROL_NAME+"mixer_control_name = \"${ALSA_MIXER_CONTROL_NAME}\";"}

cat > "/usr/local/etc/shairport-sync.conf" << EOF
general = {
  ${name}
  ${password}
  ${volume_range}
  ${drift_tolerance}
  interpolation = "soxr";
};

alsa = {
  ${output_device}
  ${mixer_control_name}
};
EOF

/usr/local/bin/shairport-sync -v
