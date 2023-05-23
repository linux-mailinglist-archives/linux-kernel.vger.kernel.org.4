Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113C570E6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbjEWUmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjEWUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:42:37 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DA185;
        Tue, 23 May 2023 13:42:22 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C4414CFBBB;
        Tue, 23 May 2023 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684874500; bh=HFBWsBkYn2DBr6AAVznAZpdgrKhwcQeGU1Uuc9j2Tyo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=aB8Kt7UZQxO2zuc5lflRIrvIhssI9kLblxslBjA+RN7je3JmR/UiM2ESFLmFIYKgC
         BLrv3dXaEU4K6q35fSHwZQaOx5A+q4OcMPDttVs/wDBEFbp3jgR3DXTRBIFeDpYiFp
         Q55sOyBTMP7p92bDwE5yE5VRrAfJSPx674LhSiK0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:41:28 +0200
Subject: [PATCH v3 1/3] arm64: dts: qcom: Add PMI632 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v3-1-079d2cada699@z3ntu.xyz>
References: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=HFBWsBkYn2DBr6AAVznAZpdgrKhwcQeGU1Uuc9j2Tyo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbST/jPJnNPzcCOq8KElAPLGfrMhiVGRehOhpa
 HyCVST7TWmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0k/wAKCRBy2EO4nU3X
 VuKyEACpa+TDToJSB3k9vfbSK0mPOS3p3K4/3lzzuNN/GV4sTKmlgw9l3FnApTzXZm0Lg8k3kPx
 eKqAuXb+sf44JFE/6kMRiMFo9brJspUqov02Rl6vbWrz6vfQcVoNC6c9IbmoH2/Q0A+0hGWOGFm
 uO6xdHOKGHaVgUXTzCpCGFcD/EJkXW0a8Vv2k2MmjCUWmoMdFAGd05mvNa6UpU9aIwCghwNLJpn
 VBhg50eaZB7yxxxGFnJb3RuS/78a/A5jb9ikk8B0VrBxVNIWFvmpCC9eEF7oLbh+4N5kaAWhjRV
 hv1UwMvya+ToF2xICEAxPVpQPWzZcr/5PRFVs+krJWfVOntEmxGXWnj1p4+q5pmR+xVtAc3w22t
 RcQDXcaVvsIsXhLoogPBxeDGNTdaScPySQNkkm6qx+FuUKxLauklx301AuYk/RRJIVeW+hCwrxI
 mHHAY+Csy+fYIWkUz6EpiJZ4Any8p63jU2nJ4jvyFYkVXwmIVkL5wNdq1qTiKM0daaQS/SwLVtf
 FOSbthPM9Ra2O/Ddi/Uddba8MNire+o0u2pqTI8O8V8a8IZCE1oen8ZoVwscZfQB0u+1qi7tkSZ
 dzTAerS9gmuQjXJn1GDpXnwrpSmiPM8rEk9uWhwD2RAEayuTkJghYQTgHdPgloNsznHREEMg0fx
 l5xdQP2ofIyuP/Q==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMI632, commonly found on SoCs with SDM632 has various standard
functions like ADC, GPIOs, LPG and more.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/pmi632.dtsi | 165 +++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
new file mode 100644
index 000000000000..4eb79e0ce40a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
+ */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pmi632-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmi632_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@2 {
+		compatible = "qcom,pmi632", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi632_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmi632_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			channel@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			channel@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			channel@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+
+			channel@7 {
+				reg = <ADC5_USB_IN_I>;
+				qcom,pre-scaling = <1 1>;
+				label = "usb_in_i_uv";
+			};
+
+			channel@8 {
+				reg = <ADC5_USB_IN_V_16>;
+				qcom,pre-scaling = <1 16>;
+				label = "usb_in_v_div_16";
+			};
+
+			channel@9 {
+				reg = <ADC5_CHG_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "chg_temp";
+			};
+
+			channel@4b {
+				reg = <ADC5_BAT_ID_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_id";
+			};
+
+			channel@83 {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+
+			channel@84 {
+				reg = <ADC5_VBAT_SNS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vbat_sns";
+			};
+		};
+
+		pmi632_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		pmi632_sdam_7: nvram@b600 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0xb600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xb600 0x100>;
+		};
+
+		pmi632_gpios: gpio@c000 {
+			compatible = "qcom,pmi632-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pmi632_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@3 {
+		compatible = "qcom,pmi632", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi632_lpg: pwm {
+			compatible = "qcom,pmi632-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+	};
+};

-- 
2.40.1

