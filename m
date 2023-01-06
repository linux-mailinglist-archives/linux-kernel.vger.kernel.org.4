Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0DB66023A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjAFOcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjAFOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:31:29 -0500
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD507F46D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:31:20 -0800 (PST)
Date:   Fri, 06 Jan 2023 14:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673015478; x=1673274678;
        bh=zwgxDtrvvsnKx3WwIiMDTQ8qwPQosXJZ2V7U0l4c1eg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kR4wRpqtPRneXInVTW1WRLYAwKN3zaJ8PjaTKTTL6DUL4lToK8fHTZ7oUHqMobIfw
         aO2D6qvOGUiz1YMm7MNWdXP7MrsaNWx8cLC9cWWocG20JpKAfqUhCo+bh8ChUtl32l
         hkiwW2JszoAATrIth6JSTeDzl8dPBYVwQTV+VspeZzHq/FavrKVwqC9oTXAYYwmaGc
         HIqeawU051Z+Ib5EnRWf+WEwWKJPBTIz9rk/cLbauksrhwnplOeVEg26n6kQ0T9Y2K
         RSkNf4fos+IcrX270MZciNChFrj6rVwo5rCqVuW1aoPU3i172UX0R/lnTAlK8lltf4
         jI7tQj9kBxYpA==
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
Subject: [PATCH v6 2/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add initial common device tree
Message-ID: <20230106143010.547140-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230106142748.546975-1-linmengbo0689@protonmail.com>
References: <20230106142748.546975-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smartphones below are using the MSM8916 SoC,
which are released in 2015-2016:

Samsung Galaxy J5 2015 (SM-J500*)
Samsung Galaxy J5 2016 (SM-J510*)

Move msm8916-samsung-j5.dts to msm8916-samsung-j5-common.dtsi, and add
a common device tree for with initial support for:

- GPIO keys
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5703 MUIC)
- WCNSS (WiFi/BT)
- Regulators

The two devices (all other variants of J5 released in 2015 and J5X
released in 2016) are very similar, with some differences in display and
GPIO pins. The common parts are shared in msm8916-samsung-j5-common.dtsi
to reduce duplication.

This patch rewrites J5 2015 devices, later patches will add support for
other models.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 ...-j5.dts =3D> msm8916-samsung-j5-common.dtsi} |   7 -
 .../boot/dts/qcom/msm8916-samsung-j5.dts      | 224 ++----------------
 2 files changed, 15 insertions(+), 216 deletions(-)
 copy arch/arm64/boot/dts/qcom/{msm8916-samsung-j5.dts =3D> msm8916-samsung=
-j5-common.dtsi} (95%)
 rewrite arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts (93%)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5-common.dtsi
similarity index 95%
copy from arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
copy to arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 7ac49a021563..502b38d4a61e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -1,15 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
=20
-/dts-v1/;
-
 #include "msm8916-pm8916.dtsi"
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
@@ -92,7 +86,6 @@ &usb {
=20
 &usb_hs_phy {
 =09extcon =3D <&pm8916_usbin>;
-=09qcom,init-seq =3D /bits/ 8 <0x1 0x19 0x2 0x0b>;
 };
=20
 &smd_rpm_regulators {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5.dts
dissimilarity index 93%
index 7ac49a021563..0a32d33e9778 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -?,? +1,15 @@
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
--=20
2.30.2


