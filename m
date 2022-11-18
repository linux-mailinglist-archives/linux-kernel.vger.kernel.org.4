Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A962F033
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiKRIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiKRIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:53:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C761B84
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so8156930wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmJBD0oRRMzrYbbDbAItcJ2A5J5IdD5EulvQFU5WhFQ=;
        b=bv5E3mA3ICFc4Gy7Pj5mCjK+LyjNhb7SSFEw7WR9E/RO3qeKKTFVcyJMHkxQRpWERn
         jr9eXOrD34kDfEkal59Ybf+VE23crhBsnn6UXhl5m32LkjGVyFe8lC81k5z8+lSbQp/j
         xtpaXXjg+efWClyQRYQ5QLCvVVMcdDogS4L4Ta1s4C3FWZwqQAJnLXWkRpMgo5UQ1/fG
         +WSGTO/Pa9sLQ1/SYbjKEL2Ou+DTUX1GOgVhIba46ENJLeTTJVKyVOBgy3Zxaq6wSogu
         oVzpSllwYl4wfdKKNWFDq/ZLW+jZ+UOUlNvYVRwJPyHQ72RkuH8K+Fi3tRjb/ytTZG3Z
         m69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmJBD0oRRMzrYbbDbAItcJ2A5J5IdD5EulvQFU5WhFQ=;
        b=2AWBIXDuICg9KglltPvrXTFrRP29UtMbpmDE0iR8mRZqCLVcHuc3zIrn1phN0FRIQp
         40Kc7/qDJCZ3WHX9Ts63VDCQBD6HYOfmV+QyFdJAEmtteFXA/iG7KyOQoVrImAXgEg4y
         +ea4tfCcC7cFXyO691vz1Na4MJ1jBPy6q/lr3IXcdAVDG4+Skg1R/w2Lz6ygoDDxTYv6
         QpPupKxb+VSkgm7WNNe/Q9tYQYlf/SDXmqm5hBL/uncJxNQXbYv87qh+nHTaaHOeAse8
         D6VQvw5302J+FNraGHG6xupypDfbo0YdYnnc/5X44bq64uz8wKTYNUsZ17HHjON44URe
         tOTw==
X-Gm-Message-State: ANoB5pltt3xARgO6MjlF1qJv0SLFdHheRE/Eq+/+RqakjOMRwBJulVB+
        bcMjNqr5t0Hv6e67NbQKsNj5UQ==
X-Google-Smtp-Source: AA0mqf4wgo3eEkgORMG5/KmBcMc34bg50XKi7GPyQ8LxxSLNlFkTLcjovERaTuMfXEWjnMmcAm/kWA==
X-Received: by 2002:adf:fdcb:0:b0:22e:386f:4088 with SMTP id i11-20020adffdcb000000b0022e386f4088mr3700848wrs.526.1668761631098;
        Fri, 18 Nov 2022 00:53:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm2971264wrw.59.2022.11.18.00.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:53:50 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 09:53:48 +0100
Subject: [PATCH v2 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS DSM
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-1-f7c65d6f0e55@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Qualcomm Modem Processing SubSystem DSM shared memory.

This memory zone is shared between the APPS and the MPSS subsystem,
and must be configured during the whole lifetime of the system.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../reserved-memory/qcom,mpss-dsm-mem.yaml         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
new file mode 100644
index 000000000000..226d0dfc422c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/qcom,mpss-dsm-mem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Modem Processing SubSystem DSM Memory
+
+description: |
+  Qualcomm Modem Processing SubSystem DSM, which serves the purpose of
+  describing the shared memory region used for MPSS remote processors.
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: qcom,mpss-dsm-mem
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        mpss-dsm@86700000 {
+            compatible = "qcom,mpss-dsm-mem";
+            reg = <0x86700000 0xe0000>;
+            no-map;
+        };
+    };

-- 
b4 0.10.1
