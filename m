Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0EA5EDCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiI1MkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiI1MkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:40:11 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C362ED69;
        Wed, 28 Sep 2022 05:40:07 -0700 (PDT)
Date:   Wed, 28 Sep 2022 12:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664368798; x=1664627998;
        bh=d+blWYb4ULJVGCJee2V9wdzS63cumSK3O0mGsQ29MLo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=f4e7RW/ynjs+kA73emJ9OV4+Cdxcctw4U7X7FuBkLnBKbIdMNX0OOmFHSFCQhXhmU
         xP4QmKJ8zTtN7FHMAUx2hYNsGSsxjORQY6HPlx0ESrQKFbjy/tXcqPAv3nvTpaxdre
         3N6vAAz16i8oSZzTzGqwpUjERLKA7wBfeXASmn1aJvW5FCC2HXIKnR9o+PhzUa1ayR
         58zDHHAfz6Z+IDFSrP6/0N94t27EnuVAIEClAvdF5/LjVPUQVlH752syYpA3i0qwme
         YO6oOu4KhKnNgkOypl+vkTKuv4titchGICvvbXgEP4Pb2j+30B1MQtBeJyyvWOWAKh
         KWr2wRHyqGoAQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        "Lin, Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Message-ID: <20220928123839.104700-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928121717.102402-1-linmengbo0689@protonmail.com>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com> <20220928121717.102402-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

The three devices (some varints of J3, all other variants of J5 released
in 2015 and J5X released in 2016) are very similar, with some differences
in display and GPIO pins. The common parts are shared in
msm8916-samsung-j5-common.dtsi to reduce duplication.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

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
 .../boot/dts/qcom/msm8916-samsung-j5.dts      | 15 +++++++++++++
 .../boot/dts/qcom/msm8916-samsung-j5x.dts     | 11 ++++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
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
index 000000000000..bf8672ebedcd
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
+=09=09tz-apps@85a00000 {
+=09=09=09reg =3D <0x0 0x85800000 0x0 0x800000>;
+=09=09=09no-map;
+=09=09};
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5.dts
new file mode 100644
index 000000000000..0a32d33e9778
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-j5-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy J5 (2015)";
+=09compatible =3D "samsung,j5", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
+
+&usb_hs_phy {
+=09qcom,init-seq =3D /bits/ 8 <0x1 0x19 0x2 0x0b>;
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


