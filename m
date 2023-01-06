Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9066023C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjAFOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjAFObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:31:37 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C917F470;
        Fri,  6 Jan 2023 06:31:32 -0800 (PST)
Date:   Fri, 06 Jan 2023 14:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673015491; x=1673274691;
        bh=Jtx9DakIpfF+Lwd5xBjPwVFe6Af//ReFvJ0WW/ILW0E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vO7cCe8GRW47dZWSjBKgSZqyrZU8WIt3CoWzj1wJv4oO1I4bQvSUDPujKG+zp+d3p
         SdZCRs1ayj/w0j+I/G5HkzJ1H2Fp8Pdamws6YbgxJNeO6SRs7X5UQnAYMsVYTTVQvx
         3j3RDTkrlaAeTNCERjfxC0fJ/U91VTs9yNLDXHwRnhB+ZT+W1jalYl46P3PijlM0n7
         ZHZ4/lIX+9PnfHG7dUpXD3ivH/CzIPndVIFMINJubyKoG5+Afw+8E4Fw/VP16MvlpR
         fadwf5aaQlA3UArYagHIvCgXZEJKaiLCZUuyMNi3p7L5iiKMLmSJyWP1zwCqBVdADN
         Bd90qUEIgxzGg==
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
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 4/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add Hall sensor
Message-ID: <20230106143037.547248-1-linmengbo0689@protonmail.com>
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

Samsung Galaxy J5 2015 and 2016 have a Hall sensor on GPIO pin 52.
Add GPIO Hall sensor for them.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 502b38d4a61e..5755b360c6ed 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -2,6 +2,7 @@
=20
 #include "msm8916-pm8916.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
=20
 / {
 =09aliases {
@@ -20,6 +21,23 @@ tz-apps@85500000 {
 =09=09};
 =09};
=20
+=09gpio_hall_sensor: gpio-hall-sensor {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&gpio_hall_sensor_default>;
+
+=09=09label =3D "GPIO Hall Effect Sensor";
+
+=09=09event-hall-sensor {
+=09=09=09label =3D "Hall Effect Sensor";
+=09=09=09gpios =3D <&msmgpio 52 GPIO_ACTIVE_LOW>;
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_LID>;
+=09=09=09linux,can-disable;
+=09=09};
+=09};
+
 =09gpio-keys {
 =09=09compatible =3D "gpio-keys";
=20
@@ -192,6 +210,14 @@ l18 {
 };
=20
 &msmgpio {
+=09gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+=09=09pins =3D "gpio52";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107", "gpio109";
 =09=09function =3D "gpio";
--=20
2.30.2


