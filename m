Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E59660F2D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjAGNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAGNdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:33:18 -0500
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01D5D431
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:33:17 -0800 (PST)
Date:   Sat, 07 Jan 2023 13:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673098395; x=1673357595;
        bh=3JUH9jgxvrO6pX2/oOfyUckL9ueEpdJEpOBuvzO+l/o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=diOEoydaVZmCYysTxD5/KrOEVRhpEHtmL6kSS96L00n7sPMVVFcc1wEqrhXwTvFE9
         qv9O3QyLXn8MjzPoN77ZMECvFMPVU4qO2Z7C7nl+axxR610QaEtwl9kPVBeIWQKeSx
         WPT9mSyc1Tkk97YdkR+JwoVOGzTryOlrjRmhzQa0zISh4sEb7bKQpq4SKedFsqX/Er
         p6OitWIw1sA8taIE16W027qppXkVWNxSXb025eRo9ompr0DJsOKvQyhWO59DHNFg1Y
         adu9ST5NX2jIwQJ5BqqmLjsjwIJPc+ymZIkKFSi3dSHs5r93V2OMYxsv3dwwnzb2SK
         LdgqrijTIO1/Q==
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
Subject: [PATCH v6 4/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add touchscreen
Message-ID: <20230107133223.139893-1-linmengbo0689@protonmail.com>
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

FL8005A uses a Focaltech FT5402 touchscreen that is connected to
blsp_i2c5. Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index a8c36c9f5d9d..b44c30a72784 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -63,6 +63,32 @@ usb_id: usb-id {
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
+=09=09pinctrl-0 =3D <&touchscreen_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &blsp1_uart2 {
 =09status =3D "okay";
 };
@@ -225,6 +251,22 @@ gpio_leds_default: gpio-led-default-state {
 =09=09bias-disable;
 =09};
=20
+=09touchscreen_default: touchscreen-default-state {
+=09=09reset-pins {
+=09=09=09pins =3D "gpio12";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+
+=09=09touchscreen-pins {
+=09=09=09pins =3D "gpio13";
+=09=09=09function =3D "gpio";
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


