Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB737393AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjFVAQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjFVAQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:16:39 -0400
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65F81FF1;
        Wed, 21 Jun 2023 17:16:06 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:04:37 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="QZTu5g/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687392292; x=1687651492;
        bh=KPV8l5vWbr9QkrijMiYUQ4TXqOgXrZpEbZB6K+/SA4w=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QZTu5g/bwfZI/hjKsmmVwZoifpGc4f0JfgYX8vgDKgVyZvKwtvBJpQstpdpIcANMN
         FnEfjIB7e2w2jYlPnzfHqlh+gY6eDss1QLQlbBmWSXLyjbhaNdtfn7ZzvF75PcLpnx
         UJ8b5KTqRG08yhW57yf+BF3otxf1zx9iowo7Lm9AwtffR2v2JyrKML+otfgvipB3o1
         VbyAcHjB5kaQ+0eTVVshm2VUAK0v1rQWmQ5Nx9h9Rh3VJUQYgiMbjbCCHnk3Zhl8kO
         1Qw4sAbYcKTKMGI46uFqSayLpli4M6daY17IQjr30l6ffXlNiNh25r3HG3+tTU4isG
         jAnSp8HhAjVPw==
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
        Joe Mason <buddyjojo06@outlook.com>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 5/7] arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
Message-ID: <20230622000358.48332-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622000007.48219-1-linmengbo0689@protonmail.com>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Mason <buddyjojo06@outlook.com>

Like msm8916-samsung-a3u-eur, the Grand Prime uses a Zinitix BT541
touchscreen. Add it together with the necessary fixed-regulator to the
device tree.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 50 +++++++++++++++++++
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  7 +++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index ca147310c27a..6d9f89446105 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -64,6 +64,19 @@ reg_motor_vdd: regulator-motor-vdd {
 =09=09pinctrl-0 =3D <&motor_en_default>;
 =09=09pinctrl-names =3D "default";
 =09};
+
+=09reg_vdd_tsp_a: regulator-vdd-tsp-a {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vdd_tsp_a";
+=09=09regulator-min-microvolt =3D <3000000>;
+=09=09regulator-max-microvolt =3D <3000000>;
+
+=09=09gpio =3D <&tlmm 73 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tsp_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
 };
=20
 &blsp_i2c1 {
@@ -94,6 +107,29 @@ battery@35 {
 =09};
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@20 {
+=09=09compatible =3D "zinitix,bt541";
+=09=09reg =3D <0x20>;
+
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09touchscreen-size-x =3D <540>;
+=09=09touchscreen-size-y =3D <960>;
+
+=09=09vcca-supply =3D <&reg_vdd_tsp_a>;
+=09=09vdd-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-0 =3D <&tsp_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -176,4 +212,18 @@ sdc2_cd_default: sdc2-cd-default-state {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
+
+=09tsp_en_default: tsp-en-default-state {
+=09=09pins =3D "gpio73";
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
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
index 5b012dc92e0e..242cb61e55fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -15,3 +15,10 @@ muic: extcon@14 {
 =09=09pinctrl-names =3D "default";
 =09};
 };
+
+&blsp_i2c5 {
+=09status =3D "disabled";
+
+=09/* Touchscreen varies depending on model variant */
+=09/delete-node/ touchscreen@20;
+};
--=20
2.39.2


