Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A296AFE95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCHFqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHFqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:46:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF33A592A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 21:46:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso948414pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 21:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678254397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TI1Dr5bu7w3qXi8ffygZPrAEov3EaoxJgB9FdyYzp7A=;
        b=ZEJaWoHYGiqOKzBsXevIwkneM/an8vfZQ59QlX/QuW/lmIXAQi4cRyCppgt5ohzj5C
         +aDH4wsqliQoZwt7Q+b63sd6y8L60NthfJkRSOXqUA4eoKdHB0CUyYQpAGPMgoyhdnWK
         zDFWZwFigzWoforeXWexd1ftbPKyl4DpPUMWS1LYO+1jd4vm6dko9NVnHwfrtaLUeJP9
         3P76U1KE8WfgNnUdXLv1iRKqgBpv7HyGywjEbt6DkMDioSIMfG+IeD52YseOXop6YUUC
         MyScmUfKmtjxReZRW+DZBgICndJZPXNap54pHzeNawuU2Fo9l7hu4XIUClREVhityC2e
         GM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678254397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI1Dr5bu7w3qXi8ffygZPrAEov3EaoxJgB9FdyYzp7A=;
        b=XMI86ULlFrbC+ocq4xSdCLzf+RpZktq+hFdSYTdTzyMByRENTp2LhvLoVM7h/KZAnN
         09dDAZeANWAiGjSdvIOiHeu8U4YxxxLBh1AbXaNeBI+UYr6V2wfYracc8mNfIw5j6jLD
         Plc9kr5v+cSlVHRDgBo7M5tpr/4EihDQZFBG4tsqpVWrW3/qD039rORuRqoBZyVf1XXc
         8TecTlc+Lo3InXlBcVof8U1NDFqd8hM17MqWjIMN/qdHFJfRtmsXAUTKvR3DEG9pH4zy
         /wHDZCyrgvZcDDCr/y+9qcLvjfRlUAssSkT9bCXEse42uQOve+4hf6vY9auGomESNSk7
         XAcg==
X-Gm-Message-State: AO0yUKXD4Bib8x5WsieBgc/Tf1mGa6FC2pahsAXn5yF/STLPnK0OMjXo
        YsIVw6P3wNjURtYAXMHsAGwrozNZU/e2tEaEIA==
X-Google-Smtp-Source: AK7set/BZiGIRUUyv15xkHBpun0YO6eT6lgClDW3OiLxmaSV9L/9ENLuw9CD40dhD6+smp5YxOiVKw==
X-Received: by 2002:a17:90b:3a92:b0:237:6d4b:7cb7 with SMTP id om18-20020a17090b3a9200b002376d4b7cb7mr18171866pjb.41.1678254397556;
        Tue, 07 Mar 2023 21:46:37 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090a429100b002369d39672asm8153148pjg.33.2023.03.07.21.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 21:46:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8550: Mark UFS controller as cache coherent
Date:   Wed,  8 Mar 2023 11:16:30 +0530
Message-Id: <20230308054630.7202-1-manivannan.sadhasivam@linaro.org>
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

The UFS controller on SM8550 supports cache coherency, hence add the
"dma-coherent" property to mark it as such.

Fixes: 35cf1aaab169 ("arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ff4d342c0725..5315e24fa525 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1905,6 +1905,7 @@ ufs_mem_hc: ufs@1d84000 {
 			required-opps = <&rpmhpd_opp_nom>;
 
 			iommus = <&apps_smmu 0x60 0x0>;
+			dma-coherent;
 
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
-- 
2.25.1

