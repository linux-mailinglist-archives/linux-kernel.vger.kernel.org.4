Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132A85BA00E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIOQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIOQxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:53:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB2F2;
        Thu, 15 Sep 2022 09:53:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l17so2297806wru.2;
        Thu, 15 Sep 2022 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9JkrATt2M8V3VdLQsKMdveWVvxUXnhUR+3P/iBkNBFY=;
        b=fAGTRetucC5vEC+0iXVBcYQLejjYf6SFPmcEzscjOxybuxHTqi180SNCyiXX9QkVNP
         uAzSR52XWT4wUKXjDf8dTou5DN/kaukqoZvYFJsqqtOhSOCICIoNl9zID7hDxQtH1mgR
         y3rp4Y+40m5MVCHkk46khyk4utKaRkM4YKctF1HNVee2CG+D6hexFE7uUU+a7a3VmMUY
         PaZdY3brLYCnXg598DoPhJvue4ZmnZ97Iqt0SpKiWIcvslEQY5ZQPZzuXzGOR8C7c5Cu
         HA2Irzq6ZociS+tksKASaMjw2nNB/GCwFoqu5xVKzcqgvPcj7EEmpaqlx9C/RM8BRshE
         x05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9JkrATt2M8V3VdLQsKMdveWVvxUXnhUR+3P/iBkNBFY=;
        b=pIbgSLN7iP55dN+1vlcJOhDoJacfIVCOrt26KCMroQ3jRXEAKC73VFbQk+5rYZzJsS
         PsfAuJ/LmmM8AKT7HgOpn3y1Evv2GjfDA7x6TVYzNjtHsO019Ew26kGZaz8Qoses+Z4c
         ca6ZRWLOZXplUrI9Ek20jXtqx8b6kLvU0J3HupIm9YQToaS7LVMzj13OS9DOqz+yEfYn
         ognPmQULZBomklSJK4ICxDegpxe4K1MYuhrrBBj1U9tfvHi9Ks9iz5mPX+/zpy+PYXL0
         qM898EA+T6+ubiolyZRr5AIjZupV7SCw3hS8e+R+hYha0qTu7myFCOaIerfVNA9lmW3F
         bKxQ==
X-Gm-Message-State: ACrzQf3hpuZI8rM/OYbOc49OfX5+cdbX+5/NsRF5pVKOAKB5IR0Y5iDt
        hJ+hz1IlJ+JDZNWgkILo2UQ=
X-Google-Smtp-Source: AMsMyM6HziML28XjbP5dM5+Uriq1l6UwR+kdUZly71aeC/wMj4XrZ/QvpbnmX6kbUjl1aE3a84pacw==
X-Received: by 2002:a5d:598e:0:b0:22a:cfe5:7ed with SMTP id n14-20020a5d598e000000b0022acfe507edmr411498wri.370.1663260821475;
        Thu, 15 Sep 2022 09:53:41 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc6e:cfa1:9281:3490])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b003b332a7bf15sm3562129wmq.7.2022.09.15.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:53:40 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] arm64: dts: renesas: rzg2ul-smarc: Add /omit-if-no-ref/ to pinmux
Date:   Thu, 15 Sep 2022 17:52:56 +0100
Message-Id: <20220915165256.352843-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In preparation to re-use the RZ/G2UL SMARC SoM and carrier DTS/I with the
RZ/Five add /omit-if-no-ref/ keyword to pinmux entries as the support for
RZ/Five SMARC EVK will be gradually added.

Once we have full blown support for RZ/Five SMARC EVK we can get rid of
the /omit-if-no-ref/ keyword.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi  | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi   |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index bd8bc858c28c..2b400100472e 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -12,12 +12,14 @@ &pinctrl {
 	pinctrl-0 = <&sound_clk_pins>;
 	pinctrl-names = "default";
 
+	/omit-if-no-ref/
 	can0_pins: can0 {
 		pinmux = <RZG2L_PORT_PINMUX(1, 1, 3)>, /* TX */
 			 <RZG2L_PORT_PINMUX(1, 2, 3)>; /* RX */
 	};
 
 #if (SW_ET0_EN_N)
+	/omit-if-no-ref/
 	can0-stb-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
@@ -26,12 +28,14 @@ can0-stb-hog {
 	};
 #endif
 
+	/omit-if-no-ref/
 	can1_pins: can1 {
 		pinmux = <RZG2L_PORT_PINMUX(2, 0, 3)>, /* TX */
 			 <RZG2L_PORT_PINMUX(2, 1, 3)>; /* RX */
 	};
 
 #if (SW_ET0_EN_N)
+	/omit-if-no-ref/
 	can1-stb-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(2, 3) GPIO_ACTIVE_HIGH>;
@@ -40,11 +44,13 @@ can1-stb-hog {
 	};
 #endif
 
+	/omit-if-no-ref/
 	i2c0_pins: i2c0 {
 		pins = "RIIC0_SDA", "RIIC0_SCL";
 		input-enable;
 	};
 
+	/omit-if-no-ref/
 	i2c1_pins: i2c1 {
 		pins = "RIIC1_SDA", "RIIC1_SCL";
 		input-enable;
@@ -55,6 +61,7 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(6, 3, 6)>; /* RxD */
 	};
 
+	/omit-if-no-ref/
 	sd1-pwr-en-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(0, 3) GPIO_ACTIVE_HIGH>;
@@ -62,6 +69,7 @@ sd1-pwr-en-hog {
 		line-name = "sd1_pwr_en";
 	};
 
+	/omit-if-no-ref/
 	sdhi1_pins: sd1 {
 		sd1_data {
 			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
@@ -78,6 +86,7 @@ sd1_mux {
 		};
 	};
 
+	/omit-if-no-ref/
 	sdhi1_pins_uhs: sd1_uhs {
 		sd1_data_uhs {
 			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
@@ -94,11 +103,13 @@ sd1_mux_uhs {
 		};
 	};
 
+	/omit-if-no-ref/
 	sound_clk_pins: sound_clk {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
 		input-enable;
 	};
 
+	/omit-if-no-ref/
 	ssi1_pins: ssi1 {
 		pinmux = <RZG2L_PORT_PINMUX(3, 0, 2)>, /* BCK */
 			 <RZG2L_PORT_PINMUX(3, 1, 2)>, /* RCK */
@@ -106,12 +117,14 @@ ssi1_pins: ssi1 {
 			 <RZG2L_PORT_PINMUX(3, 3, 2)>; /* RXD */
 	};
 
+	/omit-if-no-ref/
 	usb0_pins: usb0 {
 		pinmux = <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
 			 <RZG2L_PORT_PINMUX(5, 2, 1)>, /* OVC */
 			 <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
 	};
 
+	/omit-if-no-ref/
 	usb1_pins: usb1 {
 		pinmux = <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
 			 <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 2a0feb53f0dc..a0a41a062f55 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -132,10 +132,12 @@ &ostm2 {
 };
 
 &pinctrl {
+	/omit-if-no-ref/
 	adc_pins: adc {
 		pinmux = <RZG2L_PORT_PINMUX(6, 2, 1)>; /* ADC_TRG */
 	};
 
+	/omit-if-no-ref/
 	eth0_pins: eth0 {
 		pinmux = <RZG2L_PORT_PINMUX(4, 5, 1)>, /* ET0_LINKSTA */
 			 <RZG2L_PORT_PINMUX(4, 3, 1)>, /* ET0_MDC */
@@ -154,6 +156,7 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(4, 1, 1)>; /* ET0_RXD3 */
 	};
 
+	/omit-if-no-ref/
 	eth1_pins: eth1 {
 		pinmux = <RZG2L_PORT_PINMUX(10, 4, 1)>, /* ET1_LINKSTA */
 			 <RZG2L_PORT_PINMUX(10, 2, 1)>, /* ET1_MDC */
@@ -172,6 +175,7 @@ eth1_pins: eth1 {
 			 <RZG2L_PORT_PINMUX(10, 0, 1)>; /* ET1_RXD3 */
 	};
 
+	/omit-if-no-ref/
 	sdhi0_emmc_pins: sd0emmc {
 		sd0_emmc_data {
 			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3",
@@ -190,6 +194,7 @@ sd0_emmc_rst {
 		};
 	};
 
+	/omit-if-no-ref/
 	sdhi0_pins: sd0 {
 		sd0_data {
 			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
@@ -206,6 +211,7 @@ sd0_mux {
 		};
 	};
 
+	/omit-if-no-ref/
 	sdhi0_pins_uhs: sd0_uhs {
 		sd0_data_uhs {
 			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
@@ -222,6 +228,7 @@ sd0_mux_uhs {
 		};
 	};
 
+	/omit-if-no-ref/
 	spi1_pins: rspi1 {
 		pinmux = <RZG2L_PORT_PINMUX(4, 0, 2)>, /* CK */
 			 <RZG2L_PORT_PINMUX(4, 1, 2)>, /* MOSI */
-- 
2.25.1

