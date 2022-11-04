Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031F1619E93
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKDRWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiKDRWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:22:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EBE419B1;
        Fri,  4 Nov 2022 10:22:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B850E66029C6;
        Fri,  4 Nov 2022 17:22:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667582529;
        bh=vsfYm7vT2qPx9XRLWafhLpoqUySt2VlZYr6JdWn83Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1D65A7/7aSe7/+j6edpGLnIj0gexTW6+ufMRuli1IOAv1zVGxajwqzrwoF51F0C8
         AnnDLUKXSBGU/lt8ToWj7kXaBlGV3eaTmNFdaVhyAnXDNgz98jU46fImy2ftobSpOT
         KzZKDangddif6TYWDXfR50C3OhokEiVjN8C9Jd1TF1sR3BSUfk16o3LhM3kMdDxud8
         6w1r1ErKllNbszeOYJg5m04nJH6prN9j0al3tzhvjXiLvtei9cXDheCYd8c8s2D9CI
         JnYH3pZJIRHjT2GLOWcSPwbFxAk2W8iFkhAbDdwgCbbgwwzBmYp8O5xzXkMPr1h7P9
         nTgmnrbWrGMpg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 9/9] arm64: dts: qcom: Add support for SONY Xperia X/X Compact
Date:   Fri,  4 Nov 2022 18:21:22 +0100
Message-Id: <20221104172122.252761-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

This adds support for the Sony Xperia Loire/SmartLoire platform
with a base configuration that is common across all of the
devices that are based on this project.

Also adds a base DT configuration for the Xperia X and Xperia
X Compact (respectively, Suzu and Kugo) which is valid for both
their RoW (single-sim), DSDS (dual-sim) and other regional
variants of these two smartphones, that makes us able to boot
to a UART console.

Please note that, currently, the APC0/1 (cluster 0/1) vregs
are set to a safe voltage in order to ensure boot stability
until a proper solution for CPU DVFS scaling lands.

Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../qcom/msm8956-sony-xperia-loire-kugo.dts   |  36 +++
 .../qcom/msm8956-sony-xperia-loire-suzu.dts   |  17 ++
 .../dts/qcom/msm8956-sony-xperia-loire.dtsi   | 269 ++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b0558d3389e5..55ba551963fc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
new file mode 100644
index 000000000000..0e34e15f2ae8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
+ *                          <angelogioacchino.delregno@somainline.org>
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
+ */
+
+/dts-v1/;
+
+#include "msm8956-sony-xperia-loire.dtsi"
+
+/ {
+	model = "Sony Xperia X Compact";
+	compatible = "sony,kugo-row", "qcom,msm8956";
+	chassis-type = "handset";
+};
+
+&blsp2_i2c2 {
+	status = "okay";
+
+	/* FUSB301 USB-C Controller */
+};
+
+&blsp2_i2c4 {
+	status = "okay";
+
+	/* ST STMVL53L0 ToF @ 29 */
+	/* AMS TCS349 RGBCIR @ 72 */
+};
+
+&pm8950_l1 {
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1300000>;
+	qcom,init-voltage = <1200000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dts b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dts
new file mode 100644
index 000000000000..87d657f6806b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
+ *                          <angelogioacchino.delregno@somainline.org>
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
+ */
+
+/dts-v1/;
+
+#include "msm8956-sony-xperia-loire.dtsi"
+
+/ {
+	model = "Sony Xperia X";
+	compatible = "sony,suzu-row", "qcom,msm8956";
+	chassis-type = "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
new file mode 100644
index 000000000000..2ac21b05cb68
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
+ *                          <angelogioacchino.delregno@somainline.org>
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
+ */
+
+#include "msm8956.dtsi"
+
+#include "pm8004.dtsi"
+#include "pm8950.dtsi"
+#include "pmi8950.dtsi"
+
+/ {
+	qcom,msm-id = <266 0x10001>; /* MSM8956 v1.1 */
+	qcom,board-id = <8 0>;
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		mmc2 = &sdhc_3; /* SDC3 SDIO card slot */
+		serial0 = &blsp2_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		ramoops@57f00000 {
+			compatible = "ramoops";
+			reg = <0 0x57f00000 0 0x100000>;
+			record-size = <0x20000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x20000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+
+	usbphy_1p2: regulator-usbphy-1p2 {
+		compatible = "regulator-fixed";
+		regulator-name = "usbphy-1p2";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vph_pwr>;
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph-pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	/* Synaptics RMI4 @ 2c */
+};
+
+&blsp2_uart2 {
+	status = "okay";
+};
+
+&gcc {
+	vdd_gfx-supply = <&pm8004_s5>;
+};
+
+&otg {
+	status = "okay";
+};
+
+&pm8004_spmi_regulators {
+	vdd_s2-supply = <&vph_pwr>;
+	vdd_s5-supply = <&vph_pwr>;
+
+	/* Cluster 1 supply */
+	pm8004_s2: s2 {
+		/* regulator-min-microvolt = <500000>; */
+		/* Set .95V to prevent unstabilities until CPR for this SoC is done */
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1165000>;
+		regulator-name = "vdd_apc1";
+		/* Set always on until the CPU PLL is done */
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	pm8004_s5: s5 {
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1165000>;
+		regulator-enable-ramp-delay = <500>;
+		regulator-name = "vdd_gfx";
+		/* Hack this on until the gpu driver is ready for it */
+		regulator-always-on;
+	};
+};
+
+&pm8950_spmi_regulators {
+	vdd_s5-supply = <&vph_pwr>;
+
+	/* Cluster 0 supply */
+	pm8950_spmi_s5: s5 {
+		/* Set .95V to prevent unstabilities until CPR for this SoC is done */
+		/* regulator-min-microvolt = <790000>; */
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1165000>;
+		regulator-name = "vdd_apc0";
+		/* Set always on until the CPU PLL is done */
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&rpm_requests {
+	pm8950_regulators: regulators {
+		compatible = "qcom,rpm-pm8950-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_l1_l19-supply = <&pm8950_s3>;
+		vdd_l2_l23-supply = <&pm8950_s3>;
+		vdd_l3-supply = <&pm8950_s3>;
+		vdd_l5_l6_l7_l16-supply = <&pm8950_s4>;
+		vdd_l8_l11_l12_l17_l22-supply = <&vph_pwr>;
+
+		pm8950_s1: s1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1162500>;
+		};
+
+		pm8950_s3: s3 {
+			regulator-min-microvolt = <1325000>;
+			regulator-max-microvolt = <1325000>;
+			regulator-always-on;
+		};
+
+		pm8950_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8950_l1: l1 {
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8950_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8950_l3: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8950_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8950_l9: l9 {
+			regulator-min-microvolt = <2000000>;
+			regulator-max-microvolt = <2400000>;
+		};
+
+		pm8950_l10: l10 {
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8950_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8950_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8950_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8950_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l17: l17 {
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8950_l22: l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8950_l23: l23 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8950_l8>;
+	vqmmc-supply = <&pm8950_l5>;
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm8950_l11>;
+	vqmmc-supply = <&pm8950_l12>;
+	cd-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>;
+};
+
+&usb_hs_phy {
+	status = "okay";
+
+	vdd-supply = <&usbphy_1p2>;
+	vdda1p8-supply = <&pm8950_l7>;
+	vdda3p3-supply = <&pm8950_l13>;
+};
-- 
2.37.2

