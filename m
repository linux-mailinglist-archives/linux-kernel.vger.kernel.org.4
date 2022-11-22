Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EC7633DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiKVNcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiKVNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:32:37 -0500
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1959C74;
        Tue, 22 Nov 2022 05:32:33 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669123951; x=1669383151;
        bh=pMgyj6309dziadQUAmdkN8/52Ea7gPzJRy2Jf1geJQ0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mjtT6EgCEwE8+XuS8+w0R+4ofsX1V819BBmdonEiDDR39lUerGE3a+lF9NFEYql9J
         tGaDwLhfACpoopmLOVgzncL0p5dyhK1jyYBZ6l0HZjgEpI2zK0Y3rxHBsHm0ghxde9
         DvuWbrFAFqodjCN5qwGn4VKZ1YYy9Nq2R9cJxE8MgPrIccQRmtLt888aKgYczzYYho
         aZhg0KlT5ka0m38acxmUVZ0roCtZeRFtOZiI2YLenbqGvsayE5Jq/k/PDP3zSayjB2
         eyuZH/N87Dtc9Puezvty+hmpf0EPCLD5KlMZt/l7+MK1aiKBNCs6hLvj7bsxFmSbq4
         Gxp/Bfyjh/7Zw==
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
Subject: [RESEND PATCH v5 4/4] dts: arm64: qcom: msm8916-acer-a1-724: Add touchscreen
Message-ID: <20221122133141.258357-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221122132816.257717-1-linmengbo0689@protonmail.com>
References: <20221122132816.257717-1-linmengbo0689@protonmail.com>
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

A1-724 uses a Focaltech FT5446 touchscreen that is connected to blsp_i2c5.
Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/=
boot/dts/qcom/msm8916-acer-a1-724.dts
index bea0d022dd9a..5b216107f69b 100644
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
@@ -245,6 +269,24 @@ gpio_keys_default: gpio-keys-default-state {
 =09=09bias-pull-up;
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


