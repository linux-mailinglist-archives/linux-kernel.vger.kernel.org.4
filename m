Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003985EE47E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiI1Smm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiI1Smk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:42:40 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715E8B2E7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:42:38 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664390557; x=1664649757;
        bh=EAkIN+WYvtOVI51kPRMQTeYYERpA+jklMLzBpvelsh4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=xn7Jek4PXDCe8RFU3dNnUw972qg33W+tLebFNpbTdivnEDuJaz3DEC55LKbmIOveC
         4PDo94geSd7/KxVXnpkm6E8ysOy11vwFUVYw23cDVkng6SHlzSX1R//xH4dCizc2C4
         urdY6hyg6ai3ZEB8VRoPB9iRJ8OGQ6XIFhYNiW3nJL/4V6pXgjyXiAbM7te5MKR1pN
         RME2wHPNHEMEM6cNyknqLmV/FfkCeEm/8m+tyiHGGHZtcXHe6mkFM9mSoHg3BMFbIL
         pvzBoY9uFZbrFTB7JOwAio3lJuHZGj2vCUYGqeWF5tU1rOkZOvvpAx+KzPS/CPgxFP
         4GJnNB3VO95HQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v5 0/4] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Message-ID: <20220928184155.186632-1-linmengbo0689@protonmail.com>
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

v5: Fix address typo tz-apps@85a00000 in msm8916-samsung-j3.dts
v4: Try "git format-patch -B -C -M -D" to fix errors.
v3: Drop msm8916-samsung-j5.dts temporarily before moving it.
Minor rewords.
v2: Reword and resend. Split common dtsi patch.
Add missing suffix state in pinctrl.

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

