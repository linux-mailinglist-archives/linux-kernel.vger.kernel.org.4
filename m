Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787C73B462
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFWKDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFWKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:03:17 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667C2116;
        Fri, 23 Jun 2023 03:03:11 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687514589; x=1687773789;
        bh=AO6KSGh+T912qx4kgeEQ0q/48ydbUHhh7XZ9EUahyeU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dGXRdDMuBa5kVHOExCeUBm33cOYzHLvVVjMl9BiF5R3skQGrNf5Q4jYzypphMjX8t
         lYB0xfCkzZde1ItrRVCpE5V7qwYYZLD9RU9nreHzTyFpwFCGh7K2kzNa6xu50D0NqS
         ldi/WxlrhYYzqAErr0CgE3XsI4x+9SjOXjaLAZk5K3rkU/VLkzjuuZZPiAKrHP36cL
         0kLulfDytFHoFfzzkIqHs8q7Cr6ViQu8zulOd2/EJOL0HnA1jt8vGO5p387+u/dUED
         TYwt2rd//7Hz9a95Y39fLPZoZoLdFKtXdpYJL7lh2ddZEJA6iXbEVhemLnjS4aW0PR
         glbHh0W6JqwHQ==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
Message-ID: <20230623100237.5299-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230623100135.5269-1-linmengbo0689@protonmail.com>
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts adds support for Samsung Galaxy A7 smartphone released in 2015.

Add a device tree for A7 with initial support for:

- GPIO keys
- Hall Sensor
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5502 MUIC)
- WCNSS (WiFi/BT)
- Regulators
- Touch key
- Accelerometer/Magnetometer
- Fuelgauge
- NFC
- Vibrator
- Touchscreen

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 495 ++++++++++++++++++
 2 files changed, 496 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index 337abc4ceb17..23fd31d4bf5a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-yiming-uz801v3.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8939-samsung-a7.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8953-xiaomi-daisy.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
new file mode 100644
index 000000000000..66e56ac59998
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8939-pm8916.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+=09model =3D "Samsung Galaxy A7 (2015)";
+=09compatible =3D "samsung,a7", "qcom,msm8939";
+=09chassis-type =3D "handset";
+
+=09aliases {
+=09=09mmc0 =3D &sdhc_1; /* SDC1 eMMC slot */
+=09=09mmc1 =3D &sdhc_2; /* SDC2 SD card slot */
+=09=09serial0 =3D &blsp_uart2;
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial0";
+=09};
+
+=09reserved-memory {
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85500000 {
+=09=09=09reg =3D <0x0 0x85500000 0x0 0xb00000>;
+=09=09=09no-map;
+=09=09};
+=09};
+
+=09gpio-hall-sensor {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-0 =3D <&gpio_hall_sensor_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09label =3D "GPIO Hall Effect Sensor";
+
+=09=09event-hall-sensor {
+=09=09=09label =3D "Hall Effect Sensor";
+=09=09=09gpios =3D <&tlmm 52 GPIO_ACTIVE_LOW>;
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_LID>;
+=09=09=09linux,can-disable;
+=09=09};
+=09};
+
+=09gpio-keys {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-0 =3D <&gpio_keys_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09label =3D "GPIO Buttons";
+
+=09=09button-volume-up {
+=09=09=09label =3D "Volume Up";
+=09=09=09gpios =3D <&tlmm 107 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_VOLUMEUP>;
+=09=09};
+
+=09=09button-home {
+=09=09=09label =3D "Home";
+=09=09=09gpios =3D <&tlmm 109 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_HOMEPAGE>;
+=09=09};
+=09};
+
+=09i2c-fg {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 106 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 105 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&fg_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09battery@35 {
+=09=09=09compatible =3D "richtek,rt5033-battery";
+=09=09=09reg =3D <0x35>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <121 IRQ_TYPE_EDGE_BOTH>;
+
+=09=09=09pinctrl-0 =3D <&fg_alert_default>;
+=09=09=09pinctrl-names =3D "default";
+=09=09};
+=09};
+
+=09i2c-nfc {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&nfc_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09nfc@2b {
+=09=09=09compatible =3D "nxp,pn547", "nxp,nxp-nci-i2c";
+=09=09=09reg =3D <0x2b>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <21 IRQ_TYPE_EDGE_RISING>;
+
+=09=09=09enable-gpios =3D <&tlmm 116 GPIO_ACTIVE_HIGH>;
+=09=09=09firmware-gpios =3D <&tlmm 49 GPIO_ACTIVE_HIGH>;
+
+=09=09=09pinctrl-0 =3D <&nfc_default>;
+=09=09=09pinctrl-names =3D "default";
+=09=09};
+=09};
+
+=09i2c-sensor {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 84 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 85 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&sensor_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09accelerometer: accelerometer@10 {
+=09=09=09compatible =3D "bosch,bmc150_accel";
+=09=09=09reg =3D <0x10>;
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <115 IRQ_TYPE_EDGE_RISING>;
+
+=09=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09=09pinctrl-names =3D "default";
+
+=09=09=09mount-matrix =3D "-1", "0", "0",
+=09=09=09=09=09"0", "-1", "0",
+=09=09=09=09=09"0", "0", "1";
+=09=09};
+
+=09=09magnetometer@12 {
+=09=09=09compatible =3D "bosch,bmc150_magn";
+=09=09=09reg =3D <0x12>;
+
+=09=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09=09vddio-supply =3D <&pm8916_l5>;
+=09=09};
+=09};
+
+=09i2c-tkey {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 16 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 17 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&tkey_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09touchkey@20 {
+=09=09=09/* Note: Actually an ABOV MCU that implements same interface */
+=09=09=09compatible =3D "coreriver,tc360-touchkey";
+=09=09=09reg =3D <0x20>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <20 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09=09vcc-supply =3D <&reg_touch_key>;
+=09=09=09vdd-supply =3D <&reg_keyled>;
+=09=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
+
+=09=09=09pinctrl-0 =3D <&tkey_default>;
+=09=09=09pinctrl-names =3D "default";
+=09=09};
+=09};
+
+=09pwm_vibrator: pwm-vibrator {
+=09=09compatible =3D "clk-pwm";
+=09=09#pwm-cells =3D <2>;
+
+=09=09clocks =3D <&gcc GCC_GP2_CLK>;
+
+=09=09pinctrl-0 =3D <&motor_pwm_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_keyled: regulator-keyled {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "keyled";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09/* NOTE: On some variants e.g. SM-A700FD it's GPIO 91 */
+=09=09gpio =3D <&tlmm 100 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tkey_led_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_touch_key: regulator-touch-key {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "touch_key";
+=09=09regulator-min-microvolt =3D <2800000>;
+=09=09regulator-max-microvolt =3D <2800000>;
+
+=09=09gpio =3D <&tlmm 56 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tkey_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_tsp_vdd: regulator-tsp-vdd {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "tsp_vdd";
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09=09vin-supply =3D <&pm8916_s4>;
+
+=09=09gpio =3D <&tlmm 8 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&reg_tsp_io_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_vdd_tsp: regulator-vdd-tsp {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vdd_tsp";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09gpio =3D <&tlmm 73 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&reg_tsp_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_vibrator: regulator-vibrator {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "motor_en";
+=09=09regulator-min-microvolt =3D <3000000>;
+=09=09regulator-max-microvolt =3D <3000000>;
+
+=09=09gpio =3D <&tlmm 86 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&motor_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09vibrator {
+=09=09compatible =3D "pwm-vibrator";
+
+=09=09pwms =3D <&pwm_vibrator 0 100000>;
+=09=09pwm-names =3D "enable";
+
+=09=09vcc-supply =3D <&reg_vibrator>;
+=09};
+};
+
+&blsp_i2c1 {
+=09status =3D "okay";
+
+=09muic: extcon@25 {
+=09=09compatible =3D "siliconmitus,sm5502-muic";
+=09=09reg =3D <0x25>;
+
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <12 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09pinctrl-0 =3D <&muic_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@24 {
+=09=09compatible =3D "cypress,tt21000";
+
+=09=09reg =3D <0x24>;
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09vdd-supply =3D <&reg_vdd_tsp>;
+=09=09vddio-supply =3D <&reg_tsp_vdd>;
+
+=09=09pinctrl-0 =3D <&tsp_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
+&blsp_uart2 {
+=09status =3D "okay";
+};
+
+&pm8916_resin {
+=09linux,code =3D <KEY_VOLUMEDOWN>;
+=09status =3D "okay";
+};
+
+&pm8916_rpm_regulators {
+=09pm8916_l17: l17 {
+=09=09regulator-min-microvolt =3D <2850000>;
+=09=09regulator-max-microvolt =3D <2850000>;
+=09};
+};
+
+&sdhc_1 {
+=09status =3D "okay";
+};
+
+&sdhc_2 {
+=09pinctrl-0 =3D <&sdc2_default &sdc2_cd_default>;
+=09pinctrl-1 =3D <&sdc2_sleep &sdc2_cd_default>;
+=09pinctrl-names =3D "default", "sleep";
+
+=09cd-gpios =3D <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+=09status =3D "okay";
+};
+
+&usb {
+=09extcon =3D <&muic>, <&muic>;
+=09status =3D "okay";
+};
+
+&usb_hs_phy {
+=09extcon =3D <&muic>;
+};
+
+&wcnss {
+=09status =3D "okay";
+};
+
+&wcnss_iris {
+=09compatible =3D "qcom,wcn3660b";
+};
+
+&tlmm {
+=09accel_int_default: accel-int-default-state {
+=09=09pins =3D "gpio115";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09fg_alert_default: fg-alert-default-state {
+=09=09pins =3D "gpio121";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09fg_i2c_default: fg-i2c-default-state {
+=09=09pins =3D "gpio105", "gpio106";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+=09=09pins =3D "gpio52";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09gpio_keys_default: gpio-keys-default-state {
+=09=09pins =3D "gpio107", "gpio109";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+
+=09motor_en_default: motor-en-default-state {
+=09=09pins =3D "gpio86";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09motor_pwm_default: motor-pwm-default-state {
+=09=09pins =3D "gpio50";
+=09=09function =3D "gcc_gp2_clk_a";
+=09};
+
+=09muic_int_default: muic-int-default-state {
+=09=09pins =3D "gpio12";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09nfc_default: nfc-default-state {
+=09=09irq-pins {
+=09=09=09pins =3D "gpio21";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-pull-down;
+=09=09};
+
+=09=09nfc-pins {
+=09=09=09pins =3D "gpio49", "gpio116";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+=09};
+
+=09nfc_i2c_default: nfc-i2c-default-state {
+=09=09pins =3D "gpio0", "gpio1";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09reg_tsp_en_default: reg-tsp-en-default-state {
+=09=09pins =3D "gpio73";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09reg_tsp_io_en_default: reg-tsp-io-en-default-state {
+=09=09pins =3D "gpio8";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09sdc2_cd_default: sdc2-cd-default-state {
+=09=09pins =3D "gpio38";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+
+=09sensor_i2c_default: sensor-i2c-default-state {
+=09=09pins =3D "gpio84", "gpio85";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_default: tkey-default-state {
+=09=09pins =3D "gpio20";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_en_default: tkey-en-default-state {
+=09=09pins =3D "gpio56";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_i2c_default: tkey-i2c-default-state {
+=09=09pins =3D "gpio16", "gpio17";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_led_en_default: tkey-led-en-default-state {
+=09=09pins =3D "gpio100";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tsp_int_default: tsp-int-default-state {
+=09=09pins =3D "gpio13";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
--=20
2.39.2


