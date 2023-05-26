Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D798C712D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbjEZTWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjEZTWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:22:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717313A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:22:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b010338d82so7368745ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685128949; x=1687720949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+nxI7GPZEoJFRgou6P2z4SBcDHjxNDTiOjaHI6Wn/o=;
        b=D4zSBO3k/0mf8IYmqpnT9IuWijp1im/HraRVVg+Aw2XGa7946paoNPnmqZtAU78t3Y
         Jqk1hIvbaHUpkJyFTIHddeY+Inj4B/8l3qZIrnrqnpgQ2ttWOJzmQHOQCvBv5128pDPf
         HBwpiR6ny9P0jRdfCljHJmRu4W3HEw9IQDb8lKd9WSkkIPaoen3DatK4XpMcTpqfJt9w
         SoK4BjoQGm1f8uyLcI3+rCoEXTM9f71QvAQrF9VcWC562jcSWKFqmTP4d/pce6gVDdRY
         ym9l4dGoNzr24Lj34srUhIJw/lP8w8EKXH/OaPYRs+F7BOPw4nHxtY6pG95B47pCppDu
         AmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685128949; x=1687720949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+nxI7GPZEoJFRgou6P2z4SBcDHjxNDTiOjaHI6Wn/o=;
        b=QvbbUFbsAwFAddZ8dX8fRt5qpE7N7XeWzxjs1dbQNHPigHW322jJeTRPps9tQkfgaC
         rWdNr8jAnT33lwAxgx/f/PN7IsvSqUhBhm17RhMLe6ickt25A6ndJAF4FIVbR/JBcyKK
         jDeFx3OkUu9ccf1FXpDO4hBgke1PAB/UkHqRuW9WxbDHaOaK+s5VA7/xIjL63WhQGOSW
         eQxJqPOcbpRMXvVKi273Br6e7qcewdgSrP92n37C4k1t32Zs6oSsl/zIIlzDcyG7otrE
         1OlBkwW5nEm3HTI0wD3VaVm69ndAPUNbAh+Lo+rmQDw7j3vq+t5xTZ/KPqop939N4mgJ
         k4dQ==
X-Gm-Message-State: AC+VfDxOvRgdV6rYMlTHTsmXdFCsl4d7PIUac6q6rNVVNLmJWNuyff7z
        JSouscYlHnsgJzqspcq6X1/zMQ==
X-Google-Smtp-Source: ACHHUZ6+/1mU1U8CVP7Mhgj+OcO8VmiIArv2Xj5UKpThPqs8Tj68dI36BZs9/CTjR5gZQ3Zo4iQcsQ==
X-Received: by 2002:a17:903:22cd:b0:1aa:f6e9:4cb3 with SMTP id y13-20020a17090322cd00b001aaf6e94cb3mr3882969plg.52.1685128949279;
        Fri, 26 May 2023 12:22:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:22:28 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net
Subject: [PATCH v8 00/11] arm64: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Sat, 27 May 2023 00:51:59 +0530
Message-Id: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v7:
-----------------
- v7 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230519214813.2593271-1-bhupesh.sharma@linaro.org/
- Addressed Stephan's comment about RPM clocks for sm6115 crypto block in dtsi.
- Also fixed the iommu context ids for sm6115 crypto block in dtsi.

Changes since v6:
-----------------
- v6 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230405072836.1690248-1-bhupesh.sharma@linaro.org/
- Collected Acks, R-Bs and Tested-by for various patches.
- Addressed Konrad's comment about iommu sids for sm8150 and sm8250
  crypto node entries.
- Addressed Konrad's and Stephan's comments about adding RPM clock for
  crypto blocks on qcm2290 and sm6115.

Changes since v5:
-----------------
- v5 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230402100509.1154220-1-bhupesh.sharma@linaro.org/
- Collected Ack from Rob for [PATCH 01/11].
- Addressed Georgi's comment about interconnect cells in [PATCH 10/11].

Changes since v4:
-----------------
- v4 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230331164323.729093-1-bhupesh.sharma@linaro.org/
- Collected R-Bs from Konrad for a couple of patches sent in v4.
- Fixed incorrect email IDs for a couple of patches sent in v3, which I used for
  some patches created on a different work machine.
- No functional changes since v3.

Changes since v3:
-----------------
- v3 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230328092815.292665-1-bhupesh.sharma@linaro.org/
- Collected Acks from Krzysztof for a couple of patches sent in v3.
- Fixed review comments from Krzysztof regarding DMA binding document
  and also added a couple of new patches which are required to fix the
  'dtbs_check' errors highlighted after this fix.

Changes since v2:
-----------------
- v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230322114519.3412469-1-bhupesh.sharma@linaro.org/
- No functional change since v2. As the sdm845 patch from v1 was accepted in linux-next,
  dropped it from this version.

Changes since v1:
-----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230321190118.3327360-1-bhupesh.sharma@linaro.org/
- Folded the BAM DMA dt-binding change.
  (sent earlier as: https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/)
- Folded the QCE dt-binding change.
  (sent earlier as: https://lore.kernel.org/linux-arm-msm/20230320073816.3012198-1-bhupesh.sharma@linaro.org/)
- Folded Neil's SM8450 dts patch in this series.
- Addressed review comments from Rob, Stephan and Konrad.
- Collected Konrad's R-B for [PATCH 5/9].

This patchset enables Crypto Engine support for Qualcomm SoCs like
SM6115, SM8150, SM8250, SM8350 and SM8450.

Note that:
- SM8250 crypto engine patch utilizes the work already done by myself and
  Vladimir.
- SM8350 crypto engine patch utilizes the work already done by Robert.
- SM8450 crypto engine patch utilizes the work already done by Neil.

Also this patchset is rebased on linux-next/master.



Bhupesh Sharma (10):
  dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
  dt-bindings: dma: Increase iommu maxItems for BAM DMA
  arm64: dts: qcom: sdm8550: Fix the BAM DMA engine compatible string
  arm64: dts: qcom: sdm845: Fix the slimbam DMA engine compatible string
  dt-bindings: qcom-qce: Fix compatible combinations for SM8150 and
    IPQ4019 SoCs
  dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
  arm64: dts: qcom: sm6115: Add Crypto Engine support
  arm64: dts: qcom: sm8150: Add Crypto Engine support
  arm64: dts: qcom: sm8250: Add Crypto Engine support
  arm64: dts: qcom: sm8350: Add Crypto Engine support

Neil Armstrong (1):
  arm64: dts: qcom: sm8450: add crypto nodes

 .../devicetree/bindings/crypto/qcom-qce.yaml  | 50 +++++++++++++++----
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 +++++---
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 31 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 30 +++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 32 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 22 ++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 28 +++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  2 +-
 9 files changed, 200 insertions(+), 19 deletions(-)

-- 
2.38.1

