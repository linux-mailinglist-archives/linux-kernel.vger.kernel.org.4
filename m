Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0036395C5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKZLqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 06:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKZLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:46:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD120376
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v1so10118727wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKvWeLwtoJfm97uy3h/RfxjiQ1I7iWjVzP1sMhNwRPw=;
        b=kFQCwe/2Om59TvjSEbHKH2Kyklw+Sts8pCl9HhkKyGtLwmo+NqPOLDWRgrwhVz4vgm
         xE8kAGbbTIb49urahdk/unPLKIjeHnZMEqRukfj3VbBNgJCFXxPU8THYv+dcB1QVSehw
         SeZIEk76rxgVStL+HuCUsVIQ7hx/PXHM1WIIHFJ3uQ5e37agyTFRR9/Z8ignHyaOTTh0
         o8fx2QGeIu9vd9tzjaJK26C8LO8kdMfjin6HVZaCOzZ1lFF9r7jbsqLm9NtxI0lRTFwA
         NMQniQzuiQAYPYbWbo3AJ9CG5tSZyfvzSuMRD7jj5oHQrLdrOUpDgpcybviP0lurRn2h
         TSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKvWeLwtoJfm97uy3h/RfxjiQ1I7iWjVzP1sMhNwRPw=;
        b=GcRqEtP2fLC3/RelG+sOwccGVUEWn6khLFOh8hJGYWBsqftz7L4aajZlANdke7ZiDM
         YVCJJIVCI/6NCMiNJlxqcwE6WdpfiG7I/xPeIiQTflnSg9hlnto1fVfiSDD8rEF8YiQa
         5f+2TpyX8i8w7a16nTiU4kvLD4m/8fA3HsUWWiDb2DZAseicT/9TEDQO7SoGlT+1Ihz0
         RZCnTrRAV8hMJl1mim0WcfrHmSNb5JNkJI6tKld9eyNFLws2vPFx2XiDg+7bPpuO+8YF
         3uCAbcyTEyS/rrYtRIF9GNldCre1Li1M5t7SDxNGyPKoNruTxeAnzWFJrHe7GdIOxV2d
         CXig==
X-Gm-Message-State: ANoB5pliCdZvC61ggf7MNOnHu3JCstGgAu+Uq80m3lE4HAIU+WGuO5Yn
        qICec7Vm5LP+9xUr/DheL3xiDQ==
X-Google-Smtp-Source: AA0mqf7BAWwageiMDssiG9ygW/GGXd4b3tmxezAHnfnL1EDa+hAa2dltTR2185LM7SzlosAAXUZ1xQ==
X-Received: by 2002:a05:6000:a12:b0:241:c4d1:41a6 with SMTP id co18-20020a0560000a1200b00241c4d141a6mr23199075wrb.324.1669463189792;
        Sat, 26 Nov 2022 03:46:29 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h5-20020adfa4c5000000b0023659925b2asm5942621wrb.51.2022.11.26.03.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:46:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/10] arm64: dts: Add base device tree files for SM8550
Date:   Sat, 26 Nov 2022 13:46:07 +0200
Message-Id: <20221126114617.497677-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the base device tree files and MTP board support
for the Qualcomm SM8550 SoC, including the clock, pinctrl, smmu,
regulators, interconnect, cpufreq, and qup nodes.

The SM8550 is the latest Qualcomm Mobile Platform.
See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf

The v2 of this patchset is here:
https://lore.kernel.org/all/20221124135646.1952727-1-abel.vesa@linaro.org/

Here is a branch where the entire support has been merged:
https://git.codelinaro.org/linaro/qcomlt/linux/-/commits/topic/sm8550/next

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (3):
  dt-bindings: arm: qcom: Document SM8550 SoC and boards
  arm64: dts: qcom: Add base SM8550 dtsi
  arm64: dts: qcom: Add base SM8550 MTP dts

Neil Armstrong (7):
  arm64: dts: qcom: Add pm8010 pmic dtsi
  arm64: dts: qcom: Add PM8550 pmic dtsi
  arm64: dts: qcom: Add PM8550b pmic dtsi
  arm64: dts: qcom: Add PM8550ve pmic dtsi
  arm64: dts: qcom: Add PM8550vs pmic dtsi
  arm64: dts: qcom: Add PMK8550 pmic dtsi
  arm64: dts: qcom: Add PMR735d pmic dtsi

 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/pm8010.dtsi          |   84 +
 arch/arm64/boot/dts/qcom/pm8550.dtsi          |   59 +
 arch/arm64/boot/dts/qcom/pm8550b.dtsi         |   59 +
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi        |   59 +
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi        |  194 +
 arch/arm64/boot/dts/qcom/pmk8550.dtsi         |   55 +
 arch/arm64/boot/dts/qcom/pmr735d.dtsi         |  104 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  404 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 3536 +++++++++++++++++
 11 files changed, 4561 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550b.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550ve.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550vs.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmk8550.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmr735d.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550.dtsi

-- 
2.34.1

