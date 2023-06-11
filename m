Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8E72B236
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjFKOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjFKOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1930F6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so34725595e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492246; x=1689084246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI+2Lk67Sh+745P6r5mm+b1Wragt6EBM0nsPxDRubR8=;
        b=EIPaZ23yZRyDuF7jjQupcSQtiQgAevEdEIiUSNDqI3563bIaDEf2qnBdbK0Cax3Ukm
         pQBDpNBqH78gYF/ZPLbjUHs0J7cV5AbiXA4N1BAQSW9FnL/Sq2qo+e300Qz6nm6/KiKU
         D1wjrmDbyureiy7bfFZzl58YpdTFsgCiISkWPX1tjcVQnHARlOq5N+pxmEBsdeWfQ01Z
         sQiOt08eSSaNCLj/vyjndjYmuHgbDJbqubPjFBkuZC/ztF4KxuUM7pUObu7Ee57LYuR6
         R0avCPEbNjMc0ldTsqmPj3C1s1kOJb/IxiiKBX2ZQsrqdqaNiwxURBhoKIz49UAi1uCk
         QCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492246; x=1689084246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI+2Lk67Sh+745P6r5mm+b1Wragt6EBM0nsPxDRubR8=;
        b=Z3eJmd1DlHr9Q3apIQzW+Rw8f3FyB3Tm9Zvgs8VaQklkxpToC5f2inBIXNOoIXlf4Q
         ps7ANFlS1rt+LIh//X0uXEuBPm9T7SI9SRLpIUClXQBXvbStsGfIJ2PPrU00IxU0tmu/
         hLGp8spakrVFQTayYOtX5ZOFPxXABqZybw4uPD3OFXGyXaRIQqd5uSHhmzNMmxysBwXv
         AgXtLk7Ux6TXR3GQs8YvY1VuqOOHVdcWqssZnVSKVO3RLPDp6LAAqERg6Q+I5Zcdk1lV
         X5ji3nesPhNwdMoaERnQUdHyF0JBGga3J0xPca5xvtmlolJk8a5PDU28PJonjO+vt2m1
         /Imw==
X-Gm-Message-State: AC+VfDw28XWNXrjvcDnSWnnswamI2GYevs+hC72GgQUKXIDCj+2r0I1M
        lFrH/Zr6XLtfewfslpM9Kcrz0A==
X-Google-Smtp-Source: ACHHUZ5+C97G6W4g8TzY5qdmF65CPuj1A4Lw0Ejm7NSFDY0VhXHNI1cQLKVkkEK2bdsY7SiAhK8S0w==
X-Received: by 2002:a05:600c:364b:b0:3f7:5e08:4012 with SMTP id y11-20020a05600c364b00b003f75e084012mr5373611wmq.36.1686492245867;
        Sun, 11 Jun 2023 07:04:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 16/26] dt-bindings: nvmem: qcom,spmi-sdam: drop unneeded address/size-cells
Date:   Sun, 11 Jun 2023 15:03:20 +0100
Message-Id: <20230611140330.154222-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index dce0c7d84ce7..cd980def97b8 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -25,12 +25,6 @@ properties:
   reg:
     maxItems: 1
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 1
-
   ranges: true
 
 required:
-- 
2.25.1

