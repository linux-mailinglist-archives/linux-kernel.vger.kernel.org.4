Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067AD607971
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJUOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJUOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:23:30 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0B27CFE6;
        Fri, 21 Oct 2022 07:23:29 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666362203; x=1666621403;
        bh=5H/7a/xKSWSzrueIagX7V6sArKHXi7j+GtA083jFCVs=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=zYZAk67kmlx5KRet5AghQNAhqidx5BqnIQH9eD/0MHQY3qAl8xuoUkm58PhuIB7az
         K6sG8UcHjE85JCZ2t4YlnXnFwjjCqh3evMajgwz0303vb/xEbKN1rJ4oKZ5ApZP/l1
         CUtAd3fRM5OQzVup3VzP+rRuG0ceK3GcRFglD/KKsBZF1sEwW3AOcxeA5eLkOkQ2kc
         nq3B9lFFR5l4bUzq1P+2FBiIODJkKRtkVWRpv99AcsICA7ifq8xSwUZvPtLwKs6Ksc
         g6VfyrHdUgRj0uUfomrbiJI5aGot1qkMx0w+JQkuNjQVd1Q7YjI2wbUpKIOGfmWINW
         SHXavAQEsFifA==
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     Harry Austen <hpausten@protonmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 0/4] Initial OnePlus 3(T) Support
Message-ID: <20221021142242.129276-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the OnePlus 3 and OnePlus 3T mobile
phones based on the Qualcomm MSM8996 SoC. Currently includes support for
the following:

- UART console via PCB test pads
- Qualcomm Atheros QCA6174 WiFi and Bluetooth
- NXP TFA9890 Speaker Amplifier
- TI BQ27541 Battery Fuel Gauge
- Synaptics RMI4 Touchscreen
- UFS Storage

Harry Austen (4):
  arm64: dts: qcom: msm8996: standardize blsp indexing
  arm64: boot: dts: msm8996: add blsp1_i2c6 node
  dt-bindings: arm: qcom: add oneplus3(t) devices
  arm64: dts: qcom: msm8996: add support for oneplus3(t)

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi | 794 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts |  44 +
 .../arm64/boot/dts/qcom/msm8996-oneplus3t.dts |  45 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  49 +-
 6 files changed, 927 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts

--
2.38.1


