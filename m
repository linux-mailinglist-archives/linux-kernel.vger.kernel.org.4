Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE066F7741
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjEDUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEDUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:49 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4333317DC7;
        Thu,  4 May 2023 13:34:33 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4QC5BJ1WsCzDqLq;
        Thu,  4 May 2023 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683232424; bh=HyW6f1Ejq4tIEj0Ox1OW5zxpUg9RZUeQecRE7TjEwF8=;
        h=From:Date:Subject:To:Cc:From;
        b=dAl8oQX2qAEHubEYq6oYv3DfQfX/+qJnsmMSiN5saAnk4kfl6/pBBvOmksVv0htu1
         wW4ttzpct9SOdt1gFTaoG4fMq6LN6SHV3l6zmBqTSPgiytos55v1fPvfMb3yRnUl1t
         tMP9cjyJi4ZCC7TgP2O9/OgJxo000lqT0zmKAnKQ=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4QC5B55pNSz9sBP;
        Thu,  4 May 2023 20:33:33 +0000 (UTC)
X-Riseup-User-ID: 17BAC0AD338C584C9D8A37E6AB80C09961D7D9D8A9766880A1B9198BED57A7C1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QC5B32NmnzJmmZ;
        Thu,  4 May 2023 20:33:31 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Date:   Fri, 05 May 2023 03:33:25 +0700
Subject: [PATCH] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net>
X-B4-Tracking: v=1; b=H4sIAJQWVGQC/y2NQQrCMBBFr1Jm7cA0trR6FXGRxonNJgkzUQKld
 zdVlw/e+38DZQmscO02EH4HDSk26E8duNXGJ2N4NAZD5kwjjehrYYdZUl9RXzknKTj5aTaehpn
 4Aq1crDIuYqNbj/YnR67lvzIcUhb2oX6vb/d9/wDvQu6uigAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7528; i=danct12@riseup.net;
 h=from:subject:message-id; bh=HyW6f1Ejq4tIEj0Ox1OW5zxpUg9RZUeQecRE7TjEwF8=;
 b=owEBbQKS/ZANAwAIAWbKt+qkXdeBAcsmYgBkVBaaPpPJMYIY1wbiV1ji1jBAYSuMBqoO18GbO
 lXiN4rFR0KJAjMEAAEIAB0WIQTwmpM8D+AzHlWMpOFmyrfqpF3XgQUCZFQWmgAKCRBmyrfqpF3X
 gWPLD/0XkeWj9WmEuWXv7CvwienhcZvD6vBAsGlA8g21K7qT+CtfVQT/sBq/kwt0h9kun6MiL3o
 8draZioUlagREn3E1YyrzzUpbnJlL1m40A/k0FAOS4q5QC+u9t6M1rboHDEBWTHdmIdYZ6YiTaH
 ogqO3cHkAD8gWDu9lyu2RgxlVvMfPxYhRA4JOf6ZJI8JoN/TgXdrRiDvgFUhElF/BvbE0EShEIw
 i2OCCXwlPjyDeBou6qJkHkhQFK9H4uGYzM+XGtWSJbnqaCfKpm6HdyxsJotVNfreUck0H+9na7K
 QeYn6OqoX+2o6uuuQOAW+IfkdGwvUco9op+q74ztjDJZdz3JR1GFnp6DKx8FggyEQPkWXlir6B9
 Jn5m1sTFFOjvlgA5hUNJZ8HUwuf87S72ApoKOj1oHgE0h3KOlc+tRAgI18QBMFLKqfdylUCCX0x
 HlX0gC9MpzYacAfzMscJHAJ5NFx3cOf3EUVZMUbEexi59z/CS9IsXxHyQwFThKoI/gxatEXpN+c
 yCgNlYKL5kp8sNGCht4/869SF7DnsZ8Z5wuwrnZcp+65+ShNWZ1pjHIXRMF570XcSXMUVJeN8iE
 PWaWQju6dzg2QH5VVtw8eVmiyaB/TbNPZOaeGEb806duMjiFdZ7HS99mxdkYz7JFrXcbgluLoGb
 UjBD3LZPmcU4axw==
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
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 252 ++++++++++++++++++++++++
 2 files changed, 253 insertions(+)

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
index 000000000000..f1d18710d2f0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
+ */
+
+/dts-v1/;
+
+#include "sm6115.dtsi"
+#include "pm6125.dtsi"
+
+/ {
+	model = "F(x)tec Pro1 (QX1050)";
+	compatible = "fxtec,pro1x", "qcom,sm6115";
+	chassis-type = "handset";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <417 0x10000>, <444 0x10000>;
+	qcom,board-id = <34 0>;
+
+	aliases {
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer0: framebuffer@5c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x5c000000 0 (1080 * 2160 * 4)>;
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_n>;
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
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <14 4>;
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
+&dispcc {
+	/* HACK: disable until a panel driver is ready to retain simplefb */
+	status = "disabled";
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
+	pm6125-regulators {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vreg_s6a: s6 {
+			regulator-min-microvolt = <304000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		vreg_s7a: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s8a: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l1a: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		vreg_l4a: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		vreg_l6a: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l8a: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l10a: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l12a: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		vreg_l13a: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l14a: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1384000>;
+		};
+
+		vreg_l18a: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1312000>;
+		};
+
+		vreg_l19a: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l20a: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l21a: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		vreg_l22a: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l23a: l23 {
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		vreg_l24a: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&ufs_mem_hc {
+	vcc-supply = <&vreg_l24a>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&vreg_l11a>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vddp-ref-clk-supply = <&vreg_l18a>;
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
+	vdd-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+	status = "okay";
+};

---
base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
change-id: 20230505-fxtec-pro1x-support-7f782f0480e9

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

