Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8F70A1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjESVsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjESVse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:48:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A51B0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:48:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d3491609fso802242b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684532912; x=1687124912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zau2qsQhDV1bV+FMZBbLle6RPe9ivNDcr7IgnOjplHE=;
        b=IMAwsr9+5YpQkpjpZW1wfxFE419+51fvECkQ//gzJPWu+Ym5syz5uYmop1IrWnHqdX
         OXTkDjceuLKn/gxeZFArNWe0DqX2O3IQuJ6gzbhP2S6HDfdPUmTtIDyUxe7tAjgYlsf3
         iEW0ApPGQekcmHedcd1pzdR1DgEtlvos/27mjFIM/vvPDUbWY98OPGu/0qEoT15Kf5x5
         mTCqQROwCJKhPauYPn80TvWK7lXJD8dW7B1XXP17ou0xUiBwwL42H/qwdZfNicRB/cow
         ETp4P7vhaS4JQDesCY54+cd9h5mkgno+3+rKrAyIJtJQDYrC7284UNacABL9c0PXGdeD
         ieKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532912; x=1687124912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zau2qsQhDV1bV+FMZBbLle6RPe9ivNDcr7IgnOjplHE=;
        b=Q77gvKxEgFvh4E95Wz1lwmTRLlpxIg52vNJJK5JZO++C1cqk6eQdwuIf9hTI2tQPhc
         i6RDLw89xxtJFJJZCQuvjiFhuSBHeKr1D5KjdILuaouNEBvVmWXLtli/fpXbvcbkXJtx
         EQ/Lhr68T2dJCV6GhZBOe9JguA+fOR8DWySpaSTvhRsdxA+FVtC0V2JBhPtwwaOXBMYX
         uk3EUiv2V6cOl4lSM6z+B5nomy7Fy6nsu9Qy8qLwRSbmZMS/O1BbMS0+FHXms+WufG0/
         H97Yi+m/bSkPTx2QXfjuAd75Fjt6GrqEGtvzssSyhQtWBFCPLm0jjpSznYwDItjXgo+J
         3QAQ==
X-Gm-Message-State: AC+VfDzG4XydSPVK35JYk9hTaZ1SAF4syE08Z6Bx+Q9SHpN4+MVaC708
        BWxy7+VCXZyOFTFWsgmEGYdzyA==
X-Google-Smtp-Source: ACHHUZ4h5q/mZRzPyIqULeKtyzgLrq5KYlThiD42UFvTU6gxmHsk/Wh1DL4/bZlqVwqR2vaYQWZyDQ==
X-Received: by 2002:a05:6a00:2d90:b0:64d:2487:5b3c with SMTP id fb16-20020a056a002d9000b0064d24875b3cmr4608384pfb.29.1684532911929;
        Fri, 19 May 2023 14:48:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm144891pfo.88.2023.05.19.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:48:31 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net
Subject: [PATCH v7 00/11] arm64: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Sat, 20 May 2023 03:18:02 +0530
Message-Id: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 25 ++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 30 +++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 32 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 22 ++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 28 +++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  2 +-
 9 files changed, 194 insertions(+), 19 deletions(-)

-- 
2.38.1

