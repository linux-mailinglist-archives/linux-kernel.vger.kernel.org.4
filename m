Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECAE633D98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiKVNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiKVNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:25:24 -0500
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC564A2B;
        Tue, 22 Nov 2022 05:25:23 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669123521; x=1669382721;
        bh=AhqCCaLvPKm6+EzCNox2qptaiFM8dp9eaZqm0qf77Bk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=JqFinsJG1TTzFK/In8x7p9n3qIRqX74gGfDRJLsCp3PT2laz0UIk7kpcpUSxy/3VX
         jn9RpGtq/k3zcb5pWeFwuPJf4AcljR1Nx5DUMKg8p/X7TvCdrymHbY5D9inKsFoxea
         xfZtNlyPnaAOEiSk5xZXV8McM4S4fEnITrMRe7Mk3aCQw7nT5QSQVfYNUexeqY8dSZ
         B2ldPi8lT1fIUmXfDRYZ7U4nkPbgLzGRkzg6fWp0/xuNDmcfTcmvSwZ/myWwsBd+jk
         k0NdUvdOjqE6zeGCt/ucP7MuXEhiS6WTpWTqazTfGeGfI98aWWvxJbbwlipeJzerOw
         wFqjWJ8b1J6NA==
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
Subject: [PATCH v5 3/4] arm64: dts: qcom: msm8916-acer-a1-724: Add accelerometer/magnetometer
Message-ID: <20221122132405.257604-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221122132142.257241-1-linmengbo0689@protonmail.com>
References: <20221121133732.207820-1-linmengbo0689@protonmail.com> <20221122132142.257241-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iconia Talk S uses a Bosch BMC150 accelerometer/magnetometer combo.
The chip provides two separate I2C devices for the accelerometer
and magnetometer that are already supported by the bmc150-accel
and bmc150-magn driver.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/=
boot/dts/qcom/msm8916-acer-a1-724.dts
index 593051ea92b6..bea0d022dd9a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -6,6 +6,7 @@
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
=20
 /*
  * NOTE: The original firmware from Acer can only boot 32-bit kernels.
@@ -51,6 +52,35 @@ usb_id: usb-id {
 =09};
 };
=20
+&blsp_i2c2 {
+=09status =3D "okay";
+
+=09accelerometer@10 {
+=09=09compatible =3D "bosch,bmc150_accel";
+=09=09reg =3D <0x10>;
+=09=09interrupt-parent =3D <&msmgpio>;
+=09=09interrupts =3D <115 IRQ_TYPE_EDGE_RISING>;
+
+=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&accel_int_default>;
+
+=09=09mount-matrix =3D "0", "-1", "0",
+=09=09=09       "-1", "0", "0",
+=09=09=09       "0", "0", "1";
+=09};
+
+=09magnetometer@12 {
+=09=09compatible =3D "bosch,bmc150_magn";
+=09=09reg =3D <0x12>;
+
+=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09vddio-supply =3D <&pm8916_l6>;
+=09};
+};
+
 &blsp1_uart2 {
 =09status =3D "okay";
 };
@@ -199,6 +229,14 @@ l18 {
 };
=20
 &msmgpio {
+=09accel_int_default: accel-int-default-state {
+=09=09pins =3D "gpio115";
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


