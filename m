Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F415A609FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJXLBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJXLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:01:14 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540491F2F4;
        Mon, 24 Oct 2022 03:59:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EB9C03200934;
        Mon, 24 Oct 2022 06:59:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 24 Oct 2022 06:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666609180; x=
        1666695580; bh=WtF7brqaST2GwwLvq7GRwjaSjzpeKdkIeOWWaUmlpn8=; b=I
        C9UtGz0VNgAKqxhoj2xaeT3tp62mEnE3pokLkFI2iO8fYlCFz7C0MrWv6hu9Nyzq
        1Yf3Ks00ibzTXBPQxY1DcCMTtS02Sn9syFIWR0ow/r4n0s6Z7NCfiQf9tJyjicEF
        oxOcifClF9PUI4geihBKs32F+bVjSYLyd8hYvIejKH7eOHjp+ZUK8hJyW0RiszML
        SQeYPfx6zl4dBnvCJZFYlAKLaLFSBhVqgea1mafKss+0bd7Pv5vTxfx+bvGkTv3J
        4GytCQEeEz0SXOeLDjoBeucdGThG4h7BskbgXtKgs/7MwN08PZwlung8/VslywzV
        KBCpabJ7PrKYGGoEypYjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666609180; x=1666695580; bh=WtF7brqaST2Gw
        wLvq7GRwjaSjzpeKdkIeOWWaUmlpn8=; b=WY+qrGSzipdwOEN0Dv5pU2DEfrDmz
        J+leogpHmknYRA40KMFr21D7WOuIPckczCVOzpmtC8dXMFwZAgvwjZZVEXQjyZyd
        8TihtdS6wUfkb2LbYz0CmjI+AtDLniR2w2cLVqfgAbmt4B3nczlBtoVjoXL1HUCZ
        PASsW31IpKoVy8kK9CoIRO3thaGHY8yY4gD8d04m9mQkd/+RzR7PkYLigzAMTUN+
        7NXuFUNCWmbExAN8HuydkAw8JWZ3iF3Dx+6SH7fxqhrbH+8jQV6+GouolQotUcyf
        9y/NEYaEXuwkDJzKs8QfUc+ocRVK1P5yGdhNtk6mEcPyQKV0IhotqEL9Q==
X-ME-Sender: <xms:HHBWY-BlSpTQzvzGeLmjhhbg7-fnG8wUFaJlTi7lAj0HC0HfpoQe1g>
    <xme:HHBWY4i8qm2EzxNA5DF8ELujoyPoS1ErXEhQlvH6H2KZ8_eC6dRiG0GR4nD7kkCB_
    eQt18x58etC6CzTvMo>
X-ME-Received: <xmr:HHBWYxnO1MtX3-b5aOdjC4hF7hlsQ3kiXmc_Bcy35YpJFi7kRDimE-rEb__TSojqyzyE8eHUGLIR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekte
    elvdelveevueeujeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:HHBWY8yitewK4X7EzTXdlVpGLhE1qY6L2L5aboixtEJVcNL9ywzp8w>
    <xmx:HHBWYzRd7TGgkEYgN38_2zzYpblHE6vl1rak98VAowyweXIkuYn4_g>
    <xmx:HHBWY3YDpAjiuNZ0av1fet4QV7wmuzL0McYCO7pInlFAT4Yh1U1YGg>
    <xmx:HHBWY0LkZcmJuJ1VgygWVBnqmp0NfbjNowNSky5hB-4rn-JFffuL8Q>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 06:59:29 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        alistair@alistair23.me, geert@linux-m68k.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info, amitk@kernel.org,
        linux-hwmon@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, devicetree@vger.kernel.org,
        linux@roeck-us.net, linux-imx@nxp.com
Subject: [PATCH v22 2/2] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Mon, 24 Oct 2022 20:58:53 +1000
Message-Id: <20221024105853.42029-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024105853.42029-1-alistair@alistair23.me>
References: <20221024105853.42029-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a2a91bfdd98e..99ac0d242936 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -22,6 +22,27 @@ memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
+	thermal-zones {
+		epd-thermal {
+			thermal-sensors = <&epd_pmic>;
+			polling-delay-passive = <30000>;
+			polling-delay = <30000>;
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
@@ -84,6 +105,33 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	epd_pmic: sy7636a@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#thermal-sensor-cells = <0>;
+
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
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
@@ -177,6 +225,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -184,6 +239,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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
2.37.3

