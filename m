Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E55EE270
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiI1RAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI1RAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:00:32 -0400
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7558DF1;
        Wed, 28 Sep 2022 10:00:25 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664384424; x=1664643624;
        bh=HMfLWuTCBimoQHszrNwwVDH2NqizvlSNDkSybhyZMak=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=xwesXVg5ZMe5+KWYyfNmOI35fC16PTYEOAGWFv61C4+/4ODdv1KBArpDl8mo6pkww
         4Pk0K7bMga+qA9a6izzDBYrcA5fCtB7PIzFPF01qaCbo7gvccui8kcEuxmwc4W7aNu
         yhlMnCUXTsJQ9B3Qn3vjMSdpLPTVxIt6AEf0jRfw4A3YJ+ZLW4l9PU3NkJvLLxvCDO
         mXivexD/Fge6x6/Dou6d83fscJFLsfVwZLzCm8AVQ7du3sW5Sfix/dMW7J92eie873
         PwVPOCLj3NaCwwl6FBBTMhkFCA7Ms2bBWSRT1PpOjHkqac904a/G5hUPPLluaNtkKl
         20kjjNVzJEdrg==
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
Subject: [PATCH v3 3/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add initial common device tree
Message-ID: <20220928165920.181087-1-linmengbo0689@protonmail.com>
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

The smartphones below are using the MSM8916 SoC,
which are released in 2015-2016:

Samsung Galaxy J5 2015 (SM-J500*)
Samsung Galaxy J5 2016 (SM-J510*)
Samsung Galaxy J3 2016
- SM-J3109/SM-J320Y/SM-J320YZ
- SM-J320N0/SM-J320ZN
- SM-J320P/SM-J320R4/SM-J320V/SM-S320VL

Add a common device tree for with initial support for:

- GPIO keys
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5703 MUIC)
- WCNSS (WiFi/BT)
- Regulators

The three devices (some varints of J3, all other variants of J5 released
in 2015 and J5X released in 2016) are very similar, with some differences
in display and GPIO pins. The common parts are shared in
msm8916-samsung-j5-common.dtsi to reduce duplication.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 ...6-samsung-j5.dts =3D> msm8916-samsung-j5-common.dtsi} | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)
 rename arch/arm64/boot/dts/qcom/{msm8916-samsung-j5.dts =3D> msm8916-samsu=
ng-j5-common.dtsi} (94%)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5-common.dtsi
similarity index 94%
rename from arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
rename to arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index eabeed18cfaa..4f71609bf6f8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -1,15 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
=20
-/dts-v1/;
-
 #include "msm8916-pm8916.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
=20
 / {
-=09model =3D "Samsung Galaxy J5 (2015)";
-=09compatible =3D "samsung,j5", "qcom,msm8916";
-=09chassis-type =3D "handset";
-
 =09aliases {
 =09=09serial0 =3D &blsp1_uart2;
 =09};
@@ -92,7 +87,6 @@ &usb {
=20
 &usb_hs_phy {
 =09extcon =3D <&pm8916_usbin>;
-=09qcom,init-seq =3D /bits/ 8 <0x1 0x19 0x2 0x0b>;
 };
=20
 &smd_rpm_regulators {
@@ -199,7 +193,7 @@ l18 {
 };
=20
 &msmgpio {
-=09gpio_keys_default: gpio-keys-default {
+=09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107", "gpio109";
 =09=09function =3D "gpio";
=20
--=20
2.30.2


