Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557815EE48D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiI1Sox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiI1Soq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:44:46 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB960DF38;
        Wed, 28 Sep 2022 11:44:40 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664390679; x=1664649879;
        bh=+y/IKTutaewRNTvQIWmB1RXTuElSdtHOydFT1+sPz6c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=NQOuLeEFZtjWd6r4/ZZm/YSU9mrpsi0KChBKoUmLGxC3cyRjqBNp9l6fPKFAuDrkx
         sjc8IAorLFJGGYg0mUj2+uO4vflSafvMHYzoi32f1omw0bwohsKWNRPmZbJLczw/dP
         KcQ/4C3cV0pA/9L7kZxScbTSNV1WHldT/Q1TLcaBGm2iL1GZIVBJ5LDH969brZXLiV
         h56RCu4uSdiGQYXRZWkDOTvJj3Gk7q0UyTwJws7E1h+tDB8i3bXWCdFyRkjVJdPq89
         t1fNSGytCmedCSrUhr/VrM2lrdrN9pAPkjRSAATxBDT/G7W1LB3yGGtUyUQU5jwIZN
         fuCGJA/7iHvPQ==
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
Subject: [PATCH v5 3/4] arm64: dts: qcom: msm8916-samsung-j5-common: Add new device trees
Message-ID: <20220928184314.186805-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928184155.186632-1-linmengbo0689@protonmail.com>
References: <20220928184155.186632-1-linmengbo0689@protonmail.com>
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

After moving msm8916-samsung-j5.dts to msm8916-samsung-j5-common.dtsi,
Add new J3 and J5 2016 device trees.

[Add j5x device tree]
Co-developed-by: Josef W Menad <JosefWMenad@protonmail.ch>
Signed-off-by: Josef W Menad <JosefWMenad@protonmail.ch>
[Use &pm8916_usbin as USB extcon and add chassis-type for j5x]
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Use common init device tree and add j3 device tree]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |  2 ++
 .../boot/dts/qcom/msm8916-samsung-j3.dts      | 21 +++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-j5x.dts     | 11 ++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index 1d86a33de528..357a2529fe74 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -15,7 +15,9 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-longcheer-l8910.dt=
b
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a5u-eur.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j3.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5x.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8992-lg-bullhead-rev-10.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j3.dts
new file mode 100644
index 000000000000..35d3e9c6d012
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-j5-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy J3 (2016)";
+=09compatible =3D "samsung,j3", "qcom,msm8916";
+=09chassis-type =3D "handset";
+
+=09reserved-memory {
+=09=09/delete-node/ tz-apps@85500000;
+
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85800000 {
+=09=09=09reg =3D <0x0 0x85800000 0x0 0x800000>;
+=09=09=09no-map;
+=09=09};
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts b/arch/arm64/=
boot/dts/qcom/msm8916-samsung-j5x.dts
new file mode 100644
index 000000000000..7656ac4508cf
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-j5-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy J5 (2016)";
+=09compatible =3D "samsung,j5x", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
--=20
2.30.2


