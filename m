Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C028B6AC9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCFRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCFRWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:22:18 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A932940E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:21:48 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PVlRp5xZ0z1S5KZ
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:09:26 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1678122565;
         x=1678986566; bh=2zBjlW2RfFUNor9tBkFnpnAtnXeIE0/7aP/gy90Q0B4=; b=
        tg3AXkzF6JtPno5jWYUWra9bO2KsRYOjFFGn33/SEcOeWDj3Rk6ofQBg9m20XXc9
        IBF2QwlrtRbPBV09BU7oBIClFmc4nkV7OcmlKzUZu+0A5PGs0Nc3xI3b+ECAkqKQ
        faGkKn6hMcOYV9EQmu/yelf4Co68KWVfxmx1W9WclRt2sA9qFWcoH3iyXqV3IJ/h
        GnJ2apx9CAn99Sr076rcdqptmPZ3pXwVGszVt12Qc+cnKH9OCgIx9ulF9HZQJ9s+
        JrYZddRb5iMNEdFIZ0rqlIv8zIk54ErGi1v9ro9ms2UJqzrtIwgoMIimtfYQY5Wq
        UeDOjxURrdpCiEO5++j/Xg==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RVHLkzNoz798 for <linux-kernel@vger.kernel.org>;
        Mon,  6 Mar 2023 12:09:25 -0500 (EST)
Received: from dorothy.. (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PVlRb36jGz1S52d;
        Mon,  6 Mar 2023 12:09:15 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>
Subject: [PATCH v7 6/6] arm64: dts: qcom: sm6125: Initial support for xiaomi-laurel-sprout
Date:   Mon,  6 Mar 2023 14:08:16 -0300
Message-Id: <20230306170817.3806-7-they@mint.lgbt>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306170817.3806-1-they@mint.lgbt>
References: <20230306170817.3806-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
summary on what's defined.

- dmesg output to bootloader preconfigured display
- USB
- UFS
- SD card
- SMD RPM regulators
- Volume Up, Down and Power buttons
- Thermistors

Signed-off-by: Lux Aliaga <they@mint.lgbt>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 421 ++++++++++++++++++
 2 files changed, 422 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.=
dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom=
/Makefile
index 3e79496292e7..2b2a0170db14 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+=3D sdm850-lenovo-yoga-c630.=
dtb
 dtb-$(CONFIG_ARCH_QCOM)	+=3D sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+=3D sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+=3D sm6125-sony-xperia-seine-pdx201.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+=3D sm6125-xiaomi-laurel-sprout.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+=3D sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+=3D sm6375-sony-xperia-murray-pdx225.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+=3D sm7225-fairphone-fp4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/a=
rch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
new file mode 100644
index 000000000000..b1038eb8cebc
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include "sm6125.dtsi"
+#include "pm6125.dtsi"
+
+/ {
+	model =3D "Xiaomi Mi A3";
+	compatible =3D "xiaomi,laurel-sprout", "qcom,sm6125";
+	chassis-type =3D "handset";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id =3D <394 0>; /* sm6125 v1 */
+	qcom,board-id =3D <11 0>;
+
+	chosen {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		framebuffer0: framebuffer@5c000000 {
+			compatible =3D "simple-framebuffer";
+			reg =3D <0 0x5c000000 0 (1560 * 720 * 4)>;
+			width =3D <720>;
+			height =3D <1560>;
+			stride =3D <(720 * 4)>;
+			format =3D "a8r8g8b8";
+		};
+	};
+
+	reserved-memory {
+		debug_mem: debug@ffb00000 {
+			reg =3D <0x0 0xffb00000 0x0 0xc0000>;
+			no-map;
+		};
+
+		last_log_mem: lastlog@ffbc0000 {
+			reg =3D <0x0 0xffbc0000 0x0 0x80000>;
+			no-map;
+		};
+
+		pstore_mem: ramoops@ffc00000 {
+			compatible =3D "ramoops";
+			reg =3D <0x0 0xffc40000 0x0 0xc0000>;
+			record-size =3D <0x1000>;
+			console-size =3D <0x40000>;
+			msg-size =3D <0x20000 0x20000>;
+		};
+
+		cmdline_mem: memory@ffd00000 {
+			reg =3D <0x0 0xffd40000 0x0 0x1000>;
+			no-map;
+		};
+	};
+
+	extcon_usb: usb-id {
+		compatible =3D "linux,extcon-usb-gpio";
+		id-gpio =3D <&tlmm 102 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible =3D "gpio-keys";
+
+		pinctrl-0 =3D <&vol_up_n>;
+		pinctrl-names =3D "default";
+
+		key-volume-up {
+			label =3D "Volume Up";
+			gpios =3D <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
+			linux,code =3D <KEY_VOLUMEUP>;
+			debounce-interval =3D <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	thermal-zones {
+		rf-pa0-thermal {
+			polling-delay-passive =3D <0>;
+			polling-delay =3D <0>;
+			thermal-sensors =3D <&pm6125_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature =3D <125000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		quiet-thermal {
+			polling-delay-passive =3D <0>;
+			polling-delay =3D <5000>;
+			thermal-sensors =3D <&pm6125_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature =3D <125000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		xo-thermal {
+			polling-delay-passive =3D <0>;
+			polling-delay =3D <0>;
+			thermal-sensors =3D <&pm6125_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature =3D <125000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+		};
+	};
+};
+
+&hsusb_phy1 {
+	vdd-supply =3D <&vreg_l7a>;
+	vdda-pll-supply =3D <&vreg_l10a>;
+	vdda-phy-dpdm-supply =3D <&vreg_l15a>;
+	status =3D "okay";
+};
+
+&pm6125_adc {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&camera_flash_therm &emmc_ufs_therm>;
+
+	adc-chan@4d {
+		reg =3D <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+		label =3D "rf_pa0_therm";
+	};
+
+	adc-chan@4e {
+		reg =3D <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+		label =3D "quiet_therm";
+	};
+
+	adc-chan@52 {
+		reg =3D <ADC5_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+		label =3D "camera_flash_therm";
+	};
+
+	adc-chan@54 {
+		reg =3D <ADC5_GPIO3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+		label =3D "emmc_ufs_therm";
+	};
+};
+
+&pm6125_adc_tm {
+	status =3D "okay";
+
+	rf-pa0-therm@0 {
+		reg =3D <0>;
+		io-channels =3D <&pm6125_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us =3D <200>;
+	};
+
+	quiet-therm@1 {
+		reg =3D <1>;
+		io-channels =3D <&pm6125_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us =3D <200>;
+	};
+
+	xo-therm@2 {
+		reg =3D <2>;
+		io-channels =3D <&pm6125_adc ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us =3D <200>;
+	};
+};
+
+&pm6125_gpios {
+	camera_flash_therm: camera-flash-therm-state {
+		pins =3D "gpio3";
+		function =3D PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+
+	emmc_ufs_therm: emmc-ufs-therm-state {
+		pins =3D "gpio6";
+		function =3D PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+
+	vol_up_n: vol-up-n-state {
+		pins =3D "gpio5";
+		function =3D PMIC_GPIO_FUNC_NORMAL;
+		input-enable;
+		bias-pull-up;
+	};
+};
+
+&pon_pwrkey {
+	status =3D "okay";
+};
+
+&pon_resin {
+	linux,code =3D <KEY_VOLUMEDOWN>;
+	status =3D "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible =3D "qcom,rpm-pm6125-regulators";
+
+		vreg_s6a: s6 {
+			regulator-min-microvolt =3D <936000>;
+			regulator-max-microvolt =3D <1422000>;
+		};
+
+		vreg_l1a: l1 {
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <1256000>;
+		};
+
+		vreg_l2a: l2 {
+			regulator-min-microvolt =3D <1000000>;
+			regulator-max-microvolt =3D <1056000>;
+		};
+
+		vreg_l3a: l3 {
+			regulator-min-microvolt =3D <1000000>;
+			regulator-max-microvolt =3D <1064000>;
+		};
+
+		vreg_l4a: l4 {
+			regulator-min-microvolt =3D <872000>;
+			regulator-max-microvolt =3D <976000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt =3D <1648000>;
+			regulator-max-microvolt =3D <2950000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6a: l6 {
+			regulator-min-microvolt =3D <576000>;
+			regulator-max-microvolt =3D <656000>;
+		};
+
+		vreg_l7a: l7 {
+			regulator-min-microvolt =3D <872000>;
+			regulator-max-microvolt =3D <976000>;
+		};
+
+		vreg_l8a: l8 {
+			regulator-min-microvolt =3D <400000>;
+			regulator-max-microvolt =3D <728000>;
+		};
+
+		vreg_l9a: l9 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1896000>;
+		};
+
+		vreg_l10a: l10 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1896000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1952000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l12a: l12 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1996000>;
+		};
+
+		vreg_l13a: l13 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1832000>;
+		};
+
+		vreg_l14a: l14 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1904000>;
+		};
+
+		vreg_l15a: l15 {
+			regulator-min-microvolt =3D <3104000>;
+			regulator-max-microvolt =3D <3232000>;
+		};
+
+		vreg_l16a: l16 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1904000>;
+		};
+
+		vreg_l17a: l17 {
+			regulator-min-microvolt =3D <1248000>;
+			regulator-max-microvolt =3D <1304000>;
+		};
+
+		vreg_l18a: l18 {
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <1264000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l19a: l19 {
+			regulator-min-microvolt =3D <1648000>;
+			regulator-max-microvolt =3D <2952000>;
+		};
+
+		vreg_l20a: l20 {
+			regulator-min-microvolt =3D <1648000>;
+			regulator-max-microvolt =3D <2952000>;
+		};
+
+		vreg_l21a: l21 {
+			regulator-min-microvolt =3D <2600000>;
+			regulator-max-microvolt =3D <2856000>;
+		};
+
+		vreg_l22a: l22 {
+			regulator-min-microvolt =3D <2944000>;
+			regulator-max-microvolt =3D <2950000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l23a: l23 {
+			regulator-min-microvolt =3D <3000000>;
+			regulator-max-microvolt =3D <3400000>;
+		};
+
+		vreg_l24a: l24 {
+			regulator-min-microvolt =3D <2944000>;
+			regulator-max-microvolt =3D <2950000>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
+&sdc2_off_state {
+	sd-cd-pins {
+		pins =3D "gpio98";
+		function =3D "gpio";
+		drive-strength =3D <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins =3D "gpio98";
+		function =3D "gpio";
+		drive-strength =3D <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	cd-gpios =3D <&tlmm 98 GPIO_ACTIVE_HIGH>;
+	vmmc-supply =3D <&vreg_l22a>;
+	vqmmc-supply =3D <&vreg_l5a>;
+	no-sdio;
+	no-mmc;
+	status =3D "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges =3D <22 2>, <28 6>;
+};
+
+&ufs_mem_hc {
+	vcc-supply =3D <&vreg_l24a>;
+	vccq2-supply =3D <&vreg_l11a>;
+	vcc-max-microamp =3D <600000>;
+	vccq2-max-microamp =3D <600000>;
+	status =3D "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply =3D <&vreg_l4a>;
+	vdda-pll-supply =3D <&vreg_l10a>;
+	vdda-phy-max-microamp =3D <51400>;
+	vdda-pll-max-microamp =3D <14200>;
+	vddp-ref-clk-supply =3D <&vreg_l18a>;
+	status =3D "okay";
+};
+
+&usb3 {
+	status =3D "okay";
+};
+
+&usb3_dwc3 {
+	extcon =3D <&extcon_usb>;
+};
--=20
2.39.2

