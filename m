Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518D736D00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjFTNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFTNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B386019AF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b46f5d236dso39791871fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687267083; x=1689859083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgJzy8qqBJnj8+Ne5qJFLzH2E5CXfsNIxgixuphwBus=;
        b=RHOjkhg6cc5gz9j0PGvO4DXT3Su1skHT+MKaqCUz9QWvM8ysJ3x+sVEyD0htGdLfOd
         tkS7dDbr5TIQMnro+gTenMWRNsuleJrXzT/QBUNdlvt1nx9V+3BHZl8teoEu4VqnoUxT
         Jnj7BIRmauQIf1By3O0h4uP583S8OQqRZgaUinLVT9+ysgTboN0+dndF25lkHAa2IZTn
         7crXh2ufkBhTYcebCpfknwgF33GbdSNA4cXQ42YAjEwYa5PYEGrExXjRIEh/JgEvt5XR
         tA1ikxpzxx6002/sentjY7kQPTSvLzusVJtpWupL2it/Mq8qoTgaNqthlf4oRVfPQPC1
         +76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267083; x=1689859083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgJzy8qqBJnj8+Ne5qJFLzH2E5CXfsNIxgixuphwBus=;
        b=BH6gWUgKYM1/pjOIui6iIe97EN/aE6aboHYuS0wWJb8Z95Q9CHz2RCuj3RYxZDmlbE
         qOB2EEFYHS/Lpn3jDY2rJvjr2iG5XcGUXH3v/BJVsEvQjkjRFKgaI7LclvlqW8ySUioN
         HtqRFDWBOmz+MPCIcaBDNyTfd6Ma6W8bAq4ZgVIZOPVE1juadKsWl0Jh5jar3VieGXTM
         K10H+w7PjlED0Gael3SYazRQBPAQjDqL4bXN2vBNE5fwDAFhyqcgs0aHyHqYXLJUjUc9
         kRd6pBkp4uY0FdYdLT9gOsYAFYYpJ0mALNGWyiETZbsGx+1jikV0qwYUVYCRjZcMKQeU
         Dapg==
X-Gm-Message-State: AC+VfDwiPuPsSsAdrFFqb4bg0/g50zdLYj45ioLNFW9mENWTacVVs8hH
        qLPxvbdhY3n7l7fB/bp93YFc1g==
X-Google-Smtp-Source: ACHHUZ6pmFOj896gDxXOjarHNMvb3Rg8mxTq84rSpmKj8dkUMg5qIvOScX5ssbMfPUlxwq7XUeX4pQ==
X-Received: by 2002:a2e:9e44:0:b0:2b3:4cff:60ce with SMTP id g4-20020a2e9e44000000b002b34cff60cemr7001093ljk.0.1687267083108;
        Tue, 20 Jun 2023 06:18:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id h19-20020a2eb0f3000000b002b3318c8d6fsm414433ljl.28.2023.06.20.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 15:17:45 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: sm6115: Add GPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-gpu_tablet_disp-v1-1-7bb02bec8dc0@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687267079; l=3562;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OuC7SSa/ZEBZmoqvHBeP3pcU5FY1FG2fXFlfgiPFlho=;
 b=htlJk1t63qgqq/6MtJEq+KWGc04BXOj0dhpuTkCrY3w+/byr4yplGaYTj9OA9K1UVTdl7c0j2
 HSMdO8a4HxMDsdA8XeB5RHpwfulMUNFZjMMImsX61Fuq0Hp86+4oPIN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce nodes for the A610 GPU and its GMU wrapper along with the
speedbin fuse entry in QFPROM.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 103 +++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 55118577bf92..424b4f3c909b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -865,6 +865,11 @@ qusb2_hstx_trim: hstx-trim@25b {
 				reg = <0x25b 0x1>;
 				bits = <1 4>;
 			};
+
+			gpu_speed_bin: gpu-speed-bin@6006 {
+				reg = <0x6006 0x2>;
+				bits = <5 8>;
+			};
 		};
 
 		rng: rng@1b53000 {
@@ -1316,6 +1321,104 @@ usb_dwc3: usb@4e00000 {
 			};
 		};
 
+		gpu: gpu@5900000 {
+			compatible = "qcom,adreno-610.0", "qcom,adreno";
+			reg = <0x0 0x05900000 0x0 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			/* There's no (real) GMU, so we have to handle quite a bunch of clocks! */
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_BIMC_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "gmu",
+				      "xo";
+
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 1>;
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmpd SM6115_VDDCX>;
+			qcom,gmu = <&gmu_wrapper>;
+
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
+				opp-320000000 {
+					opp-hz = /bits/ 64 <320000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-465000000 {
+					opp-hz = /bits/ 64 <465000000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-600000000 {
+					opp-hz = /bits/ 64 <600000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-745000000 {
+					opp-hz = /bits/ 64 <745000000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-supported-hw = <0xf>;
+				};
+
+				opp-820000000 {
+					opp-hz = /bits/ 64 <820000000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-supported-hw = <0x7>;
+				};
+
+				opp-900000000 {
+					opp-hz = /bits/ 64 <900000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-supported-hw = <0x7>;
+				};
+
+				/* Speed bin 2 can reach 950 Mhz instead of 980 like the rest. */
+				opp-950000000 {
+					opp-hz = /bits/ 64 <950000000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-supported-hw = <0x4>;
+				};
+
+				opp-980000000 {
+					opp-hz = /bits/ 64 <980000000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-supported-hw = <0x3>;
+				};
+			};
+		};
+
+		gmu_wrapper: gmu@596a000 {
+			compatible = "qcom,adreno-gmu-wrapper";
+			reg = <0x0 0x0596a000 0x0 0x30000>;
+			reg-names = "gmu";
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx", "gx";
+		};
+
 		gpucc: clock-controller@5990000 {
 			compatible = "qcom,sm6115-gpucc";
 			reg = <0x0 0x05990000 0x0 0x9000>;

-- 
2.41.0

