Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C324677F38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAWPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjAWPPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5E2A15A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so10869454wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmclShYeTGrkuYn35Gd8osDDw2WC07vGDz3L0CH8Dxc=;
        b=s+ADnzAU7X7bMVCx2ZnscdcJYo86S2EUoC4eGmVDrxeJpe4W6Taz+BK8elJLns5L1I
         JQ8OhzpYRz8lsAGxA48HPUeWC6JhS+TEgH1FsNV2iVz+cFNBnAdCCjfvSanuwgkC/yNW
         bcXiRc4f3nA10S/RbGV/ctyJaPb6HxlB+ao4+tFJAUNqEij43CIipzRlkKd0qlXjnjxZ
         KnSsIw+kN+PMI6HSv0tWoKmXdvU2WoaLy8Uo9e2/K4o2PTXjfAmoL7E/RJKHLFHY1BAD
         X+gWO7SusXcNZThkCjezWtPLVBapXSOzdHkGcj6rW7Z5LNKaN+HxHesIQKdQl3CnEL0V
         D5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmclShYeTGrkuYn35Gd8osDDw2WC07vGDz3L0CH8Dxc=;
        b=loD9JgABvJPHJTjn6xV7CGc56EAfZr4g+mnV+f21rpwD/vVpSfVOxW8Ms0jtU5Kgxg
         I1q3+U5KuYREgv52vXBXeUbG4AA67MvvZz/ix5wbaAnu4a+kOeEpDH/8OGWWSFwZsitv
         Ona3HtaSTm9LLuo4IqA7HE9GW2NyCWsCzO4h4BrKdwWWVo/owCeaI5F61LSuEH7WxRp/
         dNhDznhUdBq8s1ehsZSmyOGmkloIt4Se+XRFB2XJ+g5OeIuJ+joniFEiz1/0pkeDCrCF
         phDxLGj8rLIPHAJPUnfcdhFq3xzQRmMpH4yel9/F1PSQZ1IgSfA12KRavTIsc5Rv6MfV
         yyOA==
X-Gm-Message-State: AFqh2kri3yeKwOoQyGAegMXogzUKMrZrPUHN4QGdvl7srYpAf0M2SBiS
        BAcfWaI/fwNhqocsYt3ZKg8JqA==
X-Google-Smtp-Source: AMrXdXtIOt5r6zgu9MpDD98C9P91qtL78FyKPTVb7dAiZZmoUq7dUXLQCYr4pRU+rHC+yhCG6VGONg==
X-Received: by 2002:a05:600c:80f:b0:3d2:3d7b:6118 with SMTP id k15-20020a05600c080f00b003d23d7b6118mr24635719wmp.24.1674486920939;
        Mon, 23 Jan 2023 07:15:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003dafadd2f77sm12017325wms.1.2023.01.23.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ste: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:18 +0100
Message-Id: <20230123151519.369158-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 6 +++---
 arch/arm/boot/dts/ste-href.dtsi                    | 6 +++---
 arch/arm/boot/dts/ste-hrefprev60.dtsi              | 2 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            | 2 +-
 arch/arm/boot/dts/ste-nomadik-s8815.dts            | 2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 6 +++---
 arch/arm/boot/dts/ste-snowball.dts                 | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-codina.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-gavini.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-janice.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-kyle.dts       | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     | 6 +++---
 14 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index a42a4fd69299..ecfaf5a70403 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -846,7 +846,7 @@ spi3: spi@80129000 {
 			status = "disabled";
 		};
 
-		serial0: uart@80120000 {
+		serial0: serial@80120000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80120000 0x1000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
@@ -862,7 +862,7 @@ serial0: uart@80120000 {
 			status = "disabled";
 		};
 
-		serial1: uart@80121000 {
+		serial1: serial@80121000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80121000 0x1000>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -878,7 +878,7 @@ serial1: uart@80121000 {
 			status = "disabled";
 		};
 
-		serial2: uart@80007000 {
+		serial2: serial@80007000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80007000 0x1000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 8f1bb78fc1e4..2def50da9eb6 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -45,7 +45,7 @@ bat_therm: thermistor {
 	};
 
 	soc {
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -53,13 +53,13 @@ uart@80120000 {
 		};
 
 		/* This UART is unused and thus left disabled */
-		uart@80121000 {
+		serial@80121000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u1rxtx_a_1_default>;
 			pinctrl-1 = <&u1rxtx_a_1_sleep>;
 		};
 
-		uart@80007000 {
+		serial@80007000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
 			pinctrl-1 = <&u2rxtx_c_1_sleep>;
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 29b67abfc461..9859ee91a15e 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -17,7 +17,7 @@ button@1 {
 
 	soc {
 		/* Enable UART1 on this board */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 8142c017882c..d4bbe9729ced 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -190,7 +190,7 @@ nomadik_clcd: endpoint {
 		};
 
 		/* Activate RX/TX and CTS/RTS on UART 0 */
-		uart0: uart@101fd000 {
+		uart0: serial@101fd000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_nhk_mode>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index f16314ffbf4b..c905c2643a12 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -133,7 +133,7 @@ stw4811@2d {
 
 	amba {
 		/* Activate RXTX on UART 0 */
-		uart0: uart@101fd000 {
+		uart0: serial@101fd000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_s8815_mode>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 1815361fe73c..6816eef39d45 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -769,7 +769,7 @@ vicb: interrupt-controller@10140020 {
 			reg = <0x10140020 0x20>;
 		};
 
-		uart0: uart@101fd000 {
+		uart0: serial@101fd000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101fd000 0x1000>;
 			interrupt-parent = <&vica>;
@@ -782,7 +782,7 @@ uart0: uart@101fd000 {
 			dma-names = "rx", "tx";
 		};
 
-		uart1: uart@101fb000 {
+		uart1: serial@101fb000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101fb000 0x1000>;
 			interrupt-parent = <&vica>;
@@ -796,7 +796,7 @@ uart1: uart@101fb000 {
 			dma-names = "rx", "tx";
 		};
 
-		uart2: uart@101f2000 {
+		uart2: serial@101f2000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f2000 0x1000>;
 			interrupt-parent = <&vica>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index e2f0cdacba7d..9a3d6546399d 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -308,7 +308,7 @@ mmc@80114000 {
 			status = "okay";
 		};
 
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -316,13 +316,13 @@ uart@80120000 {
 		};
 
 		/* This UART is unused and thus left disabled */
-		uart@80121000 {
+		serial@80121000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u1rxtx_a_1_default>;
 			pinctrl-1 = <&u1rxtx_a_1_sleep>;
 		};
 
-		uart@80007000 {
+		serial@80007000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
 			pinctrl-1 = <&u2rxtx_c_1_sleep>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts b/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
index e036393d5415..463942ae755e 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
@@ -369,7 +369,7 @@ mmc@80005000 {
 		};
 
 		/* GBF (Bluetooth) UART */
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -393,7 +393,7 @@ bluetooth {
 		};
 
 		/* GPS UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			/* CTS/RTS is not used, CTS is repurposed as GPIO */
@@ -403,7 +403,7 @@ uart@80121000 {
 		};
 
 		/* Debugging console UART connected to AB8505 */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
index 1a6d24a7ccb8..c1ae0e23fe45 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
@@ -462,7 +462,7 @@ mmc@80005000 {
 		};
 
 		/* GBF (Bluetooth) UART */
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -485,7 +485,7 @@ bluetooth {
 		};
 
 		/* GPS UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u1rxtx_a_1_default &u1ctsrts_a_1_default>;
@@ -505,7 +505,7 @@ gnss {
 		};
 
 		/* Debugging console UART connected to TSU6111RSVR (FSA880) */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
index 5b445fa4c8c0..b21e40da3dfd 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
@@ -417,7 +417,7 @@ mmc@80005000 {
 		};
 
 		/* GBF (Bluetooth) UART */
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -439,7 +439,7 @@ bluetooth {
 		};
 
 		/* GPS UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			/* CTS/RTS is not used, CTS is repurposed as GPIO */
@@ -449,7 +449,7 @@ uart@80121000 {
 		};
 
 		/* Debugging console UART connected to TSU6111RSVR (FSA880) */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index 9604695edf53..f736888474e7 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -186,7 +186,7 @@ mmc@80005000 {
 		};
 
 		/* BT UART */
-		uart@80120000 {
+		serial@80120000 {
 			status = "okay";
 
 			pinctrl-names = "default", "sleep";
@@ -209,7 +209,7 @@ bluetooth {
 		};
 
 		/* GPF UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 
 			pinctrl-names = "default", "sleep";
@@ -218,7 +218,7 @@ uart@80121000 {
 		};
 
 		/* Debugging console UART */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 
 			pinctrl-names = "default", "sleep";
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
index e901cb76b899..6e586e875565 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
@@ -467,7 +467,7 @@ mmc@80005000 {
 		};
 
 		/* GBF (Bluetooth) UART */
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -491,7 +491,7 @@ bluetooth {
 		};
 
 		/* GPS UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			/* CTS/RTS is not used, CTS is repurposed as GPIO */
@@ -520,7 +520,7 @@ gnss {
 		};
 
 		/* Debugging console UART connected to TSU6111RSVR (FSA880) */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
index 45fab5283a9d..ba4421080b2a 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
@@ -292,7 +292,7 @@ mmc@80005000 {
 		};
 
 		/* GBF (Bluetooth) UART */
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -310,7 +310,7 @@ bluetooth {
 		};
 
 		/* GPF UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u1rxtx_a_1_default &u1ctsrts_a_1_default>;
@@ -333,7 +333,7 @@ gnss {
 		};
 
 		/* Debugging console UART connected to AB8505 USB */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
index 93e5f5ed888d..064d6fee8821 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
@@ -271,7 +271,7 @@ mmc@80005000 {
 		};
 
 		/* GBF (Bluetooth) UART */
-		uart@80120000 {
+		serial@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
@@ -290,7 +290,7 @@ bluetooth {
 		};
 
 		/* GPS UART */
-		uart@80121000 {
+		serial@80121000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u1rxtx_a_1_default &u1ctsrts_a_1_default>;
@@ -313,7 +313,7 @@ gnss {
 		};
 
 		/* Debugging console UART connected to AB8505 USB */
-		uart@80007000 {
+		serial@80007000 {
 			status = "okay";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u2rxtx_c_1_default>;
-- 
2.34.1

