Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D792B634ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiKWERK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiKWEQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:16:13 -0500
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF7AB865;
        Tue, 22 Nov 2022 20:14:05 -0800 (PST)
Date:   Wed, 23 Nov 2022 04:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669176844; x=1669436044;
        bh=mKT0b3j/bY3j0Y2khrfg5ryVKfOy6kNma6mcjHf4UFk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QlzoiIgIT1vfZMLnPBiYQwgr5bxtWJ4jO5ZgkfOpyKANElPswtZ31Qulx5qnKcvcn
         Xmx7dep6ZZiyA9Bv1II9vhj5K5uIArfLh82n4mqNQGMBJN3oDFbD0lIKY/815ZSNyv
         UIREjBtljutP9mZCZqxtdyWeo8G3tR6SQcZR1YcwcT89ETB1JPXvaRgOmACVuW3zRX
         QU8pajwn+pgu745hK0ucrrrli8/BCyIEPRK057KN7P6AD1AsP3O+FovzrJYb5nR5my
         jB6Bujw9qXWc/xHAgfOzeL95l+YK+slX79r5FL+rBozMtA4MWxZfPwiB3S/EyYakjc
         SpcksM36VeNkA==
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
Subject: [PATCH v4 5/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add flash LED
Message-ID: <20221123041312.151109-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221123041110.150837-1-linmengbo0689@protonmail.com>
References: <20221123041110.150837-1-linmengbo0689@protonmail.com>
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

FL8005A uses SGM3140 Flash LED driver. Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 2cac99e3e52c..b28d7d0f1ed5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -21,6 +21,21 @@ chosen {
 =09=09stdout-path =3D "serial0";
 =09};
=20
+=09flash-led-controller {
+=09=09compatible =3D "sgmicro,sgm3140";
+=09=09enable-gpios =3D <&msmgpio 31 GPIO_ACTIVE_HIGH>;
+=09=09flash-gpios =3D <&msmgpio 32 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&camera_flash_default>;
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
@@ -239,6 +254,14 @@ l18 {
 };
=20
 &msmgpio {
+=09camera_flash_default: camera-flash-default-state {
+=09=09pins =3D "gpio31", "gpio32";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107";
 =09=09function =3D "gpio";
--=20
2.30.2


