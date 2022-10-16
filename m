Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB89C600220
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJPRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJPRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:22:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F530566
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:30 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i12so6285475qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gbkkSbXqT43PmPto6mFBhamUZk4OeGT/iuTbMIcXNY=;
        b=Z83lLugiejE4w80gq/rvtZZTGPNgW9Mjn55PiYiEbwnatskFW8B6NOBid+Di1mwy9L
         3HPklr/j4Ztxg0xtIEB85fZlmQTzTSKC4cuUjGfdNjXssCnR7MVeCs+EAwXUlV5lzRx7
         3gGYPTOd5Iciyi+BNUCoB5wIl52F0nz7SZP5ctPzR02Tte1F/KQf8JYtasFNEfIuHWNr
         sGlTVnUnP1CJPDBcOZxOuw4VSYMNcoV7B5cLAmawdmGMlXXl7crIZA5TLuvzNV2PEN97
         6qMvBe299BpA7MSJRV5Ekx1TCY4nd7qd+oGFSi9YPQNmV+7QHSiCitVxWF7vFfrP5YLP
         gp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gbkkSbXqT43PmPto6mFBhamUZk4OeGT/iuTbMIcXNY=;
        b=ImmG2DDyN6J6P+e0oGdvMfBn0L3SSh+9BNV/WoHB1pIUzY6qXzSZniq1uIRdmtDCfa
         R968aTGnxNSntxPg/B+DLAqBVWWJ0nANMKQHHuogLOJSLl7tyJs2j3DMoi5zSOt2yTy0
         UZ19fO5B1kMtY8N0iCFguMJ77exWqCgkkwTENDB+Zfnn4rdFPSLTUc4f/mA/9i7r+L7x
         2HmWYQkXQ8OfnAaVWBXkrwIjs8uQcZ922iDKxQpxVcSQWyI31hiNv0zYNpBKHxwMsk5p
         /b7JdUVg0pOg/P7k7awyArhopKJbBx6DVgyKDcwHK3iAOsB/DJVu3y08SCpQDp29SauO
         xsSg==
X-Gm-Message-State: ACrzQf2HXmbfZI6B3fLrFfzG+iwuzmgdgxjXG4rx5d2o0GG5Ph1Gkg0d
        dtu7Lv4+RzEbNoscORLMGn1CUg==
X-Google-Smtp-Source: AMsMyM5STrKtZsCS7HDu9wc1Ve/epP/Da6e6B/vg1bztG044hcO+Mo8667UbXkih9U9Uak0tjFKVqg==
X-Received: by 2002:ad4:5d48:0:b0:4af:b6ef:eea9 with SMTP id jk8-20020ad45d48000000b004afb6efeea9mr5678320qvb.53.1665940949960;
        Sun, 16 Oct 2022 10:22:29 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/17] pinctrl/arm64: qcom: 4th set of Qualcomm TLMM pinctrl schema warnings
Date:   Sun, 16 Oct 2022 13:21:55 -0400
Message-Id: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. Drop drive-strength, reword commit msg of "qcom,sm8250: use common TLMM pin
   schema" and "qcom,sc7280: use common TLMM pin schema".
2. Move "dt-bindings: pinctrl: qcom,sc7280: use common TLMM pin schema" to this
   patchset. Previously it was part of:
   https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/
3. Add tags.

Changes since v1
================
1. Check for function on non-GPIO pins was moved to common TLMM schema, thus
   new patch #12: dt-bindings: pinctrl: qcom,sm8250: drop checks used in common
   TLMM

2. Above also makes minor context changes in patch #13 "dt-bindings: pinctrl:
   qcom,sm8250: fix matching pin config"

3. Add tags (I am using `b4 trailers` so they might appear in odd order).

Overview
========
This is the *fourth* patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes:
   https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/T/#t
3. ARMv7 TLMM fixes:
   https://lore.kernel.org/linux-arm-msm/20221016170035.35014-1-krzysztof.kozlowski@linaro.org/T/#t
4. ARMv8 remaining TLMM fixes: *THIS PATCHSET*
5. Fifth clean - styles and using common TLMM schema:
   https://lore.kernel.org/linux-arm-msm/20221011172358.69043-1-krzysztof.kozlowski@linaro.org/T/#m277d25a5f3e9d10ca8221a7fba62ca468a67a60b

Dependencies
============
1. Almost no dependencies - logically the bindings patch "dt-bindings: pinctrl:
   qcom,sm8250: drop checks used in common TLMM" depends on patchset #3 above.
   This is not a hard-dependency, everything will compile nicely, no warnings.

2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (17):
  arm64: dts: qcom: sm8250: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm8250-sony-xperia-edo: fix touchscreen bias-disable
  arm64: dts: qcom: sc8280xp: align TLMM pin configuration with DT
    schema
  arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema
    (really)
  arm64: dts: qcom: sc7280-herobrine: correct number of gpio-line-names
  arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
  arm64: dts: qcom: msm8953: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm6125-sony-xperia: add missing SD CD GPIO functions
  arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
  dt-bindings: pinctrl: qcom,sm8250: add gpio-reserved-ranges and
    gpio-line-names
  dt-bindings: pinctrl: qcom,sm8250: use common TLMM pin schema
  dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8250: add input-enable
  dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
  dt-bindings: pinctrl: qcom,sc7280: add bias-bus-hold and input-enable
  dt-bindings: pinctrl: qcom,sc7280: use common TLMM pin schema

 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  28 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 140 ++---
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  70 +--
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  12 +-
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts    |   8 +-
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-evoker-r0.dts   |   1 -
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 -
 .../dts/qcom/sc7280-herobrine-villager.dtsi   |   1 -
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  44 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  26 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  20 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 316 +++++-----
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  12 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  12 +-
 .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |   2 +-
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |   2 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |   4 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       |  38 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  18 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 556 +++++++-----------
 22 files changed, 582 insertions(+), 740 deletions(-)

-- 
2.34.1

