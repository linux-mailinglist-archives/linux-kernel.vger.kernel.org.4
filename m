Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3756C791B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjCXHln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCXHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:41:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB09E19F0B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:41:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ew6so4352543edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679643695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPqFaK3PfCV9f0plVHjaFnI0EQVHjWHhUIO49LkNrrg=;
        b=1AANZ2/bS3AMQkcUUHO0ZZCL8X6ou4PlmramzhRfkFPTwV38Z8DusOr510nm698Ftl
         VjA/CQCFhtvTL+pdi3bjgqkq+JHDtEkJ2gXUW+hlfDOolcf0Y6L1kUR32bFZPREnNSCd
         3Vq/DZZblF0vbLRvP4D8+UgiCSGuj/iLZo+zYzoHHAhE3Jkjt5p3pIoU/SYiU4saj+Km
         M2gZaPLJJgX6+kBpGqAIqrniptKyXtahslLtZKezjgpbDfTNirJkKXNa4/E5RHHch6l1
         Si7WQO7sLLaYFnK1s9e1mAVMuj+9Kn4bsTnF+aLtGPibaSd2dQkWv4pNVul7haQ5AFBT
         q7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPqFaK3PfCV9f0plVHjaFnI0EQVHjWHhUIO49LkNrrg=;
        b=LSapl11GIwSbbH1/5xp//6gov5cEHaIPEYvtv0EBe3SdbXs6as3kSA1gVZMjFFsQB1
         iirbwT1O/Ftx5Hr2WWqMxfbm/ZJbEwlxVIC4aT6dmaWC9327q3PKiBVPRIHU2gCgJefO
         OIZ5BaGLT7t+qPE9eZPkUKgMzVioY7BWx7xNb0wHTVWnucZKC24EKWKU/l4MaaGl3FUk
         +G36kcSXf8gJmhKJtkld4eSXTnuZDzPi3CG8GpTQtyn0mVhzlMM9E67BmlgFjUffJAwl
         5Nr90aISJu80nl24s9AlzGeo04W/IexJKJan8XWEbQtDJFlS+I0Ewyn+60hYz5m+rz19
         9iTQ==
X-Gm-Message-State: AAQBX9eogT/fOk2htXreEyv3uEmu1kk9XNAKGYEh3+EDzVGYhNqNy1BH
        rcbBjMpAPmdIJ+DZb/LAgO9cow==
X-Google-Smtp-Source: AKy350aAXImvzI8NjEszfNA39ejVSja1xKQWepyXhUlX9yXoeMEm+YLwAc3Pz8I1zp5f2RtdzuJxKw==
X-Received: by 2002:a50:ed11:0:b0:4fc:b51f:ff50 with SMTP id j17-20020a50ed11000000b004fcb51fff50mr2052797eds.30.1679643695136;
        Fri, 24 Mar 2023 00:41:35 -0700 (PDT)
Received: from [192.168.0.29] (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id d23-20020a50f697000000b004fd2a7aa1ecsm10271227edn.32.2023.03.24.00.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:41:34 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 24 Mar 2023 08:41:28 +0100
Subject: [PATCH v3 1/3] dt-bindings: ufs: qcom: Add sm6115 binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v3-1-499dff23a03c@fairphone.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Iskren Chernev <me@iskren.info>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iskren Chernev <me@iskren.info>

Add SM6115 UFS to DT schema.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..23447281deec 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8998-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
+          - qcom,sm6115-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -185,6 +186,31 @@ allOf:
           minItems: 1
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm6115-ufshc
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: core_clk
+            - const: bus_aggr_clk
+            - const: iface_clk
+            - const: core_clk_unipro
+            - const: ref_clk
+            - const: tx_lane0_sync_clk
+            - const: rx_lane0_sync_clk
+            - const: ice_core_clk
+        reg:
+          minItems: 2
+          maxItems: 2
+
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
 unevaluatedProperties: false

-- 
2.40.0

