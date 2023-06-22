Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B27393A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjFVAPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFVAPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:15:24 -0400
X-Greylist: delayed 449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 17:15:23 PDT
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594311A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:15:22 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:04:25 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="J3HGnhIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687392279; x=1687651479;
        bh=7io2nYrzkHD3aXlPybSWf16LW6ApjJS6Dz0Z07AACno=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=J3HGnhIZuW2c0V617HbLENla7VuW4MpttI+pL/EhcZ8Mr1eOBgMbLIJj+1K67zdZl
         Hacf+Dud6NyVDwsZzt93pIoBg0p+uh6TLqcWg5mSoem5VR01qHfBDGTtFgiyMhpv4h
         hdWlex33whlRhAPD9u29aSiYinmwuGBzCMbHSwHgcUSXT8eGBEQkkDkSxcn2rk4b6B
         9EFu0ggCqS4+ZKwmNMBm/WgwGNDimLKhjmoYK/Bfzgzt0bapLh/bynklunTvYFsyAx
         QgWuLf+SgkKuMY9Im5b2U22TtFzK2lynIkOx3yTuqmYpL5AAXt0gHf7E43PetSMzJ0
         336O4ySxkjuoQ==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Joe Mason <buddyjojo06@outlook.com>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 4/7] arm64: dts: qcom: msm8916-samsung-fortuna: Add rt5033 battery
Message-ID: <20230622000338.48315-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622000007.48219-1-linmengbo0689@protonmail.com>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Mason <buddyjojo06@outlook.com>

Like the Samsung Galaxy A3/A5, the Grand Prime uses a Richtek RT5033 PMIC
as battery fuel gauge, charger, flash LED and for some regulators.
For now, only add the fuel gauge/battery device to the device tree, so we
can check the remaining battery percentage.

The other RT5033 drivers need some more work first before they can be used
properly.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index 40c8edc795b0..ca147310c27a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -79,6 +79,21 @@ muic: extcon@25 {
 =09};
 };
=20
+&blsp_i2c4 {
+=09status =3D "okay";
+
+=09battery@35 {
+=09=09compatible =3D "richtek,rt5033-battery";
+=09=09reg =3D <0x35>;
+
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <121 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09pinctrl-0 =3D <&fg_alert_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -127,6 +142,13 @@ &wcnss_iris {
 };
=20
 &tlmm {
+=09fg_alert_default: fg-alert-default-state {
+=09=09pins =3D "gpio121";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107", "gpio109";
 =09=09function =3D "gpio";
--=20
2.39.2


