Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32D173B459
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFWKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjFWKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:01:50 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E810D2;
        Fri, 23 Jun 2023 03:01:40 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687514497; x=1687773697;
        bh=tDChsguxGV1DtxUOY3/1Y42T2+eyLtmbRl+XkwaJQzc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=afoVKASO3K68rRSyDS1NBbYzJVmhn4DvsA4oi2o7E0AHchCTLggTw2vAvTvbPw09J
         UGaNY8gZIbVSC0f+nVoBV90twWMOWXi/lAJ8tFIYrDbJ5jlu9HVPziv9Lk30H+qYpe
         q4LYnW8TE1NtzUMJmeaFusN+d1aOzMhmbAwndz1N4aG+XXcAJoGrLyLUkGl3ecaGik
         8tguWZDlMDzTT1TEyfVhTSi5Zk2am9Aqj/jJd/vGk7LNakD9+xC2bKkRsePYDaOgMM
         o0e37pBN5GP5RQz1KTZifYFoHhK7yJMXZRD2i9jxVBn6vbzl7wYRfp/cAzqkQoM1Iq
         Im6SPUQuQaGug==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
Message-ID: <20230623100113.5253-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622020344.65745-1-linmengbo0689@protonmail.com>
References: <20230622020344.65745-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Squash patches

This dts adds support for Samsung Galaxy A7 smartphone released in 2015.

Add a device tree for A7 with initial support for:

- GPIO keys
- Hall Sensor
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5502 MUIC)
- WCNSS (WiFi/BT)
- Regulators
- Touch key
- Accelerometer/Magnetometer
- Fuelgauge
- NFC
- Vibrator
- Touchscreen

