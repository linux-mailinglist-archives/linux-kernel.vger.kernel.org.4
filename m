Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF227393A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFVAPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFVAP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:15:26 -0400
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD98EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:15:23 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:03:58 +0000
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sYu5ch+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687392242; x=1687651442;
        bh=k95Rm+/XsuD1Zbhlgvh9VBWjca3m91Tk86Wa6hdx9Ek=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sYu5ch+dQQe8JGn+JGHHiMVAAea0Dm5EZYs81d86PP7WTDtsyUoEzLkCHL7Tkx/9Z
         oeoMEFkiVspAjnud7ZA8FH4eQMruwRleSHK6ZmiCDEwLs1Nv/REyjievvu/N5DzFz2
         y4Tb6WkCeoPa681cWOqRa3SoNNOhfhdYFOZJCv9q8Zr1QEBVYG2gsP6Wdjy1K0L9nq
         U03fGuYC0ecjIFFTgKXwyr8xXwWEFMwa2CDmPBiXsx9wVxJo1YlJl6lHafJKr1czMf
         /owcy5WLpDTssFC58EPRXkhPC8uTev9wU/K//ST6q/+2UD2Cd3ypAo2BD/DlDk/yDc
         nxzNchOuG2hYQ==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Walter Broemeling <wallebroem@gmail.com>,
        Joe Mason <buddyjojo06@outlook.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Gareth Peoples <mail@gpeopl.es>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 2/7] arm64: dts: qcom: msm8916-samsung-fortuna: Add initial device trees
Message-ID: <20230622000307.48281-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622000007.48219-1-linmengbo0689@protonmail.com>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walter Broemeling <wallebroem@gmail.com>

Samsung Galaxy Core Prime, Grand Prime and Ace 4 are phones based on
MSM8916. They are similar to the other Samsung devices based on MSM8916
with only a few minor differences.

This initial commit adds support for:
 - fortuna3g (SM-G530H)
 - fortunaltezt (SM-G530Y)
 - gprimeltecan (SM-G530W)
 - grandprimelte (SM-G530FZ)
 - heatqlte (SM-G357FZ)
 - rossa (SM-G360G)

The device trees contain initial support with:
 - GPIO keys
 - Regulator haptic
 - SDHCI (internal and external storage)
 - USB Device Mode
 - UART (on USB connector via the SM5502/SM5504 MUIC)
 - WCNSS (WiFi/BT)
 - Regulators

There are different variants of Grand Prime, with some differences
in accelerometer, NFC and panel.
Core Prime and Grand Prime are similar, with some differences in MUIC,
panel and touchscreen.
Ace 4 and Core Prime are similar, with some differences in panel and
touchscreen.

The common parts are shared in
msm8916-samsung-fortuna-common.dtsi and msm8916-samsung-rossa-common.dtsi
to reduce duplication.

Unfortunately, SM-G357FZ and SM-G530Y were released with outdated 32-bit
only firmware and never received any update from Samsung. Since the 32-bit
TrustZone firmware is signed there seems to be no way currently to
actually boot this device tree on arm64 Linux at the moment.

However, it is possible to use this device tree by compiling an ARM32
kernel instead. The device tree can be easily built on ARM32 with
an #include and it works really well there. To avoid confusion for others
it is still better to add this device tree on arm64. Otherwise it's easy
to forget to update this one when making some changes that affect all
MSM8916 devices.

Maybe someone finds a way to boot ARM64 Linux on this device at some
point. In this case I expect that this device tree can be simply used
as-is.

Signed-off-by: Walter Broemeling <wallebroem@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Add fortuna-common.dtsi, buttons, vibrator, WiFi]
Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
[Add fortuna3g]
Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
[Add heatqlte]
Signed-off-by: Gareth Peoples <mail@gpeopl.es>
[Add grandprimelte and fortunaltezt]
[Use msm8916-samsung-rossa-common.dtsi and reword the commit]
[Use regulator-haptic instead of gpio-vibrator]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   6 +
 .../dts/qcom/msm8216-samsung-fortuna3g.dts    |  11 ++
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 157 ++++++++++++++++++
 .../dts/qcom/msm8916-samsung-fortunaltezt.dts |  23 +++
 .../dts/qcom/msm8916-samsung-gprimeltecan.dts |  22 +++
 .../qcom/msm8916-samsung-grandprimelte.dts    |  11 ++
 .../dts/qcom/msm8916-samsung-heatqlte.dts     |  23 +++
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  17 ++
 .../boot/dts/qcom/msm8916-samsung-rossa.dts   |  11 ++
 9 files changed, 281 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common=
.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.d=
ts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.d=
ts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.=
dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-heatqlte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.d=
tsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index 337abc4ceb17..f18db5063eda 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp433.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp449.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp453.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp454.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8216-samsung-fortuna3g.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-acer-a1-724.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-asus-z00l.dtb
@@ -29,11 +30,16 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a3u-eur.=
dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a5u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-e5.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-e7.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-fortunaltezt.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-gprimeltecan.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-grandmax.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-grandprimelte.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-gt510.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-gt58.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-heatqlte.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5x.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-rossa.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-thwc-ufi001c.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts b/arch/=
arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
new file mode 100644
index 000000000000..366914be7d53
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530H)";
+=09compatible =3D "samsung,fortuna3g", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
new file mode 100644
index 000000000000..40c8edc795b0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-pm8916.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+=09aliases {
+=09=09mmc0 =3D &sdhc_1; /* eMMC */
+=09=09mmc1 =3D &sdhc_2; /* SD card */
+=09=09serial0 =3D &blsp_uart2;
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial0";
+=09};
+
+=09reserved-memory {
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85a00000 {
+=09=09=09reg =3D <0x0 0x85a00000 0x0 0x600000>;
+=09=09=09no-map;
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
+=09haptic {
+=09=09compatible =3D "regulator-haptic";
+=09=09haptic-supply =3D <&reg_motor_vdd>;
+=09=09min-microvolt =3D <3300000>;
+=09=09max-microvolt =3D <3300000>;
+=09};
+
+=09reg_motor_vdd: regulator-motor-vdd {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "motor_vdd";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09gpio =3D <&tlmm 72 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&motor_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
+&blsp_i2c1 {
+=09status =3D "okay";
+
+=09muic: extcon@25 {
+=09=09compatible =3D "siliconmitus,sm5502-muic";
+=09=09reg =3D <0x25>;
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <12 IRQ_TYPE_EDGE_FALLING>;
+=09=09pinctrl-0 =3D <&muic_int_default>;
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
+=09compatible =3D "qcom,wcn3620";
+};
+
+&tlmm {
+=09gpio_keys_default: gpio-keys-default-state {
+=09=09pins =3D "gpio107", "gpio109";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+
+=09motor_en_default: motor-en-default-state {
+=09=09pins =3D "gpio72";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09muic_int_default: muic-int-default-state {
+=09=09pins =3D "gpio12";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09sdc2_cd_default: sdc2-cd-default-state {
+=09=09pins =3D "gpio38";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts
new file mode 100644
index 000000000000..f7c4dcb34bb3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/*
+ * NOTE: The original firmware from Samsung can only boot ARM32 kernels.
+ * Unfortunately, the firmware is signed and cannot be replaced easily.
+ * There seems to be no way to boot ARM64 kernels on this device at the mo=
ment,
+ * even though the hardware would support it.
+ *
+ * However, it is possible to use this device tree by compiling an ARM32 k=
ernel
+ * instead. For clarity and build testing this device tree is maintained n=
ext
+ * to the other MSM8916 device trees. However, it is actually used through
+ * arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
+ */
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530Y)";
+=09compatible =3D "samsung,fortunaltezt", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
new file mode 100644
index 000000000000..883f20554dbe
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530W)";
+=09compatible =3D "samsung,gprimeltecan", "qcom,msm8916";
+=09chassis-type =3D "handset";
+
+=09reserved-memory {
+=09=09/* Firmware for gprimeltecan needs more space */
+=09=09/delete-node/ tz-apps@85a00000;
+
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85500000 {
+=09=09=09reg =3D <0x0 0x85500000 0x0 0xb00000>;
+=09=09=09no-map;
+=09=09};
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
new file mode 100644
index 000000000000..ea8a1e698dd4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530FZ)";
+=09compatible =3D "samsung,grandprimelte", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-heatqlte.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-heatqlte.dts
new file mode 100644
index 000000000000..fbf065734cbb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-heatqlte.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-rossa-common.dtsi"
+
+/*
+ * NOTE: The original firmware from Samsung can only boot ARM32 kernels.
+ * Unfortunately, the firmware is signed and cannot be replaced easily.
+ * There seems to be no way to boot ARM64 kernels on this device at the mo=
ment,
+ * even though the hardware would support it.
+ *
+ * However, it is possible to use this device tree by compiling an ARM32 k=
ernel
+ * instead. For clarity and build testing this device tree is maintained n=
ext
+ * to the other MSM8916 device trees. However, it is actually used through
+ * arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts
+ */
+
+/ {
+=09model =3D "Samsung Galaxy Ace 4 (SM-G357FZ)";
+=09compatible =3D "samsung,heatqlte", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
new file mode 100644
index 000000000000..5b012dc92e0e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+&blsp_i2c1 {
+=09/* SM5504 MUIC instead of SM5502 */
+=09/delete-node/ extcon@25;
+
+=09muic: extcon@14 {
+=09=09compatible =3D "siliconmitus,sm5504-muic";
+=09=09reg =3D <0x14>;
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <12 IRQ_TYPE_EDGE_FALLING>;
+=09=09pinctrl-0 =3D <&muic_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-samsung-rossa.dts
new file mode 100644
index 000000000000..2c6f04ad2cfe
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-rossa-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Core Prime LTE";
+=09compatible =3D "samsung,rossa", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
--=20
2.39.2


