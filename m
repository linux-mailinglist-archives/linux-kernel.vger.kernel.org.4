Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C8660039
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAFM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjAFM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:26:17 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8AE8FCF;
        Fri,  6 Jan 2023 04:26:12 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E4CB441902;
        Fri,  6 Jan 2023 17:26:06 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673007967; bh=86xiYSv+MPrFMXtYcOiY0Rh3lvW73O7CDGUCbBq3NfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DVu3qIX34r8h8IsJhPeWHrynjbynNhMspWINBedML/lu6VZegi1frr4CZI0pOZmyJ
         KhfyAGE+XPcuJiemfby48FyveDS+TuTt2o4UbshnC56r42rM/ChKVZmDchsmAZNgOK
         porSTUN7bLSsmTtRrw4RhCg60Tc7giDG4QoyR/TwguFNFzSyfRxzK/ygNzQ9g3SHB1
         B/ihtKVQpvT0ND9r0inD3gCv1m2dyX05OqfVYsi5YsDaSbAYxWjFdmLb5J+A2lCHiO
         5PDWrUlT5DhkkbOxoMceBmDAmhey/o2claMXeMLUIBd/BNM7rwGVfyNmIKSfFlH40h
         Kb0sQ1T3lWOeA==
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
Subject: [PATCH v2 0/3] Add support for Samsung Galaxy tab A (2015) tablets
Date:   Fri,  6 Jan 2023 17:25:29 +0500
Message-Id: <20230106122532.3310265-1-nikita@trvn.ru>
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

Jasper Korten (1):
  arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 9.7 (2015)

Nikita Travkin (1):
  dt-bindings: qcom: Document samsung,gt58 and gt510

Siddharth Manthan (1):
  arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 8.0 (2015)

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 300 ++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 116 +++++++
 .../boot/dts/qcom/msm8916-samsung-gt58.dts    |  78 +++++
 5 files changed, 498 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts

-- 
2.38.1

