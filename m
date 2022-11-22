Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F23633D94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiKVNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKVNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:25:19 -0500
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BAF17594
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:25:16 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669123514; x=1669382714;
        bh=6W9FJcrKkXqvtUDQ/mak3DR9IXLeyshZQ39tP+pf8Cs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cXwI+cuHqAqfChxXuJD+VSG/5yoeXVha8RE9ZUbaLVplCBnUjuysZrfZ8Xjmnn2zz
         yMkdqhbNCBAizfl/gl+DQLl95SGMwoJZpnBHGE3JbOjW/NLnWIHl3ys0KNg00QpIq2
         WJJav/mYCknmVhVJWsMoHRjTR6da7L4DQOCEaXDWeopqsiuSnA2kiTAKNrH+PhF0t+
         mkqlbLPMU1i4Z7ENG7kSWycsILXSJ+spfucHihR4kLq3UV3uiUmuCBKDf3uh6vpe1j
         dvxZyW+6hxBpR5rcBqSzKR8Ll9Oo3BQpZ/GUV9hN2XS4qpt6gtbC23gEg6KL6ZBUHV
         MvAjtVhUGMM0w==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v5 2/4] arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
Message-ID: <20221122132350.257550-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221122132142.257241-1-linmengbo0689@protonmail.com>
References: <20221121133732.207820-1-linmengbo0689@protonmail.com> <20221122132142.257241-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer Iconia Talk S A1-724 is a tablet using the MSM8916 SoC released
in 2014.

Note: The original firmware from Acer can only boot 32-bit kernels.
To boot arm64 kernels it is necessary to flash 64-bit TZ/HYP firmware
with EDL, e.g. taken from the DragonBoard 410c. This works because Acer
didn't set up (firmware) secure boot.

Add a device tree for with initial support for:

- GPIO keys
- pm8916-vibrator
- SDHCI (internal and external storage)
- USB Device Mode
- UART
- WCNSS (WiFi/BT)
- Regulators

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 217 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index afe496a93f94..f38a20074013 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq6018-cp01-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq8074-hk10-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq8074-hk10-c2.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-acer-a1-724.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-asus-z00l.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-huawei-g7.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/=
boot/dts/qcom/msm8916-acer-a1-724.dts
new file mode 100644
index 000000000000..593051ea92b6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-pm8916.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/*
+ * NOTE: The original firmware from Acer can only boot 32-bit kernels.
+ * To boot this device tree using arm64 it is necessary to flash 64-bit
+ * TZ/HYP firmware (e.g. taken from the DragonBoard 410c).
+ * See https://wiki.postmarketos.org/wiki/Acer_Iconia_Talk_S_(acer-a1-724)
+ * for suggested installation instructions.
+ */
+
+/ {
+=09model =3D "Acer Iconia Talk S A1-724";
+=09compatible =3D "acer,a1-724", "qcom,msm8916";
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
+=09linux,code =3D <KEY_VOLUMEDOWN>;
+=09status =3D "okay";
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
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
+=09pinctrl-1 =3D <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+
+=09status =3D "okay";
+};
+
+&sdhc_2 {
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
+=09pinctrl-1 =3D <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+
+=09cd-gpios =3D <&msmgpio 38 GPIO_ACTIVE_HIGH>;
+
+=09status =3D "okay";
+};
+
+&usb {
+=09extcon =3D <&usb_id>, <&usb_id>;
+=09status =3D "okay";
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
+=09=09regulator-system-load =3D <200000>;
+=09=09regulator-allow-set-load;
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
+=09=09regulator-min-microvolt =3D <2900000>;
+=09=09regulator-max-microvolt =3D <2900000>;
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


