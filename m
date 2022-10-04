Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0EC5F3DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJDIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJDII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1290E237C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so183343wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=/dCo2x1GJGO6lcsdYgfVE3C0ko4+taeASe5EAnmSl7Y=;
        b=xNwadZ2h2MHBiX/y6D1x01Qwk/JxsJbGmTP7PcfsSaiQk6yS/g7Q/A2hGgAwuRnKVh
         4KLY/UyTOx7Ce7gi1HFy5j9u7o77h4Ijb7O2f2cQwWDmThsX/mNDLh0/2OZDEdeCTej4
         T+jKQoBglw2x1pQsC4BwLDWSq2a82KE8KQmnXxstr4Q7KNYnE32ZqPbX+DAadVCaS2Ws
         dMEITYYAfswMHJj5wJVyR0RJDfVvIS2ue7cjQjhG+3S0IpuvphReBkMzzB/12hvWHVXn
         TVLuvHsCQo+mFgHrhibGEOQMemQeoNr16mWqg70nRTrRH9QoFpYnZuKLBy5sWafTdsjY
         rrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=/dCo2x1GJGO6lcsdYgfVE3C0ko4+taeASe5EAnmSl7Y=;
        b=VJa7v0tmGfG4iZmfmaFEoCSjr4ituLy3Jk//l9ryb2IFrl/bOs8rlPPzy0wJOFPa1f
         3pRk8UBeeBkNYd1cGdNFmlfuvwFqj04DboXmZOLDJwQjbPazSYL2jOQs3dC4+S04tPBD
         W/dhEffmlcC8ETMfLFt3woi6L4JKb79wSk2YH8/6ycGGXF5mjkUz51CX9RgQsgEOrvKq
         +Bm0ePDUR66TMxyVDNM32m+m8gjzQrmpA041w9krqMc7gpMICEofnAPJLzJs0SpbQYzN
         w73ax6gKzOSRtnm+FkPneYXWPHLT8ccnyDFX6+tONqx5yXHRwhuhChTWc75A4ZrrDbru
         LvKQ==
X-Gm-Message-State: ACrzQf0Pg5lWpPYd5F+6xie9ZAQhe73E9c4KlqjfHkgzAs+wvVjvLE2f
        JCE2UjYv6Dp6tIYhIxodgheYgg==
X-Google-Smtp-Source: AMsMyM6Es/yTNo8XrErc7/e8f2DPBMVbSm6jt+YT4UcPFryEALZku1sLyh+siU2xAEWTOoHGqnWL3g==
X-Received: by 2002:adf:ecc9:0:b0:22e:2e94:bdef with SMTP id s9-20020adfecc9000000b0022e2e94bdefmr8469844wro.689.1664870903597;
        Tue, 04 Oct 2022 01:08:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:23 -0700 (PDT)
Subject: [PATCH v2 00/11] arm: qcom: mdm9615: first round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAPDpO2MC/4WNWwrCMBREt1Lut1eSqOnjy32IH3ncNoE2gdxalNK9G9yAX8MZODM7MJVIDEOzQ6
 Etcsypgjo14IJJE2H0lUEJpUSvOlz80mt5Q78iu0CLwTG+iVFrf/XCOdu6FqptDRPaYpIL1U+vea5l
 iLzm8vm9bbLG4//wJlGg1aQvpvWjpO4+x2RKPucywfM4ji/Xd/HXxAAAAA==
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:16 +0000
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first round of trivial bindings & DT fixes for the MDM9615 platform.

This first round focuses on trivial changes, the remaining work will
mainly be .txt to .yaml transition of old qcom pmic & co device bindings.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Lee Jones <lee@kernel.org>
To: Satya Priya <quic_c_skakit@quicinc.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Dependencies: None
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- patch 1: switch to move from swir.txt to qcom.yaml
- patch 2: use MIT licence instead of X11 licence
- patch 3: move reg after compatible
- patch 4: added Krzysztof's review
- patch 5: split into 5 changes:
  - document qcom,pm8921 as fallback of qcom,pm8018
  - convert qcom,pm8921-pwrkey to dt-schema
  - document qcom,pm8921-rtc as fallback of qcom,pm8018-rtc
  - drop unused PM8018 compatible
  - drop unused pm8018 RTC compatible
- patch 6: None
- patch 7: Reworded commit log based on Dmitry's wording on similar patches
- Link to v1: https://lore.kernel.org/r/20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org

---
Neil Armstrong (11):
      dt-bindings: arm: qcom: move swir,mangoh-green-wp8548 board documentation to qcom.yaml
      arm: dts: qcom: mdm9615*: add SPDX-License-Identifier
      arm: dts: qcom: mdm9615: add missing reg in cpu@0 node
      arm: dts: qcom: mdm9615: remove invalid spi-max-frequency gsbi3_spi node
      dt-bindings: mfd: qcom-pm8xxx: document qcom,pm8921 as fallback of qcom,pm8018
      dt-bindings: input: qcom,pm8921-pwrkey: convert to dt-schema
      dt-bindings: rtc: qcom-pm8xxx: document qcom,pm8921-rtc as fallback of qcom,pm8018-rtc
      mfd: qcom-pm8xxx: drop unused PM8018 compatible
      rtc: pm8xxx: drop unused pm8018 compatible
      arm: dts: qcom: mdm9615: remove invalid interrupt-names from pl18x mmc nodes
      arm: dts: qcom: mdm9615: remove useless amba subnode

 Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
 Documentation/devicetree/bindings/arm/swir.txt     |  12 --
 .../bindings/input/qcom,pm8921-pwrkey.yaml         |  77 +++++++++++++
 .../bindings/input/qcom,pm8xxx-pwrkey.txt          |  46 --------
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  45 +++++++-
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |  16 ++-
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  39 +------
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         |  39 +------
 arch/arm/boot/dts/qcom-mdm9615.dtsi                | 121 +++++++--------------
 drivers/mfd/qcom-pm8xxx.c                          |   1 -
 drivers/rtc/rtc-pm8xxx.c                           |   1 -
 11 files changed, 173 insertions(+), 230 deletions(-)
---
base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
change-id: 20220928-mdm9615-dt-schema-fixes-66d4d0ccb7c7

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
