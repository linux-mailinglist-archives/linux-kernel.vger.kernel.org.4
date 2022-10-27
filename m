Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793C560F420
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiJ0Jzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiJ0JzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:55:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274557247;
        Thu, 27 Oct 2022 02:55:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 41C2066028D3;
        Thu, 27 Oct 2022 10:55:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666864518;
        bh=xcx9U/aROaZZ49l0z81maIZawW15cVft/U5u/XSuPjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRI1BCTmmBayY8GX84Fj90iefNeS98hIY11MZn66mHWuztY07oE+LM46VcMnuO0tD
         wGht6GYbb/gzDUEUqaRBZM5vYhcRjrQPFX3+7NQVExsfc7fBV0PojqR7oNCDmjyVfn
         zkrGtWC4Q1IpS+VA4Ie3RVriVA6Gt8/8DbPDG8gLb6iGZPfOd8YSIXUZg2PC7iS5op
         xg2TgEi3iEdNNRRARi0RV3jYVQBY66QT2EOoqamWZFggdVIWh8jPQOAuK6LGGtaHMn
         FpMDX5yZXEbA7oPEXV4Kci6lDhjLYKQTfCAQ8piOHILL2+zW5cOdTFIke/VQPU2nYw
         JXpziFrc5PG3g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sam.shih@mediatek.com, andrew@lunn.ch, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 6/6] arm64: dts: mediatek: Add support for MT6795 Sony Xperia M5 smartphone
Date:   Thu, 27 Oct 2022 11:55:04 +0200
Message-Id: <20221027095504.37432-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
References: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
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

Add a basic support for the Sony Xperia M5 (codename "Holly")
smartphone, powered by a MediaTek Helio X10 SoC.

This achieves a console boot.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 88 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 04597ffc4286..179661c9cc1c 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
new file mode 100644
index 000000000000..d3415527d389
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Collabora Ltd
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+/dts-v1/;
+#include "mt6795.dtsi"
+
+/ {
+	model = "Sony Xperia M5";
+	compatible = "sony,xperia-m5", "mediatek,mt6795";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x1e800000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@43000000 {
+			reg = <0 0x43000000 0 0x30000>;
+			no-map;
+		};
+
+		/* preloader and bootloader regions cannot be touched */
+		preloader-region@44800000 {
+			reg = <0 0x44800000 0 0x100000>;
+			no-map;
+		};
+
+		bootloader-region@46000000 {
+			reg = <0 0x46000000 0 0x400000>;
+			no-map;
+		};
+	};
+};
+
+&pio {
+	uart0_pins: uart0-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO113__FUNC_URXD0>;
+			bias-pull-up;
+			input-enable;
+		};
+		pins-tx {
+			pinmux = <PINMUX_GPIO114__FUNC_UTXD0>;
+			output-high;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO31__FUNC_URXD2>;
+			bias-pull-up;
+			input-enable;
+		};
+		pins-tx {
+			pinmux = <PINMUX_GPIO32__FUNC_UTXD2>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+};
+
+&uart2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
-- 
2.37.2

