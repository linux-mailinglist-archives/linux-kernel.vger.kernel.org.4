Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3453614FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiKAQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:53:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF01CFDE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:53:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so10262804wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eddshc+TxD4X+o0YuSoxkETZc7MLSHkFPfgjCwFMvTg=;
        b=a6HYjhrXZzleuVL9tGLIFkSKMqrSToAPLaanINPn84AynQBXZWrzFALwULk6n+Xl0n
         gykOUZjQJmVwQivzwE1OeqZKNuyD/k9PrN3lr0sfHHDgbNN6d3dysjYkWJyOqbmkINEp
         FmK7Av3BQ2v6onHAKZU0IEK1btLNk6S/4ERdfFrEMoEypGdVvjeIhlNUuWrpl+FL8I3C
         F1xCLvV8//Anqx0g1J1CKcrKIEJXbpfp7NJXvPD6xytQ3Qvzk+MsWExBQGvOYBJBtM8Y
         Hq35lgHy3ib2kvX63bopjZQZvcJwGyfFTaoMy0iLvCgYixwtHFm4R+7YmwLxqTyvjz5Q
         gIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eddshc+TxD4X+o0YuSoxkETZc7MLSHkFPfgjCwFMvTg=;
        b=PHiVNvj07LSBuiBy8TOzI2rnC92Vy9cv225shEgORJGHGqMw8o+9vo2+zhsVsCtc0Q
         R/A1soN0d0LQcYeKh/QE472v7pRgLsFyOT7J8jUMnmlk2N7TfjnFXdybZ9W3WUzFc+Ie
         EtRDInbkWMsLRj8bcWFJ/ioUhfLmwfNdxhNc7co42LVHUNyna1lB/w0E63OH/dHz/ayY
         vh1Tr4ZwO3N3Dehap2p4KOLXb1b1CDTR+ntRG9x/KWppC3iEyjw7HCdFkfwsIgknRwFz
         rEX6la7CEZCdCBGRre7pJYMLfiPV0FIfLKcmx+jZ3QMfIEBIVSTW0UNSLjsuCPMeIJMo
         m4XQ==
X-Gm-Message-State: ACrzQf0IXJAi3nF/bIUVCFKjLIEgT5hqeJetuoBLwxAecCn5FRruiY0s
        ubMMCUQJvGSolcLFrPd75wy/1FjMxxt9uC1W
X-Google-Smtp-Source: AMsMyM6VaoNDvcmrVDIe4tMUSbd5RfO+/f0fCMO6zBNXkV2PkHkR+9UuQls626JwX/wFDNQqlkcbPQ==
X-Received: by 2002:a05:600c:1ca5:b0:3cf:550f:0 with SMTP id k37-20020a05600c1ca500b003cf550f0000mr13146286wms.23.1667321632754;
        Tue, 01 Nov 2022 09:53:52 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b003c6f1732f65sm9186716wmq.38.2022.11.01.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:53:52 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Tue,  1 Nov 2022 17:53:43 +0100
Message-Id: <20221101165344.3455723-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221101165344.3455723-1-Naresh.Solanki@9elements.com>
References: <20221101165344.3455723-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcello Sylvester Bauer <sylv@sylv.io>

The MAX597x is a hot swap controller with configurable fault protection.
It also has 10bit ADC for current & voltage measurements.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max5970.yaml b/Documentation/devicetree/bindings/mfd/max5970.yaml
new file mode 100644
index 000000000000..a0cc6a7543b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max5970.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max5970.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX5970 smart switch from Maxim Integrated.
+
+maintainers:
+  - Patrick Rudolph <patrick.rudolph@9elements.com>
+
+description: |
+  The smart switch provides no output regulation, but independent fault protection
+  and voltage and current sensing.
+  Programming is done through I2C bus.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
+    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max5970
+      - maxim,max5978
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  leds:
+    type: object
+    description:
+      Properties for single channel.
+
+    patternProperties:
+      "^led@[0-3]$":
+        $ref: /schemas/leds/common.yaml#
+        type: object
+
+    additionalProperties: true
+
+  vss1-supply:
+    description: Supply of the first channel.
+
+  "#io-channel-cells":
+    const: 1
+
+  regulators:
+    type: object
+    description:
+      Properties for single channel.
+
+    patternProperties:
+      "^(sw[0-1])$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+      shunt-resistor-micro-ohms:
+        description: |
+          The value of curent sense resistor in microohms.
+          Must be specified for each channel.
+
+    additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - regulators
+  - vss1-supply
+
+allOf:
+  - $ref: /schemas/regulator/regulator.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - maxim,max5970
+    then:
+      properties:
+        vss2-supply:
+          description: Supply of the second channel.
+
+        io-channels:
+          items:
+            - description: voltage first channel
+            - description: current first channel
+            - description: voltage second channel
+            - description: current second channel
+          description: |
+            Voltage and current for first and second channel.
+      required:
+        - vss2-supply
+
+    else:
+      properties:
+        io-channels:
+          items:
+            - description: voltage first channel
+            - description: current first channel
+          description: |
+            Voltage and current for first channel.
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                led@0 {
+                        reg = <0>;
+                        label = "led0";
+                        default-state = "on";
+                };
+                led@1 {
+                        reg = <1>;
+                        label = "led1";
+                        default-state = "on";
+                };
+            };
+            regulator@3a {
+                    reg = <0x3a>;
+                    vss1-supply = <&p3v3>;
+                    compatible = "maxim,max5978";
+
+                    regulators {
+                            sw0_ref_0: SW0 {
+                                   regulator-compatible = "SW0";
+                                   shunt-resistor-micro-ohms = <12000>;
+                            };
+                    };
+            };
+    };
+
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulator@3a {
+                    reg = <0x3a>;
+                    vss1-supply = <&p3v3>;
+                    vss2-supply = <&p5v>;
+                    compatible = "maxim,max5970";
+
+                    regulators {
+                            sw0_ref_1: SW0 {
+                                   regulator-compatible = "SW0";
+                                   shunt-resistor-micro-ohms = <12000>;
+                            };
+                            sw1_ref_1: SW1 {
+                                   regulator-compatible = "SW1";
+                                   shunt-resistor-micro-ohms = <10000>;
+                            };
+                    };
+            };
+    };
+...
-- 
2.37.3

