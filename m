Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587265B32FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiIIJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiIIJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:11:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061C135D5B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:11:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so1600220lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ru7Sx5i9RvgY3g7fyc0DntX2hhZQfjQ93TQ69JqCe9Q=;
        b=Qkpoucx28Duq+NWHjpWycxiETGjowchu+jAIp4OPfbnygiILEsjNGFgiRLH/4QoFvB
         de+MBz7CCHm4zXvnhMyLGxUc9jYkb/B029h5fWWApL3nE0Q6U0fXLcAhDJ8WUCuFpUBO
         h7pxc4i32kGOvf2FPvk7vkFJrOMJL3kFsKzN0FUU/lsSmnkBICPE9Tm/pvOb3/CFXcOW
         EFLcESJOlinIWR8IGZGtwa3biq92p+gxHvtswCI9Mmd/UF4hvAwTvHvIZpOHUCSNRsOt
         S+f5YJJOmMJClItubheGV3tkFExxsu8J0u91JJeOKZfnm13MNrUK968/Fy29g9R6mp6Y
         uE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ru7Sx5i9RvgY3g7fyc0DntX2hhZQfjQ93TQ69JqCe9Q=;
        b=VQGRR9pMHaN6t/c/yQICPVUPzObUuOwJbK9oGhOztltKhxxDuC26ijaIKbfkziPQ0x
         W3gg7hV6bKHVlmzPkaJHPF7iZA6k25aixPPjSRt9l1/IotXGZ5ys86atDM7js5OkqocW
         ZaYazwxXUIyY3zfnqAhQ8Dso6wJ2t6YtrkFEzkhGkorn9tizcRNFikZN29o4LrG0YFyL
         Irs3KLt8Y2tKX97uZhu7yUla2u0rjtwXHUzl9LVWshIZhxUcQ4hrCWjT6vugR5o/BqPD
         9vMuIS1DY39fjTfLKWYLbItz+/jSupP7YXi/6jgQ3xkb5ThRCG6EvtsbwYswTj4NWm1U
         qf2A==
X-Gm-Message-State: ACgBeo3TvRlS4Yr9HG0NwH2GBPNk1u52FTUD1+o9oKXOkWhEgzflmNte
        QxViDBOog/i0McE6AFtszfy/Tg==
X-Google-Smtp-Source: AA6agR7+f0ARlXM0jJUnvsVkrZZApw52MJnuOH4zi76ULJbHUHYUwamJBsE5yP9Jqf98yR788MdsSQ==
X-Received: by 2002:ac2:5bd2:0:b0:498:909:9c81 with SMTP id u18-20020ac25bd2000000b0049809099c81mr2509172lfn.120.1662714660020;
        Fri, 09 Sep 2022 02:11:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o16-20020a05651238b000b0049602a81111sm2758lft.107.2022.09.09.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:10:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: mfd: qcom,tcsr: drop simple-mfd from IPQ6018
Date:   Fri,  9 Sep 2022 11:10:56 +0200
Message-Id: <20220909091056.128949-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7677ed11e9fa ("dt-bindings: mfd: qcom,tcsr: Convert to dtschema")
converted bindings to DT schema literally - including the
qcom,tcsr-ipq6018 expecting syscon and simple-mfd.  Such configuration
is not used in DTS and there is no actual need of it.  The TCSR block is
purely configuration block and should not have children.  Any child
device should be simply moved outside of TCSR syscon block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2
================
1. Rebase on current MFD changes.
2. Split from the series. Nothing depends on it, AFAIK.
v2: https://lore.kernel.org/all/20220817145901.865977-2-krzysztof.kozlowski@linaro.org/
---
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index d3c25daa995e..b12809b5cc22 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -15,31 +15,27 @@ description:
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - enum:
-              - qcom,msm8998-tcsr
-              - qcom,qcs404-tcsr
-              - qcom,sc7180-tcsr
-              - qcom,sc7280-tcsr
-              - qcom,sdm630-tcsr
-              - qcom,sdm845-tcsr
-              - qcom,sm8150-tcsr
-              - qcom,tcsr-apq8064
-              - qcom,tcsr-apq8084
-              - qcom,tcsr-ipq8064
-              - qcom,tcsr-mdm9615
-              - qcom,tcsr-msm8660
-              - qcom,tcsr-msm8916
-              - qcom,tcsr-msm8953
-              - qcom,tcsr-msm8960
-              - qcom,tcsr-msm8974
-              - qcom,tcsr-msm8996
-          - const: syscon
-      - items:
-          - const: qcom,tcsr-ipq6018
-          - const: syscon
-          - const: simple-mfd
+    items:
+      - enum:
+          - qcom,msm8998-tcsr
+          - qcom,qcs404-tcsr
+          - qcom,sc7180-tcsr
+          - qcom,sc7280-tcsr
+          - qcom,sdm630-tcsr
+          - qcom,sdm845-tcsr
+          - qcom,sm8150-tcsr
+          - qcom,tcsr-apq8064
+          - qcom,tcsr-apq8084
+          - qcom,tcsr-ipq6018
+          - qcom,tcsr-ipq8064
+          - qcom,tcsr-mdm9615
+          - qcom,tcsr-msm8660
+          - qcom,tcsr-msm8916
+          - qcom,tcsr-msm8953
+          - qcom,tcsr-msm8960
+          - qcom,tcsr-msm8974
+          - qcom,tcsr-msm8996
+      - const: syscon
 
   reg:
     maxItems: 1
-- 
2.34.1

