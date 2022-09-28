Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0125EE490
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiI1SpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiI1Sos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:44:48 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7911A0B;
        Wed, 28 Sep 2022 11:44:42 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664390681; x=1664649881;
        bh=XpZbDM+upygRTlijf/OSRl41+UlZ87vL8pT9rplz1UM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=jUQ0ZD9gOj1I7lAJragr/717l3sL05BAR8Qn+ibt4SEq7gVgrajploWcAAhKC0rFs
         u2k+rAJgLKqAOsXQeubH0K3t3zwQNuTeneIVkYnPt38W8aIae+KiF5zJdd+/z636MY
         xRkD9uZb9ICPQV5aZ7zr8YZhhwGEXM5MK1xI8GsNEH9F15gR9ZNk+g6lZnDIIXMU/V
         BlD0qbdXrRnWzFbQauA/1cpbEhEkCRZT1jb32AbOXoTWI4XOmtzC6u7n5d5vNajjK/
         gt1V2HF2HDHz8lhJPo0ljT/3p9eJKzbER8t6Spsi8sL8nrt5for3A8s7217urQV3Pl
         mDCLcxhEXzMCg==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v5 4/4] arm64: dts: qcom: msm8916-samsung-j5-common: Add Hall sensor
Message-ID: <20220928184325.186866-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928184155.186632-1-linmengbo0689@protonmail.com>
References: <20220928184155.186632-1-linmengbo0689@protonmail.com>
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

Samsung Galaxy J5 2015 and 2016 have a Hall sensor on GPIO pin 52.
Add GPIO Hall sensor for them.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-samsung-j3.dts      |  4 +++
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j3.dts
index 35d3e9c6d012..7cfc6f8f5fcf 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
@@ -19,3 +19,7 @@ tz-apps@85800000 {
 =09=09};
 =09};
 };
+
+&gpio_hall_sensor {
+=09status =3D "disabled";
+};
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


