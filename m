Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C7660F2F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAGNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjAGNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:33:30 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6E5DE5B;
        Sat,  7 Jan 2023 05:33:29 -0800 (PST)
Date:   Sat, 07 Jan 2023 13:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673098407; x=1673357607;
        bh=pZqBx8JCAkeYcPAdWXRIi74S0JqcHdu0E5A9iWrKaZ0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=iwAYvSsjrQSZuFbs2zt+tiSusDB2d8hfwq8/9fFHEO4sCXF6sxCQ4P/CTlahI7uJm
         nngNB0rN4GrRIA+hGFE0z2nl4vnG5KXqbv7w8tXYMfuL1gOC3TXs4tYNqL+vFtXZrV
         of1Fvxqvy5u3AdTv4SIytFGDcMMNiWIuiJMFETEeza9UDgayz8c6P9XGaomq3nvKP1
         j373SK7vwHMMPMJE+mrk+lpQeQddmflWo00lH21z7yY27X875cYEpt5Y1AfZnxqygo
         oM5YckNNNlqHVOLjKW1YYBEgb9y0rEe3IgkB/IXNCX5mt7tWWJXNDxQoRYqa/QtFp8
         By28DbQIB8JyA==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 5/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add flash LED
Message-ID: <20230107133235.139947-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230107132932.139669-1-linmengbo0689@protonmail.com>
References: <20230107132932.139669-1-linmengbo0689@protonmail.com>
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

FL8005A uses Qualcomm GPIO flash LEDs which is compatible with
SGM3140 Flash LED driver. Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index b44c30a72784..a0e520edde02 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -21,6 +21,22 @@ chosen {
 =09=09stdout-path =3D "serial0";
 =09};
=20
+=09flash-led-controller {
+=09=09/* Actually qcom,leds-gpio-flash */
+=09=09compatible =3D "sgmicro,sgm3140";
+=09=09enable-gpios =3D <&msmgpio 31 GPIO_ACTIVE_HIGH>;
+=09=09flash-gpios =3D <&msmgpio 32 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-0 =3D <&camera_flash_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09flash_led: led {
+=09=09=09function =3D LED_FUNCTION_FLASH;
+=09=09=09color =3D <LED_COLOR_ID_WHITE>;
+=09=09=09flash-max-timeout-us =3D <250000>;
+=09=09};
+=09};
+
 =09gpio-keys {
 =09=09compatible =3D "gpio-keys";
=20
@@ -237,6 +253,13 @@ l18 {
 };
=20
 &msmgpio {
+=09camera_flash_default: camera-flash-default-state {
+=09=09pins =3D "gpio31", "gpio32";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107";
 =09=09function =3D "gpio";
--=20
2.30.2


