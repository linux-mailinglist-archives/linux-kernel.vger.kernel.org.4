Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C516D7582
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbjDEHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbjDEHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:31:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1BA5587
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id le6so33628309plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lP0xe1rpfhrIkLyhMnO9naLS5LLel1l/TortX66fNI=;
        b=JaMs1axwgRzopOcNZli/yegR4fCkEtluCFhn7aQTV0CAyfEHR2p+08/j0RBRU3isL3
         V6xdTP2duLMfvSUdj8Fg2ukiyClbh2rwnVVDQqJ3ErHtAYnaQpVaZEY89n5S0/m4FQJQ
         XaLLY+U7mfIZmq5F+YU1+Mh2k+LjhZ8HQ/hXPneyv47FGxPfSBNMf7MDCOPYSAAH34wG
         AKiupOUELltb/jtgakeaobvQzpVrMbSb4NV7hmxeSaKB4lLr+u22LIdBniUNGwHWpAua
         soPtBzPK/K32psjpLb+SfVeq1m/T8ICbvCewNr7KIhxxHL/SomwUeEIBSGOjPQNMg6SJ
         0Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lP0xe1rpfhrIkLyhMnO9naLS5LLel1l/TortX66fNI=;
        b=y0xzCNdKS2aFLBPprJt/X8LWtyw6w30bW+q7v9brcOGaXzgP/ir9rrL6F/+Vutz6hK
         pOG1qn+a67kfcHZIvZpIQxltuO/y9J5ZkLz8xulQePMnQ+PikETf1cKGO48EMtDzZSs0
         wybOktJ/LjC3Fl9Spv5dK1yj4s+spg0nqyoF6+ec+KZmYzwzR5b9QXuprzJd+UHir/Th
         Iiy6Cob7w6ZFQz1oOmIHEIQvPVVMWyzBMZTgIIXpu4LPbRMsBff8DpzxAO/B7bxkcums
         WdaqlS94RjCRWlIKmoiMQSQe2TcYTrPktB8xPckBUHCNARx1rn/i+AzacOrxOr2stujZ
         AADg==
X-Gm-Message-State: AAQBX9cl5TQlwEZ1LArdt9ugx3yP2E/8MIq/om5+S/HgdSp9tFzgB0B0
        uwtvoNq9BizljLCX3dY1vKOSUw==
X-Google-Smtp-Source: AKy350YwQopALW/nSXnNj4j+Q8AncsUlQ8WIHCM0GGMBCgeyuh3Rja+To4Pj1goHjZKKp1ELj9wi7Q==
X-Received: by 2002:a17:90a:1a13:b0:23d:e0e8:f453 with SMTP id 19-20020a17090a1a1300b0023de0e8f453mr5407502pjk.38.1680679869411;
        Wed, 05 Apr 2023 00:31:09 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a635b47000000b004facdf070d6sm8781507pgm.39.2023.04.05.00.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 00:31:09 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
Subject: [PATCH v6 04/11] arm64: dts: qcom: sdm845: Fix the slimbam DMA engine compatible string
Date:   Wed,  5 Apr 2023 12:58:29 +0530
Message-Id: <20230405072836.1690248-5-bhupesh.sharma@linaro.org>
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

As per documentation, Qualcomm SDM845 SoC supports SLIMBAM DMA
engine v1.7.4, so use the correct compatible strings.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f32179c7d1b..17a29184884c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5152,7 +5152,7 @@ msi-controller@17a40000 {
 		};
 
 		slimbam: dma-controller@17184000 {
-			compatible = "qcom,bam-v1.7.0";
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
 			num-channels = <31>;
-- 
2.38.1

