Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D096310B6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiKSU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKSU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:28:03 -0500
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F111C3F;
        Sat, 19 Nov 2022 12:28:00 -0800 (PST)
Date:   Sat, 19 Nov 2022 20:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668889679; x=1669148879;
        bh=uR60VGFonjZ2PAlG5YE8jC3dYPRJhZgB4wAVz8J7utU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HFUaSs7YsyvgLT59EYnRbr4ooh3L6TlIUm9mHUXl6jA9rsWzPrLtIcLino9ZE68Dg
         zK2Osi8lJVl52DK9lma/Qu92p97rY0D2296KilPJQaD/F5P4DABZXihvCZloHJagOc
         jy2YPT7Pj/6/3AbhM37x/K9m75CkuYw55m9QqFZ3vvJZfFkrndTKIv9dwkMAnaGNGk
         afqWnuLgFCz2kcX3ZLV0n1+JlvpXIlxp1tWAtF0F1NjWlsbPEgtxAQcXPMiJw1WzzG
         G27RapfTlpIKjFAvf2ZTh8B4z642x9NSNw8fExb3WbUUCks0lUFETI+pRqQHCsU0KU
         hvgvd72wZY+mw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 3/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add initial device tree
Message-ID: <20221119202639.93559-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221119202316.93142-1-linmengbo0689@protonmail.com>
References: <20221119202316.93142-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLUS FL8005A is a tablet using the MSM8916 SoC released in 2015.

Add a device tree for with initial support for:

- GPIO keys
- GPIO LEDs
- pm8916-vibrator
- SDHCI (internal and external storage)
- USB Device Mode
- UART
- WCNSS (WiFi/BT)
- Regulators

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 239 ++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index afe496a93f94..5a2dcf726159 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq8074-hk10-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq8074-hk10-c2.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-asus-z00l.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-gplus-fl8005a.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-huawei-g7.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-longcheer-l8150.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-longcheer-l8910.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-gplus-fl8005a.dts
new file mode 100644
index 000000000000..bed1fe984287
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-pm8916.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+=09model =3D "GPLUS FL8005A";
+=09compatible =3D "gplus,fl8005a", "qcom,msm8916";
+=09chassis-type =3D "tablet";
+
+=09aliases {
+=09=09serial0 =3D &blsp1_uart2;
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial0";
+=09};
+
+=09gpio-keys {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&gpio_keys_default>;
+
+=09=09label =3D "GPIO Buttons";
+
+=09=09button-volume-up {
+=09=09=09label =3D "Volume Up";
+=09=09=09gpios =3D <&msmgpio 107 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_VOLUMEUP>;
+=09=09};
+=09};
+
+=09gpio-leds {
+=09=09compatible =3D "gpio-leds";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&gpio_leds_default>;
+
+=09=09led-red {
+=09=09=09function =3D LED_FUNCTION_CHARGING;
+=09=09=09color =3D <LED_COLOR_ID_RED>;
+=09=09=09gpios =3D <&msmgpio 117 GPIO_ACTIVE_HIGH>;
+=09=09=09retain-state-suspended;
+=09=09};
+
+=09=09led-green {
+=09=09=09function =3D LED_FUNCTION_CHARGING;
+=09=09=09color =3D <LED_COLOR_ID_GREEN>;
+=09=09=09gpios =3D <&msmgpio 118 GPIO_ACTIVE_HIGH>;
+=09=09=09retain-state-suspended;
+=09=09};
+=09};
+
+=09usb_id: usb-id {
+=09=09compatible =3D "linux,extcon-usb-gpio";
+=09=09id-gpio =3D <&msmgpio 110 GPIO_ACTIVE_HIGH>;
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&usb_id_default>;
+=09};
+};
+
+&blsp1_uart2 {
+=09status =3D "okay";
+};
+
+&pm8916_resin {
+=09status =3D "okay";
+=09linux,code =3D <KEY_VOLUMEDOWN>;
+};
+
+&pm8916_vib {
+=09status =3D "okay";
+};
+
+&pronto {
+=09status =3D "okay";
+};
+
+&sdhc_1 {
+=09status =3D "okay";
+
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
+=09pinctrl-1 =3D <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+};
+
+&sdhc_2 {
+=09status =3D "okay";
+
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
+=09pinctrl-1 =3D <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+
+=09cd-gpios =3D <&msmgpio 38 GPIO_ACTIVE_LOW>;
+};
+
+&usb {
+=09status =3D "okay";
+=09extcon =3D <&usb_id>, <&usb_id>;
+};
+
+&usb_hs_phy {
+=09extcon =3D <&usb_id>;
+};
+
+&smd_rpm_regulators {
+=09vdd_l1_l2_l3-supply =3D <&pm8916_s3>;
+=09vdd_l4_l5_l6-supply =3D <&pm8916_s4>;
+=09vdd_l7-supply =3D <&pm8916_s4>;
+
+=09s3 {
+=09=09regulator-min-microvolt =3D <1200000>;
+=09=09regulator-max-microvolt =3D <1300000>;
+=09};
+
+=09s4 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <2100000>;
+=09};
+
+=09l1 {
+=09=09regulator-min-microvolt =3D <1225000>;
+=09=09regulator-max-microvolt =3D <1225000>;
+=09};
+
+=09l2 {
+=09=09regulator-min-microvolt =3D <1200000>;
+=09=09regulator-max-microvolt =3D <1200000>;
+=09};
+
+=09l4 {
+=09=09regulator-min-microvolt =3D <2050000>;
+=09=09regulator-max-microvolt =3D <2050000>;
+=09};
+
+=09l5 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09};
+
+=09l6 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09};
+
+=09l7 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09};
+
+=09l8 {
+=09=09regulator-min-microvolt =3D <2850000>;
+=09=09regulator-max-microvolt =3D <2900000>;
+=09};
+
+=09l9 {
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l10 {
+=09=09regulator-min-microvolt =3D <2700000>;
+=09=09regulator-max-microvolt =3D <2800000>;
+=09};
+
+=09l11 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <2950000>;
+=09=09regulator-allow-set-load;
+=09=09regulator-system-load =3D <200000>;
+=09};
+
+=09l12 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <2950000>;
+=09};
+
+=09l13 {
+=09=09regulator-min-microvolt =3D <3075000>;
+=09=09regulator-max-microvolt =3D <3075000>;
+=09};
+
+=09l14 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l15 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l16 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l17 {
+=09=09regulator-min-microvolt =3D <2850000>;
+=09=09regulator-max-microvolt =3D <2850000>;
+=09};
+
+=09l18 {
+=09=09regulator-min-microvolt =3D <2700000>;
+=09=09regulator-max-microvolt =3D <2700000>;
+=09};
+};
+
+&msmgpio {
+=09gpio_keys_default: gpio-keys-default-state {
+=09=09pins =3D "gpio107";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+
+=09gpio_leds_default: gpio-led-default-state {
+=09=09pins =3D "gpio117", "gpio118";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09usb_id_default: usb-id-default-state {
+=09=09pins =3D "gpio110";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <8>;
+=09=09bias-pull-up;
+=09};
+};
--=20
2.30.2


