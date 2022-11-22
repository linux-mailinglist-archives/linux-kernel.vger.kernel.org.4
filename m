Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9339A633D83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVNXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiKVNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:23:21 -0500
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280113CDD;
        Tue, 22 Nov 2022 05:23:19 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669123396; x=1669382596;
        bh=wJUmbJeGI3ZBTQ2ffMxbeJTCLbab3pg4+WRPmiiIANI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RlA+r/TUQuEUQkBUBImv7ZSXNvkQ9ifWVjxa6+P/DLPD7cFFOwMda3ZduNL6OJTOu
         oURlEuKpB4wOxctOEDHKiPY+4l10st788utceR/akN18UowYSqkCPUrv/yDXqGc1WI
         g9DE6l9Vjgm2+kAa0JZ1RYVg4Gaq6BLuqF+Aay8WMiFF4SlDnxIFwU5XHV3QMz2QrE
         GKVk+X1eNH9jRV60QX7XRgNk3nDnhh1JTxyyslEvkBlIJfoUTi/lPvldxnsHlM8YXI
         5g64nhIIH098jb/xuyyPpSfVeWLaE8Bq+XEgVn1KejD6lVMRbcLwNxkM2B8bEd5L/F
         JVw5eIvvF5NMg==
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
Subject: [PATCH v5 0/4] arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
Message-ID: <20221122132142.257241-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221121133732.207820-1-linmengbo0689@protonmail.com>
References: <20221121133732.207820-1-linmengbo0689@protonmail.com>
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

v5: Add touchscreen.
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
- Focaltech FT5446 touchscreen

