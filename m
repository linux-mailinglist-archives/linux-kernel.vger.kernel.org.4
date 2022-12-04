Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A8641CA5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLDLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLDLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:36:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A5167F6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:36:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so10063809lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQnmM+tbwGp1xjm6EZSQWhKQr6qx3wPe7/rpEovRxCE=;
        b=iHSWCfoM2DsUGan2y+UsdRNgZYt9qnt1mCs/08M91Nr2hm/gsydZ26zVvLXnUs5zE2
         02s98zcI86ueIErQqw+GggAK1BG2cfexSJbwRmaLN0Ctddu1pzgZKhFrCTi105+DNjlV
         20NCT54gJM+NEeD9RYLKHBcL2BmzW+jlEIu4gQnCDC/nBILxCNxBHC1KKGJoF0W9DSdm
         RUBUOXnt91SBnd5qJCOr5I5nOEePAZPhZk9p474cPOm8QHBJ1y7Hqj3k0yaPZITL9J1n
         10jyDocD1Kc4N9Pqj80eovu3TcGqEaSL1W1cd+jg0GYKekKX8vhoR94e8EpN5+WNGPMX
         3iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQnmM+tbwGp1xjm6EZSQWhKQr6qx3wPe7/rpEovRxCE=;
        b=ajJwyRTHJEh38wnn6gc4gmf3VAtogY44LYu3ALyIfgj2wkpW2TipLwYmUB4KSXQOfo
         jhF66MsBSLJQHZJBSd8AhK+kGevFQUszhGgTQ3AOLGWp+Au3ULYbpYwKLBAoYSMQ/6Z/
         rX88vWakmX6CNfhZjni6aN9ScrD0a5v1jDmSEmzlwHImeX3XcXBoxxZmleVAt2Ov2Jok
         XAyts8fzKOYZ+5rdClQpJzlaLcNu0SdM2bVzzYaOezhYYE6URzIScewCU9GbrTTfQVP1
         izXu9eVGGRnfMAngOkBwr4MsWEUBFujHE+jql0b5Bhz9qunCcBmX2WfpES9YKSfKCIFF
         Litw==
X-Gm-Message-State: ANoB5plyn/JKQU35LX5xljtQIA/oMa4NuKXxDMpGwC4OAN26kjJaLsZf
        kM/k+Ns7npbHgiDlBO8JXSsYUQ==
X-Google-Smtp-Source: AA0mqf6gsHCWXt2fpz1ejjG10S9Wwiec/P26LeDcw2/HmjdfxG25h/zsFmoJ4CfF2sEUUwZ4bn4irQ==
X-Received: by 2002:a05:6512:2a97:b0:4a2:5522:d37c with SMTP id dt23-20020a0565122a9700b004a25522d37cmr25307066lfb.662.1670153783740;
        Sun, 04 Dec 2022 03:36:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k19-20020a2eb753000000b002778a9b0c34sm1097107ljo.45.2022.12.04.03.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 03:36:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: maxim,max98504: Convert to DT schema
Date:   Sun,  4 Dec 2022 12:36:21 +0100
Message-Id: <20221204113621.151303-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Maxim Integrated MAX98504 amplifier bindings to DT schema.
Few properties are made optional:
1. interrupts: current Linux driver implementation does not use them,
2. supplies: on some boards these might be wired to battery, for which
   no regulator is provided.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/max98504.txt    | 44 ----------
 .../bindings/sound/maxim,max98504.yaml        | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max98504.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98504.yaml

diff --git a/Documentation/devicetree/bindings/sound/max98504.txt b/Documentation/devicetree/bindings/sound/max98504.txt
deleted file mode 100644
index 583ed5fdfb28..000000000000
--- a/Documentation/devicetree/bindings/sound/max98504.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Maxim MAX98504 class D mono speaker amplifier
-
-This device supports I2C control interface and an IRQ output signal. It features
-a PCM and PDM digital audio interface (DAI) and a differential analog input.
-
-Required properties:
-
- - compatible : "maxim,max98504"
- - reg : should contain the I2C slave device address
- - DVDD-supply, DIOVDD-supply, PVDD-supply: power supplies for the device,
-   as covered in ../regulator/regulator.txt
- - interrupts : should specify the interrupt line the device is connected to,
-   as described in ../interrupt-controller/interrupts.txt
-
-Optional properties:
-
- - maxim,brownout-threshold - the PVDD brownout threshold, the value must be
-   from 0, 1...21 range, corresponding to 2.6V, 2.65V...3.65V voltage range
- - maxim,brownout-attenuation - the brownout attenuation to the speaker gain
-   applied during the "attack hold" and "timed hold" phase, the value must be
-   from 0...6 (dB) range
- - maxim,brownout-attack-hold-ms - the brownout attack hold phase time in ms,
-   0...255 (VBATBROWN_ATTK_HOLD, register 0x0018)
- - maxim,brownout-timed-hold-ms - the brownout timed hold phase time in ms,
-   0...255 (VBATBROWN_TIME_HOLD, register 0x0019)
- - maxim,brownout-release-rate-ms - the brownout release phase step time in ms,
-   0...255 (VBATBROWN_RELEASE, register 0x001A)
-
-The default value when the above properties are not specified is 0,
-the maxim,brownout-threshold property must be specified to actually enable
-the PVDD brownout protection.
-
-Example:
-
- max98504@31 {
-	compatible = "maxim,max98504";
-	reg = <0x31>;
-	interrupt-parent = <&gpio_bank_0>;
-	interrupts = <2 0>;
-
-	DVDD-supply = <&regulator>;
-	DIOVDD-supply = <&regulator>;
-	PVDD-supply = <&regulator>;
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98504.yaml b/Documentation/devicetree/bindings/sound/maxim,max98504.yaml
new file mode 100644
index 000000000000..23f19a9d2c06
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98504.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98504.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98504 class D mono speaker amplifier
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Maxim Integrated MAX98504 speaker amplifier supports I2C control interface
+  with an IRQ output signal, PCM and PDM digital audio interface (DAI) and a
+  differential analog input.
+
+properties:
+  compatible:
+    const: maxim,max98504
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  DIOVDD-supply: true
+  DVDD-supply: true
+  PVDD-supply: true
+
+  maxim,brownout-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 21
+    default: 0
+    description:
+      PVDD brownout threshold, where values correspond to 2.6V, 2.65V...3.65V
+      voltage range.  Property also enables the PVDD brownout protection.
+
+  maxim,brownout-attenuation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 6
+    default: 0
+    description:
+      Brownout attenuation to the speaker gain applied during the "attack hold"
+      and "timed hold" phase, the value must be from 0...6 (dB) range.
+
+  maxim,brownout-attack-hold-ms:
+    maximum: 255
+    default: 0
+    description:
+      Brownout attack hold phase time in ms, VBATBROWN_ATTK_HOLD, register 0x0018.
+
+  maxim,brownout-timed-hold-ms:
+    maximum: 255
+    default: 0
+    description:
+      Brownout timed hold phase time in ms, VBATBROWN_TIME_HOLD, register 0x0019.
+
+  maxim,brownout-release-rate-ms:
+    maximum: 255
+    default: 0
+    description:
+      Brownout release phase step time in ms, VBATBROWN_RELEASE, register 0x001A.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        amplifier@31 {
+            compatible = "maxim,max98504";
+            reg = <0x31>;
+
+            DIOVDD-supply = <&ldo3_reg>;
+            DVDD-supply = <&ldo3_reg>;
+        };
+    };
-- 
2.34.1

