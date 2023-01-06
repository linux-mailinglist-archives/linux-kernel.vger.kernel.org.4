Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07F660240
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjAFOce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjAFOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:32:07 -0500
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB07F46A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:32:04 -0800 (PST)
Date:   Fri, 06 Jan 2023 14:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673015523; x=1673274723;
        bh=ocUQAxaviL0qvTTTeOczw/hurbzdqCtMbAPWkB864dI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kkgN17pr031wlpop0EiBxWQhDhpsetS1Q2dRztdmaT/SwioQXIglGBv8UkLZlT7MI
         kESv6LvlUBVVhZp4cuWkSeK0eHfkEyNX7L8v0trZo5+/3S68Mg2569NMPR9fTBx1cG
         5iW4RKkugVZ7qQVnGEKkO+7hPHpBoC2ttGSjo7pSYeCOQmDu0ek9DuLYvmt6E5/BqI
         cxBnqsFjQP6KI0hvw/isqmresyqID9Q0LbNlWLs+7Q7vn7EGV0cYn9FXye3yrivRck
         ezUmr6euM4z71ugLqN16+NLv0G2R/dDr2NOyecy8igLpeCI9r+fbagJDMt8FEe0K7u
         3BmArqp3Rkb7g==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 5/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add MUIC support
Message-ID: <20230106143051.547302-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230106142748.546975-1-linmengbo0689@protonmail.com>
References: <20230106142748.546975-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markuss Broks <markuss.broks@gmail.com>

The MUIC installed is a part of SM5703 MFD, and it seems to work
the same as the SM5502 MUIC unit.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
[Apply for msm8916-samsung-j5x]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 50 ++++++++++++++++---
 .../boot/dts/qcom/msm8916-samsung-j5x.dts     |  8 +++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 5755b360c6ed..f3b81b6f0a2f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -3,6 +3,7 @@
 #include "msm8916-pm8916.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
=20
 / {
 =09aliases {
@@ -58,6 +59,29 @@ button-home {
 =09=09=09linux,code =3D <KEY_HOMEPAGE>;
 =09=09};
 =09};
+
+=09i2c_muic: i2c-muic {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&msmgpio 105 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&msmgpio 106 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&muic_i2c_default>;
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09muic: extcon@25 {
+=09=09=09compatible =3D "siliconmitus,sm5703-muic";
+=09=09=09reg =3D <0x25>;
+
+=09=09=09interrupt-parent =3D <&msmgpio>;
+=09=09=09interrupts =3D <12 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <&muic_int_default>;
+=09=09};
+=09};
 };
=20
 &blsp1_uart2 {
@@ -69,11 +93,6 @@ &pm8916_resin {
 =09linux,code =3D <KEY_VOLUMEDOWN>;
 };
=20
-/* FIXME: Replace with SM5703 MUIC when driver is available */
-&pm8916_usbin {
-=09status =3D "okay";
-};
-
 &pronto {
 =09status =3D "okay";
 };
@@ -97,13 +116,12 @@ &sdhc_2 {
 };
=20
 &usb {
+=09extcon =3D <&muic>, <&muic>;
 =09status =3D "okay";
-=09dr_mode =3D "peripheral";
-=09extcon =3D <&pm8916_usbin>;
 };
=20
 &usb_hs_phy {
-=09extcon =3D <&pm8916_usbin>;
+=09extcon =3D <&muic>;
 };
=20
 &smd_rpm_regulators {
@@ -225,4 +243,20 @@ gpio_keys_default: gpio-keys-default-state {
 =09=09drive-strength =3D <2>;
 =09=09bias-pull-up;
 =09};
+
+=09muic_i2c_default: muic-i2c-default-state {
+=09=09pins =3D "gpio105", "gpio106";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09muic_int_default: muic-int-default-state {
+=09=09pins =3D "gpio12";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts b/arch/arm64/=
boot/dts/qcom/msm8916-samsung-j5x.dts
index 7656ac4508cf..7e1326cc13c5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
@@ -9,3 +9,11 @@ / {
 =09compatible =3D "samsung,j5x", "qcom,msm8916";
 =09chassis-type =3D "handset";
 };
+
+&muic {
+=09interrupts =3D <121 IRQ_TYPE_EDGE_FALLING>;
+};
+
+&muic_int_default {
+=09pins =3D "gpio121";
+};
--=20
2.30.2


