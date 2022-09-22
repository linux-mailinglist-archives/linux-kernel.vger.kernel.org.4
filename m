Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634C5E5EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiIVJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIVJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:49:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01608D4AB1;
        Thu, 22 Sep 2022 02:49:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5AB706602220;
        Thu, 22 Sep 2022 10:49:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663840156;
        bh=wJr++mgtlB0haCHpsGcU+/sZxX7EhT3lTzKcLP5Sa+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my13z2QCQ8ScWdhB1vhyZRsI+1ungf5aAE9eQB5FnsrX8JmyqTjOqLlkOqL54P/w9
         hwMsDnsIGWpQrAJuM/lDuFNGaN53YvjZG4D67yd/2yvbl/GXsUbXOQsYX5NT3faYQR
         L0wutPj8FEcMVdbNYzfndu3g3rkeMNp0S3ToETcOI+jMGldcUpZB4v5LnkaWas7SgO
         1PiYEyooESo0x/wz79FHNCKjsfI4a0owXfS0TXPSSCd3XYjA9NZIgNVnFWc8b0n3yj
         rPOtrHV/Uq9tl6gg9APb0J/yPYI1IRgeEVgOL3avTo9og1zecBxyUG7ZPg411MNDTP
         XNfwiDB0SWPvg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/4] arm64: dts: mediatek: cherry: Add sound card configuration
Date:   Thu, 22 Sep 2022 11:49:08 +0200
Message-Id: <20220922094908.41623-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
References: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the sound card on all MT8195 Cherry Tomato devices to
enable audio support.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  5 +++
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  5 +++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  5 +++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 40 +++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 3767b49ea896..2d5e8f371b6d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -15,6 +15,11 @@ &audio_codec {
 	realtek,btndet-delay = <16>;
 };
 
+&sound {
+	compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
+	model = "mt8195_r1019_5682";
+};
+
 &ts_10 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 0ed83a79d680..2586c32ce6e6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -35,6 +35,11 @@ pins-low-power-pcie0-disable {
 	};
 };
 
+&sound {
+	compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
+	model = "mt8195_r1019_5682";
+};
+
 &ts_10 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index c47b341e98fb..f54f9477b99d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -36,6 +36,11 @@ pins-low-power-pcie0-disable {
 	};
 };
 
+&sound {
+	compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
+	model = "m8195_r1019_5682s";
+};
+
 &ts_10 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 95e93b791432..3410e16d7e99 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -526,6 +526,34 @@ &pio {
 		"AP_SPI_FLASH_MOSI",
 		"AP_SPI_FLASH_MISO";
 
+	aud_pins_default: audio-default-pins {
+		pins-cmd-dat {
+		    pinmux = <PINMUX_GPIO69__FUNC_AUD_CLK_MOSI>,
+			     <PINMUX_GPIO70__FUNC_AUD_SYNC_MOSI>,
+			     <PINMUX_GPIO71__FUNC_AUD_DAT_MOSI0>,
+			     <PINMUX_GPIO72__FUNC_AUD_DAT_MOSI1>,
+			     <PINMUX_GPIO73__FUNC_AUD_DAT_MISO0>,
+			     <PINMUX_GPIO74__FUNC_AUD_DAT_MISO1>,
+			     <PINMUX_GPIO75__FUNC_AUD_DAT_MISO2>,
+			     <PINMUX_GPIO0__FUNC_TDMIN_MCK>,
+			     <PINMUX_GPIO1__FUNC_TDMIN_DI>,
+			     <PINMUX_GPIO2__FUNC_TDMIN_LRCK>,
+			     <PINMUX_GPIO3__FUNC_TDMIN_BCK>,
+			     <PINMUX_GPIO60__FUNC_I2SO2_D0>,
+			     <PINMUX_GPIO49__FUNC_I2SIN_D0>,
+			     <PINMUX_GPIO50__FUNC_I2SO1_MCK>,
+			     <PINMUX_GPIO51__FUNC_I2SO1_BCK>,
+			     <PINMUX_GPIO52__FUNC_I2SO1_WS>,
+			     <PINMUX_GPIO53__FUNC_I2SO1_D0>;
+		};
+
+		pins-hp-jack-int-odl {
+			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
 	cr50_int: cr50-irq-default-pins {
 		pins-gsc-ap-int-odl {
 			pinmux = <PINMUX_GPIO88__FUNC_GPIO88>;
@@ -833,6 +861,18 @@ cros-ec-rpmsg {
 	};
 };
 
+&sound {
+	status = "okay";
+
+	mediatek,adsp = <&adsp>;
+	mediatek,dai-link =
+		"DL10_FE", "DPTX_BE", "ETDM1_IN_BE", "ETDM2_IN_BE",
+		"ETDM1_OUT_BE", "ETDM2_OUT_BE","UL_SRC1_BE",
+		"AFE_SOF_DL2", "AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";
+	pinctrl-names = "default";
+	pinctrl-0 = <&aud_pins_default>;
+};
+
 &spi0 {
 	status = "okay";
 
-- 
2.37.2

