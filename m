Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DC65AEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjABJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjABJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:46:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBB60DE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:46:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s22so28605955ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Gtnc7vcqrgpY3S5KTeCd8H/ZqD0S93TfnNyC/PPRM=;
        b=lZM+dn3TEoTPn5yHhE84UpSSM428YWIu/T7sawMCKuLumD4s24qkXhMazjLA9zLQMo
         AAK0qczEka0aWXqpGQ8DEd+KUf5dPz80OmNIMv6mgItj4Uq5ucbuq3nImMmutWYolkng
         ZCRQt87KMEMShD21Sxz4WSTAtbcHRXaPUYUtwZQj0Soc6ZGcH6RAeNe1j/eOLm//rZYQ
         w+kCvrE1MXvNSJfUPYEdCRcqHbNzPdgwnNX6wwbz95+CP9MdI3lTP43cDe2KGr36nhKW
         poE95y29VePo1q+A/GulhrmFTMe8ajn1E2zt5cjpd/1LqYN5tou1JYH6KykKWzNtEPqF
         bENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0Gtnc7vcqrgpY3S5KTeCd8H/ZqD0S93TfnNyC/PPRM=;
        b=mfn30CCJnxt8D59ln+77lV3pV/fasTMbZ1qDfKHwDZz0r/Kw69qG46iNSkaDjx5sJw
         dcKHiL0bwx2PFv42MO4AZIt7P5BbL5HMAl5OFNJpLNnBiGvmkW/V7RiaC/HpSJB9AjJB
         Va6u827gv0rLkw43/aulBENqYspM5mKkZKhnS4H+buvnLgMZvfF/40XoB8XpXZS7coYR
         MgH60mAyUy+8ytCIeskMelv1y71vrpavuCp8NcMNPkloYhzAmXnGtLKLS6leE7tS90Q7
         n2KHDczij7xPKsBviBkuyUbMUC4V+oHrFAG4wVXjGBId2xLWjqEASswJE7qF2vkRAH3k
         8DNw==
X-Gm-Message-State: AFqh2kqbzZ+jLWOb0tdO7hlICX06XDyQt8SDeMLDtDAefLLFI/mJfw77
        3YfVmIvDLkiz4qvWU4okb8CNKg==
X-Google-Smtp-Source: AMrXdXvJIj1uGAhTI+tYfyG9LC/zoppxPN2+vVYhgePNTmmB/9OS6kEpz5j9kKbYLFGE6iES1VlFcQ==
X-Received: by 2002:a05:651c:228:b0:279:7ecb:897f with SMTP id z8-20020a05651c022800b002797ecb897fmr10533062ljn.28.1672652810911;
        Mon, 02 Jan 2023 01:46:50 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] arm64: dts: qcom: ipq6018: Add/remove some newlines
Date:   Mon,  2 Jan 2023 10:46:29 +0100
Message-Id: <20230102094642.74254-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
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

Some lines were broken very aggresively, presumably to fit under 80 chars
and some places could have used a newline, particularly between subsequent
nodes. Address all that and remove redundant comments near PCIe ranges
while at it so as not to exceed 100 chars needlessly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 8937b10748f3..0d9074b3b1a2 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -102,26 +102,31 @@ opp-864000000 {
 			opp-microvolt = <725000>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
 			opp-microvolt = <787500>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1320000000 {
 			opp-hz = /bits/ 64 <1320000000>;
 			opp-microvolt = <862500>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
 			opp-microvolt = <925000>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
 			opp-microvolt = <987500>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <1062500>;
@@ -131,8 +136,7 @@ opp-1800000000 {
 
 	pmuv8: pmu {
 		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
-					 IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	psci: psci {
@@ -734,24 +738,18 @@ pcie0: pci@20000000 {
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x20200000 0 0x20200000 0 0x10000>,
+				 <0x82000000 0 0x20220000 0 0x20220000 0 0xfde0000>;
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83
-					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
 				 <&gcc GCC_PCIE0_AXI_M_CLK>,
-- 
2.39.0

