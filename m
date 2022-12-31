Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7160765A777
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiLaWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiLaWZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:25:25 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F6B855
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 14:25:10 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NkxX46HmCz1S5Dw
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:25:08 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672525507;
         x=1673389508; bh=FFiZGTOLqnc5O7NWNkxiJRm1CIiUGan+2JsCabL8LJo=; b=
        iMgG0XjYMBgrdzAflBuM0sdaaMBa+AR8g8plK0ZKLBAqaBy9w7JoqcjSLxC9smdL
        +HEx1nPS4sbFVIuMpkQc6UNcWppvUhoZYVke40JvSAsDB80Hki38sTA9r6MKS/tM
        Lj5AGPFTQilAjJazSTp7ep/Jeh6UfkyIVvZ/3VDu0+ej/4NkBkRgN5Xe0MwfoxJY
        9zIIDkXtMC5KRo5EVJW5CisXQNelhnvLAL17oaD/ECpqVyxzGePuoeQQ6qacpnUS
        /a2RbXVaT4VRMvtrbvt3x9dclpWKMYr/Zcf0q5iMpe+K3Hp3KMK2sGNqxlx86zND
        xvM9BOjLbld0G/Kk7kkPOg==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Tf-xuH61grz for <linux-kernel@vger.kernel.org>;
        Sat, 31 Dec 2022 17:25:07 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NkxWy077sz1S5Dr;
        Sat, 31 Dec 2022 17:25:01 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 6/6] arm64: dts: qcom: sm6125: Initial support for xiaomi-laurel-sprout
Date:   Sat, 31 Dec 2022 19:24:20 -0300
Message-Id: <20221231222420.75233-7-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231222420.75233-1-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
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

Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
summary on what's working.

- dmesg output to bootloader preconfigured display
- USB
- UFS
- SD card
- SMD RPM regulators
- Volume Up, Down and Power buttons
- Thermistors

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 413 ++++++++++++++++++
 2 files changed, 414 insertions(+)
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
index 000000000000..cc338c7ef358
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -0,0 +1,413 @@
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
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+
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
+		status =3D "okay";
+		compatible =3D "gpio-keys";
+		autorepeat;
+
+		key-vol-up {
+			label =3D "Volume Up";
+			gpios =3D <&pm6125_gpio 5 GPIO_ACTIVE_LOW>;
+			linux,input-type =3D <1>;
+			linux,code =3D <KEY_VOLUMEUP>;
+			gpio-key,wakeup;
+			debounce-interval =3D <15>;
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
+	rf-pa0-therm@4d {
+		reg =3D <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+	};
+
+	quiet-therm@4e {
+		reg =3D <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+	};
+
+	camera-flash-therm@52 {
+		reg =3D <ADC5_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
+	};
+
+	emmc-ufs-therm@54 {
+		reg =3D <ADC5_GPIO3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time =3D <200>;
+		qcom,pre-scaling =3D <1 1>;
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
+&pm6125_gpio {
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
+	key_vol_up: key_vol_up {
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
+	status =3D "okay";
+	linux,code =3D <KEY_VOLUMEDOWN>;
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
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt =3D <1648000>;
+			regulator-max-microvolt =3D <2950000>;
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
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1952000>;
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
+			regulator-max-microvolt =3D <3304000>;
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
2.38.1

