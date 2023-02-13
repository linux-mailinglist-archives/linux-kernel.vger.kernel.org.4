Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98540695096
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBMTYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBMTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:24:46 -0500
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC620680
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676316271; bh=xkmJJqu6MolKJdoAjsMp0nlBp8nKSB4Kl7pZsLx6TUk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=r/M6sjS5+L5YkZo5Ws5mZsv2Hz3oYUlnXUl7gzCyggfijeRIqHJ9zFRsZTSaB3+Sj
         oYIiLizNgoCK+hPv+HE7hGf53JdMCIbFAF1C8VPNRoiDL8tJ+sauAFeXDZV8FxtvUU
         b5T95e2nDMqWpTVpPfQgHWAI5G/1z1rq310UZqEFc4ZK38F27N6CWIvMtHGx//e2Jj
         3zeJHLY159NVmdnGTREtwEikrNlpXx1mpc3n2MMwckVFGms78uiNwGNpwPIa0InS5R
         ZymRxo74P7WH2HQtUn/Uy8OdzjwnSAC8vC6nHm20tQmVSniBhlg08WU9Zd7m/tMVa+
         vmMO/Eulu528g==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 4419F8E095F;
        Mon, 13 Feb 2023 19:24:29 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: spi: spi-st-ssc: convert to DT schema
Date:   Mon, 13 Feb 2023 20:23:48 +0100
Message-Id: <20230213192349.17101-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Gvif1CpBDyyDTT7F6ljF9AvkEw--yut
X-Proofpoint-ORIG-GUID: 2Gvif1CpBDyyDTT7F6ljF9AvkEw--yut
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302130169
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert spi-st-ssc.txt into st,ssc-spi.yaml for the
ST Microelectronics SSC SPI driver.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: correct subject & commit log
    drop quotes around spi-controller.yaml
    remove extra spaces within example

 .../devicetree/bindings/spi/spi-st-ssc.txt    | 40 ------------
 .../devicetree/bindings/spi/st,ssc-spi.yaml   | 61 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 62 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-st-ssc.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,ssc-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-st-ssc.txt b/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
deleted file mode 100644
index 1bdc4709e474..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-STMicroelectronics SSC (SPI) Controller
----------------------------------------
-
-Required properties:
-- compatible	: "st,comms-ssc4-spi"
-- reg		: Offset and length of the device's register set
-- interrupts	: The interrupt specifier
-- clock-names	: Must contain "ssc"
-- clocks	: Must contain an entry for each name in clock-names
-		    See ../clk/*
-- pinctrl-names	: Uses "default", can use "sleep" if provided
-		    See ../pinctrl/pinctrl-bindings.txt
-
-Optional properties:
-- cs-gpios	: List of GPIO chip selects
-		    See ../spi/spi-bus.txt
-
-Child nodes represent devices on the SPI bus
-  See ../spi/spi-bus.txt
-
-Example:
-	spi@9840000 {
-		compatible	= "st,comms-ssc4-spi";
-		reg		= <0x9840000 0x110>;
-		interrupts	= <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-		clocks		= <&clk_s_c0_flexgen CLK_EXT2F_A9>;
-		clock-names	= "ssc";
-		pinctrl-0	= <&pinctrl_spi0_default>;
-		pinctrl-names	= "default";
-		cs-gpios	= <&pio17 5 0>;
-		#address-cells	= <1>;
-		#size-cells	= <0>;
-
-		st95hf@0{
-			compatible		= "st,st95hf";
-			reg			= <0>;
-			spi-max-frequency	= <1000000>;
-			interrupts		= <2 IRQ_TYPE_EDGE_FALLING>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/spi/st,ssc-spi.yaml b/Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
new file mode 100644
index 000000000000..6a77cd3f5d6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/st,ssc-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics SSC SPI Controller
+
+description: |
+  The STMicroelectronics SSC SPI controller can be found on STi platforms
+  and it used to communicate with external devices using the
+  Serial Peripheral Interface.
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: st,comms-ssc4-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ssc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stih407-clks.h>
+    spi@9840000 {
+      compatible = "st,comms-ssc4-spi";
+      reg = <0x9840000 0x110>;
+      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+      clock-names = "ssc";
+      pinctrl-0 = <&pinctrl_spi0_default>;
+      pinctrl-names = "default";
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e32eb8d44f5..0fc3e4c6c1e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2926,6 +2926,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.stlinux.com
 F:	Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
+F:	Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
 F:	arch/arm/boot/dts/sti*
 F:	arch/arm/mach-sti/
 F:	drivers/ata/ahci_st.c
-- 
2.34.1

