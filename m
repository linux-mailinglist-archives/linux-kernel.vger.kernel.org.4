Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC111701D72
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjENMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjENMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:37:34 -0400
Received: from sonic306-19.consmr.mail.ir2.yahoo.com (sonic306-19.consmr.mail.ir2.yahoo.com [77.238.176.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C42D48
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067850; bh=qFvY2JFOmSq4Z+lRw0WQgKuCvuPeqtQx/L9EsUd7oWo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ap94I2PWKPqMd9rRCgQ8jVmOa+eE2265+ka0nXYHgJM73TYfm5DR5dkh6AE+bsYv3sTcLfZ1ZtKMtSwztvm8sQYUX8FNJm6FEwo16h3bB2LpIrkhjPCw9cg7p6PUD2UQ0GBnKvIdxlSeTJyOKN+Orum1yJrOF8wpKryUEJ8kjvDI40JYAIvnRESXQLrMIYQYPhJaafO4ynlkV4Hj6Mp8PSXp74hYpEvk9Ubvil6W6oZGLxExWR14aMaCnqWGhnawL33P3XeW/EsigKEQj/O0UHsyLtfU9CTxyEKoBYk0hEy+8vd0DfTMFr9P3t+Cr8dXbd8Z+0o2Gma/+liar7dENg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067850; bh=LogvbTdi4dn1Hdfv+qy/CLbOlrMg659kLM33wQPo/Ky=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RGqKNsM/xGfSTo3znIbKNJLpHqvzylIX0mJUwcXGWbCO7sl3qhscCkQSNItKx2m/Ou6ZeC8qftu/fFBQmt/Sauf2apYohXnN6n0U09Diuj2X/fLjJlLesXFx2gCVswsYHScEMz5xgRfOoLRR0vbSna30vxetH55bQKbq4dRecQSQ1PjUWAgGUmLFlxKeC2WtYBG48H+CvjB2FufBhjLxrZcqGKM2tpqX1ziqrb9ukfKlQiHcnwZ7h1UYCGODgL9372CfEOhY7Ld9EMKyz+1AGHMT/1WLbizt5X+32304ENC8C8Zz474XfSr0qW/tUsIvbp3ktYkl/gakrEIKromt9Q==
X-YMail-OSG: 1Eq9dX8VM1lMjqoBxexnhjTMJ_365F20O2C_zEsUDlR9k4jm70nypMrSHut64Ei
 Ubm1ajRrR.olfUCgpqjZW0H1FDnyKR39lVl.9WKPRtFJ7aqBVySb7Czbmv6LPgloPZEnZCTrrOMz
 BRqn_d4gT5rok.fuxiq5KCcq_fkuITKn9ociAHn1_g_vaur0cyZEfsIWA5HAYl59b9NG78tHqFjd
 EDEwsmH04XGjVvIsVRrkmoqLki1_cW2zOtaM8GZ63SMMo6xtzW0oK.PL98eGSV.0BmIXlRY.flLl
 Oz2GTnRa3NDIXQ0aEOmJHOO6_h9mnNV49H1bik1PSK54S1WNDqaDTXWVuuru9nfc4PELZPUsHUAe
 X5NPDdeHB7Nq2AN3.vT2T0swBLNFxNI7GVa4JSr2MamtqxgtU.7Woe5FH6_YpG3G.okZ8w2zKe4.
 OL23cp.kvU4BON.DNKC9cbLzbxUmziXHTapR8l4h7iMBoKmGv8SpnuxjVRigl3yqFneSEDFWtFh0
 hr8rzzqW3KTVOK19fNUw3Xjb1OGVVki81.3OvP1rZZUgbtE6GPuAbcbdSpLhWtmE8UO3CKnjSEG8
 CibCmwje3SQupoVsvFYD3meAZHkBLGdfWcio.FkjwshZ77c3XzglmXmMUouid3jSFpJPGbxMRs7Y
 CfWUTiDcXDMbW5Z1ImT9MJb_N4lGctYHVSMqUO8ScwvGK4K8dqSQAdC1dCqSdZNa1DMHf4iGGZUV
 FIG7Au_GhD2QUB6LTaNX95SRmVXIpL6wb5dIevu0w5zacXQwI.LGHlqPwRJe2IEp4S9qVTD6TUBe
 1502ms7RxLP8MTzzK.4Ava10X6q5EIT0wi_SNLkGGoUV0fLg2nGorkmrX3sadWKi_HpXYq.e4mhf
 SaUCSGLAPNwnu5GC4cUP6un013Rf1yrCAQwLwoZwlgGqTDmdH8gN9bCmuWokQ7mszsU0eNZwKoQD
 13wPxAQHSGqHlASW0OPzaJ9lr4VAhdnNTG3lLibXB0y0X2HXAMI3USYZnQe_DXc7.nD5Xp1dTQ.9
 qd_oY1AOIAtcLsQvoYCRAzWCuW4zaWUiKIklBrs.sS987H5whQQSa1d6DaQPcKs9KNLBQC3.58jG
 8WYRB1mU9ILG9RG3XF1s1IAwnS.BodVCgX_Ji.ovou.INZLh5vD6367zFstXx1JyN32fu3JsuMpJ
 keloWvXLvkU0ErdwnJAntpfTE2azJENcybeoc2rUnpT6lL3.6Hvi0wZO3MkwHYWCpueel3k.ee7b
 cAVq3QSdpK49BKGM_FCqvVkPaDvP8qGIyIL6UAUfBAdASslq4d2_bxzZVT0Z9cBN.iXCv_ky_nrG
 ZS6ab782KxZW7aYzjutuT_ZvPPTSTrFE16BOgFrWVGGsMjiI8b8JyGu0K.2YaOCmu_5AHcBSW_lt
 bCzZPmFojrv4Vjwy95xh13GJkc.pP2RvNfagLgY4bBZkEBqvudbvy19_d6m64AqYjv4IiTANWm2K
 qsTGmLrmQUkPBPP9cwmd51oygCVesV6TLwtwGbbXSpFRhQHnQk6PPCAjADAk2tQys_EegcXhimr3
 OyR1GwbfCgC2d5Mb9TyN5nWqm3AGIXWz4z._Hf_CSv1y6WNxBxRQBn8Sl.lF1I.yWpxanKGnj9GZ
 OJLCfgdLboEWn.pCNAOStcD8HgSejV9wDwafV2O1WbGSGTzfJ9EzQdXB_RP_k3YboOgTtIIRW9x_
 GccPoj6Al.mHzR13L5hQ9unWod5Gp_8QuqXrqlp1i_..bjeRkMBfu9ZmRbR1t0PugRf6pIREWTn1
 szY0i_dhVnd0nBuExQKgdcqwz1PRw9pPu1qRQaFYTVncPxtk5zBcnlCX8T7Bf6i1R7YK5xl.FRRm
 pPEgl9s5Jc5m5mNYM00IVp5BeRMYRKuQI9fUc6YKWOZtsfyO7QiAwsa.TA.ARahdeSVIXHixJlZI
 W4teFDZr5wNv4EO8GyF_XjBdMZTTQO3KqidKAXmFlXrHyeND3dzCrIrhr5kXGqpcjzXW9FCC26VS
 eBA6LepTNHGW8qk819LS5Zk1nQ2ONeNh.ZVhLJx7KnKK1mlSXSsqaqqKUbgB_ajBP8ro7ROxwa_U
 RYDV0iYGbcaA_JYJaPbE3pjocJ2xWSI4Q7LNYgFdBQIoTiEfPLJeThTp8t8Ay6kc8hbl8SOzhhn2
 CbadxJs8kpVgOxf4wT10A0CuOS_853le7ZDariIN2._QILCCHLJju1ZEbyQ9wbhcltHyd4zbxjcU
 tUeHoXaTuvAizmP0.wvb0XWyWNFOx1c4UU1tv0Cp2IcFcWn0NT2o5moektmbnKpNIsV0SVWujp_y
 Z1RSnIxMiiAEUU36dUJ6ibWYxXu_n5V4-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 810f99fe-6e5b-402e-9bbc-38b58df947d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:37:30 +0000
Received: by hermes--production-ir2-7867f454fc-tvsct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec262f708c8ca7d1990bed607fb68ca2;
          Sun, 14 May 2023 12:37:26 +0000 (UTC)
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 10/10] dt-bindings: Add rt5033 mfd, regulator and charger
Date:   Sun, 14 May 2023 14:31:30 +0200
Message-Id: <20230514123130.41172-11-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
The patch is based on torvalds/linux v6.4-rc1.

The drivers for rt5033 (mfd) and rt5033-regulator are existing. Whereas the
the driver rt5033-charger is new in this patchset.

Changes in v5:
 - In file "richtek,rt5033-charger.yaml" fixed typo on "PMIC" in the title.
 - In the charger file changed the general "connector" property into
   vendor-specific "richtek,usb-connector".
 - In the charger file added $ref to phandle for "monitored-battery" and
   "richtek,usb-connector".
 - In charger file removed line "maxItems: 1" from property
   "richtek,usb-connector" because dt_binding_check complained about it.
 - In the mfd example added the "power-supplies" connection between fuel-gauge
   and charger. As the example fuel-gauge contains compatible
   "richtek,rt5033-battery", dt_binding_check was rather picky to implement
   that node completely.

 .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++++++++++++++++
 .../power/supply/richtek,rt5033-charger.yaml  |  65 +++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
new file mode 100644
index 000000000000..386b1a50158a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
@@ -0,0 +1,138 @@
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
+        i2c@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0>;
+
+            fuel-gauge@35 {
+                compatible = "richtek,rt5033-battery";
+                reg = <0x35>;
+
+                interrupt-parent = <&msmgpio>;
+                interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&fg_alert_default>;
+
+                power-supplies = <&rt5033_charger>;
+            };
+        };
+
+        i2c@1 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <1>;
+
+            pmic@34 {
+                compatible = "richtek,rt5033";
+                reg = <0x34>;
+
+                interrupt-parent = <&msmgpio>;
+                interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&pmic_int_default>;
+
+                regulators {
+                    safe_ldo_reg: SAFE_LDO {
+                        regulator-name = "SAFE_LDO";
+                        regulator-min-microvolt = <4900000>;
+                        regulator-max-microvolt = <4900000>;
+                        regulator-always-on;
+                    };
+                    ldo_reg: LDO {
+                        regulator-name = "LDO";
+                        regulator-min-microvolt = <2800000>;
+                        regulator-max-microvolt = <2800000>;
+                    };
+                    buck_reg: BUCK {
+                        regulator-name = "BUCK";
+                        regulator-min-microvolt = <1200000>;
+                        regulator-max-microvolt = <1200000>;
+                    };
+                };
+
+                rt5033_charger: charger {
+                    compatible = "richtek,rt5033-charger";
+                    monitored-battery = <&battery>;
+                    richtek,usb-connector = <&usb_con>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
new file mode 100644
index 000000000000..5b3edd79a523
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 PMIC Battery Charger
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
+    $ref: /schemas/types.yaml#/definitions/phandle
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
+  richtek,usb-connector:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a USB connector according to usb-connector.yaml. The connector
+      should be a child of the extcon device.
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
+        richtek,usb-connector = <&usb_con>;
+    };
-- 
2.39.2

