Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7961612997
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ3JnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJ3JnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:43:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C46CE30;
        Sun, 30 Oct 2022 02:43:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j15so12104384wrq.3;
        Sun, 30 Oct 2022 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBK4eajyaayOpX9DdVnDzlG8OxVihLhLym73hQV3R9Y=;
        b=H6vHTPf4Qxb/TisGjjb7Q2+YLGroPJY6+Ryhql/XhosjWnKyp38sJZj4nhfJcrWJBd
         sAAvXjCwyHkWTOnyzIXmne6A9obDowMue64dViuUq4viJSmHQE9Mr0IkmbOmWF9KLLzX
         Qe4JBlCquV5Wc3vUdYn36wCQQJVBgEuiutH/Gi24IPdlpxaGCkCNz0PV+Y5A88Ee8+IR
         gaR+Rc+/DdYC9H1K8nOncGowgdqZG1IRzDOC7p8ks4q8oNeY0VIdCQGarPeLEzanCtY0
         NLb18rxWTIQ6nCEUjJTQoy3Yp1tU3aWypaxaEtibUZh0/uNXVfCL8P8tJyi3CAcz5u9w
         9o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBK4eajyaayOpX9DdVnDzlG8OxVihLhLym73hQV3R9Y=;
        b=3dueflPhrsz4qRhqiONuGLGm+RBqqusViIXygyY4UAugGcRvzsHdqek527D/5clMp+
         NqAZWK6mktkimjW9PIhQQL11DiFMcRKJWPomoI2c5qT8hiO6qrbQZ7e9du0Q81xSBfLg
         bUhHS/qOXErrFp85vASomJDCgFe3vX275gbUbkf0z4oCUS5n+7RRfatxfFOfUsjdG9DW
         WfwKrt/mPoMQTFhMa3NVbb8ZBvl9WeGhOHsyLmF1qZUP3i8Z9VD0Qr6tUC1DtoMXoYcc
         SwfyjI7wV0OQii8aITjOS1+6FSBVPz6pewcKVf2dNpYMUOebf6p77eia9l5BcVVXCko2
         ZwLA==
X-Gm-Message-State: ACrzQf2hf+exX5Uf2E8d4JHhErtDxq8Y4+cXhgCTj6TD3IGPqQK8y7B4
        oiLGR7cZ8jvoKebJkrdl3uY=
X-Google-Smtp-Source: AMsMyM7tg/AKZ2BWnj8GOYyUbHyqMOD8dDbX+1Qno7SXFEzR3p2nycair8V+eIGl/0J8yt0P+IXzhQ==
X-Received: by 2002:a5d:47c5:0:b0:22e:6941:81eb with SMTP id o5-20020a5d47c5000000b0022e694181ebmr4479204wrc.408.1667122985385;
        Sun, 30 Oct 2022 02:43:05 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b003c6b9749505sm4057032wmq.30.2022.10.30.02.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:04 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] dt-bindings: ufs: qcom: Add sm6115 binding
Date:   Sun, 30 Oct 2022 11:42:51 +0200
Message-Id: <20221030094258.486428-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6115 UFS to DT schema.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..b517d76215e3 100644
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
@@ -178,6 +179,31 @@ allOf:
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
2.38.1

