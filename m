Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAC8612228
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJ2KHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJ2KHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:07:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D715B122;
        Sat, 29 Oct 2022 03:07:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E4675C0144;
        Sat, 29 Oct 2022 06:07:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 29 Oct 2022 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667038049; x=
        1667124449; bh=ii5FrCn9Wh+rrZgHgZM99N/eK/RiQhzg3xDbaGnZMmg=; b=V
        5X78iF7R8sq4FWmo7Ew6GGWW3oGpVOmY3K04uBh5nhyySETslK7WXhZ+eBCC6Hfc
        6gzDyNjf09UqxPx7bH/JDuJfz2mmJYopjtTDLEvcbnEFm2X5aDhykot1337BnFdK
        KoEbxVvfjZyP2QjdA6bMdp3xX9+FwAM+zt/fCiYhRGVIb9anwKXGlujTbHXqogaX
        Oj7A6tSI2gq7Z6YKzUZpZhLnqjcG6RMGYKhS7lPJsorfEyrD1zytBgUgxrMkMGNZ
        rKwOVBJvafPRAOv54ghjHL2q7RheLzSlltv/1ruAbD2Jy84QedwsTRDAfTzea6eb
        QBLYCcsEcypHP9U7m9/9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667038049; x=1667124449; bh=ii5FrCn9Wh+rr
        ZgHgZM99N/eK/RiQhzg3xDbaGnZMmg=; b=JPAL25Hg9skLnFrvLVDV2Vw1B2Uvh
        twDXPKL9dxC5qpm5bXKbwbLBF8SInt8t7MtAGOF9IzDa8bhy5twdFloJ9oB4NQ1H
        AMT9mUIzRZvUrlx26vPlO69YSFk6a9Qk5gQpwbq/vY+0tVEjJKVloJsukbYLEb+A
        e1VvO+36TxDq1gPTEnHa+xHDlkLBqdjbEFapJt4ks0DKRNIh5gEW7dK+a+ZkyEVA
        6y1JtbGO9fXCfjWLgiplMNR++GkYmo6eNNcqVpZHGxXAwujQ/6xCtr7g9XGueimQ
        PjLkSG6gJF5uy4JJMQ6dZhqdzkfHHo2h0fvmntECAWXB40ROZ/EYZpqhg==
X-ME-Sender: <xms:YPtcY1drhVKyO3AqRiHrp70WZy5cNAOfWORJ6PHQS6XYR2Nk_9sWYw>
    <xme:YPtcYzP6aK_07HKjpUFJYctcchrVW4Il5_6fNA6WAhUSQUKF_OfVNE1Wn2Lr3smRo
    M_8QIrpc0ldgncGcYE>
X-ME-Received: <xmr:YPtcY-ix4Ng8gzM-GkNn9ijpjgXM3ra5n-L5Z7DVJGvryuqpdBQHEbyF9fNOybsoNOMoAv4P0RKa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:YPtcY--bRa6NZL_caSOTr_ltS9luqEsTAt3-PuRhbV_UR8RhkdwGoA>
    <xmx:YPtcYxvjU_wVP0KDK1xXTsQpH2Uz21rjqWCek1-0_DqjjBCNVXt1qA>
    <xmx:YPtcY9GQjBXUPaSkxu8mn4Lqeh3ioisITffcOCMjKplbjyXWU5G7dQ>
    <xmx:YftcY8kf_ZH2H82g9T8ngZa5eKDojFMlVMXIloAudMR8nzyzzT-aBw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Oct 2022 06:07:18 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        kernel@pengutronix.de, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-imx@nxp.com, alistair@alistair23.me, amitk@kernel.org,
        s.hauer@pengutronix.de, linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, shawnguo@kernel.org,
        andreas@kemnade.info, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH v23 2/2] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Sat, 29 Oct 2022 20:06:46 +1000
Message-Id: <20221029100646.294583-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221029100646.294583-1-alistair@alistair23.me>
References: <20221029100646.294583-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a2a91bfdd98e..58581295b9a0 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -22,6 +22,28 @@ memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
+	thermal-zones {
+		epd-thermal {
+			thermal-sensors = <&epd_pmic>;
+			polling-delay-passive = <30000>;
+			polling-delay = <30000>;
+
+			trips {
+				trip0 {
+					temperature = <49000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	reg_brcm: regulator-brcm {
 		compatible = "regulator-fixed";
 		regulator-name = "brcm_reg";
@@ -84,6 +106,33 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	sy7636a: pmic@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#thermal-sensor-cells = <0>;
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+
+		regulators {
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -177,6 +226,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21	0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x00000014
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -184,6 +240,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.38.1

