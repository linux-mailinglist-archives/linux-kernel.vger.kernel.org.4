Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D86AA4A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjCCWjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjCCWjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:39:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817A5FCB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:38:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so16266128eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 14:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677883022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N802Fr0mvYVFoYKvgL4Iscqjub6mN4UuWcVLOyObAeQ=;
        b=znAGlO4MxPeMGfb8PAHbhbaUbiyoJMuhDNRIB8xYV3yiFdEXG3QSN2ewwBj0yGdQzq
         1bemQmBzoOAUmH7W+WydtH7k+aPfDX8TGN/3qcARvsTDv4QzjLdIXQtVpgBhd07sXDo0
         IJ43RuEwk5SVqSSZzfZqkLwPsgmglLbT5Ry/BRZ5eyDqSIxvRmuKY3UgTt5V5/OOAFRI
         IydmbCiYTEFr9MYGpd75xDRty5jRADOiH4orKPo1n7lJj5K4wVpKcMCn1x7j47ZHZPBy
         UomariLa70tbpWKCbJ/15M3qrr6/30SesP8kFazRDT4E9JeKcRbuJZOqTvKXQ3fEtRhi
         v6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677883022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N802Fr0mvYVFoYKvgL4Iscqjub6mN4UuWcVLOyObAeQ=;
        b=GidSNXnHx2CjZ/tJPk5i2uj7fWfezhaK4BTXdKSE5J5sqle9+7sc5OYoK1roWxjEAO
         bNjE5V3dKJIAQBSjq7YoCJqx5k8ZZvZyRndmqyWM+XODzKAK8TWvzotZBkPmRrP58bOD
         BmAdrr4hkgJEXIUQcDFXj+baZHjmbGmlg2rRhwSbJscUqVqKhfZiAVCv63jRO4d5cFnp
         m91LZ0Te6hLDszvyjcdGyM/ocd4U3hC5056mgDmW3LujGBWnd2nI2mKSQVmUIhBwVmg5
         czvsaklllNMuFZceqGtuz0dcH/2W+Tv6+SkYcB66XV4D1ij9/3RSyfFE/pgwfaCVPmaM
         EcVQ==
X-Gm-Message-State: AO0yUKXNyvXN6EVIr+/9oZ+WqqojEctJK6BPENdqC9wX8hV7HzPAj+PK
        MYywHr7Q2JEn7Xv5JPmEbvqTo19A6iG1OWF0Vj4=
X-Google-Smtp-Source: AK7set8Fdfy5WOEqMgqPc2rdpcjhWkLcJquvS80WpInpqtI8xhRl5yrormBUiwIZnCdnpW6je8iNDw==
X-Received: by 2002:ac2:4462:0:b0:4b5:8f03:a2bc with SMTP id y2-20020ac24462000000b004b58f03a2bcmr921031lfl.9.1677880698708;
        Fri, 03 Mar 2023 13:58:18 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:05 +0100
Subject: [PATCH 05/15] arm64: dts: qcom: sm6375: Add IMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-5-8c8d94fba6f0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=952;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XeByskUh4IJy5GUSRGVEOURhAeiNtSqMfR5ebBA6Oes=;
 b=4BGCWuRt4pHZDEFG5NnlENa82CtqJNl0M7IwD7B0smCe7QLF2yvSlwkP01BJ7lIgUrn6TL3n7+R7
 Yqfs45A3AJM1sn6WX5CatJztLRKbi85YddngzJDzDLOMdYW9lsNU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the IMEM block on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index de5882c0ff81..5a0abb7f7124 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1233,6 +1233,20 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
+		sram@c125000 {
+			compatible = "qcom,sm6375-imem", "syscon", "simple-mfd";
+			reg = <0 0x0c125000 0 0x1000>;
+			ranges = <0 0 0x0c125000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6375-smmu-500", "arm,mmu-500";
 			reg = <0 0x0c600000 0 0x100000>;

-- 
2.39.2

