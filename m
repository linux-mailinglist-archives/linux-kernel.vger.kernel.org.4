Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258F739534
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjFVCGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFVCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:06:29 -0400
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A8D1FE7;
        Wed, 21 Jun 2023 19:06:08 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:05:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399566; x=1687658766;
        bh=9Osyd7zMvptKqruHnCZMd8o/FOKHIT+eTshZCfZIz54=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=u5+aWGZ0/uGAFfyormP+GoQyr+P5jEWm+No4L3iLzpoJaIPhxN+aMaky+SeTe15WT
         3ClmMjE0N+QWDrAKwQePapQ50ScXmCtYDxkAQTuOgxEyPmjCXRqjJ3aiLMqIyDmnip
         PBGZuunXpt3yTyfMzC6qh5uHZ/xI2sH6XPb67lEvxrgIT819a+As3RvAcov6+s7kJP
         tBelNZmitaSm6u3VoFrFJY6a20hJvPjccPM6+irXRzGiSXfLT2P3culoVxCVWE9SaW
         BA9qafWd4AGxfFTk5/bjHCmezoQ/Fcjk7hihOBuChG9gl1Z/Nh7WXiFdN3C5kk35dy
         XqH0AGlIEuplA==
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
Subject: [PATCH 7/8] arm64: dts: qcom: msm8939-samsung-a7: Add vibrator
Message-ID: <20230622020541.65860-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622020344.65745-1-linmengbo0689@protonmail.com>
References: <20230622020344.65745-1-linmengbo0689@protonmail.com>
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

A7 uses motor driver controlled with PWM signal with a fixed regulator
that powers the driver and is controlled by enable signal.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index dcbc8a97ce63..ea74b61782de 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -185,6 +185,16 @@ touchkey@20 {
 =09=09};
 =09};
=20
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
 =09reg_keyled: regulator-keyled {
 =09=09compatible =3D "regulator-fixed";
 =09=09regulator-name =3D "keyled";
@@ -211,6 +221,28 @@ reg_touch_key: regulator-touch-key {
 =09=09pinctrl-0 =3D <&tkey_en_default>;
 =09=09pinctrl-names =3D "default";
 =09};
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
 };
=20
 &blsp_i2c1 {
@@ -311,6 +343,18 @@ gpio_keys_default: gpio-keys-default-state {
 =09=09bias-pull-up;
 =09};
=20
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
 =09muic_int_default: muic-int-default-state {
 =09=09pins =3D "gpio12";
 =09=09function =3D "gpio";
--=20
2.39.2


