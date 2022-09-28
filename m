Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E375EE243
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiI1QuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiI1QuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:50:17 -0400
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A507F75FCB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:50:16 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:50:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664383814; x=1664643014;
        bh=o11CrCXx0Cb6C3dCffIEI1V7Knf/291iZPlpw60/k7s=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=wqn3bFFtbPzeDvuatqWT+QHMChrXBU2xzAwob5hZ85MjeWi+xmxnEes2mIyYiG3af
         1AT5iSvrltQrgz/KO9QWqSoYl4UMufWxuD9wJdmV8hiMbty3S5AULwkxqV6CRcGSaC
         yP8rCpkBGeAnQSRQR6oJM1vlbsWgCTR/qs0TxjHRBsc+8oYK1fNnt7O1gKq/PaM2aV
         5sx16n1UgNU1FjcvU62Xz1yGI0KU9W0HJA5yn6foJptRtqPebCqjlUA+vRvN9HvTaq
         ouQCZujD+q2BPb4xKZhFdFhlBCei2wfjEWkO1nrkYYXcttSLDyWhqCryvOcH6wHAax
         fMC3o/k9El+7w==
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
Subject: [RESEND PATCH v3 0/5] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Message-ID: <20220928164806.179314-1-linmengbo0689@protonmail.com>
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

