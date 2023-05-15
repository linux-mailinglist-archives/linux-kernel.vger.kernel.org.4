Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C12703F44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245489AbjEOVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbjEOVD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:03:27 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36449F9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184594; bh=PH47Hq7/S8NqOww8hP8w5e2nE3GA6cTmgI+LCsNt/lw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gaYhHgZewwvZzgRVZmG6ah7CbOtrrE4yKaMdtiiTRu0sJrvEdlrCWhhN/wPbOcX+m9FutbJqXiKgnpzyd5ac4xYfo1IVDy/FxxSPZ0lejSbRPKFfPXMaVvKPi6mviQyk/H2ojOdqPUl9UuTT95GUaHZyQ3yCL3ortBj99a4KyWwXfWKcupAUg16qAUYjh1v6o/MDx4C0SM9dLDFN9aAkyU1HS5Y3jJzHebQo9ABlDlOnl00Ef9/9KbMt6Y2sB2M58DrrWvIm+t0zZU/qMOViZJN95oyR3te1Bvi+GU5wYVFGKYP5POTALXtImAURrjgvrcIioQCTlmChjJ8bxxD1DQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184594; bh=ZqNf2Qd99hqG+4m9Oa4vl6eoWqc0i3F+8RiikTygapZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qL9rJUPoAEG8YyuTfJpDhFaqpAd+GLN7FEfrWwGkT6ZE7i/naPsFUVIYFRl1vrT2MVlWqqnplzo6lQD/cydQ62NdTVtEaMj4jDCVq+RfDpCc+d7n9IMiP38MNpx6roy34IRWk5CCCajYXne0OSL2BIIAMo36sz+YzqeePBSXVx8NZ3F87a7wqXTbC1shC8as3m3kRxSRkhqV2fFEYLpUiljZvHcZY9fMPmuF+CXbiIfMdmTbD671PQniQnBzXfvE9HrGULWt1IiTtHWNa8ApgWZnb67OwrGuxewel6henkTv+K/CpwcYEm4z6iQ1nbAuw4rmSf5ArSv907+zsbCZug==
X-YMail-OSG: _TpOHKgVM1njRylNcAHw.MH4sAfQ0vpJs2obRqlyXbd_EromBB0r32rMxPQcHqk
 nY9l6cWsOaZm2gSGKPO3xs8EmOcbvl4nr.yMQ4Y7Vee0jFwAGyzjdeLRRNyOJG2RN2jZM5VWJTSV
 NCWyra6OKHD_Vb4RdmzaaK2nRug.mm3ee8M9TtIkTdLbxerIJUgIwZOLdANf1r.cxmU6zjd7wyFY
 NJ07d9ebV0yFZ.8Td7cyRTcUruC545sooZeAe0OUE9sAmCateXoPhyYv9DsxgdeZdPvLeRXS3r0_
 jln31zoAUWVXA5Q0ZSQkj.4wvokw66rciN6s36tEsi6d9f2l6_HTFwOTfKLsqWWLXP7ym98aBDu2
 9zab_IbPYFXs7Vi50i5aBWdbemAVmyGpnGAqj551rVVHWcPHmteNubJ_LLSEVYRNAybVx2u8cAHD
 9cmQnRUNJY2FiX70HnXER5Xhl8RddhEOex3vAQi8tnZHb6snYUWnSkfP9g.nwDftbsbwyE3hljeE
 y23YIAXn.GlDG7dDv.QNKhBKn.YGcmgCvkKXgDbJ.nhIiSmxytWleK4P01YJSwIwEypMqcFb84du
 c3B6qC3ZKdJ_F.LHMxktrK99ReXEy2f.xNmJUO9yKonpTcQvXGrwKzaeTFVY3ynf4rOX3XgixbhW
 ohz3U_7fXos9PU0Fx75gzDDT.Fs7lBdWWHaTBWYAfSF0cbprHExToVya11YjvTe2zXnCzxC.ndtC
 sYTYGkkXHIeRY0uFYqo.ReeyVmRRARDl0Ql.iXrXZZbGYF1E0Vg0nkvj2TWeXqoka9C36Hyt6iE2
 aai8Zz1uc1w6gYhud4MDZ5epBdS1xV848lr.nAu.TB4_daP5a29DOlNsFHqz8bXFcnqW8VX3UfSo
 v1vmgJuRItp.QB4BvrlgV2xbZR1ac2cJovxm3CsYkUX8B6vWh2woglaN1QiYmTLsMo9vBqdS684Z
 O36G_8QzfAtv0nU4oJDJCwH4zm5S_wJCx0ydbkmqxxr3uI2QrEMyz2JTntsu8udAo7DWm7UYb.uQ
 TZ8gAPUhV6ggjz_V0FKYGOP4wCXLzckxT2dDIYMxClH_pWz3UnGlCWKjebVMUfSmiuw_LRM4YWdL
 y_DCOSPKGR_0WYQk6fk4PmYq9vzHOvW1Pcj04vYEf1pQVR9zCtFSbcgcEPKNLCDn2_TFFPPqeCjV
 YRDJO4iWBB4F4DFeg6aHmdFgPARbxCQwfrj2OiE04eWEmNmDzFcf2RORq89vTk.aD8lDghVwfk6B
 rxu.nFwVP2mheoYZO.1zNFO787i5OAHod4vllF9uoLJ89u4i_2JHYLeJzlC5r372IwtyO_zdxUPp
 gBvgHF6GTmahwsUYLvKjlVK15ErLsUtqjOn2HvCtlegGPtAnY7ztwWpTMXVTdkIUbB4Quydv_Q9C
 mAa0fDilNgDw644yX_J9eNbDI0Z5YDobcJwRKkMAvzQqS.X66bJFDjjMj1aa5I31m_1aDVBFGc9R
 FLBhSs0UYr35bRemxhhnWXRPDm5RhEap08ijDtIlgsY_d0_DJH.9kUavKDmyeGyphb5npUi89lvq
 pHPubLaEVASDnkCWtKPTXvg2A0T6WSu4ebh5eIRVPacvWYdRsW_gZ8Kcsbuh21XgAb9mk5wEoxX6
 tgKyX78cf1aEncQjv3YV29UCJcMSCQyySJG7O_dRd8xZWo1nQPDCMmYl9oE5BJ3FiK.Bb9sqtOZj
 7WGMxW6UHeWtC39Tv61hwW.2ghWgEvU6FtJTMz8A6CihCk5O6XbPpjUGKSKdGj0ExtTL_z4tubdv
 9xWysXxwYkMnff7oQUp4UCfgaqK2VAUJ.9dNiOdNpdAHsyH3PH5M8aPIGhyH60bIGJWb.YVkxncW
 9IvHSY3_AJrYC7igeRl2wu1Slo1iEM8MXkkg6jDO4FJuQlhC46ho1zwChEj1YGup5XwjvIWIOEWH
 30J4Q7uRmALnASPordRjUVYJFMePYLKILq.w8kAdi9d3gmMScfn3nLlxQs88nKAJGnW4xm.U5QQL
 c5FBPF0XaACMrQ0G7iaSh8nPu0A_CoZ3GqcHESAVMzcNnvPKNrCYNKSbpcB50kVvecn5z8oyAmpi
 wn7WZmSYBDQR52PPsSNqIgCo41laQ4gRW.JYAy2_XntFiR0vxm55EKigYQ2Td6HVYBqzjrE09CIv
 S7W4vJYVwbXnRTI.iGxI8W6d34LjWj0Ye1yUeRGIjcaWEwbe6a8IVepg8dRUpMluX5Yt3A6AnkXi
 s2WdoJoBWsmXmiAlcBfc4eiuU3_AtKZ7WG1v.1qHlFt68IgAGjAZ5AHYp3k9VK4vQwrorHg5rF3N
 akjaESNHfLS79HCXiotnvw_44JIHZ
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 305ac328-5515-4555-a85b-46dfebfea7ae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 21:03:14 +0000
Received: by hermes--production-ir2-7867f454fc-bgghb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8cd4b5b48eaefdf4c621d749d286a70;
          Mon, 15 May 2023 21:03:09 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 10/10 RESEND] dt-bindings: Add rt5033 mfd, regulator and charger
Date:   Mon, 15 May 2023 22:57:19 +0200
Message-Id: <bff139976865c2a489ab62333d78c4e3179a8eae.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
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

