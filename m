Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038F5B6CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiIMMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiIMMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:14:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4626F7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:14:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n8so1786288wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=zGKP5Wt8s+Izp0RT7HfI6dIBI6KAZhMJfhNjmmY98W4=;
        b=0UqYnVo4Jbqe8LXs7OjZWBMhtQf+4+scrr3ibhRVL3Q5dMwq/sS+iQXMQTjSCychMl
         uJJRJxbB3masQmC6gUeGCFj/SJ6yA+lsxCyNI4TeRGIYPwiJe8dnTXFZy9iqTM095L5x
         e9tl21rRKgkFtBH7wWBBZQefONF9KSNyP/Q4U3q7f+w+gxbfbjf8cuUBF1XQnxSbNg3Z
         TIIPMNCcQqkcDPVpdeg0JmPdVMsSM8g0TGpsQrLe6VbU7GNHJP71Abg6oNw1GNsXKX1G
         IaVRoUE0p8K8IgzSkdtZNM2P71IHE/kX8T7UzfZS4dEstaVfJqKpG0NrQjq+tJoOwWdD
         sebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zGKP5Wt8s+Izp0RT7HfI6dIBI6KAZhMJfhNjmmY98W4=;
        b=Y+I+UCddnVFwPt823UaOF7VPDT73kMWTlnGK+iCmYoRHsNHevfQ6p3pQcLH10o16JX
         s1M3oSp5jNxKWY3/dEl0AVp9LYjlCsznOsNVOH6s+xNs2oxyEESLYopNOqITbrkHJRe1
         dGNzFDkg0r434T5TDYs34WQ76DmTTTJ8I5snvJnQn/gPgRdgztCu6Bx3xyKGlx4y2HVs
         /2GhmN9W55oG2uurvrOsUS/fjGY3WzBYg3uPUjTDO6w2kRV1+xCkY7I2zdp8TtFs9Dm9
         pQp6Jrjhw4DJ8vY8efI2mxyqQ81yq3B6vl3GkJlqp1TUz2bjMO71hIymoUvHW0mglivA
         ci7Q==
X-Gm-Message-State: ACgBeo2IpOC6Gj17T5s22uqnuQk68Wi5HOtisB1B82SSFH9KTC+L3Vff
        CBZURodurcWueI4M3ECXcEAvEw==
X-Google-Smtp-Source: AA6agR4QVGRqtnAU1nY0ysQpYybBo4ZENNZEnqRIwRHfB0kXuBiTsTdxgVqMxemmPUXm87WQvzFRdQ==
X-Received: by 2002:a05:600c:26d2:b0:3b4:7572:4317 with SMTP id 18-20020a05600c26d200b003b475724317mr2296122wmv.134.1663071269121;
        Tue, 13 Sep 2022 05:14:29 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id p10-20020adf9d8a000000b00228634628f1sm10512230wre.110.2022.09.13.05.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:14:28 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v5 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC support for AM642 SK board.
Date:   Tue, 13 Sep 2022 14:14:14 +0200
Message-Id: <20220913121419.15420-2-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913121419.15420-1-jneanne@baylibre.com>
References: <20220913121419.15420-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support fot the TI Power Management IC TPS65219
on the AM642 SKEVM board.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 104 +++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 2620469a7517..565b50810579 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -150,6 +150,20 @@
 		vin-supply = <&com8_ls_en>;
 		gpio = <&main_gpio0 48 GPIO_ACTIVE_HIGH>;
 	};
+
+	vsel_sd_nddr: gpio-regulator {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel_sd_nddr_pins_default>;
+		regulator-name = "tps65219-LDO1-SEL-SD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&ldo1_reg>;
+		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
 };
 
 &main_pmx0 {
@@ -181,6 +195,13 @@
 		>;
 	};
 
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-pins-default {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
@@ -267,6 +288,12 @@
 			AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
 		>;
 	};
+
+	vsel_sd_nddr_pins_default: vsel-sd-nddr-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 7) /* (Y7) PRG1_PRU0_GPO0.GPIO0_45 */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -315,6 +342,83 @@
 	status = "disabled";
 };
 
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		system-power-controller;
+
+		buck1-supply = <&vcc_3v3_sys>;
+		buck2-supply = <&vcc_3v3_sys>;
+		buck3-supply = <&vcc_3v3_sys>;
+		ldo1-supply = <&vcc_3v3_sys>;
+		ldo2-supply = <&buck2_reg>;
+		ldo3-supply = <&vcc_3v3_sys>;
+		ldo4-supply = <&vcc_3v3_sys>;
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VCC1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_LPDDR4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-name = "VDDSHV_SD_IO_PMIC";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "VDDAR_CORE";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-name = "VDD_PHY_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-- 
2.17.1

