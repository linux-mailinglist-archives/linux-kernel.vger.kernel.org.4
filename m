Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2465BDAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiITDFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiITDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:04:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66DBCB5;
        Mon, 19 Sep 2022 20:04:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a80so1474307pfa.4;
        Mon, 19 Sep 2022 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1ZAgs0EUhexlFlK2MZMbzZ6IVMi8WJy1viUVzYD9emk=;
        b=mz2nf/kpV65RpPN0RxEjlCpMh7TtltlOTVC6jiGG97yzv1C4MN6RzvyEYIuSmm3OG2
         Our5rGPb7SjhuI7BtCKuDLTeRkiA4xYUMmIykzT1wDDOvJiQMQJYLll+cpUUc3Ex9AL4
         YnWINGn19qKq6DKXF3Ccwk5TDfy07eS8eVqSSwsZReBLbJBLrERONLNwrqrQ0B3b3y8/
         kG7i3GmFTNNHrxcJ/kZIuAf85k6RaYmRsl5zgLh7oEs5na1Gr5+lxooREHsD7yGk5Dsq
         O/Gzda4ZIwpI/xuJZVseT92X9MJEMv8mSqy1amnhjm+FIAz5Bazg3AFyecau54wTxf30
         15qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1ZAgs0EUhexlFlK2MZMbzZ6IVMi8WJy1viUVzYD9emk=;
        b=uCXJ914i67ONFbL9BVU30kWR4fDhFyVeqs39Me9AeD+5Rx4Zt46k93m1t+v3PUZCW2
         l/vUyP1a0rTvLoVUIMCvX0esYbCSfxCA8ahUEg4xBMrCsZcsgU1UhdrDwfcoHIfTzust
         5NWPrfuW/suTz/4f0VvBlLOK8acifHcoiPphAJylnMcpUdFn/AK2iGlUQfv7ZxWuEXMW
         MuBKSh2i8kJGyRE9owHWbvAvEKW6++mylg37KOlXEbNJVcbUgrtROZdFxJHn0FbRscGp
         NG2AR9xPkty963ZrmNeMi5c+PbLTfspUQLZCf53MDWzA5vq105fkPRn4SZbmfAiXCKMP
         ruRg==
X-Gm-Message-State: ACrzQf1RDOLV9G25D+mEwEQKams9Q/QROko0sVrGvYJvHfc6+SGZhy+b
        wt4x5s0eB4kFbCwst+S803pzZZFAN+j2gQ==
X-Google-Smtp-Source: AMsMyM4c+NnhvJf5VR8ihN9H6u+dBOlOl1hRfRzYIvJe9+wQ2FGWaeKUq7AcKI69mRRNR2ZnJgH3XQ==
X-Received: by 2002:a63:d250:0:b0:435:1774:1f93 with SMTP id t16-20020a63d250000000b0043517741f93mr18422050pgi.339.1663643065471;
        Mon, 19 Sep 2022 20:04:25 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t193-20020a635fca000000b0043a18cef977sm171083pgb.13.2022.09.19.20.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:04:24 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     andersson@kernel.org, Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
Date:   Tue, 20 Sep 2022 08:33:16 +0530
Message-Id: <20220920030316.1619781-5-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
References: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pronto v3 remoteproc is similar to pronto v2. It is found on the
MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
other SoCs. Since the configuration is same on all SoCs, a single
compatible is used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 31232c59b22b..639c52284f4f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,pronto-v1-pil
               - qcom,pronto-v2-pil
+              - qcom,pronto-v3-pil
           - const: qcom,pronto
       - const: qcom,riva-pil
 
@@ -197,6 +198,21 @@ allOf:
         - power-domains
         - power-domain-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pronto-v3-pil
+    then:
+      properties:
+        vddmx-supply: false
+        vddcx-supply: false
+
+      required:
+        - power-domains
+        - power-domain-names
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.37.3

