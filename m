Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D415EECF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiI2FDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiI2FC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:02:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91996128A29;
        Wed, 28 Sep 2022 22:02:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so498204pgc.0;
        Wed, 28 Sep 2022 22:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=juW9wu13y489Hph7sR+dhrqUMWDs6TD8KFYBRB4JbO4=;
        b=G3Xxu7ZvNGRd8fN9tX/5TWIr9fy++QsTZ7/ZckdyCHzJNHQfUX7TNkreWBeYtOP8SR
         hoAr7VeQexpBA+KJBcyA4ooRQVKuRnItiwm+Lz6B4NtLW48Yuqq3gkxDG4SAmNiC38Z5
         k+6mf3DANeiT4fNzOYMxwTtblfHZ546eCGhC5lK2rjhHPbzVdxfmfX1MGHlHn2PoDL8V
         C0Nm6MSq5trXpO2gundC4+9xxldV14mISwzB0bPset6oV+XeWwqmmogEIJXle//clAle
         vX/cKmuYQ6l6sw5ZocUxbfxz7L4++i7wJ9K1ghjEYj4Ct3a6XqcjpKxkGGb+vsTfCv6Z
         kViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=juW9wu13y489Hph7sR+dhrqUMWDs6TD8KFYBRB4JbO4=;
        b=lWpicdgrDIl0SWrmW5aJg2TEDRoxhhI/fdlt0bALFB/02cW0s9RmofUuA6BERb3RfG
         yxSOCCBsBUE4aXi7M6KoQkDGIuOXoCwNWi/YQ9lpUtCpAnU+vz5u20M6EUw3yT957X4y
         5/CbCwAQr3AbPfQwy8fRfJjPAsO9xBymCuefkt+2WveDMceBikt2D8TQr6hC6L+QYMVo
         jzAThEZKMdBQPjsVAszWZVqL+p0PZ5/nFF6UWmhRcE2mUgZCcf28aEkarGwU5yvHYrnn
         mCYZXMq++qs41W25KUhk7xOO6b+FejAjwAp8WVV7t0e7HaDxVPsohIwZZsXbppjnzLeu
         ypUg==
X-Gm-Message-State: ACrzQf0w6fOMJtrltGzKwDRTxBK7HCriefAYgsWC9iwSxvincd8lrPgq
        i24NfvfOeGQkACiJxmDOZ5gpvqikA/Z9KqUK
X-Google-Smtp-Source: AMsMyM7Zba0qfDZYMrALKSmvp8fAyCBvTGCUHZhEMQlQtnV4Em8sTbX+B3AA+sqFNC73wbg+wPAi4Q==
X-Received: by 2002:a63:cc4a:0:b0:439:1c48:2fed with SMTP id q10-20020a63cc4a000000b004391c482fedmr1317619pgi.618.1664427774356;
        Wed, 28 Sep 2022 22:02:54 -0700 (PDT)
Received: from skynet-linux.local ([2a09:bac0:579::681d:4237])
        by smtp.googlemail.com with ESMTPSA id rm13-20020a17090b3ecd00b0020263b7177csm1895962pjb.3.2022.09.28.22.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:02:53 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 4/5] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
Date:   Thu, 29 Sep 2022 10:32:08 +0530
Message-Id: <20220929050209.1464526-5-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
References: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 0eb2617e3482..2ba2b6cf11fb 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,pronto-v1-pil
               - qcom,pronto-v2-pil
+              - qcom,pronto-v3-pil
           - const: qcom,pronto
       - const: qcom,riva-pil
 
@@ -199,6 +200,21 @@ allOf:
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

