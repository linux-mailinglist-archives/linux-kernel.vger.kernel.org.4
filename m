Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59062DEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiKQOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbiKQOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:48:38 -0500
X-Greylist: delayed 1187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 06:48:35 PST
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33E308;
        Thu, 17 Nov 2022 06:48:24 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668696502; x=1668955702;
        bh=dS2uiDSZKMvuJWEBxvTbd4Wb9ikgFCZTHfkeHw4tYO4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=aZW2BGhBXhazUeSELNvdB1B4l1xKbyJ95eM642n5uKk/RnYr6quGkNcfRC0fltp7k
         DfYA+AHWTotUSq8Wa0JjJV85Sg4u9YyZpcNhjWO3mmYxVqwzKpWhF5zP/lEFPL1JbD
         vsWevXkyIJ0jzXGs0Cs2JWPwStzQ0Vr/cY8FinxrNKxBrgb32GFtFVVVclWX06oSAW
         E6uCyKRK5qBZYqq60IbSFPcGaaT0Il6WSFkZLQ+KbgUdXxaFoS+X+8ql7m1zox/WbS
         sTvJsIrJr3YeaKP4/BNqYnzeO4RUjhk8O3LHMchLZ4X2Rk+TKKF8aQwniPDUXR4wQu
         0t4JG1xRhdIow==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-grandmax: Add properties function and color for keyled
Message-ID: <20221117144717.17886-1-linmengbo0689@protonmail.com>
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

keyled is white, and used as touchkey LEDs.
Add properties function and color for keyled.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index bc7134698978..042ec55d447d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -29,8 +29,12 @@ / {
=20
 =09gpio-leds {
 =09=09compatible =3D "gpio-leds";
-=09=09keyled {
+=09=09led-keyled {
+=09=09=09function =3D LED_FUNCTION_KBD_BACKLIGHT;
+=09=09=09color =3D <LED_COLOR_ID_WHITE>;
+
 =09=09=09gpios =3D <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
 =09=09=09pinctrl-names =3D "default";
 =09=09=09pinctrl-0 =3D <&gpio_leds_default>;
 =09=09};
--=20
2.30.2


