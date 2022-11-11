Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68EF625A25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiKKMDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiKKMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C185450;
        Fri, 11 Nov 2022 04:02:16 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D1836602A7D;
        Fri, 11 Nov 2022 12:02:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668168135;
        bh=iz94emL+JF9s4mzYlCcC+kyE/fLPjDpZFpKTPzTyij0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdDzoXtJG+U399fxeBf7s7f0HjKbuJD01JUtJ1xhh35X09gSQvSrmi9uJcWwIXEqX
         wi1ilKPsdphAMeNwAX7Yd2mEy4sBz0Wj6w/7/TzFcpBjSiw5xYaKnYTt+D6gphJuXB
         IiUifIjwbE0jGJPGVAvdrPY91P2Zl2ioUpBExv01usULFM5vtZ3DUMyTJSvnaDcXFm
         TPFuSvZa3X4kylce3aZuuTQTfoKfeI9JhzAo+rCbuaTvmoo8XC3B5zco3doLSX5TuS
         hGumABXjQIBqUq5BAVf6yrxNggwqacia7fCKvXr92a8znQgduvms+8D/1rw5hpUFO8
         kUP/+sLuv5jbg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 09/11] arm64: dts: qcom: Add configuration for PM8950 peripheral
Date:   Fri, 11 Nov 2022 13:01:54 +0100
Message-Id: <20221111120156.48040-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
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

The PM8950 features integrated peripherals like ADC, GPIO controller,
MPPs, PON keys and others.
Add them to DT files that will be imported on boards having this PMIC
combo (or one of them, anyways).

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/qcom/pm8950.dtsi | 165 +++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8950.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
new file mode 100644
index 000000000000..07c3896bd36f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
+ */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@0 {
+		compatible = "qcom,pm8950", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
+		pm8950_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8950_vadc VADC_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8950_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			vcoin@5 {
+				reg = <VADC_VCOIN>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vph-pwr@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			die-temp@8 {
+				reg = <VADC_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			ref-625mv@9 {
+				reg = <VADC_REF_625MV>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			ref-1250mv@a {
+				reg = <VADC_REF_1250MV>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			ref-buf-625mv@c {
+				reg = <VADC_SPARE1>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			ref-gnd@e {
+				reg = <VADC_GND_REF>;
+			};
+
+			ref-vdd@f {
+				reg = <VADC_VDD_VADC>;
+			};
+
+			pa-therm1@11 {
+				reg = <VADC_P_MUX2_1_1>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+
+			case-therm@13 {
+				reg = <VADC_P_MUX4_1_1>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+
+			xo-therm@32 {
+				reg = <VADC_LR_MUX3_XO_THERM>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+
+			pa-therm0@36 {
+				reg = <VADC_LR_MUX7_HW_ID>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+
+			xo-therm-buf@3c {
+				reg = <VADC_LR_MUX3_BUF_XO_THERM>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
+
+		pm8950_mpps: mpps@a000 {
+			compatible = "qcom,pm8950-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			gpio-ranges = <&pm8950_mpps 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm8950_gpio: gpio@c000 {
+			compatible = "qcom,pm8950-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8950_gpio 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm8950", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8950_spmi_regulators: regulators {
+			compatible = "qcom,pm8950-regulators";
+		};
+	};
+};
-- 
2.38.1

