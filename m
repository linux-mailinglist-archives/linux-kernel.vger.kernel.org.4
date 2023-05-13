Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5867013A1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 03:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbjEMBFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 21:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbjEMBFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 21:05:46 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDD9026;
        Fri, 12 May 2023 18:05:40 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4QJ6r856t5zDr8G;
        Sat, 13 May 2023 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683939940; bh=OY7l7rYNqi9qEr0PvHVynyXqnCQxKhcV6ItU3jS1v4I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VhnzIm7sIyvh3fkH1DJ4WHRXUwT84QSqMQbhXr3KxlVjJQC6g+oFPqnMATOVImoM6
         cEIC4y2D+2/V+lv/w+fCoMa87NasaDaEafnB6f6Dp+Gjdkggv1MGhLmAArAQAe3HNa
         uUpIq2eQS4gWmcQ8LUPhAuxSoNStjUjnZDGG0hVA=
X-Riseup-User-ID: AE309535D314BDE18FF9B3C3D4D4A34F2E36E5D3C5F1FB583FF8B89F1D24AAA3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QJ6r60SySzJp1Q;
        Sat, 13 May 2023 01:05:25 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Date:   Sat, 13 May 2023 08:05:05 +0700
Subject: [PATCH v3 2/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230505-fxtec-pro1x-support-v3-2-0c9c7f58b205@riseup.net>
References: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
In-Reply-To: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7444; i=danct12@riseup.net;
 h=from:subject:message-id; bh=OY7l7rYNqi9qEr0PvHVynyXqnCQxKhcV6ItU3jS1v4I=;
 b=owEBbQKS/ZANAwAIAWbKt+qkXdeBAcsmYgBkXuJPuNYgTsjZOO5J6HdlFRKsqbus9S6LP0JkG
 XevpPBKRuOJAjMEAAEIAB0WIQTwmpM8D+AzHlWMpOFmyrfqpF3XgQUCZF7iTwAKCRBmyrfqpF3X
 gbviEACzyxH+M1iK8MI0W2GzIZgn8OBOgO0c1BSx46PPJU7MDTWC4MtAP7zdHaXEwJnTVzgamAU
 /po6q2sXFvx3wV8mMxIQtxNIfBShScIFxmCbPK+2idqv5TcL82iD56sroc4xC7pxBUDUeOkhIgt
 pQLYWoBcgp/VFqf5E7dBI5IWq4qrQMu92cwa9/RKmKb45AypFFyzOJfMIs9Qn0TrzRixoYq7M1b
 0ILg4SPtUc1ioC3he2HGRyms7e/XvUxKfoAAOM7OpvnP3+nHBHt7IsHyeACdVwXO/LdyGJ9WYyK
 2mohyPg/q1W0uhO9ouFbSrEM968Zb84lyQ34mb894LvO8aemWS+stgmHWbBH8V9BMFM4miBogoE
 2NG+bwETdN33XZTIuoe7fV7m+obpURWeXIMgp0d+mmbBp/vB1YmqXZN35oY7AcVthu5WVrZtqv0
 lDu+0bZrICWxC7lJ7sSufc9d58+FS+1aZMtai26RDeVpQiVhor5O/uMl7CwFgY0dVJJRO7RHs5z
 VftePxdkQVjvshKvqj7lCE6+zdFpuMknefW6GeB5/ANp3OMxTXvJyhWY1G0HPe0kZssutHBOByG
 5mzDwbnFMGu6fd/g5UIZNu/h8hWn2orGiNE3oI8rlzG23kLlAn9H1WOiS/ywMi2cr57Ols0GcJZ
 jM95I/9z4EQQrDw==
X-Developer-Key: i=danct12@riseup.net; a=openpgp;
 fpr=F09A933C0FE0331E558CA4E166CAB7EAA45DD781
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
in 2022.

The phone is exactly the same as the Pro1 released in 2019 with some
changes:
- MSM8998 -> SM6115
- Camera button is no longer multistate
- Only one 48MP back camera
- A new keyboard layout picked by the community.

This commit has the following features working:
- Display (using simplefb)
- UFS
- Power and volume buttons
- Pinctrl
- RPM Regulators
- USB (Device Mode)

To get a successful boot run:

cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/\
sm6115-fxtec-pro1x.dtb  > .Image.gz-dtb

mkbootimg --kernel .Image.gz-dtb \
--ramdisk initrd.img \
--base 0x0 \
--kernel_offset 0x8000 \
--ramdisk_offset 0x1000000 \
--second_offset 0xf00000 \
--tags_offset 0x100 \
--pagesize 4096 \
--cmdline "CMDLINE HERE" \
-o qx1050-boot.img

fastboot flash boot qx1050-boot.img
fastboot erase dtbo
fastboot reboot

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 250 ++++++++++++++++++++++++
 2 files changed, 251 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d42c59572ace..e311ba675f35 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -174,6 +174,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
new file mode 100644
index 000000000000..3ce9875e932c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
+ */
+
+/dts-v1/;
+
+#include "sm6115.dtsi"
+#include "pm6125.dtsi"
+#include <dt-bindings/arm/qcom,ids.h>
+
+/ {
+	model = "F(x)tec Pro1X (QX1050)";
+	compatible = "fxtec,pro1x", "qcom,sm6115";
+	chassis-type = "handset";
+
+	qcom,msm-id = <QCOM_ID_SM6115 0x10000>;
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer0: framebuffer@5c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0x5c000000 0x0 (1080 * 2160 * 4)>;
+			width = <1080>;
+			height = <2160>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&vol_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+	};
+};
+
+&dispcc {
+	/* HACK: disable until a panel driver is ready to retain simplefb */
+	status = "disabled";
+};
+
+&pm6125_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio5";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		pm6125_s6a: s6 {
+			regulator-min-microvolt = <304000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		pm6125_s7a: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		pm6125_s8a: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l1a: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		pm6125_l4a: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm6125_l5a: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		pm6125_l6a: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		pm6125_l7a: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l8a: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		pm6125_l9a: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l10a: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l11a: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+			regulator-allow-set-load;
+		};
+
+		pm6125_l12a: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		pm6125_l13a: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		pm6125_l14a: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l15a: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		pm6125_l16a: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		pm6125_l17a: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1384000>;
+		};
+
+		pm6125_l18a: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1312000>;
+		};
+
+		pm6125_l19a: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l20a: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l21a: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		pm6125_l22a: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l23a: l23 {
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24a: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <14 4>;
+};
+
+&ufs_mem_hc {
+	vcc-supply = <&pm6125_l24a>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&pm6125_l11a>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&pm6125_l4a>;
+	vdda-pll-supply = <&pm6125_l12a>;
+	vddp-ref-clk-supply = <&pm6125_l18a>;
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
+&usb_hsphy {
+	vdd-supply = <&pm6125_l4a>;
+	vdda-pll-supply = <&pm6125_l12a>;
+	vdda-phy-dpdm-supply = <&pm6125_l15a>;
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};

-- 
2.40.1

