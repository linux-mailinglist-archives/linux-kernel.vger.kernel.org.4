Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E465F2ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJCKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJCKay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:30:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D7286C6;
        Mon,  3 Oct 2022 03:30:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id au23so372835ejc.1;
        Mon, 03 Oct 2022 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ar33mgNjHp58FYO5NdYWCVqVRxZiogwxtAJa69icZLI=;
        b=kUTKY3UJg1JsQHd0MWiUDEO9Uoyf2sxB3Vtp+cjqDc4y9lFmLjEzwyYn9B4dRSjXnl
         G66XEdgmXcaeuNMxwGIYKkGZ/pHChFqb/HlNUOn4JlXdSaRS7ZArJDpujJQa/NKsvYvj
         hZxkclCqAS4iBe0InZ0nexigdmSxYo38CVTL5x3ugT8A3wS41oFheGUUYwc0KeC835WO
         CpENHvmNw2Rf26ZygcXRFzpSVYN1kfpENVYqzHXdEka0myFUSp4o3dndVUoGXHYOFGDf
         qOFPIYQ+gtQ3HeaS/Df7LmCnno9ellsQOKE0EOWteLxrzaoCva60LRKzcREpC5P6yn6n
         vo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ar33mgNjHp58FYO5NdYWCVqVRxZiogwxtAJa69icZLI=;
        b=vUnhBY7Enoln09fDiLjtp9PyqvnDNmBb2FZ3t8zAO4KXI1eEppxzNlCHXWTT107wNR
         PycwnDZS3d5lV36Ubb0AOsO+NEqgzgUMpEFM9FGoo5jLmHcc3gQx8hADbBlFSIT2O+1a
         kNupaq5mjK4eQlN/7ijXvhKnVCfswOC3Qp1EFbmmlmeJEVv2EVUfTobCfvP2tU21ldM6
         ntt9mU+wT/gKjzD/arZSAfC1Jru9PxKuVw69Z9uA3g196TkheQbR8mqtELV/W4XeIJt8
         wsfWws1CqAq1CDyXo2dx2Zi4UXMlLzUA7OItU37cTY+Za5+UGFfD6NncizW5M7GxIDGs
         knSg==
X-Gm-Message-State: ACrzQf1Le8VN5BXGEPl8aw5okKz+rD6Zxqz6GlGKjGj+xMkBclnbMZgn
        VkrorqfhvAJgWntH+eevMgBevtR5Iw+3RA==
X-Google-Smtp-Source: AMsMyM6VWBaAhivtxFqq7EWEtGma058wtTng8KKONetBdhF2OhXGdn+DHJ5wh1aQ4TdCb9Vdw2afRg==
X-Received: by 2002:a17:907:1b1e:b0:783:8e33:2d1c with SMTP id mp30-20020a1709071b1e00b007838e332d1cmr14599576ejc.304.1664793046797;
        Mon, 03 Oct 2022 03:30:46 -0700 (PDT)
Received: from localhost.localdomain ([109.166.136.105])
        by smtp.gmail.com with ESMTPSA id u3-20020a50c043000000b0045754cd5e08sm7232173edd.39.2022.10.03.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:30:46 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: addac: add AD74115
Date:   Mon,  3 Oct 2022 13:30:14 +0300
Message-Id: <20221003103016.195805-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003103016.195805-1-demonsingur@gmail.com>
References: <20221003103016.195805-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The AD74115H is a single-channel, software-configurable, input and
output device for industrial control applications. The AD74115H
provides a wide range of use cases, integrated on a single chip.

These use cases include analog output, analog input, digital output,
digital input, resistance temperature detector (RTD), and thermocouple
measurement capability. The AD74115H also has an integrated HART modem.

A serial peripheral interface (SPI) is used to handle all communications
to the device, including communications with the HART modem. The digital
input and digital outputs can be accessed via the SPI or the
general-purpose input and output (GPIO) pins to support higher
speed data rates.

The device features a 16-bit, sigma-delta analog-to-digital converter
(ADC) and a 14-bit digital-to-analog converter (DAC).
The AD74115H contains a high accuracy 2.5 V on-chip reference that can
be used as the DAC and ADC reference.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/addac/adi,ad74115.yaml       | 491 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
new file mode 100644
index 000000000000..1f894d80b259
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
@@ -0,0 +1,491 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/adi,ad74115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD74115H device
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The AD74115H is a single-channel software configurable input/output
+  device for industrial control applications. It contains functionality for
+  analog output, analog input, digital output, digital input, resistance
+  temperature detector, and thermocouple measurements integrated into a single
+  chip solution with an SPI interface. The device features a 16-bit ADC and a
+  14-bit DAC.
+
+    https://www.analog.com/en/products/ad74115h.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad74115h
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 24000000
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply: true
+  avcc-supply: true
+  dvcc-supply: true
+  aldo1v8-supply: true
+  dovdd-supply: true
+  refin-supply: true
+
+  adi,ch-func:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Channel function.
+      0 - High impedance
+      1 - Voltage output
+      2 - Current output
+      3 - Voltage input
+      4 - Current input, externally-powered
+      5 - Current input, loop-powered
+      6 - Resistance input
+      7 - RTD measure
+      8 - Digital input logic
+      9 - Digital input, loop-powered
+      10 - Current output with HART
+      11 - Current input, externally-powered, with HART
+      12 - Current input, loop-powered, with HART
+    minimum: 0
+    maximum: 12
+    default: 0
+
+  adi,conv2-mux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Input node for ADC conversion 2.
+      0 - SENSE_EXT1 to AGND_SENSE
+      1 - SENSE_EXT2 to AGND_SENSE
+      2 - SENSE_EXT2 to SENSE_EXT1
+      3 - AGND to AGND
+    minimum: 0
+    maximum: 3
+    default: 0
+
+  adi,conv2-range:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Conversion range for ADC conversion 2.
+      0 - 0V to 12V
+      1 - -12V to +12V
+      2 - -2.5V to +2.5V
+      3 - -2.5V to 0V
+      4 - 0V to 2.5V
+      5 - 0V to 0.625V
+      6 - -104mV to +104mV
+      7 - 0V to 12V
+    minimum: 0
+    maximum: 7
+    default: 0
+
+  adi,diag0-func:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Diagnostic channel 0 function.
+      0 - Disabled
+      1 - Temperature sensor
+      2 - DVCC
+      3 - AVCC
+      4 - ALDO1V8
+      5 - DLDO1V8
+      6 - REFOUT
+      7 - AVDD
+      8 - AVSS
+      9 - LVIN
+      10 - SENSEL
+      11 - SENSE_EXT1
+      12 - SENSE_EXT2
+      13 - DO_VDD
+      14 - AGND
+      15 - Sinking current from external digital output
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,diag1-func:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Diagnostic channel 1 function.
+      0 - Disabled
+      1 - Temperature sensor
+      2 - DVCC
+      3 - AVCC
+      4 - ALDO1V8
+      5 - DLDO1V8
+      6 - REFOUT
+      7 - AVDD
+      8 - AVSS
+      9 - LVIN
+      10 - SENSEL
+      11 - SENSE_EXT1
+      12 - SENSE_EXT2
+      13 - DO_VDD
+      14 - AGND
+      15 - Sourcing current from external digital output
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,diag2-func:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Diagnostic channel 2 function.
+      0 - Disabled
+      1 - Temperature sensor
+      2 - DVCC
+      3 - AVCC
+      4 - ALDO1V8
+      5 - DLDO1V8
+      6 - REFOUT
+      7 - AVDD
+      8 - AVSS
+      9 - LVIN
+      10 - SENSEL
+      11 - SENSE_EXT1
+      12 - SENSE_EXT2
+      13 - DO_VDD
+      14 - AGND
+      15 - Sinking current from internal digital output
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,diag3-func:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Diagnostic channel 3 function.
+      0 - Disabled
+      1 - Temperature sensor
+      2 - DVCC
+      3 - AVCC
+      4 - ALDO1V8
+      5 - DLDO1V8
+      6 - REFOUT
+      7 - AVDD
+      8 - AVSS
+      9 - LVIN
+      10 - SENSEL
+      11 - SENSE_EXT1
+      12 - SENSE_EXT2
+      13 - DO_VDD
+      14 - AGND
+      15 - Sourcing current from internal digital output
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,sense-agnd-buffer-lp:
+    type: boolean
+    description: |
+      Whether to enable low-power buffered mode for the AGND sense pin.
+
+  adi,lf-buffer-lp:
+    type: boolean
+    description: |
+      Whether to enable low-power buffered mode for the low-side filtered
+      sense pin.
+
+  adi,hf-buffer-lp:
+    type: boolean
+    description: |
+      Whether to enable low-power buffered mode for the high-side filtered
+      sense pin.
+
+  adi,ext2-buffer-lp:
+    type: boolean
+    description: Whether to enable low-power buffered mode for the EXT2 pin.
+
+  adi,ext1-buffer-lp:
+    type: boolean
+    description: Whether to enable low-power buffered mode for the EXT1 pin.
+
+  adi,comparator-invert-en:
+    type: boolean
+    description: Whether to invert the comparator output.
+
+  adi,digital-input-range:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Digital input range.
+      0 - Range 0.0 to 3.7mA in steps of 120uA, ~2k series resistance
+      1 - Range 1.0 to 7.4mA in steps of 240uA, ~1k series resistance
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,digital-input-sink:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Digital input sink.
+    minimum: 0
+    maximum: 31
+    default: 0
+
+  adi,digital-input-debounce-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Digital input debounce mode.
+      0 - Integrator method is used, a counter increments when the
+          signal is asserted and decrements when the signal is de-asserted
+      1 - A simple counter increments while a signal is asserted and
+          resets when the signal de-asserts
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,digital-input-unbuffered:
+    type: boolean
+    description: Whether to buffer digital input signals.
+
+  adi,digital-input-short-circuit-detection:
+    type: boolean
+    description: Whether to detect digital input short circuits.
+
+  adi,digital-input-open-circuit-detection:
+    type: boolean
+    description: Whether to detect digital input open circuits.
+
+  adi,digital-input-threshold-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Digital input threshold mode.
+      0 - The threshold range is from -0.96 * AVDD to AVDD
+      1 - The threshold range is fixed from -19V to 30V
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,dac-bipolar:
+    type: boolean
+    description: |
+      When not present, the DAC operates in the 0V to 12V range.
+      When present, the DAC operates in the -12V to 12V range.
+
+  adi,charge-pump-en:
+    type: boolean
+    description: Whether to enable the internal charge pump.
+
+  adi,dac-hart-slew:
+    type: boolean
+    description: Whether to use a HART-compatible slew rate.
+
+  adi,dac-current-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Current limit.
+      0 - 32mA source or sink for VOUT, 4mA sink for IOUT
+      1 - 16mA source or sink for VOUT, 1mA sink for IOUT
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,rtd-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RTD mode.
+      0 - 3-wire mode
+      1 - 4-wire mode
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,3-wire-rtd-excitation-swap:
+    type: boolean
+    description: Whether to swap the excitation for 3-wire RTD.
+
+  adi,rtd-excitation-current-microamp:
+    description: Excitation current to apply to RTD.
+    enum: [250, 500, 750, 1000]
+    default: 250
+
+  adi,ext1-burnout-en:
+    type: boolean
+    description: Whether to enable burnout current for EXT1.
+
+  adi,ext1-burnout-current-nanoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Burnout current in nanoamps to be applied to EXT1.
+    enum: [0, 50, 500, 1000, 10000]
+    default: 0
+
+  adi,ext1-burnout-current-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Burnout current polarity for EXT2.
+      0 - Sinking
+      1 - Sourcing
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,ext2-burnout-en:
+    type: boolean
+    description: Whether to enable burnout current for EXT2.
+
+  adi,ext2-burnout-current-nanoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Burnout current in nanoamps to be applied to EXT2.
+    enum: [0, 50, 500, 1000, 10000]
+    default: 0
+
+  adi,ext2-burnout-current-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Burnout current polarity for EXT2.
+      0 - Sinking
+      1 - Sourcing
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,viout-burnout-en:
+    type: boolean
+    description: Whether to enable burnout current for VIOUT.
+
+  adi,viout-burnout-current-nanoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Burnout current in nanoamps to be applied to VIOUT.
+    enum: [0, 1000, 10000]
+    default: 0
+
+  adi,viout-burnout-current-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Burnout current polarity for VIOUT.
+      0 - Sinking
+      1 - Sourcing
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  adi,gpio0-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - Comparator output
+      3 - Control HART CD
+      4 - Monitor HART CD
+      5 - Monitor HART EOM status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+  adi,gpio1-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - Drive external digital output FET
+      3 - Control HART RXD
+      4 - Monitor HART RXD
+      5 - Monitor HART SOM status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+  adi,gpio2-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - Drive internal digital output FET
+      3 - Control HART TXD
+      4 - Monitor HART TXD
+      5 - Monitor HART TX complete status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+  adi,gpio3-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - High impedance
+      3 - Control HART RTS
+      4 - Monitor HART RTS
+      5 - Monitor HART CD complete status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - spi-cpol
+  - avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+      status = "okay";
+
+      addac@0 {
+        compatible = "adi,ad74115h";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi-max-frequency = <12000000>;
+        spi-cpol;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+        refin-supply = <&ad74115_refin>;
+        avdd-supply = <&ad74115_avdd>;
+
+        adi,ch-func = <1>;
+        adi,conv2-mux = <2>;
+        adi,conv2-range = <1>;
+
+        adi,digital-input-unbuffered;
+        adi,gpio0-mode = <2>;
+
+        adi,gpio1-mode = <1>;
+        adi,gpio2-mode = <1>;
+        adi,gpio3-mode = <1>;
+
+        adi,diag0-func = <10>;
+        adi,diag1-func = <8>;
+        adi,diag2-func = <6>;
+        adi,diag3-func = <12>;
+
+        adi,dac-bipolar;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c547559eddf9..25071e763b33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1140,6 +1140,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD74115 DRIVER
+M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
+
 ANALOG DEVICES INC AD74413R DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.37.3

