Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC56C39AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCUTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCUTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:01:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0F56169
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso21359949pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679425297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/f1KlYJ1sj6omoytOxModx8WTmRbKolqwyODRJBsN4=;
        b=YZB6+Kx7qsGOCcFh4UhaD0KElckR9bAVGI388CvWoghfHmg7uTUverbSwhR2WbnDwl
         kEvptIV3V3RZRTyN6WJZa7Pk8ReVUwYBrkLUpB5Mms9gd+Lgug3h72GJxiXyoGLAQPb3
         qzAgWEofeVB1v0HqCtL0a0lNypQM3eIlOJTFJZDkpLdU+NE1BzCFoY5lLbQewd+cPL/f
         IaXLHTkv01KlLw5VchxNzCttFd2snWUTX9nrp2rQToqyzu87w0vmRrypt2MPR5zfKOw2
         wZ4qeXBjjfCAx+qS2+aeSznsu2nsVHnul4Dhihf7mafo7M23iMtl8xGvby+xVtafyHJq
         G2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/f1KlYJ1sj6omoytOxModx8WTmRbKolqwyODRJBsN4=;
        b=Ff/dDwi8V4hW+H5NqijR20DCN17p7FwacAVpwC/X11xRqZD8Fk6DyP7+yAb2UOQ5ds
         300hGhyyVk6E6D7FfmBYvEYerV4cj7qMBGjQQNP9qbTot9Ecb5shFQ1eKg8v9wt/3c5L
         2VgMEGA2p2dwCDIPf0jNRzwipVvvg4KROLd3zFfCfQ4hm6I/vQgr5Ga/cDKARoYeze6m
         WuP1oyXxvorVpjj2FL/MDcN9lRmtH9UoQyb00kaE2034ONAh5Iod3ruEYAe2PCLbL8CW
         eDGtcmmk2PCrAynG4ipVMBWQyQF1YV3L8GW8l9K1aESP1SgTVZXBLroKMHNrvfaBF5I5
         x0Tw==
X-Gm-Message-State: AO0yUKWyhbFUZJ8ivG6LYyI23iClkcwu78rqj629oPhady+TyE3eNC/l
        2yknuzSrm7YWm4WzFu1yix3UGg==
X-Google-Smtp-Source: AK7set9t/MBtRLcrC+6D/IIJpj1Fg8yNrqriHbRkqTTwBQAYbbILtPA18Wls9NXh8FR9zd21ZHrzKA==
X-Received: by 2002:a17:902:e881:b0:1a0:67b1:a777 with SMTP id w1-20020a170902e88100b001a067b1a777mr104894plg.61.1679425297304;
        Tue, 21 Mar 2023 12:01:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709028d8900b001964c8164aasm9043453plo.129.2023.03.21.12.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:01:37 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sm6115: Add Crypto Engine support
Date:   Wed, 22 Mar 2023 00:31:15 +0530
Message-Id: <20230321190118.3327360-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
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

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm6115.dtsi'.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index c56738633431..b2d2cdde41fa 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -664,6 +664,32 @@ usb_1_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <8>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x84 0x11>,
+				 <&apps_smmu 0x86 0x11>,
+				 <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x84 0x11>,
+				 <&apps_smmu 0x86 0x11>,
+				 <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
-- 
2.38.1

