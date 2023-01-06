Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8013660221
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjAFO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjAFO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:28:51 -0500
X-Greylist: delayed 22727 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 06:28:50 PST
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F97F470;
        Fri,  6 Jan 2023 06:28:49 -0800 (PST)
Date:   Fri, 06 Jan 2023 14:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673015327; x=1673274527;
        bh=EjS6ZMNfxyg1IpQb2RzuuQ6AIAq0IAmasRoXbMY2njg=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=GFAopug4XsB9KeDTz+zVqIieXaocn4ehFITyEhf5uK2gg6a89b28Y1TsjN8/9s47l
         TlT2uzx/7UiDQI4dhEXS6Lldtdno1keJ8u7GW4cZzthtQZA+VM3+jyvNyNrjoIb56J
         RBvrK0RUeNKMUslOJWbTjAEPzgZzlIUCOBvA/xjvffPPyAd+X5XuK7gmKNXQmPLKPS
         Fp0+ZvBuR+5BjN0AH6UsIUm8yvZyS+5YdClADJ2/ZAWepVD++2F01Zp0LEbhm12y6J
         q7XuORbTKfnFjVRMQALgU+xAeXeI2uejofw6zIVGPgVlXWeP0JH1rUkmK6Px3Rgdk1
         K+z6hN8dOMpiA==
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
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 0/5] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Message-ID: <20230106142748.546975-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6: Rebase on linux-next and reword. Add MUIC. Drop WIP J3 device tree
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

Add a common device tree for with initial support for:

- GPIO keys
- GPIO Hall sensor
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5703 MUIC)
- WCNSS (WiFi/BT)
- Regulators

The two devices (all other variants of J5 released in 2015 and J5X
released in 2016) are very similar, with some differences in display and
GPIO pins. The common parts are shared in msm8916-samsung-j5-common.dtsi
to reduce duplication.

