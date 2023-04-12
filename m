Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F976DF3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjDLLah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDLLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:30:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C007AAC;
        Wed, 12 Apr 2023 04:28:51 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64757660322F;
        Wed, 12 Apr 2023 12:28:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298900;
        bh=chGWBs1hJYSca6e8u/s/vnv2XlltpEF6hKJyQaXeTLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJ4B67IQhVehxBnCg7vCaAFTsKCrZJaYar7p2G0EvYSGXq1jakB58n2ggE1rfT4vt
         hYO2Cf8WmSD8AEGL6b1YVqZQ3sMMz8hTZmZIe2aEpM8zSvGSr4ZGcsqv/L2M2Ynhom
         NQrriGbEhl34aoLlaLPV/jWtjqohLwcLOrG4iAQ9ebZrEG8PlyG+1YTz+GSp2Q3uMK
         PzqK6niOgIyVFB708Ebl4WyAzSngcTBqZko5cMza84tHuQbSjb8jgqlyZ+lpO7LdyP
         vMDWInSAvoaVfLb+fEjsGedLN/8o/T1MczFldXGPEIgUw7gmalL++ciEGLQm1HdRCh
         Og6QWH//MZrDg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 25/27] arm64: dts: mediatek: mt6795-xperia-m5: Add eMMC, MicroSD slot, SDIO
Date:   Wed, 12 Apr 2023 13:27:37 +0200
Message-Id: <20230412112739.160376-26-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure and enable the MMC0/1/2 controllers, used for the eMMC chip,
MicroSD card slot and SDIO (WiFi) respectively.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index debe0f2553d9..155a573eac4c 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -17,6 +17,7 @@ / {
 	aliases {
 		mmc0 = &mmc0;
 		mmc1 = &mmc1;
+		mmc2 = &mmc2;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -121,7 +122,97 @@ proximity@48 {
 	};
 };
 
+&mmc0 {
+	/* eMMC controller */
+	mediatek,latch-ck = <0x14>; /* hs400 */
+	mediatek,hs200-cmd-int-delay = <1>;
+	mediatek,hs400-cmd-int-delay = <1>;
+	mediatek,hs400-ds-dly3 = <0x1a>;
+	non-removable;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	vmmc-supply = <&mt6331_vemc33_reg>;
+	vqmmc-supply = <&mt6331_vio18_reg>;
+	status = "okay";
+};
+
+&mmc1 {
+	/* MicroSD card slot */
+	vmmc-supply = <&mt6331_vmc_reg>;
+	vqmmc-supply = <&mt6331_vmch_reg>;
+	status = "okay";
+};
+
+&mmc2 {
+	/* SDIO WiFi on MMC2 */
+	vmmc-supply = <&mt6331_vmc_reg>;
+	vqmmc-supply = <&mt6331_vmch_reg>;
+	status = "okay";
+};
+
 &pio {
+	mmc0_pins_default: emmc-sdr-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO155__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO156__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO160__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO162__FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO163__FUNC_MSDC0_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO165__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	mmc0_pins_uhs: emmc-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO154__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO155__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO156__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO160__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO162__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO163__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO165__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO164__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
 	nfc_pins: nfc-pins {
 		pins-irq {
 			pinmux = <PINMUX_GPIO3__FUNC_GPIO3>;
-- 
2.40.0

