Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC766D6A61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjDDRWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjDDRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBAD1717
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so133477145edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4i10Nu53Bt3FeFdaaCNbwgGOLAXs2beXmn7v88uxP0=;
        b=nP7X/2nPRF7l16+IigXht4VSenKiHnt3mctghSd++ZKNedKaiva0CCAjAxjoZxBdin
         vlRSY/qROKZqZf52CIc4m5HtMdTAtqyQfKYBBUSjYvEQR15BjJfULEv/c/8RH+SwsHf+
         IgFT+PJcy101yA6QFth7kbzUEgG1vleqwS6zy5YcC8SaQJwiKBh9tOoSMU2mHA8kkb+0
         A+23kDJymgUD7SCRliEm4tx8gohj8hBE5Q4tywCKd9++Qp7LH6p5X1YRAxIFq/CHJqSR
         yRHEVcjBxI4dIQ+SNC30InFyKLwNdJrqPoNMzEoUAtDSnHzJv+JuYymgYBD9zJdEgTDd
         lw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4i10Nu53Bt3FeFdaaCNbwgGOLAXs2beXmn7v88uxP0=;
        b=PY/KiCPmsH/Qh1YlQtWMYAR/HaUGR+Sn+3oqgGt9pkKL1a7yGrm6EB1U8QIdX9svcF
         hG9Pdysy4IJrjF8QmEV9X5uRicNwbhXJGz54IjxscIGqEiP60Cot6jcf0scqiDWFHhzX
         Y/t3HRV8h9JBLJss8lfMWCKBMusb7cRLmV3VheUgHyby93z8omEbUc3ZqNg+ly9cO7ME
         QkuNlQNtOSDTKWjmoInkpNH3YiINVyPCkXrjFYY3uXi2ZVilZQJ6u37ZXQwlyRYAkVgI
         d2//qIB29lVmScIX6kdpye2bv2l5/T/P14Ij2Edvnow6pxpc/8qvbEbWfHY+hcFJUS5V
         m7gg==
X-Gm-Message-State: AAQBX9fgn++E+S2PBDRpheWbbBZCLadQ9BwFRYwp4fP73OXlkpr4yGOK
        WM70/YOLJaJRSTrhSBxXyQBIXg==
X-Google-Smtp-Source: AKy350YCCfw960OjUdjDZOBMlZ3hZMSYycwEDsy99nytIwnmlzDl10aD7t23k3ygynKfOEzVEH0ioA==
X-Received: by 2002:a17:907:a802:b0:8b1:7684:dfab with SMTP id vo2-20020a170907a80200b008b17684dfabmr369493ejc.38.1680628943281;
        Tue, 04 Apr 2023 10:22:23 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/40] dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg' property
Date:   Tue,  4 Apr 2023 18:21:10 +0100
Message-Id: <20230404172148.82422-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

The SPMI PMIC register region width is fixed and should not be encoded
in the devicetree.

Amend the example with a parent pmic node with the expected
'#address-cells' and '#size-cells' and fix up the 'reg' property.

Fixes: 9664a6b54c57 ("dt-bindings: nvmem: add binding for QTI SPMI SDAM")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/qcom,spmi-sdam.yaml        | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index e08504ef3b6e..4702f10ecca2 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -42,17 +42,22 @@ unevaluatedProperties: false
 
 examples:
   - |
-      sdam_1: nvram@b000 {
-          #address-cells = <1>;
-          #size-cells = <1>;
-          compatible = "qcom,spmi-sdam";
-          reg = <0xb000 0x100>;
-          ranges = <0 0xb000 0x100>;
-
-          /* Data cells */
-          restart_reason: restart@50 {
-              reg = <0x50 0x1>;
-              bits = <6 2>;
-          };
-      };
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sdam_1: nvram@b000 {
+            compatible = "qcom,spmi-sdam";
+            reg = <0xb000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0xb000 0x100>;
+
+            /* Data cells */
+            restart_reason: restart@50 {
+                reg = <0x50 0x1>;
+                bits = <6 2>;
+            };
+        };
+    };
 ...
-- 
2.25.1

