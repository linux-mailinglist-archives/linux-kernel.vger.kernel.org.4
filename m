Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64A16AA409
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjCCWRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCCWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:17:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813341B44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:08:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so16023085eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677881241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vqopDs853OIz7wr3B+Xdv3eU9ExHJXccftgDO6ekVc=;
        b=EI6qdWxz3L4CrTKEDw4ZQxPFwqUBdxTLVh+rpRsmakHtdc7sV2qprdGlCKAaTwrGdD
         M1UzrU0ADazqvcFy7PIviJkQV4IcBs+CKLhOtMW10dQb+4U2LkO9CN8SAR3bOaK4oTRB
         FZRcq3YxiLS+mpyrYxuQh/Gj8mr2pvEZ9EYP28hFlad+ORbCk9slW21J3RXH5d6ptXyX
         VibmaTE2q8SPxpnIfO4Q7I8SE1FBQTk1xcfkjVEmGb0MHNmFYsYNm6xBPQ7GKeYN/Qka
         +Z8SM8UGYYf2lryyJiJisCJH/uePAi5n8gAyo78IR+J6L6TFdUKMORAOrFv1PpjkEi9+
         ngyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vqopDs853OIz7wr3B+Xdv3eU9ExHJXccftgDO6ekVc=;
        b=O5r6KBJCcbLyvYfjNKStga9Tr51zLrDajYxZ9R84tpZMC5SMYU2pr7FsDcpYID+iaJ
         dJ2KFQGVf/3VPHUTK2vbbC0+XfZHnakdLeca1cbbiNKmR9fqRSPtUmJGOfvBNbRNjYZp
         TGdlVkomBCt3geiNgtwEv76sW+Cr5A/5lJYPNCu07e9Zqe2Za8I5LeEZSK3Cs7H/qDe/
         sKjZmpiLVqqnBPTJRkZpCFyW0FPwLPff7aaNKikWUWpT1NTNFFWqryoYkHXvuUdElFow
         +ngLoiTo5Dv80r42+/JyrZMEEftWx30hoEWwokixDHB+x2EOwGURP1CDmlKZYXgf9beE
         CE4w==
X-Gm-Message-State: AO0yUKUYGN/nC5Pc+237romxsTJm6wqAit6uRvpEjVHKEJg7nCQhnS9B
        1KeF4N4M7RxpGQyrlRmXVbs221lkbu783zQnDps=
X-Google-Smtp-Source: AK7set/7fbUGMNphs0vqwhtKNC8wUa02T3V0w2DnPoVMlQTOL0XZqLhNi8C2eaaqCOyDl+kTJPwPtA==
X-Received: by 2002:ac2:5283:0:b0:4de:21c9:8a37 with SMTP id q3-20020ac25283000000b004de21c98a37mr999841lfm.1.1677880701620;
        Fri, 03 Mar 2023 13:58:21 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:21 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:07 +0100
Subject: [PATCH 07/15] arm64: dts: qcom: sm6375: Add wifi node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-7-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=1484;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+otj1Pk8eMle5AYQIbjERaviQEzSMjyG5K7Qicq4ass=;
 b=zKCRFNuu2ZhSbAUiErsbbp5MTBp9Ox7bl3O409WX+r+1mc2/LYy1Uw/iluf6ootGQTNOURxRTWEA
 AV3SRONUCc/p8GWOezmmFe3iqQnVwl42QlZxFzRTFIJg9WFx6OKU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for ATH10K_SNoC wifi on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 2cdd000a4e2b..e473a90f3dea 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1333,6 +1333,28 @@ apps_smmu: iommu@c600000 {
 			#iommu-cells = <2>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0 0x0c800000 0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&pil_wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x80 0x1>;
+			qcom,msa-fixed-perm;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x0f200000 0x0 0x10000>,  /* GICD */

-- 
2.39.2

