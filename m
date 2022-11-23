Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02D3634E67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiKWDhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiKWDhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:37:37 -0500
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9B5F49;
        Tue, 22 Nov 2022 19:37:33 -0800 (PST)
Date:   Wed, 23 Nov 2022 03:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669174651; x=1669433851;
        bh=yIBwMfmtIa7Rb5jFkIzp6XGNfH1PaXySIjE175eRKns=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=rXMStljVNPYuKcFircOv0p6e27hsQb1i8duznbG4OPfBV2OMN50FVNgDTLJwF5C/X
         Uvz1VCfAbRSs8iEnRT0FxoIEra629qUl32cAffmxbAwWVagwqONMZQhrU7tfpQNRhb
         ZMR3dh1F5k0GeKL8nJbkxSWyXXXIl44BJSnpfGPJ3pM6VHb0F0rexng0wt1wRCtB7j
         9tmQ9jnJEkyq24cHWO46AWkPmTImsWhkDGm6T1NZP4iYEAa3cjMlLjSinuqoTqQ496
         eKQaH5Aomd8iuz+1Hgrc8WeDOw32xooCyZb4c923IugiKCq4E4UBZ1ZtG/UYkkLFLZ
         YNRXYYFcc7Rjw==
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
Subject: [PATCH v6 0/4] arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
Message-ID: <20221123033524.148682-1-linmengbo0689@protonmail.com>
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

v6: Fix incorrect commit message and newlines in touchscreen.
resend: Fix incorrect in-reply-to
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

