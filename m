Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758D373F729
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjF0I2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjF0I2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:28:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A1D1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:28:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98df69cacd1so245848366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1687854487; x=1690446487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8oO/PwgsW79kOUbldrma34w+xKKDHQ32lW8yb4A9TU=;
        b=tuSWv5qj+E4F7o1mPxrHTHT51NE6/boot+MilRskVeObQCQNvZkbclT0djz2ll24+n
         1nrIaZXTM5xfGkSHV0nJbXjMkdQBAgJPhCbifm8Z4OVTLvW6sxowvNozNLrASk0ZMiKo
         OoRic72CuKwbTtx7A2yPe1Q2KSQZxR4+qmp+hVXWV/pd22hpGk9w15IQNq9PtBUU67zr
         VE5Dr4eAdybN5mQuuiIEJ8R4MYojI6ZL4RoxZ5mY51Yly56JaySt62jnT9GwYZ4XLf0v
         yHLZ4iYAtOVmjzvylcslEj9m7ViDJwrINtuun3UEC4h1Hwq70m6B2eV+7JhE6uRCB008
         DW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854487; x=1690446487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8oO/PwgsW79kOUbldrma34w+xKKDHQ32lW8yb4A9TU=;
        b=ijbVSVFwbuWvu9DHQKMvb9VEGe19ZIac1IqRJER8NZOrGQq20Ccbo3m+J35Ma1Pj67
         YYfSqfPIDYivnv7ai6r6Mcwy3/U084da+jubcHZe2OSkKLnl+xwmDXUZAsqVqA/PNoeG
         ag5qx+1N7tfe6fZ6Jcs/E5JOtp9Et3wy9J7iDFw3JUQrHVWBk7HsJ1qkiIFJXf69IJgj
         Cx1uwH7AuQemIRwII1k/ODRO+0ocTg3S3pa4t/Ka8IFmoT7DTmg4RbYAhSRPs4i6QA6v
         qMcQPWNBsP/AtkHhOK7pvFPwy7JA9Yleo3OvHcStp7ZbSOhjYxAcHU5+xmB8WaY/1l/Y
         JtQw==
X-Gm-Message-State: AC+VfDxK5X/1HZTsgTbKP1oCw+fhSlQL+8o4jrevvw2opIADxAeAOOuy
        cq5Dekh9HE+q/9UpJt8Cq0ebzw==
X-Google-Smtp-Source: ACHHUZ4dEU9Y2foautCqr2edkyJqPEnEjYbloscPJxXHL3t5qjrDh0P71tm7rX9O3LQwP82Lf8oJfw==
X-Received: by 2002:a17:907:e8b:b0:988:9b29:564f with SMTP id ho11-20020a1709070e8b00b009889b29564fmr24910564ejc.40.1687854487070;
        Tue, 27 Jun 2023 01:28:07 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b009894b476310sm4253038ejb.163.2023.06.27.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:28:06 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 27 Jun 2023 10:28:02 +0200
Subject: [PATCH v5 2/5] dt-bindings: ufs: qcom: Add sm6115 binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v5-2-c9a58c0a53f5@fairphone.com>
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
In-Reply-To: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Iskren Chernev <me@iskren.info>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Iskren Chernev <me@iskren.info>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 4cc3f8f03b33..2b0831622cf0 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,sa8775p-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
+          - qcom,sm6115-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -204,6 +205,35 @@ allOf:
         reg-names:
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
+        reg-names:
+          minItems: 2
+      required:
+        - reg-names
+
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
   - if:

-- 
2.41.0

