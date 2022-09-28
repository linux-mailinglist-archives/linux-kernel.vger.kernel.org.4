Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189A05EE26D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiI1RAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiI1RAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:00:13 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142AC7859D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:00:11 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664384410; x=1664643610;
        bh=mo7AOkHDwtAowybZCz4gOmDpXU1TRunSY5GhLVmFCfk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=t4biK5LkVbgF39OHwoxgpWZfZl6skEh4lO3+EbNUMm84TRj/jS1oWkh6otxZT+HH8
         Sr02Iz4CDnHzaBvady+u+BZfDiZxewb/VlM4/MlmSDU8lRiTGl3fOBDDVNLMhvQoxz
         5zyyLDxurXrDdFaKzCzck+869WUrlgVbuSoFl78fExodo4T2AMcBYtsHVckYbDpSlc
         ULQU3U1PE5dHE8ZRQvT2VAcK/cPpv32ioYnzum/MMNYav4oAIi+iLA+laW76igefgV
         gIJJrC5Cvixl1cPO0YKPWAyT3wE/Mmkb4AZKRN67Q//90Xhmwgg/00cpPobJvuaJnk
         s8dT7+EuDAEWg==
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
Subject: [PATCH v3 2/5] arm64: dts: qcom: msm8916-samsung-j5: Drop from Makefile
Message-ID: <20220928165909.181028-1-linmengbo0689@protonmail.com>
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

Before moving msm8916-samsung-j5.dts to msm8916-samsung-j5-common.dtsi,
drop it from Makefile temporarily to avoid errors.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index 1d86a33de528..6db7d9d791d5 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -15,7 +15,6 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-longcheer-l8910.dt=
b
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a5u-eur.dtb
-dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8992-lg-bullhead-rev-10.dtb
--=20
2.30.2


