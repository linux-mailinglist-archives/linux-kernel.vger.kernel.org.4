Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196E6323F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKUNjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiKUNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:39:23 -0500
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D941DAFE5D;
        Mon, 21 Nov 2022 05:38:47 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669037926; x=1669297126;
        bh=kfk6bVEV/JyzyHMeoamDSd9as4fQPubMKRh8Hzvf9Ks=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=L/XaJhZD62TIcWJXINUUdKibeAUQ7Cw4kRK9ig//L8eGNIX1ZYRV1X1+Er84ZUYml
         +TpExwwkAuCbnnfmvGAOIHQX4OW8xlnn3/MH9JLtwlSB4Oie7VWsJ14F9S41yZ0VB5
         4XzJ7sKPtn0SUca4TXPxEHdCZ76xtDRd8POlctBcQNlAO3os0BeGGANPPgEqoZQGro
         elt+kHEOHEbWueXuQu9wSfac1r14ynpeeiLXD03tvOJ2by9GxfJvIYUO0ij/BmJwus
         pzqEW3nMzKiQo0rHX3Q2bMua2XdqaegI6dwYU14qK56Zsw9TkJZGkLxSgf0JMmv3Sr
         0y8awmOqJGmUQ==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 0/3] arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
Message-ID: <20221121133732.207820-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: Sort properties in l11.
v3: Set property status =3D "okay"; as the last property.
Reword the bindings patch.
v2: Fix a typo in dt-bindings commit message

Acer Iconia Talk S A1-724 is a tablet using the MSM8916 SoC released
in 2014.

Note: The original firmware from Acer can only boot 32-bit kernels.
To boot arm64 kernels it is necessary to flash 64-bit TZ/HYP firmware
with EDL, e.g. taken from the DragonBoard 410c. This works because Acer
didn't set up (firmware) secure boot.

Add a device tree for with initial support for:

- GPIO keys
- pm8916-vibrator
- SDHCI (internal and external storage)
- USB Device Mode
- UART
- WCNSS (WiFi/BT)
- Regulators
- Bosch BMC150 accelerometer/magnetometer

