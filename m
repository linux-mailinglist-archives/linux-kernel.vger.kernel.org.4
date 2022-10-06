Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65445F6965
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiJFOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiJFOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:10:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8844AE22F;
        Thu,  6 Oct 2022 07:08:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m15so2950652edb.13;
        Thu, 06 Oct 2022 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfendtoye8jgEYml7jmF5ZfwLRYBNVI64fx9t7gqW2o=;
        b=puhw3HZPT2EyVMq32dof3DfsDh3FAtk3xAX82KQf/M4LHEya86Hw2i84kxRSiR20kT
         SIlAjzPeiHyEMxHuvFuqsellq9ba0wG77M57tjj0dmWqqs2YwfdeSFwVAZgMiR6zXGbV
         teP/LWn9gkGHUm5pN53w9+aG/G7yEawfsCJMcocomXDSmPHzy78l2AKr1dj/s137nqOo
         SXqqCJscPFZM+OnovNQGViiOsGOcE8N9dtfT8gvRhga0ZZYxH1rd4+jame7DPdMP/uXq
         GW1OAeEJYoNITUy9yz7H+qo+Aw8bmD9cMVWTydXCVztoi7CZcCBwoswi0i5fydmOizbn
         flQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfendtoye8jgEYml7jmF5ZfwLRYBNVI64fx9t7gqW2o=;
        b=Mwlsh5WNxx07ppfT5KxlVHWOxoHsD6lUEYLRX/B33bOk4YnpS8bHh76eG1wTNXG+AZ
         WJNFjLPPk+C0cZpHhP5Zr9qw6p7VolEYpDOvPhCAITWPDC0iEfaRkLHNozdhtZJAswkK
         YDqqQ2CHMdxoLXFFSZNJFGqyFETIAerVa+nrRqi+q5Xx48UvqUxchCB/SMSHbhq+0q2o
         oCasd3oeQ8XINCVS0ETH1gCSPXSw2H611ouxjLdhZqVsf49O54/1GC8oJ1zkCTOEKIPz
         b0f6dFyn9FbB+MJ/eiNGoZ39LITEFiTEybBrZS0Tc79+J0r8xAbAVagLhuCD6hkXw1bQ
         w3gw==
X-Gm-Message-State: ACrzQf0/Io2XFycIZowg65JGCmFDVGZu5NJQG91ZQZd6IeQPPfYL+i15
        oSIVvQLUHDIaBju8ynzbO6bVCAI4f7k=
X-Google-Smtp-Source: AMsMyM4S78Knt4S1WYFWLeqNAb0mnQH3o/oSNavpeiTaUr6U0AvmoM83bQcsCzL/iwdBDtJ096mpsg==
X-Received: by 2002:a05:6402:548a:b0:454:762b:158b with SMTP id fg10-20020a056402548a00b00454762b158bmr4739912edb.362.1665065270407;
        Thu, 06 Oct 2022 07:07:50 -0700 (PDT)
Received: from demon-pc.localdomain ([86.123.72.23])
        by smtp.gmail.com with ESMTPSA id l3-20020a170906644300b0077a201f6d1esm10358210ejn.87.2022.10.06.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:50 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/2] dt-bindings: iio: adc: add AD4130
Date:   Thu,  6 Oct 2022 17:07:36 +0300
Message-Id: <20221006140737.12396-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006140737.12396-1-cosmin.tanislav@analog.com>
References: <20221006140737.12396-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

AD4130-8 is an ultra-low power, high precision, measurement solution for
low bandwidth battery operated applications.

The fully integrated AFE (Analog Front-End) includes a multiplexer for up
to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
selectable filter options, smart sequencer, sensor biasing and excitation
options, diagnostics, and a FIFO buffer.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/adi,ad4130.yaml          | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
new file mode 100644
index 000000000000..dea7426095c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -0,0 +1,252 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4130 ADC device driver
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4130
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: phandle to the master clock (mclk)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    description: |
+      Specify which interrupt pin should be configured as Data Ready / FIFO
+      interrupt.
+      Default if not supplied is int.
+    enum:
+      - int
+      - clk
+      - p2
+      - dout
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  refin1-supply:
+    description: refin1 supply. Can be used as reference for conversion.
+
+  refin2-supply:
+    description: refin2 supply. Can be used as reference for conversion.
+
+  avdd-supply:
+    description: AVDD voltage supply. Can be used as reference for conversion.
+
+  iovdd-supply:
+    description: IOVDD voltage supply. Used for the chip interface.
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  adi,ext-clk-freq-hz:
+    description: Specify the frequency of the external clock.
+    enum: [76800, 153600]
+    default: 76800
+
+  adi,bipolar:
+    description: Specify if the device should be used in bipolar mode.
+    type: boolean
+
+  adi,vbias-pins:
+    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 16
+    items:
+      minimum: 0
+      maximum: 15
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+patternProperties:
+  "^channel@([0-9a-f])$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel number.
+        minimum: 0
+        maximum: 15
+
+      diff-channels:
+        description: |
+          Besides the analog inputs available, internal inputs can be used.
+          16: Internal temperature sensor.
+          17: AVSS
+          18: Internal reference
+          19: DGND
+          20: (AVDD − AVSS)/6+
+          21: (AVDD − AVSS)/6-
+          22: (IOVDD − DGND)/6+
+          23: (IOVDD − DGND)/6-
+          24: (ALDO − AVSS)/6+
+          25: (ALDO − AVSS)/6-
+          26: (DLDO − DGND)/6+
+          27: (DLDO − DGND)/6-
+          28: V_MV_P
+          29: V_MV_M
+        items:
+          minimum: 0
+          maximum: 29
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on the
+          specific channel. Valid values are:
+          0: REFIN1(+)/REFIN1(−)
+          1: REFIN2(+)/REFIN2(−)
+          2: REFOUT/AVSS (Internal reference)
+          3: AVDD/AVSS
+          If not specified, REFIN1 is used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 0
+
+      adi,excitation-pin-0:
+        description: |
+          Analog input to apply excitation current to while the channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 15
+        default: 0
+
+      adi,excitation-pin-1:
+        description: |
+          Analog input to apply excitation current to while this channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 15
+        default: 0
+
+      adi,excitation-current-0-nanoamp:
+        description: |
+          Excitation current in nanoamps to be applied to pin specified in
+          adi,excitation-pin-0 while this channel is active.
+        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
+        default: 0
+
+      adi,excitation-current-1-nanoamp:
+        description: |
+          Excitation current in nanoamps to be applied to pin specified in
+          adi,excitation-pin-1 while this channel is active.
+        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
+        default: 0
+
+      adi,burnout-current-nanoamp:
+        description: |
+          Burnout current in nanoamps to be applied for this channel.
+        enum: [0, 500, 2000, 4000]
+        default: 0
+
+      adi,buffered-positive:
+        description: Enable buffered mode for positive input.
+        type: boolean
+
+      adi,buffered-negative:
+        description: Enable buffered mode for negative input.
+        type: boolean
+
+    required:
+      - reg
+      - diff-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad4130";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi-max-frequency = <5000000>;
+        interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+
+        channel@0 {
+          reg = <0>;
+
+          adi,reference-select = <2>;
+
+          /* AIN8, AIN9 */
+          diff-channels = <8 9>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          adi,reference-select = <2>;
+
+          /* AIN10, AIN11 */
+          diff-channels = <10 11>;
+        };
+
+        channel@2 {
+          reg = <2>;
+
+          adi,reference-select = <2>;
+
+          /* Temperature Sensor, DGND */
+          diff-channels = <16 19>;
+        };
+
+        channel@3 {
+          reg = <3>;
+
+          adi,reference-select = <2>;
+
+          /* Internal reference, DGND */
+          diff-channels = <18 19>;
+        };
+
+        channel@4 {
+          reg = <4>;
+
+          adi,reference-select = <2>;
+
+          /* DGND, DGND */
+          diff-channels = <19 19>;
+        };
+      };
+    };
-- 
2.38.0

