Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86892634E71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiKWDje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiKWDja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:39:30 -0500
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069EE6EFA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:39:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 03:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669174767; x=1669433967;
        bh=VAzF2acE8fV18MqA/KaNHMPFyttLWRS89RLiSXR00tc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aqhv26zEwL4SOKL7qqOgZcJDLcNF611HAmls7ZIdx3jMmVzi8DeGSg7ON/PJ9N0/M
         1ESTnXKC16/kn/OWIAjzx8TFoKncFJX7ChB33VVlzEg7AkSZmidIKESVbhx9laSXUz
         khmlW+dJdePtZFoWsM05rI+0XN0uCQK8jzLILdbpB9h/uiw332iTOiTB5bVcoSH5Ls
         tZ7ZSANczr7oDYt1gn56fwmM44GC8LN9boFtTmYMdt82keWBWzcuLrc8rK0XDHvonH
         THI4Sbv5XUq3Bi7y1wcvJeqYrIbGw78zDPYtushyJhW2t/GPvWKpVEKviIouinY050
         rHd59DpC131PQ==
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
Subject: [PATCH v6 4/4] arm64: dts: qcom: msm8916-acer-a1-724: Add touchscreen
Message-ID: <20221123033844.149115-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221123033524.148682-1-linmengbo0689@protonmail.com>
References: <20221123033524.148682-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A1-724 uses a Focaltech FT5446 touchscreen that is connected to blsp_i2c5.
Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/=
boot/dts/qcom/msm8916-acer-a1-724.dts
index bea0d022dd9a..ed3fa7b3575b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -81,6 +81,30 @@ magnetometer@12 {
 =09};
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@38 {
+=09=09/* Actually ft5446 */
+=09=09compatible =3D "edt,edt-ft5406";
+=09=09reg =3D <0x38>;
+
+=09=09interrupt-parent =3D <&msmgpio>;
+=09=09interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
+
+=09=09reset-gpios =3D <&msmgpio 12 GPIO_ACTIVE_LOW>;
+
+=09=09vcc-supply =3D <&pm8916_l16>;
+=09=09iovcc-supply =3D <&pm8916_l6>;
+
+=09=09touchscreen-size-x =3D <720>;
+=09=09touchscreen-size-y =3D <1280>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&touchscreen_default>;
+=09};
+};
+
 &blsp1_uart2 {
 =09status =3D "okay";
 };
@@ -245,6 +269,22 @@ gpio_keys_default: gpio-keys-default-state {
 =09=09bias-pull-up;
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


