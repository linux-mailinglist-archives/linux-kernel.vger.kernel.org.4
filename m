Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9B72FC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjFNLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244090AbjFNLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:36:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835D10D5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so7941200e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686742557; x=1689334557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jaKkGkIsypo/HND0DbQ6vruiMEF8kdTc0ValZyEYo8=;
        b=iCkpWb6ESeD2lHxHwEtzgffY7572pjXjOE/aA6VVDfXo9MkWkRuwDGXDzfEoHsvHAK
         vqyMsDGWBLJbMS3Gx/tajd1faVH8MwR3FrAxvcvcVhxMgimslgs09j0zUB0rPUQ1e7j7
         nc+tQtdGtLIqnimT5KhfwQnSO1dUlFN9azJMovFXBqsrfzVjwx7FktrZSiz4Joi/FQU2
         pKWEmCQJWTpJH7RxZ3rbvEo7IQqe7uEqHCmEVE0AKWJtASfdXhkBIjh27qvNFTslMqFB
         h9HSy57dy2rlzOEaTgBa7udscq9IP4crUgiYpeZCF/iYfL/yY1ozCIuikvYRTS1eSXYk
         PW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742557; x=1689334557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jaKkGkIsypo/HND0DbQ6vruiMEF8kdTc0ValZyEYo8=;
        b=JbMyS4VOyH7r/DwBTYqAWz+rlAyN8chQShR6biSkK4CbW0qL+5fN2GPt5Vpp3VcdSD
         kyhJrFQvKH1adevikrCMAsUkog++V0DICeXt2x0HGcpXCGwcBRH1xOgaVyCJZEAHVNrM
         /DR4fOrpKAFed3HTZRSdd9l7mXhfpUAD0DBprkhvJL6InQFLSystaUpGHEqbqwssuYUj
         bt7GU6HpvWHfquxiI4z1dOGE56cTVsS+LYjWtzLgUwSe1RnrWmgnOuyPPbg/REkgUE6I
         fVaWFhQC14koo+wULoo64v/24xJ16BDETLwN4v3nFS7APONF41+3jU9znxWoUlP0g4tP
         udAA==
X-Gm-Message-State: AC+VfDy2Bcqa69y2Yf+S+Kvz2rNDycsbjIb9vWqMFGjebLD6wmSaBP3O
        ZxjjCFAs2QxQsopvP881Uoa/rQ==
X-Google-Smtp-Source: ACHHUZ6/AtzF7ETM0NRzAi7oezIomSTjXVRgU6gaC6zW8ovyirb/eHe01y/JBm/zmilnHjK3WSNmGA==
X-Received: by 2002:a19:6747:0:b0:4f3:b520:e0af with SMTP id e7-20020a196747000000b004f3b520e0afmr6845188lfj.13.1686742556849;
        Wed, 14 Jun 2023 04:35:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x1-20020ac25dc1000000b004f64b8eee61sm2088406lfq.97.2023.06.14.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:35:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 13:35:36 +0200
Subject: [PATCH v2 5/7] arm64: dts: qcom: sm6350: Add GPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v2-5-afcdfb18bb13@linaro.org>
References: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686742545; l=4658;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hebgvqDxcP5/jpVdGp5qyd6v0S/XcOR8k6z5qijdwvg=;
 b=Vslq+h8v6Ug4FxssYmahe0vqA8WKjBotTiq84VPW7dcNRIX6r6L/p5w1L/JqBNLQ9ccdcHfHC
 XFE2LLf5NqAB4fOBJiSiZCUrfoBZbcLGpgMireMDLERCvldwhzEOGVF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add Adreno, GPU SMMU and GMU nodes to hook up everything that
the A619 needs to function properly.

Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 139 +++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c0f34bc1d78c..d928e64e33ae 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1321,6 +1321,145 @@ compute-cb@5 {
 			};
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-619.0", "qcom,adreno";
+			reg = <0 0x03d00000 0 0x40000>,
+			      <0 0x03d9e000 0 0x1000>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem";
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0>;
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			status = "disabled";
+
+			zap-shader {
+				memory-region = <&pil_gpu_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-850000000 {
+					opp-hz = /bits/ 64 <850000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-supported-hw = <0x02>;
+				};
+
+				opp-800000000 {
+					opp-hz = /bits/ 64 <800000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-supported-hw = <0x04>;
+				};
+
+				opp-650000000 {
+					opp-hz = /bits/ 64 <650000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-supported-hw = <0x08>;
+				};
+
+				opp-565000000 {
+					opp-hz = /bits/ 64 <565000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-supported-hw = <0x10>;
+				};
+
+				opp-430000000 {
+					opp-hz = /bits/ 64 <430000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-355000000 {
+					opp-hz = /bits/ 64 <355000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-253000000 {
+					opp-hz = /bits/ 64 <253000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-supported-hw = <0xff>;
+				};
+			};
+		};
+
+		adreno_smmu: iommu@3d40000 {
+			compatible = "qcom,sm6350-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
+			reg = <0 0x03d40000 0 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names = "ahb",
+				      "bus",
+				      "iface";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-619.0", "qcom,adreno-gmu";
+			reg = <0 0x03d6a000 0 0x31000>,
+			      <0 0x0b290000 0 0x10000>,
+			      <0 0x0b490000 0 0x10000>;
+			reg-names = "gmu",
+				    "gmu_pdc",
+				    "gmu_pdc_seq";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi",
+					  "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc";
+
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 5>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			status = "disabled";
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sm6350-gpucc";
 			reg = <0 0x03d90000 0 0x9000>;

-- 
2.41.0

