Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5C5EE276
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiI1RAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiI1RAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:00:43 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C9780BDA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:00:42 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664384441; x=1664643641;
        bh=gUhqstaRapz/dEFPQohg3Styf6DL29cIpA3fSfsODL0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=zK2eQy6lao1+50JVyNkwsj29cMwOASBhry1NxC0TDywJaJ5F/BdobgDt4lujEAlsO
         x9PORPUEzMrJW+ukjvWV15iIM0O3eoEfzSPjb1waaa1J2MKHlQpQsLLkYHubE3FTO9
         MPWaz1Y8/T1PSwo8VRCbws1lavPB07FJQfrv0Sd/elUFJX5lILE4p6h+8iE5fp9ZKJ
         6yf8V8z0Ft/po3qrjn3UnOID1VoTiXY2b8eq0bar075uhvGTM40kouGdmMHISqy7yH
         b/ct73/PL7lVJvVD1YGxvOU+iSKakoSnBtVDmeSsibBNU1nwj63j/akkSWm6zhpKPL
         Lcnuj98UVawuA==
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
Subject: [PATCH v3 5/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add Hall sensor
Message-ID: <20220928165944.181207-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928164806.179314-1-linmengbo0689@protonmail.com>
References: <20220928164806.179314-1-linmengbo0689@protonmail.com>
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

Samsung Galaxy J5 2015 and 2016 have a Hall sensor on GPIO pin 52.
Add GPIO Hall sensor for them.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-samsung-j3.dts      |  4 +++
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j3.dts
index bf8672ebedcd..7fd357b7f728 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
@@ -19,3 +19,7 @@ tz-apps@85a00000 {
 =09=09};
 =09};
 };
+
+&gpio_hall_sensor {
+=09status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 4f71609bf6f8..54190144f823 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -3,6 +3,7 @@
 #include "msm8916-pm8916.dtsi"
=20
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
=20
 / {
 =09aliases {
@@ -21,6 +22,23 @@ tz-apps@85500000 {
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
@@ -193,6 +211,14 @@ l18 {
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


