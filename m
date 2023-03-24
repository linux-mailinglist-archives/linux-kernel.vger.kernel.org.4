Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3726C7922
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCXHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjCXHll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:41:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0719F18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:41:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so4407716edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679643697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcxZofqIK3HRTdfpbgfEH068msVjQMhnD45KuQ5H/ms=;
        b=UpxLxwfQ3V5dOLpYAxUHsBqOU/qL0dFRrAKzHeFjnL9i1MORE7bFusJ8QZhtRpJZBX
         jdUFiNSk0OYHx2U8sI7pOR81D3o10pW9LMOIGqlecqAfJtI6N+kf0T59P7jS4AP7WLZp
         I79gJy9W6BAKRgY1Q34popVJyDtTK/HQMF1cIOGufNPViWrIwy/bAq69zeg/wdh3v3qq
         JAuMoRraWIQAkmPZCCOlvx7XeUq0/Z8ubjAiNE5CiE3Q3I5WIjPJMpqlwc57X2ts2V3m
         JP5gfj7eQVHOj9FhFZ2FalYis5PCt5r0HMFnSf7TLUQVdqO5mT/xPqF4ykmEpPz/AtCu
         Ef8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcxZofqIK3HRTdfpbgfEH068msVjQMhnD45KuQ5H/ms=;
        b=QXH9QnrZVoGv7BjvRtjnruc38X01qU7IbvVFCDr4+/rSJCTYbbF+m37bHbWxZVP5N1
         eYXYFCsn8i9BSZn/d4x7oHfcreSJf0zXnH6XhjFuX5gwqgyc+k32DE4XRMQmRR7iyyRE
         hnRTPY2hiBZBToMq+tItLm7K5ut0YXvvsAbwbhwgtte00LWaYYu2dyi0ymO32SqZRqJf
         o2elOKfZiaxCWxGDAV1R2j2uuifxT4avfdMkr67YOmcxAsvk2NNAPULRdHj41iOeV6Mv
         FGSbyztR0ar/z0Wy4jnCgQoVs04orwChP4at4qf7RCISH1Y1dPY7ForiYhmAOz4BxVIz
         +gvg==
X-Gm-Message-State: AAQBX9fpoyXBibqBka2eLM2C4vopidNAIhVLiDckAc+f5RnNYE7r20Z5
        QRN/+V4tmUdVZS5qIwr5F61cmQ==
X-Google-Smtp-Source: AKy350bjHXtnBgON3ZW3HnBdpfI4Z4agAe97ZtevC+h3lL7GTKudFDLdnSm5AHY7pX49rQ77F85nJQ==
X-Received: by 2002:a17:906:c11:b0:91f:17a5:b359 with SMTP id s17-20020a1709060c1100b0091f17a5b359mr1648648ejf.66.1679643696996;
        Fri, 24 Mar 2023 00:41:36 -0700 (PDT)
Received: from [192.168.0.29] (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id d23-20020a50f697000000b004fd2a7aa1ecsm10271227edn.32.2023.03.24.00.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:41:36 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 24 Mar 2023 08:41:30 +0100
Subject: [PATCH v3 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v3-3-499dff23a03c@fairphone.com>
References: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
In-Reply-To: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
bindings and the example to match.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index ebc8e1adbc6f..3af786120fa5 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -113,7 +113,6 @@ allOf:
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-              - qcom,sm8450-ufshc
               - qcom,sm8550-ufshc
     then:
       properties:
@@ -144,6 +143,7 @@ allOf:
               - qcom,sdm845-ufshc
               - qcom,sm6350-ufshc
               - qcom,sm8150-ufshc
+              - qcom,sm8450-ufshc
     then:
       properties:
         clocks:
@@ -250,7 +250,9 @@ examples:
         ufs@1d84000 {
             compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
                          "jedec,ufs-2.0";
-            reg = <0 0x01d84000 0 0x3000>;
+            reg = <0 0x01d84000 0 0x3000>,
+                  <0 0x01d88000 0 0x8000>;
+            reg-names = "std", "ice";
             interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
             phys = <&ufs_mem_phy_lanes>;
             phy-names = "ufsphy";
@@ -278,7 +280,8 @@ examples:
                           "ref_clk",
                           "tx_lane0_sync_clk",
                           "rx_lane0_sync_clk",
-                          "rx_lane1_sync_clk";
+                          "rx_lane1_sync_clk",
+                          "ice_core_clk";
             clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
                      <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
                      <&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -286,7 +289,8 @@ examples:
                      <&rpmhcc RPMH_CXO_CLK>,
                      <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
                      <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
+                     <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
             freq-table-hz = <75000000 300000000>,
                             <0 0>,
                             <0 0>,
@@ -294,6 +298,7 @@ examples:
                             <75000000 300000000>,
                             <0 0>,
                             <0 0>,
-                            <0 0>;
+                            <0 0>,
+                            <75000000 300000000>;
         };
     };

-- 
2.40.0

