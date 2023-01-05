Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981F265EB06
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjAEMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjAEMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:24 -0500
X-Greylist: delayed 1043 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 04:51:22 PST
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE74BD68;
        Thu,  5 Jan 2023 04:51:22 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B7F4F405D5;
        Thu,  5 Jan 2023 17:33:54 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922035; bh=JY3J18vceNqkSljuhdCvK7VZGF4GKA73SWNTTOQTB8M=;
        h=From:To:Cc:Subject:Date:From;
        b=SZ+qLlPOV4Wt3/zRoqX2hI0ItaBm6Rwhu3jThWYFfnvPgHf2RgfsnJ0ucvkI0K6dC
         Tx4SeA0cQ/nqSsPMOhX90ZZR7U4uo6wBMCJnHZOSL/CxsasCN5ZQp0M9BO9lPED85w
         dC24BDvF5P3thm2lCj1iI2TaFDF00Lny5vU797zHPNby1zTZSD+Twlpt8qzcVNTaCf
         Pvi9R2mkgoHDhk0VEjy2Hf8rjIO9VnS0pITrOYSxNqAJAhNTurZTJO59VNssKywiXl
         shQD9pApGw7jPF3LTruM9EiKakElPJPLjM9EaTzhZ3jx8BXIfU9zlWkXcf0QrGwQyc
         bFprF6YDmY2xg==
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
Subject: [PATCH 0/8] Add support for Samsung Galaxy tab A (2015) tablets
Date:   Thu,  5 Jan 2023 17:32:32 +0500
Message-Id: <20230105123240.1089375-1-nikita@trvn.ru>
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


Jasper Korten (2):
  arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A (2015)
  arm64: dts: qcom: msm8916-samsung-gt510: Add touchscreen

Nikita Travkin (3):
  dt-bindings: qcom: Document samsung,gt58 and gt510
  arm64: dts: qcom: msm8916-samsung-gt510: Add Vibrator
  arm64: dts: qcom: msm8916-samsung-gt5-common: Add fuelgauge

Siddharth Manthan (3):
  arm64: dts: qcom: msm8916-samsung-gt58: Add Vibrator
  arm64: dts: qcom: msm8916-samsung-gt58: Add touchscreen
  arm64: dts: qcom: msm8916-samsung-gt5-common: add sensors

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

