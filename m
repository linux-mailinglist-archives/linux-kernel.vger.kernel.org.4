Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2649E64E0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLOSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLOSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:24:53 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14EC4876D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:24:51 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NY0yB28C0z1S4tN
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:24:50 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1671128689;
         x=1671992690; bh=L2vpO3fqYNWaVdzbjd/ELrTw+gV/I3Z57NB7dWfmFMc=; b=
        bbPTlw/tKl0/RA0tzcWR7j4r3+ZmzGNHe2/qLl3KmOSA3/W+mYCvlL6NC9m3hPAi
        kCd3Dy/Rivan3hpwexPzyrKNyiiwkKjA75DgmaUbvhEYBhL7oup8/uBbCvA4jwS2
        sOPkC3tdhtyMe5w7y9eOQ8oheR9ZrynWo5sc4lNcb3OtE9lNdBdZty/P5fiWXR1m
        bjkVRZWglPXUMKFYg3rs3Uv0KkXMDAFs7wMBu0v5Qiz5FmyjqxwUGGt6J3YEYqEK
        OGzQNorjathocJehC5GB4qEJLOBKLEMM016ZBuKeHOtsmD6MmbE4MubtME/QTU+p
        E6HWow7ZbQNj89qtQaUSUA==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c66SdlzoGVYs for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 13:24:49 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NY0y35s9Dz1S5D0;
        Thu, 15 Dec 2022 13:24:43 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Lux Aliaga <they@mint.lgbt>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: qcom: sm6125: Initial support for xiaomi-laurel-sprout
Date:   Thu, 15 Dec 2022 15:24:12 -0300
Message-Id: <20221215182412.386064-4-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215182412.386064-1-they@mint.lgbt>
References: <20221215182412.386064-1-they@mint.lgbt>
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
- SMD RPM regulators

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 254 ++++++++++++++++++
 2 files changed, 255 insertions(+)
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
index 000000000000..acdfaa83b152
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -0,0 +1,254 @@
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
+#include "sm6125.dtsi"
+
+/ {
+	/* required for bootloader to select correct board */
+	qcom,msm-id =3D <394 0>; /* sm6125 v0 */
+	qcom,board-id =3D <11 0>;
+
+	model =3D "Xiaomi Mi A3";
+	compatible =3D "xiaomi,laurel-sprout", "qcom,sm6125";
+	chassis-type =3D "handset";
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
+	extcon_usb: usb-id {
+		compatible =3D "linux,extcon-usb-gpio";
+		id-gpio =3D <&tlmm 102 GPIO_ACTIVE_HIGH>;
+	};
+
+	reserved-memory {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+
+		debug_mem: memory@ffb00000 {
+			reg =3D <0x0 0xffb00000 0x0 0xc0000>;
+			no-map;
+		};
+
+		last_log_mem: memory@ffbc0000 {
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
+};
+
+
+&hsusb_phy1 {
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
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt =3D <1648000>;
+			regulator-max-microvolt =3D <3104000>;
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
+			regulator-max-microvolt =3D <3304000>;
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
+&tlmm {
+	gpio-reserved-ranges =3D <22 2>, <28 6>;
+};
+
+&ufs_mem_hc {
+	vcc-supply =3D <&vreg_l24a>;
+	vccq2-supply =3D <&vreg_l11a>;
+	vcc-max-microamp =3D <600000>;
+	vccq2-max-microamp =3D <600000>;
+
+	status =3D "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply =3D <&vreg_l4a>;
+	vdda-pll-supply =3D <&vreg_l10a>;
+	vdda-phy-max-microamp =3D <51400>;
+	vdda-pll-max-microamp =3D <14200>;
+	vddp-ref-clk-supply =3D <&vreg_l18a>;
+
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

