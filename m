Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD36F7C5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjEEFVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEEFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:21:38 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41959199D;
        Thu,  4 May 2023 22:21:34 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D8731BF209;
        Fri,  5 May 2023 05:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1683264093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oot7a6jjkHYrhgmWeZp0eSKNEBceRdK+riq6iDjoiY=;
        b=LochVUyvd29nALvDfn6vrXXHq8NtkMhpSDMjMhWh8muXxnY0iuJCA7KVuy3wPIENCLmP3N
        +lvbJmrzSwmyTeS5AaNyYHEsB49wA7QGY/c/CEgmx7UZCjRIGdX9kg6/e4lGcR2h09P55p
        43o+qi54mr4oBU8/hTWMPBwQD39D9UFqqK61RNBDdtFLjUAm9AgZfkpkrcGLiyJH6jwugb
        EimAaRpvYJ8/3G396KPd31KsYBZYFc6blToQOVp6ad5lvxRAkASW/rpYr0bcb+A3uOGQeX
        in4wnSIVtSphv98NnFa/DZ1Mfbe6CJ0yPDlY/00Seah2KihwxL3uRRZ3c6vaVQ==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] ARM: dts: sunxi: rename tcon's clock output
Date:   Fri,  5 May 2023 07:21:08 +0200
Message-Id: <20230505052110.67514-3-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230505052110.67514-1-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the rate of TCON0's DCLK matches dotclock for parallel and LVDS
outputs, this doesn't hold for DSI. According manuals from Allwinner,
DCLK is an abbreviation of Data Clock, not dotclock, so go with that
instead.

Signed-off-by: Roman Beranek <me@crly.cz>
---
 arch/arm/boot/dts/sun5i.dtsi                  | 2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          | 2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi             | 2 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 250d6b87ab4d..2f901a013676 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -286,7 +286,7 @@ tcon0: lcd-controller@1c0c000 {
 			clock-names = "ahb",
 				      "tcon-ch0",
 				      "tcon-ch1";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			status = "disabled";
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index f630ab55bb6a..ddc87cc15e51 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -190,7 +190,7 @@ tcon0: lcd-controller@1c0c000 {
 			clock-names = "ahb",
 				      "tcon-ch0",
 				      "lvds-alt";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_LCD>,
 				 <&ccu RST_BUS_LVDS>;
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 82fdb04122ca..94eb3bfc989e 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -456,7 +456,7 @@ tcon0: lcd-controller@1c0c000 {
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
 			clock-names = "ahb", "tcon-ch0";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index db194c606fdc..ab2a0e1235e4 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -191,7 +191,7 @@ tcon0: lcd-controller@1c0c000 {
 				 <&ccu CLK_TCON0>;
 			clock-names = "ahb",
 				      "tcon-ch0";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_TCON0>;
 			reset-names = "lcd";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 62f45f71ec65..e3b17575699c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -407,7 +407,7 @@ tcon0: lcd-controller@1c0c000 {
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
 			clock-names = "ahb", "tcon-ch0";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
-- 
2.32.0 (Apple Git-132)

