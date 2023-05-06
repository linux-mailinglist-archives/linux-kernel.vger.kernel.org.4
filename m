Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4766F92FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjEFQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjEFQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:00:36 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637B11730
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388833; bh=4LMqYZtP+QyD3CI40Mhxt6doctZbhjuQfVAYaRh8YSA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=C9uVHPQ5dvu2iy6ic9Q1t9UUfl2Rl1lJv9i7ETLKMi4VR4LHCZ98Wj7WlvJy1RyG55YsTH3iW1QERd8fKpI06FNecBcOAk7j+kSu2czKpgOdZDRVhnqwaaOTq0dfQv0eZ3GKfQJ6pvCIR7CnNiH/6RtxLWd4VVWeV6vMi2836uzOwLvRtajARhIvROn8bVWFePG8P5xIxCOPYl9O9VoTe4TSL4HCLCvLr+MY7mc7dAQaGap5Som/0WjmS4n2fjEXU3LipQ8gSCuvDQuDW6aHXruhBHRkUYvZiyZQ7fQWyE6Z4oVMH4Ul6w3yM2qxuiyIDLS3V00S52CJYeYUODKaeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388833; bh=MGXJBtvr6gIr2dGZ22bZry0n7exM2DGEh5gwNvRc5sv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NyWgbAW0jz7T1hgvSww6fEa/F1yJAT0svSYJZd8vR9RSdgdyxIbbOOD2c0t1cRGZceXSRt9BnxpPrUmkYVDdcxsz7v5Q8KS7ReDC5H0XU1FWTIseMppSoxUmpqyVu1YzGuECWKLrfVrPmvcUkByeA0wjGSLybSMW4qflXQroV/Gmo62ZXyxWa0yOEp6PWFdxMlMsvLCwdfdm8svDw4aJh+Ruvu4gQtS9qI06WbrOojYoTbnPSmkVkxzp0Z0pHvFTpd25gvaZuq6c2rxsxDpf5xbdPF+K/r9kIEtFNHZ31xQGCfd+q0NJc3mnTvDOv5Jhsl6xprF+UefHC8MgViBRWw==
X-YMail-OSG: wdf.wKwVM1m9KfmYTyboBzX6sjnz174.tzHGmgkS8IZXFUre_P5QayrsulTzZyP
 VA0LgB4cEwpWPJrP0ylfm4LLfy.asrghuAdCAUVUQeshM.aJHzmrdQzyAvSKgPr5ZsTTRZMXUtQI
 eC34mgPbCZ173VLakKARQPdvMuhafAb680UPJ0btYXmozTY_ATknQX0mTd7VFcUri9FMefeTQQsk
 FcO1lljnzez18K9c5jp5jXRSTJcbZ8i2bxx0KsdYGpQfrrh38LR7Iazwk3kbwNoDncZ_S5FfKFdL
 zkE2ET8IUVnNuxSLMhblOpZJR4ugAP.YK_ms3N8cRcDnJYYzqJvBuwhZ09VWtfPPZAyrcOfGyylf
 02U99csIYFtH4XgzPh.NkHM.lqYBVi.Nw6cRfl7_iqFApujYyjnDFksLJDIo1T17_NL2POg1rIJ3
 S67KKIAbvU3q9Sn52USakVhAd8jmylBsauoiV5GmAgFcTL7pMzdlnyt626BAwBoTD2bwpYTbb2wb
 AK_ho79SmtR5eKKa9plyWzRK6K51hgp1GHPgBHa3Oz1x0M_OlBrdFO560EHgVks4aTG5Xh3OBeJ7
 Ifua6dju0GoxwUVows7GRSpcLwQw7vFjCpgvXlKl6z.fBBeKGdnSGOljkzyPsKpQkuKe0tAWbFKC
 p8OkqZssMVCu6_1IEQh09UfI_u2dONIhtd6564InsNfrILtI8a5fBw55SxslNi3u4DMO1lSzBCZf
 .RJvzT6pfHRUwj5il_71W66pR_J1omcIv1LLlyxadyj8LY8yiFmGtASR20QODw6P4JWn7jais_Im
 Bh.u0.BvyY1G7xJPRn5vnI7qNG4MePrm77ysvACXUbU2tqdmufl_30xZ3zbXJHe7sD367hxDWAAT
 JKMHMRiQFkiu_0lrxk3_XQYXQxPMWdTVLwmkFWR.EpUseC.vEyTbnQmm8iECK7fBmeCfFaK.jjnQ
 36yIFcCZCU6YNLVAkAy9c.SHRXFzLyYgciGWOVS5t3akaTrPFv47VT8GexROT.pSBG1SuW2mAZzK
 FwWtEEeBHSFgI7JIzqWiyhdvCdoiNgRIj6rPjD.hfe_zperg0KjITKxrC9K.ndYRtXFrpJsU3haz
 99wi4M.HefHhsMzWa5f3h5ZbRZvVYseHELyDR1M0Cm5l3EbmKe5GaUt4BacKYjYpWyZXhbn2stru
 wug_mFYnEXM_eWiu7vh4N6xf6mkQBQATnKQLIkvpR6_14o_.0z1V8t9ij_8cAOiOQzkU_rDMs5nh
 .Czb2xdp9PlzHNODv62inSHPbvnKEa6T.0YTUGPD56rwfmTpxNxxqv7qn6T53owzpeL4lKzZzZnr
 xTWkfSNb7YFW5a5NYNg.zUj1M0JoPNJ9m9NcCgRWui5H258dLNMIK4Wmywr0v2QCXwd.WLsDsd6W
 KkO4pKIN3Z55ebUex2vbVWp9k4eUbkDLyeDh1Un84U00r1tMoO9HBjL6Xd4VoRKq1VZydE7i9Dys
 SeoTqpLd8oeQvblc4xrZuRDJBK8R85PsAZkAEvv.8c3roC8YU7L3a1kH7mFFzaF_MXERAxG727PX
 kQKXbw8I96AS5MNdrB0JHZhiGf1d1EKWGhIOIQm6XRkSqnCh_dXq30wUajch4wcLVtVc1kkQjO_H
 Q6Fp7HBT9yadz3PDNdZNJGVmdvXoSXbsIc9YTxrZW7Q4OoQ7E4b2HxkfDTTJN3hSIEVp9G.JXJL.
 n7kqsjRwInAdKZeeWHTkAsGC_mgU.eTAXQUh_ekcElb.a08lbRoCF.VqgB1bo9CZIwkBPIWBJF8Z
 CFp7AHxcTmJQSHQTSdaCq5IPq7VLUpqF71.r9LK3ou7fq79Ci9YpZ_jPucCx5.Tn6a_7A4GuTi2z
 j2ygcpzRRh6Q7V6lSzf6CGXochFutv3VW5.wOPaTU4QpNdgfcfAZuV.KXZde6bBcs4sxhU38yMNC
 jeawxxqcDFw.qq3gfOkHRhCDtz9Wgr.XDCbVo7EFn3p4QimYlVvtrW23xHxjipm8PwHYevLCnMFI
 jdlp9vfEUJFLxTSpL9k.7UUNQA8HvBCo165fM4mUxhFFWoi7UQRt.B.5s7FYNVfLXc9oRySzMppI
 i7gRW6nirXiSDiyWkQWP_B_UP7nphdg1nnG0NXKnazTwnTtz920qIOWqoxNvAVfrSKs4i.gL0xh.
 TH2NJClUumbt_sxUgUnbihVcWoDWIQ1grPNhA8hx5vvsWA0VM654.7Gq29eOg5lofOIXOqonUiit
 _qox6IYtO4l9h5VNnXalB.VUKXRt9zGGueK6QKTBkvHGktNHomzl0E_izx7cRySK2uWZcLqb3m30
 zOPXi.N1WqyLGWGfvH2dWhdX.0kqkAUw-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8c8d0f8f-be25-4607-9a27-b36008a88978
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 16:00:33 +0000
Received: by hermes--production-ir2-74cd8fc864-j696l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b71ff572232817f95ac730737b6b2406;
          Sat, 06 May 2023 16:00:32 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Date:   Sat,  6 May 2023 17:54:35 +0200
Message-Id: <20230506155435.3005-9-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506155435.3005-1-jahau@rocketmail.com>
References: <20230506155435.3005-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for rt5033 multifunction device, voltage
regulator and battery charger.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
The patch is based on next-20230505.

The drivers for rt5033 (mfd) and rt5033-regulator are existing. Whereas the
the driver rt5033-charger is new in this patchset.

 .../bindings/mfd/richtek,rt5033.yaml          | 113 ++++++++++++++++++
 .../power/supply/richtek,rt5033-charger.yaml  |  64 ++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
new file mode 100644
index 000000000000..0aa0a556b50f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/richtek,rt5033.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 Power Management Integrated Circuit
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+description:
+  RT5033 is a multifunction device which includes battery charger, fuel gauge,
+  flash LED current source, LDO and synchronous Buck converter for portable
+  applications. It is interfaced to host controller using I2C interface. The
+  battery fuel gauge uses a separate I2C bus.
+
+properties:
+  compatible:
+    const: richtek,rt5033
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    description:
+      The regulators of RT5033 have to be instantiated under a sub-node named
+      "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
+      voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges
+      from 1.0 V to 3.0 V in 0.1 V steps.
+    type: object
+    patternProperties:
+      "^(SAFE_LDO|LDO|BUCK)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+    additionalProperties: false
+
+  charger:
+    type: object
+    $ref: /schemas/power/supply/richtek,rt5033-charger.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    battery: battery {
+        compatible = "simple-battery";
+        precharge-current-microamp = <450000>;
+        constant-charge-current-max-microamp = <1000000>;
+        charge-term-current-microamp = <150000>;
+        precharge-upper-limit-microvolt = <3500000>;
+        constant-charge-voltage-max-microvolt = <4350000>;
+    };
+
+    extcon {
+        usb_con: connector {
+            compatible = "usb-b-connector";
+            label = "micro-USB";
+            type = "micro";
+        };
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@34 {
+            compatible = "richtek,rt5033";
+            reg = <0x34>;
+
+            interrupt-parent = <&msmgpio>;
+            interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pmic_int_default>;
+
+            regulators {
+                safe_ldo_reg: SAFE_LDO {
+                    regulator-name = "SAFE_LDO";
+                    regulator-min-microvolt = <4900000>;
+                    regulator-max-microvolt = <4900000>;
+                    regulator-always-on;
+                };
+                ldo_reg: LDO {
+                    regulator-name = "LDO";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+                buck_reg: BUCK {
+                    regulator-name = "BUCK";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+            };
+
+            charger {
+                compatible = "richtek,rt5033-charger";
+                monitored-battery = <&battery>;
+                connector = <&usb_con>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
new file mode 100644
index 000000000000..b8607cc6ec63
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 PIMC Battery Charger
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+description:
+  The battery charger of the multifunction device RT5033 has to be instantiated
+  under sub-node named "charger" using the following format.
+
+properties:
+  compatible:
+    const: richtek,rt5033-charger
+
+  monitored-battery:
+    description: |
+      Phandle to the monitored battery according to battery.yaml. The battery
+      node needs to contain five parameters.
+
+      precharge-current-microamp:
+      Current of pre-charge mode. The pre-charge current levels are 350 mA
+      to 650 mA programmed by I2C per 100 mA.
+
+      constant-charge-current-max-microamp:
+      Current of fast-charge mode. The fast-charge current levels are 700 mA
+      to 2000 mA programmed by I2C per 100 mA.
+
+      charge-term-current-microamp:
+      This property is end of charge current. Its level ranges from 150 mA
+      to 600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and
+      600 mA in 100 mA steps.
+
+      precharge-upper-limit-microvolt:
+      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
+      threshold voltage, the charger is in pre-charge mode with pre-charge
+      current. Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
+
+      constant-charge-voltage-max-microvolt:
+      Battery regulation voltage of constant voltage mode. This voltage levels
+      from 3.65 V to 4.4 V by I2C per 0.025 V.
+
+  connector:
+    description:
+      Phandle to a USB connector according to usb-connector.yaml. The connector
+      should be a child of the extcon device.
+    maxItems: 1
+
+required:
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    charger {
+        compatible = "richtek,rt5033-charger";
+        monitored-battery = <&battery>;
+        connector = <&usb_con>;
+    };
-- 
2.39.2

