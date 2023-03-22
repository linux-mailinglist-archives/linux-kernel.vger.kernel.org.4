Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113B6C4997
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCVLrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCVLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:46:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3386D6041D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:46:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so18994360pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGb3BIQsyUNL1+BgFa8yu/K6OVQSXWMJMp42ClXNo3w=;
        b=qivrf3cVu8WgCYcV3RRjSXa3JDpbSbJwgsIyAGATk1QVxCl+JdpHhfMVBAsQi/JHbP
         Gsc38pRrGVopn+W5jf62e6KcU30cTBbra+Z7fdqrcSqf+Hb2l3TY7YMGm3D8L4FmE9NM
         QM5VUpA0j9LtQJjuLrbtl+iMW9I+pQWgyyRSSfubRfV5rPXxwESd0hYO8IS+uVcucpG9
         DYeaiXkKuKDlibTuhSXf9Ty0IRbX5yaz2b3A8o3t5qHSmap5SJ6eppyotTxO7/QHnWFo
         I0BbunXYQyfnyowMIywHHuDp/1/60s343dY+DVmKaSUVu347mTMRNf9RkIABjGLy7B37
         BGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGb3BIQsyUNL1+BgFa8yu/K6OVQSXWMJMp42ClXNo3w=;
        b=QfW2FCGXS1NqEuT5ZgRpE0413SBQiiJADXKGNiU/Rg3yQOWsdIWPaGxjexgqeEyR4b
         fKEaqqzNKZrj936+osBBURR05pZ7fbA2BpULRx9DpUTBF/zQGRsvxgIYoS4D9iHTHM/v
         MNaUoXGDOCkRUsD3I39xTY88PadEVRKbbZc2h+DNnpPl8CEcbdz3kxp/PUe4d0QzKqJ7
         jfSVs6/c2ga9qZOmRBMOlSH3SXLj20WKrHt+BEK0iyh+WNmoJ2yNl+kYI+ouAd8byvel
         WCDw4S5JxwegxLiPPJPwpEoi58WYj7CbjiblYpsB0hDUWkQFYeOGHKyDh43mwMl5BoTw
         xPjQ==
X-Gm-Message-State: AO0yUKUEPiBRBtTzLMsYaHvQ3xTpOk9gKBuFjF/S/IIsx20cUNAtSYF6
        EE03Ssh9xR+tvTThDS2ukinzVw==
X-Google-Smtp-Source: AK7set9KvFvCmxihb0yEPnk5v2IjyDopshZ1tR4NTJsWxnuXPlvyg5TXwVG6e/KkXEs+jGsHaiOisw==
X-Received: by 2002:a17:903:27c4:b0:19e:8088:b852 with SMTP id km4-20020a17090327c400b0019e8088b852mr2282952plb.10.1679485582557;
        Wed, 22 Mar 2023 04:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:46:22 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 10/10] arm64: dts: qcom: sm8450: add crypto nodes
Date:   Wed, 22 Mar 2023 17:15:19 +0530
Message-Id: <20230322114519.3412469-11-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
References: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Add crypto engine (CE) and CE BAM related nodes and definitions
for the SM8450 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bhupesh: Corrected the compatible list]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7c1d1464a1f8..c2b6c163ee6b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4084,6 +4084,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x28000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x584 0x11>,
+				 <&apps_smmu 0x588 0x0>,
+				 <&apps_smmu 0x598 0x5>,
+				 <&apps_smmu 0x59a 0x0>,
+				 <&apps_smmu 0x59f 0x0>;
+		};
+
+		crypto: crypto@1de0000 {
+			compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x584 0x11>,
+				 <&apps_smmu 0x588 0x0>,
+				 <&apps_smmu 0x598 0x5>,
+				 <&apps_smmu 0x59a 0x0>,
+				 <&apps_smmu 0x59f 0x0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.38.1

