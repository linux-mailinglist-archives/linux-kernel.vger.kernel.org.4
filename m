Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0896C632387
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKUNaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKUNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:30:08 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E4BF81F;
        Mon, 21 Nov 2022 05:30:07 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669037406; x=1669296606;
        bh=GqWfwOkoBVZ9tw8IM+eBPsfBSmvmLyw9g6tZ93oFnPU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=M/Mv1UxJrvdP8jxxolAkSuhMvk7lGo0MZiu9L/+Rj57ZbWLFKRqoZ9vIl4Onpx4u2
         bCS0slYpP/86VsHJvc+4rQOD4kB5jPoC0wZ2PXdtI353JCjRSzUvoPvoAbxAJKK56k
         3561YjdjCcTwilgL6NPHiEy367NKN50NnGVqPOQHqLpQkueIG6BoVvvxcm/uNLQZ0J
         fuDTWSPryAZIp8LzHmRA65OFiB0t5p51T7yC3iLR6ifsyXrdmZz6dIpTxEWwf6I04t
         EXTRNXSEX6fNcrNYPRegDnhuQlLroaAZQkgrwy7mzb5j7Z0PokPD3exeF/ctpOhyAL
         6wU0ohuRybX6w==
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
Subject: [PATCH v3 4/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add touchscreen
Message-ID: <20221121132828.207053-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221121132139.206581-1-linmengbo0689@protonmail.com>
References: <20221121132139.206581-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FL8005A uses a Focaltech FT5402 touchscreen that is connected to
blsp_i2c5. Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index a8e8d5273e75..2cac99e3e52c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -65,6 +65,32 @@ usb_id: usb-id {
 =09};
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@38 {
+=09=09/* Actually ft5402 */
+=09=09compatible =3D "edt,edt-ft5406";
+=09=09reg =3D <0x38>;
+
+=09=09interrupt-parent =3D <&msmgpio>;
+=09=09interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09reset-gpios =3D <&msmgpio 12 GPIO_ACTIVE_LOW>;
+
+=09=09vcc-supply =3D <&pm8916_l17>;
+=09=09iovcc-supply =3D <&pm8916_l6>;
+
+=09=09touchscreen-size-x =3D <800>;
+=09=09touchscreen-size-y =3D <500>;
+=09=09touchscreen-inverted-x;
+=09=09touchscreen-swapped-x-y;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&touchscreen_default>;
+=09};
+};
+
 &blsp1_uart2 {
 =09status =3D "okay";
 };
@@ -229,6 +255,24 @@ gpio_leds_default: gpio-led-default-state {
 =09=09bias-disable;
 =09};
=20
+=09touchscreen_default: touchscreen-default-state {
+=09=09reset-pins {
+=09=09=09pins =3D "gpio12";
+=09=09=09function =3D "gpio";
+
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+
+=09=09touchscreen-pins {
+=09=09=09pins =3D "gpio13";
+=09=09=09function =3D "gpio";
+
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-pull-up;
+=09=09};
+=09};
+
 =09usb_id_default: usb-id-default-state {
 =09=09pins =3D "gpio110";
 =09=09function =3D "gpio";
--=20
2.30.2


