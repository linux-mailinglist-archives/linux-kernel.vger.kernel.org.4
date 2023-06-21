Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAC7382CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjFULWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjFULWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:22:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E30135
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:22:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b4636bb22eso67105081fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687346526; x=1689938526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afrS/r3Jpl+lieZo9J+fA9jIAnBpaiCiUTWlN9YBqDM=;
        b=ODddu4CTFlDcfwCdB9H3nN0azQAlAcL082ol1AecELnvcuWp6uOsxxZOzOFlKl1wpr
         UwHs0+FqvPfysCqepgVwRX/9kloIC/ON3xOfKsJyVUviFbtUv1YFClxb4GOitN7l3SxF
         tLp+ByaRM2o6FfGDJae8NLt37EfGyrmoxhW6KjIsLdwRze2oxrEzLsBAy+x4Sx7U9wrm
         8IX8ztJnbU+cob546YDB/+zXauarVPhKKf5zk2D1nVaWFsw3K1ystiKb6XKLWm1B3Mts
         4EnkiGIKaCGV/Plu2H7Is8YI7KjKcGnt8IN2bopnuJlyRp5GsDappjRZZlt+3DXSHdIs
         Isvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346526; x=1689938526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afrS/r3Jpl+lieZo9J+fA9jIAnBpaiCiUTWlN9YBqDM=;
        b=C258NoCZwUBDvmX7DBhwhvkMwnVaCWNspMIy6DfbFjXOVNQt+MMihKQpLEgcY1Tax9
         AApzy7kn2+DfROgW7k7UmljK9YSvrJ+MC0woeWoZ+u1VKiN0WJm2T4uYI0V6arr8ug9y
         XGcfWuatg8wPOuTO8oBdsICP97HcUjaQBExxlVtm31lnJPJ1oHAoSHFuXlAqpiTHXiFf
         Tfl9WFClCTqgo+DMv/9q7sNxeGIuGIeMW726zg189upGR+1oCKwcwQNZmqGWtSWv3BKF
         K6O5mW8JvBHgq0u/dUnm0Ypg1XdjQqHZ9j+Q7QC92+lb0m9jl1vJt80XgmLMGs8kWdck
         bTHA==
X-Gm-Message-State: AC+VfDwf4Wvj7NHmJIeYeK1UULNA4n+DOFc42//AmU6OFKF4Kz5+458c
        bRdB/29FxtR1BKMVNilTIWAgzA==
X-Google-Smtp-Source: ACHHUZ7OlsrwhBlKl7QrHImcHR23KDG3ne3iNYyAyEKyNVSJgTuhGUfboqQRFoy7pLJmudXcLFIvqQ==
X-Received: by 2002:a2e:9985:0:b0:2b4:5a71:e637 with SMTP id w5-20020a2e9985000000b002b45a71e637mr9671045lji.18.1687346526542;
        Wed, 21 Jun 2023 04:22:06 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l4-20020a05651c10c400b002b22a1a21easm866171ljn.110.2023.06.21.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:22:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 21 Jun 2023 13:21:52 +0200
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm6115: Add GPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-gpu_tablet_disp-v2-1-0538ea1beb0b@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687346515; l=3623;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rrwHv/YxiN3sUzxciWmcTrdSRgXtI03mz+a9WJQcNo0=;
 b=gJnvOwZ6OEzWLw7Id3ZEbQzozrseg494A5KEV8wj4k67RirVGyNSqmkOdPwmz2kyweZLSZlnk
 oMTc4A2WfG7DiagwYI2QqAgE7r99wSMdGSROo9m8Mk8QpmvSLARoyeD
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

