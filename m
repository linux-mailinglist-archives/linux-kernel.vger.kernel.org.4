Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1D6A629B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjB1WjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjB1WjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:39:00 -0500
Received: from sonic305-35.consmr.mail.ir2.yahoo.com (sonic305-35.consmr.mail.ir2.yahoo.com [77.238.177.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407F2D14C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623936; bh=DEPjcIA3533VAWySuEI9s7PPZDzVB5wbr8s5WByqx1U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GLkQ1YmZofqOFSU4HHlCBhXXvjQuAOYRnV+HNOEcJudjl5DblCXek1CTsaOUewsYZ42HS6LMkg7oXk726KgzRAqwIOo7wCDWExN/Ys5mojRtdm3HcG1UVlgaNArK+kIJopf+8J/i3YuqSSaziBG3wX7TgcmXjeC0LAcIpvvCfchyBefazGRDSiSvFqnO9QkfLlY3iz5EFtQQAuqzfYf7j2L9oVJcKCr7DRVB1ip6MEnk+NTnr2wH/CWDcE6f60zSy9rzV8abywp+yJTfaMSbtRrz7DBbL76D23oHur01onHeEqbyfB6RPVTXEgKl+kd/dlwhjlMTNB9XHWz0U+f0pA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623936; bh=puQJA0gdVym2HfwHj5egYqRerFeCvP4PggIFAAKOIRc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UkFbdaxEulnv5TVXl0qmYdrNbmFKncHQZE9Y2d5rpRbc82gA5kckJDBCEnUc4iUDUPXohaH9zAzBzdKlUNuxt8zis9lpmSSfvHISm2GMzylWYz4GQCEpnhKWWOQAwzyszazX1MwlWujGK7EvAnqJKMNFlVOTavQ9mphd/3QgFiOSrVePVGeCdZPw0vCCSzLwiBhKRg21f5kgP+38ztmThaEtGuEpIll2aRxBaDRrdeExPYCBpdkMA2CeruScCtFsS20o4peMNi//Cqv3QY1sfbVwrAKBl92ZYnLXJA16NIpujUnSuEpHRbWzSIEKIF8unZAm0Lix8hOavzGsKv6+5g==
X-YMail-OSG: rktOehMVM1lApGO.db2VNB2jhLvPQpCZr5joCvujiq8YHDTbdtPtVrV7Nfwcib5
 XvlaAMF5EpLsV__fJEFsX05Yjm4sZW8q0QcBMoLlCKqw4RSdrpsqDIuvSS48MV.xqqPTo2w9WCpu
 IMpEJdxff.NMzLTbLzUBkXUQdeXckzjIcW5N.dMbJS4L7l8oI5WwxQY6UYoBjr7b_yk1GEDGhLEb
 TTf3b5RNxUq8SkAl7vwPMj_jtwDH6hA0oMbmmWjfAr0xtN96lwdGyxjqEQKGgKfU7NZMkofjeGdT
 00gx.0IojhExt9QpxY7LVTVGHV2Usm5sgVYceQ_dVBOIo2.7QtiuNRfYUsRtRMS5d3ywzSzd9syC
 puXF1SGhLp56ppjYjqZJA2RGXqV9IiOAvk_GOSHc7E8MaVGzdmBCUJ0aJL_NyM9prl5XD8GX_.yK
 ot1TX3IzOqL9SE27jfnkBhlwpI0F2wNWa6JQrIZbJk9UcafcYrO40cL71Ja805k1X2xQ7ByNPJnJ
 5E7yx3JoS4nigASS2zMbG80QalFvrGHsGS52Kw3t6nJniuGgPizz.9MclQq6oMqd7oZ.RAsSWYWI
 d9qqTnOM.D8W7Op3MrjsOovkMwGrIOKX29D3xZvtxJ3juG_cgkPo6cTkoW.7.ziiIrsdmaFqyWQg
 c3zuOq1G6dDp7SDkJE4GtH7OCxnFr_xK7NfnfrKFk0_KoxW.7tWMPW2cz0rlbqYEgBqgi7ZaiqLd
 O_9dWzRBM_zLNcZKJQ9IQqX7SnxdrohIOaL2D_n9gmjGOlSu_Dqzb_O7y9SyK58EEfY.0uzISY5v
 5nGzkJg5uX54ZxSxWa2FAewhIpkuC9C4wYbI0e8B9YBanhEdEv6DjA4x9ykzDzZmY0zt_tpvwYYD
 SgWrRRIKyw10yvUMygVNzbM17rjyXmPl63m0csG1qRVIIAycWU4_ZhoFGNGDZOA.4YqKI5Zoj2cB
 0JZ_SRpCXcukTPvqLJADud0li6nDo34KBXoUlyqHYKscgpb70Br96NBQp228aR8zjf4QbVdxWRsv
 wGROnEEfRksjxoUC7.ceoKYQjf0wAPYg3MoWrVzCEkuJrNdHmpA7hLDt7z_yCE6mUoFrWYEJ1U4p
 sqSNCi2beLBOvqKZshBQZcGli9hrChn4BGcSKIP3WQ4XNH9DN2dfGjiyMbVP7CrAaeye4Yqk8HN6
 Kq8NjoFhwF_yQ63B8vMTYOuCsiQJtCM66CcLuBM.rcSmKqcmjJFNqYvyNP1oisxxMMBzoTdecjAc
 eO4eyu6awpqadT_t4_CrecKNn4OwEpHbBEld5hzHjNERbgGRqqyfrqkM4zDnqwFbpRk0j3z9fJhU
 NmJmh4HoabjMdiFZCNBCY78V52dVlel1arctxg8NT2CTwZ3voggHvvhaaKK3COdZHdIjChMJo8gI
 qQXlNJU7s1ukcFOxGpMj1PvL0SYmQGCD.VJOX_LKmAkGAiNNmOCg.hLczF7RFuhBEiU7Qj8zVbZC
 3gWlXrEpC.wwdjlczZB77pT.j7EnadOzkrQrL3pGQBujlmZ_VCz_XfDBIPMlV9N_Df0cH.Hvhm3e
 FNCaX9oZLkMguTwooUV2auTk7F.3HVO9rrn5_w1yzQaRZ6oNNY6d8dm2qULsMTcBtFKxRV4p71hT
 YHuhmz_72zRi0JJL1RstxokT1OPZcYG2_x8G9E4xGwB0wtSHux_lQLMl25g76P3CmIHsQu9oPHtp
 Q3oJXj.WW2BOvWHok8eD6PiO5pjfTqa_M_b72IRde49GUAwNaNzVqaHM6qwnZP4V04a.k6h59x.J
 a_gXmWu3g.DJrMfd2UQzEF5fnRdugMobOwXC247Y_KlB2SvcK1Y_b3dMZZ7vBpMTc7Mrw93ZKXa7
 Oj20cX8a4TtO.AZyjzavL0D7A8h5eReq9BhObugJRcV2213OODqL1t8BNUYsFReKeNlfgTe_Qrri
 bCsChdyShy0bDq4_2o7Qr3yk9lS3f3KHbveCQ1SoDht0b66_ncKuCCOkJjuchvHzfuixie3Vz8hf
 iKHX7v20yV3sOM7yCIaGzUjpRs8bPdpFsxEYcccIgztCFkivQyY5VQkDGNtYKKGQM1emXIHC5Ka5
 NOREzSMQnIVEfqfaSgciRTcSGEHKKRxjXEAjQ5y4NeKkm7sQW_AiXtkmxivg7CF6VjFVSt1Ny4rV
 WDQYfUwk.hfquUU9sTx63A3FcdholkECDZ_ziXr8xJaI6kQDqlkRU4iDAII97YYfyAdqoOs_9tcw
 KG98KAUUbJTk8IrkaOngNUTrccw_K4F5xf6knJ7GnQ7LVMqmfHvO80_2Y5POCWoHRl_Qne39Idd0
 yb5AFpkZMvk1W3YrnlCL_S1bZ43v7E33rbWV47Py91sREpHTs7V7H_JWfRB3QhO4LAkKAEj4psct
 uYppjtlOCIktRaprFGIxociotrdDeNLCv79WEAfg8I8J0mk8-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:38:56 +0000
Received: by hermes--production-ir2-65c64dfd66-svnc4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1052c26ec2388683ab738a7f87fce466;
          Tue, 28 Feb 2023 22:38:52 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 10/10] dt-bindings: Add documentation for rt5033 mfd, regulator and charger
Date:   Tue, 28 Feb 2023 23:32:27 +0100
Message-Id: <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../bindings/mfd/richtek,rt5033.yaml          | 102 ++++++++++++++++++
 .../power/supply/richtek,rt5033-charger.yaml  |  76 +++++++++++++
 .../regulator/richtek,rt5033-regulator.yaml   |  45 ++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
new file mode 100644
index 000000000000..f1a58694c81e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
@@ -0,0 +1,102 @@
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
+description: |
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
+    type: object
+    $ref: /schemas/regulator/richtek,rt5033-regulator.yaml#
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
+    i2c@0 {
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
+                richtek,pre-uamp = <450000>;
+                richtek,fast-uamp = <1000000>;
+                richtek,eoc-uamp = <150000>;
+                richtek,pre-threshold-uvolt = <3500000>;
+                richtek,const-uvolt = <4350000>;
+                extcon = <&muic>;
+            };
+        };
+    };
+
+    i2c@1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        battery@35 {
+            compatible = "richtek,rt5033-battery";
+            reg = <0x35>;
+            interrupt-parent = <&msmgpio>;
+            interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
new file mode 100644
index 000000000000..996c2932927d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -0,0 +1,76 @@
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
+description: |
+  The battery charger of the multifunction device RT5033 has to be instantiated
+  under sub-node named "charger" using the following format.
+
+properties:
+  compatible:
+    const: richtek,rt5033-charger
+
+  richtek,pre-uamp:
+    description: |
+      Current of pre-charge mode. The pre-charge current levels are 350 mA to
+      650 mA programmed by I2C per 100 mA.
+    maxItems: 1
+
+  richtek,fast-uamp:
+    description: |
+      Current of fast-charge mode. The fast-charge current levels are 700 mA
+      to 2000 mA programmed by I2C per 100 mA.
+    maxItems: 1
+
+  richtek,eoc-uamp:
+    description: |
+      This property is end of charge current. Its level ranges from 150 mA to
+      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
+      in 100 mA steps.
+    maxItems: 1
+
+  richtek,pre-threshold-uvolt:
+    description: |
+      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
+      threshold voltage, the charger is in pre-charge mode with pre-charge current.
+      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
+    maxItems: 1
+
+  richtek,const-uvolt:
+    description: |
+      Battery regulation voltage of constant voltage mode. This voltage levels from
+      3.65 V to 4.4 V by I2C per 0.025 V.
+    maxItems: 1
+
+  extcon:
+    description: |
+      Phandle to the extcon device.
+    maxItems: 1
+
+required:
+  - richtek,pre-uamp
+  - richtek,fast-uamp
+  - richtek,eoc-uamp
+  - richtek,pre-threshold-uvolt
+  - richtek,const-uvolt
+
+additionalProperties: false
+
+examples:
+  - |
+    charger {
+        compatible = "richtek,rt5033-charger";
+        richtek,pre-uamp = <450000>;
+        richtek,fast-uamp = <1000000>;
+        richtek,eoc-uamp = <150000>;
+        richtek,pre-threshold-uvolt = <3500000>;
+        richtek,const-uvolt = <4350000>;
+        extcon = <&muic>;
+    };
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
new file mode 100644
index 000000000000..61b074488db4
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5033-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5033 PIMC Voltage Regulator
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+description: |
+  The regulators of RT5033 have to be instantiated under a sub-node named
+  "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
+  voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges from
+  1.0 V to 3.0 V in 0.1 V steps.
+
+patternProperties:
+  "^(SAFE_LDO|LDO|BUCK)$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    regulators {
+        safe_ldo_reg: SAFE_LDO {
+            regulator-name = "SAFE_LDO";
+            regulator-min-microvolt = <4900000>;
+            regulator-max-microvolt = <4900000>;
+            regulator-always-on;
+        };
+        ldo_reg: LDO {
+            regulator-name = "LDO";
+            regulator-min-microvolt = <2800000>;
+            regulator-max-microvolt = <2800000>;
+        };
+        buck_reg: BUCK {
+            regulator-name = "BUCK";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <1200000>;
+        };
+     };
-- 
2.39.1

