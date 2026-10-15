meta:
  id: nz_payload
  file-extension: bin
  endian: le

seq:
  # The Python script creates a 112-byte (0x70) crypto block.
  # This block is stripped by the (!SDW + BSSID) XOR pad before reading.
  - id: encrypted_nzon_data
    size: 112

instances:
  # This tells Kaitai to look at the stream from byte 0
  # and apply cleartext/decrypted type schema to it.
  decrypted_view:
    pos: 0
    type: nzone_decrypted_frame
    io: _root._io

types:
  nzone_decrypted_frame:
    seq:
      # Offset 0x00: The target redirect URL
      - id: redirect_url
        type: strz
        encoding: ASCII
        size: 64

      - id: network_padding
        size: 4

      # Offset 0x44: This is where 'wep_key' actually lives
      - id: ap_crypto_key
        type: str
        size: 32
        encoding: ASCII

      # Offset 0x64
      - id: dsi_client_flag
        type: u1

      # Offset 0x65: This is where 'wep_type' enum  belongs
      - id: ap_crypto_type
        type: u1
        enum: wep_modes

      # Offset 0x66: The 0x01 activation flag written
      - id: system_flags
        type: u1

      # Offset 0x67
      - id: browser_flags
        type: u1

      # Offset 0x68
      - id: structural_padding
        size: 4

      # Offset 0x6C: The 0x0428 validation marker 
      - id: magic_marker
        type: u2

      # Offset 0x6E: The CRC16 generated dynamically
      - id: sub_payload_crc16
        type: u2

enums:
  wep_modes:
    0: open_network
    1: wep_64
    2: wep_128
    3: wep_152
    4: wpa_psk_tkip
    5: wpa2_psk_tkip
    6: wpa_psk_aes
    7: wpa2_psk_aes
