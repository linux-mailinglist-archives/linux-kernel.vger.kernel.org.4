Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043E66B0055
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCHH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCHH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:56:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1229BA77
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:56:56 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ce7so9646569pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678262215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrwgidfL5ATDTcKj1WN5LLsg6LHsipfNpzW/NMIXfVc=;
        b=k5P+q19svLG4J5CRTWrL14HGCAT+jvabDyWSyJ0VzPMzaW1jIr5T07EampCioeKdcg
         OxvHwvsGQ0fwVyyWOAp3x0x/Q4QA9dfA7VSIdTD0jUhHOQmr01pgk5f+sqJUGNea4nks
         3hhFMYV5jSe8VoTu9z3g05Ju37RCf/MDn8ujgwvjSOCxgYNkJeafbvhcMS7KTQTZbMVM
         nLCTedoYF+Of/7XcKm7aQ6dTpeuITtd4UZ7X3ihoQCrWii9HK7LjfrB+XkUCBwok4U6m
         0f94vF69JFYpKTzY/8BXtFqB7u9Jt9+e+5imuzRB+SQ0xXT4KUqLYnjM14LaZrpjBimA
         HlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrwgidfL5ATDTcKj1WN5LLsg6LHsipfNpzW/NMIXfVc=;
        b=GnF3f8jpumNXgwtnemqz344KqrHzwEKNQs6NY1ndwxkppXDHIMGm/xnQvORWgJp5Dw
         P7lAL0iJe5pHSem8lu+eETa0ClnGT+Z2HkHfKJlVaPQXdhhUERbgohuYlZyfP9htpIj6
         HnvN36KWAWymhDv0Yu9lTgCAHQrwRrUsY24RqYnVeaeNJsfy4OhT+KgWEPY68efOhdVN
         PcYKoRz4Iryv8j/UUk4LKnIvycoXeBtyu3wL8m+1ag7ZcxTaLWj/5DSv7kIMm2YIh0CR
         U6bvs0iNAkemAK7jAajMdhwaoUKY0BbNdbo3OR9KkekUzOybzAxPiaGP/N8RWLWlSItF
         A4NA==
X-Gm-Message-State: AO0yUKWnsSLEdRWK6DFPunsqbnO2HMR88PeqKl+tpJfz+wNvYeZ7Z1eK
        NBK7erpH1fBHAPTPF9n1MZOp
X-Google-Smtp-Source: AK7set/szOUrKmNv9NhOizS3XUAjlmltJB2runIynxxL2Sww6s6HwR5K5QuVwmHQXrSEFRJZbSdL9g==
X-Received: by 2002:a62:4ecb:0:b0:593:f191:966 with SMTP id c194-20020a624ecb000000b00593f1910966mr13799358pfb.1.1678262215533;
        Tue, 07 Mar 2023 23:56:55 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id c17-20020a631c51000000b004facf728b19sm8631840pgm.4.2023.03.07.23.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:56:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] arm64: dts: qcom: Remove "iommus" property from PCIe nodes
Date:   Wed,  8 Mar 2023 13:26:48 +0530
Message-Id: <20230308075648.134119-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, most of the Qualcomm SoCs specify both "iommus" and "iommu-map"
properties for the PCIe nodes. First one passes the SMR mask to the iommu
driver and the latter specifies the SID for each PCIe device.

But with "iommus" property, the PCIe controller will be added to the
iommu group along with the devices. This makes no sense because the
controller will not initiate any DMA transaction on its own. And moreover,
it is not strictly required to pass the SMR mask to the iommu driver. If
the "iommus" property is not present, then the default mask of "0" would be
used which should work for all PCIe devices.

On the other side, if the SMR mask specified doesn't match the one expected
by the hypervisor, then all the PCIe transactions will end up triggering
"Unidentified Stream Fault" by the SMMU.

So to get rid of these hassles and also prohibit PCIe controllers from
adding to the iommu group, let's remove the "iommus" property from PCIe
nodes.

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-arm-msm/20230227195535.GA749409-robh@kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 ---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 --
 7 files changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8f4ab6bd2886..9f7269029a02 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2133,8 +2133,6 @@ pcie1: pci@1c08000 {
 
 			dma-coherent;
 
-			iommus = <&apps_smmu 0x1c80 0x1>;
-
 			iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
 				    <0x100 &apps_smmu 0x1c81 0x1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..5f110b0062d9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2319,7 +2319,6 @@ pcie0: pci@1c00000 {
 				      "slave_q2a",
 				      "tbu";
 
-			iommus = <&apps_smmu 0x1c10 0xf>;
 			iommu-map = <0x0   &apps_smmu 0x1c10 0x1>,
 				    <0x100 &apps_smmu 0x1c11 0x1>,
 				    <0x200 &apps_smmu 0x1c12 0x1>,
@@ -2429,7 +2428,6 @@ pcie1: pci@1c08000 {
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			iommus = <&apps_smmu 0x1c00 0xf>;
 			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
 				    <0x100 &apps_smmu 0x1c01 0x1>,
 				    <0x200 &apps_smmu 0x1c02 0x1>,
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 13e0ce828606..6a383e918329 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1826,7 +1826,6 @@ pcie0: pci@1c00000 {
 				      "slave_q2a",
 				      "tbu";
 
-			iommus = <&apps_smmu 0x1d80 0x3f>;
 			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
 				    <0x100 &apps_smmu 0x1d81 0x1>;
 
@@ -1925,7 +1924,6 @@ pcie1: pci@1c08000 {
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			iommus = <&apps_smmu 0x1e00 0x3f>;
 			iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
 				    <0x100 &apps_smmu 0x1e01 0x1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2f0e460acccd..c7682fda9d8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1871,7 +1871,6 @@ pcie0: pci@1c00000 {
 				      "tbu",
 				      "ddrss_sf_tbu";
 
-			iommus = <&apps_smmu 0x1c00 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
 				    <0x100 &apps_smmu 0x1c01 0x1>;
 
@@ -1977,7 +1976,6 @@ pcie1: pci@1c08000 {
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			iommus = <&apps_smmu 0x1c80 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c80 0x1>,
 				    <0x100 &apps_smmu 0x1c81 0x1>;
 
@@ -2085,7 +2083,6 @@ pcie2: pci@1c10000 {
 			assigned-clocks = <&gcc GCC_PCIE_2_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			iommus = <&apps_smmu 0x1d00 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1d00 0x1>,
 				    <0x100 &apps_smmu 0x1d01 0x1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..365b9d773b5c 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1526,7 +1526,6 @@ pcie0: pci@1c00000 {
 				      "aggre1",
 				      "aggre0";
 
-			iommus = <&apps_smmu 0x1c00 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
 				    <0x100 &apps_smmu 0x1c01 0x1>;
 
@@ -1610,7 +1609,6 @@ pcie1: pci@1c08000 {
 				      "ddrss_sf_tbu",
 				      "aggre1";
 
-			iommus = <&apps_smmu 0x1c80 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c80 0x1>,
 				    <0x100 &apps_smmu 0x1c81 0x1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1a744a33bcf4..e3201b1b07a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1790,7 +1790,6 @@ pcie0: pci@1c00000 {
 				      "aggre0",
 				      "aggre1";
 
-			iommus = <&apps_smmu 0x1c00 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
 				    <0x100 &apps_smmu 0x1c01 0x1>;
 
@@ -1904,7 +1903,6 @@ pcie1: pci@1c08000 {
 				      "ddrss_sf_tbu",
 				      "aggre1";
 
-			iommus = <&apps_smmu 0x1c80 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c80 0x1>,
 				    <0x100 &apps_smmu 0x1c81 0x1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 25f51245fe9b..6edb3acb91ef 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1692,7 +1692,6 @@ pcie0: pci@1c00000 {
 			interconnect-names = "pcie-mem";
 			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
 
-			iommus = <&apps_smmu 0x1400 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
 				    <0x100 &apps_smmu 0x1401 0x1>;
 
@@ -1796,7 +1795,6 @@ pcie1: pci@1c08000 {
 			interconnect-names = "pcie-mem";
 			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
 
-			iommus = <&apps_smmu 0x1480 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
 				    <0x100 &apps_smmu 0x1481 0x1>;
 
-- 
2.25.1

