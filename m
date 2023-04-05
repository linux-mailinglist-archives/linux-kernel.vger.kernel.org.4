Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D136D75A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjDEHcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjDEHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:32:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0059D4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l184so12060353pgd.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oFHBwDflAuoBx3nAvQZJqLFUNje4jYksqgr3MUJ8Rg=;
        b=iXUMZHc446PS3IQBnpaoYwlsVWtesXSS14qR/2raGp8D9arZ2hC9sa7ua9uL3LlVWz
         ODVIdaWILyr+HCGJo8szz2pHi3D19q5+yC2y3dK5Ue2H96BOwQ7Bx9GedzGCAz0TSqzQ
         yLnvyeBLmNEoIveXrjAFAzyx6gjpmqkCFwz0gyUerlMBPip6iTofHr3jRF5glsxqTL3Z
         O5oGrcm8Gr7qkVYb/sd3WePQtA5khwlR2liNu5y0GiyN/JA+z50i2VAsfp1VV2osfDBT
         s078Ck6ypD0yAnFyG7Kv0NmlgK94VgCD2CKuLabl3K+D4yGbBCW/HQC8L0g8o3lfeCnY
         baEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oFHBwDflAuoBx3nAvQZJqLFUNje4jYksqgr3MUJ8Rg=;
        b=rVOFmfHRUxxakn5bZzwSOeqtQuXBqOwoM9efj9yKjuChKnUbjPe8/3olf0RJkLNVnS
         i7kG89rNGwlfrWc89DqImjnifZDYTfqC2vda664CBysD15vJew6DogZSVzKNuTTgzu2O
         D+RWnCCrmN9u8Afljn448tUCgCqCCP+PGMyMJxIqB3SgdXcwtKCitFhu+qUvjAVgZ287
         YMI91QCE2S9SL9Rsu6jY5nDzWdgfD8YTRXkeXDV4Ui+uLjjQw8GEjvQsArg0COn2hkP6
         Xa2CC0vtQzU/uBEIv1o8L9P1xYkKqum5GL202zv5QnJohXH+lkxmUB5W7uzDCfjyr4Z+
         GPxg==
X-Gm-Message-State: AAQBX9e2n77IBYHEaUoSPSJu/Gp8FXLz4uVfuMna8Px9/snHyfYxRNl5
        oKiycYFb6SndzwnoZjgp6VSXtA==
X-Google-Smtp-Source: AKy350YhwcabbMAVUwTuagacxKx3KGMxiWOnBOsSG28WbyONpgKoA/kMxM9LvBpYrEs/YV0r2K8kzA==
X-Received: by 2002:aa7:93da:0:b0:62d:d748:94d2 with SMTP id y26-20020aa793da000000b0062dd74894d2mr5410013pff.28.1680679903377;
        Wed, 05 Apr 2023 00:31:43 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a635b47000000b004facdf070d6sm8781507pgm.39.2023.04.05.00.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 00:31:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
Subject: [PATCH v6 11/11] arm64: dts: qcom: sm8450: add crypto nodes
Date:   Wed,  5 Apr 2023 12:58:36 +0530
Message-Id: <20230405072836.1690248-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 31877f18dce2..d7a28cac4f47 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4146,6 +4146,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
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

