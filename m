Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD74660F75
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjAGOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjAGOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:19:26 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55554ECAD;
        Sat,  7 Jan 2023 06:19:24 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 410FF4139C;
        Sat,  7 Jan 2023 19:19:18 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673101158; bh=kb1xKWXTqtrVL/HLrsPEo6UqzygHz3DIBWdjQoIGsTs=;
        h=From:To:Cc:Subject:Date:From;
        b=WlM9mW5NgotGAm2YMMXhA3VxpZ1QhoKiJ6Sqc+C5St/DJUBJ/Ef24zobshXiwbbZi
         Ji+HfsE2D8OYAsY3MvTJRJi7z0ZEG1U4E4AZEdRtzX0CmJ6U317NOnvCiPnFVwr0TF
         ULxFpQe8cEinpEvRx743cAz7mVvNiKHbvEmV4XGnnlhCbkxX5fNlA/euYBOQ2RTmzZ
         dzIiQRJTxj0wNBryx0sBbrf4eVsE+T1yRMgKdERNLqWGmowIASQSoCMa8iCoXtM7Wi
         Z/vpqe//7cF1eO3af3uOEntekYpmDjjCkOAxlYdSq4FD336HnLCNN6MPz6O2sv22Kt
         9tiJ4OP4D91AQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/3] Add support for Samsung Galaxy tab A (2015) tablets
Date:   Sat,  7 Jan 2023 19:19:08 +0500
Message-Id: <20230107141911.47229-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_ANY_PILL_PRICE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces basic support for two Galaxy Tab A
tablets: 8 and 10 inch variants. They share most of the
hardware and are mainly dffernet by the display.

With this series both tablets gain support for things like
- SDHCI (internal and external storage)
- USB Device Mode
- UART
- Regulators
- WCNSS (WiFi/BT)
- GPIO keys
- Fuel gauge
- Touchscreen
- Accelerometer

In fact, with some additional patches like display and
modem support, that are not included as part of this
series, these tablets can actually reach one's expectations
of what a "normal" tablet should be able to do.

Changes in v2:
- Squashed the commits.

Changes in v3:
- Address Konrad's review comments.

Jasper Korten (1):
  arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 9.7 (2015)

Nikita Travkin (1):
  dt-bindings: qcom: Document samsung,gt58 and gt510

Siddharth Manthan (1):
  arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 8.0 (2015)

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 296 ++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 113 +++++++
 .../boot/dts/qcom/msm8916-samsung-gt58.dts    |  75 +++++
 5 files changed, 488 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts

-- 
2.38.1

