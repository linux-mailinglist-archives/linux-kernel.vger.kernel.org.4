Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1750E62B789
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKPKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiKPKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:16:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9FBF47
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:16:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id cl5so29093062wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu7n9N+0O5BDIzgboei0EVzrkBbQ6PttgZW+WxRWsp0=;
        b=G7Z5/x6S57rt6bfL4e5y1ndNXKgn6SQ2r47XxAXklpogTiYtUVc4LvU9HBUhUJIqGW
         CK/RD7IJL+hmfAug62nieUT/iNNNbFxjBjG54g3DznfPOnDpToG1tWBl4fE/I4oVSyCO
         4jEnCBQaDRAweOJsgDP1ODET/dfz5n8L5XZklazjKgl8+BIae0F87+KL+D9X0+XZwIT4
         QsUF30r9TEYrHr1ijeJgDRUSdBdISVqwZplQOwRi2+nivnzQ3td5bKYB3Geca08WoPET
         egj5FJHXUum+8qtFXc8ivx36sR65ZqtkN7iFMkqqdE/T2j7mbOW9ia4E7/WwmzHAHsN6
         SVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pu7n9N+0O5BDIzgboei0EVzrkBbQ6PttgZW+WxRWsp0=;
        b=m32N/nZ7tHx2QvIt9pVkgq24V6myb5HMf09SXsVWBqHO75L9E7FDscgWLFnYS5D0nI
         rZsP5xyIi+yRvFRSLc0EBnard5qKSfudhYqpLY1hhDqqLqv+sIIPBJ6chvfQULaXW4Ym
         wTuTf4HywbmJfAp2x3Sr4bLcjOsm+0ZGty3RytvjpMg+l43frYH83MUipEV6T2Ps+HSK
         W4S7iba7JHGc53Cvk85hzdDvtYPe7kGpeHYekpboX3GJNGT3Y4yxFABUViW0P5Yovc0P
         kS75k4wuHRcTgEueOkBSZWklnklJ5iqJXm6m8vLYUu+bAgPk7C8vu0Ks78lWmRK2kcZ2
         0EHw==
X-Gm-Message-State: ANoB5pmaMYuO89NFz3kXQ3ADbAgh9JSb+myYxnBgSYpZ5Xcl6DsjGk7A
        TVvxlHtdCiZb2+pxm44SmlDxJg==
X-Google-Smtp-Source: AA0mqf4X4UyzMTmZMBThnmCPMnmHPtKL9J94nSju8yGwDuhBd/kFgRwxYZCzqG7VteZ2tgaIvhR50A==
X-Received: by 2002:a5d:43d0:0:b0:236:4e3c:7720 with SMTP id v16-20020a5d43d0000000b002364e3c7720mr13509880wrr.674.1668593816360;
        Wed, 16 Nov 2022 02:16:56 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d4f04000000b0023672104c24sm15081007wru.74.2022.11.16.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:16:56 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:16:52 +0100
Subject: [PATCH 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS DSM
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-1-158dc2bb6e96@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
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

This documents the Qualcomm Modem Processing SubSystem DSM shared memory.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../reserved-memory/qcom,mpss-dsm-mem.yaml         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
new file mode 100644
index 000000000000..65f37e1356d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reserved-memory/qcom,mpss-dsm-mem.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Modem Processing SubSystem DSM Memory
+
+description: |
+  This binding describes the Qualcomm Modem Processing SubSystem DSM, which serves the
+  purpose of describing the shared memory region used for MPSS remote processors.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
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
