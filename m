Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3105663D310
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiK3KS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiK3KSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:18:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974592A27C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:18:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s5so23333990edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YlrwU4occVe0adogrVPtY69ywnLn4XdBZ7LW42fxJc=;
        b=YEatoxhGTuwpwU22Fx99KGAvkMEGPXHZBdZOPZu3X1iP+h9H+GszskwGBiY8moPDi5
         Xr0WSM+MnMt6ysahaHcf29FQb+HPv5wKaJEOFUE+yA9rXUlSIA9sZFysbKUehnA9mBn+
         5JktMJ1xp7daV+P1si6d+VdcE1kTrWJ/j2c9HURL67YGDqH1tF6Fh7QFyug9Rs548mQ2
         Yf863EdUo2x91oy8na0YP6aKlkVgpzMXh/1o02R7VMPNlYjLysBkvF3NV/o3eQhXCc3n
         OOIlMJSrXdXtQmgHY3zPI8DKAcUmzCov+aH4BbEsbgYXYYj9tu+dohArQhTHV5ewPjTX
         vpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YlrwU4occVe0adogrVPtY69ywnLn4XdBZ7LW42fxJc=;
        b=8Ed8Kw7YOsrmbWidEr20cTppnUUsdFR7+Yz+3AP7rOIeNjJrFRne9DMTkWiT8QaR3y
         1xv1cLxVQWMjOGyridmPk3BnPyuBS6xa0cG5PBoh/OdalXzM32xv6xcIFzkQosVb8Rnp
         dL5uzVEgjxqn7NiACRjNpStyQ38aW6rqNQATxxUavCkZOaPkkYSaplR1o9E2vrihF/+Y
         LM/qoP8XZaCJMhb63J+kRRd2akU0Dtt757sa4IUiAY7iPIoKzVmXxdUE178JY1Z/tlUI
         GIxG/w14PwgSyPDcao4N9NGexXH1kkKUq8eYAjVWfLVCGXqJtcOO34vCqoOVvDCYyinU
         /rkg==
X-Gm-Message-State: ANoB5plTBSpvMGLEnZ+DEWtDL3T1BKeDjVpmgTZE6oh4KVQzQTDY8xjd
        xIIrM2ToXW4SU6nasA8hYQra5Xi89LVvBA==
X-Google-Smtp-Source: AA0mqf6nBPRHsu8ALUW2482qbHD6afgyXawtnD2XY1qV1eQbr97eJMCu9I0Tw+dRC3kl3BmLIGrCDg==
X-Received: by 2002:a05:6402:541a:b0:463:be84:5283 with SMTP id ev26-20020a056402541a00b00463be845283mr13828667edb.7.1669803525639;
        Wed, 30 Nov 2022 02:18:45 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm449462edq.72.2022.11.30.02.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:18:45 -0800 (PST)
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
Subject: [PATCH v4 00/10] arm64: dts: Add base device tree files for SM8550
Date:   Wed, 30 Nov 2022 12:17:34 +0200
Message-Id: <20221130101744.2849294-1-abel.vesa@linaro.org>
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

This series adds the base device tree files and MTP board support
for the Qualcomm SM8550 SoC, including the clock, pinctrl, smmu,
regulators, interconnect, cpufreq, and qup nodes.

The SM8550 is the latest Qualcomm Mobile Platform.
See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf

The v3 of this patchset is here:
https://lore.kernel.org/all/20221126114617.497677-1-abel.vesa@linaro.org/

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
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 3535 +++++++++++++++++
 11 files changed, 4560 insertions(+)
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

