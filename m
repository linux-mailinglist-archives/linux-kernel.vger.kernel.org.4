Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF16620C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjAII5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjAII4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:56:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A40165A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:49:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bn26so7413132wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6pYLeV8ft+/6v9rIuv+K6mJ3K2zLutxNoFJngUlRoU=;
        b=Gc3kJ7GOoJIlt+95aZM+RVvNjVZEAnLdrxxAsRyaU6kOORyfTXGWsrXAbZ+vy6GJfV
         VTfHPOOkxhWLCCIxt0NWs59LZSkCgTAQm1goyoj+2iWaYtVO42DTF1980uDhAA6pQvS2
         JG/KUBbnC/K36auRBWTG0Ln2SRJDSkA2WSUGsGq0W9BbpIAu9ZEmyfAVjHq/j8eR5Lzr
         MYRlb2DTYHLVUw+xUsGwSMXfGpEQY7A4bVfQCbvoDN4NzJBbJQid9rjS0GeAdug3oCLY
         LaML8etsX4dOYqCPLpjmbrTA6IPAugsY2Wz8EQs0xNKYzNRkLpaa83w61FKtPZFIAMv5
         A0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6pYLeV8ft+/6v9rIuv+K6mJ3K2zLutxNoFJngUlRoU=;
        b=s4zGVY/VI6k816ZW97/FPB2tJl6r4iNiQxqeCLbj6ztliRXd6aRHOikgbvI3W4CT0e
         tXAGGCEz6N3Drnbz9Gp08+OXfuZNiJURwKc8f9rZtur2xxFPcDj4IrxZYI7hqNVeHEvJ
         iC1O2GBcA9Jge3tvnYaFm7kDTDwvzHad1ev+mRt5+WNkW0S41WHfKhHDaSsZqEPLIW/F
         9Vh6Lbn3YksnMyYBVSBiloyXiP9w/Sa60U+Pqk1dcZa0EQbCFfB582pGcu7jCCwUMyTv
         IPxBVJrjUbEHR3BnimOp8HGNR68tXjmuVDm7fIBBCtIIiu+1g5eVAMy/QzMoK6+rYPrB
         EFmg==
X-Gm-Message-State: AFqh2kouUHqZ3+vY95bpSqLx+cRrcxy9K16KqBgzGUvf82agDFkRbfTo
        zHivhNqVkiWGO1jHI8g07GjxVQ==
X-Google-Smtp-Source: AMrXdXv9Wgk4GPjPzq+gS8KbdtipvpmsekLvOY9Xqbr8eISL+KMJYpw3ydoH7rzzQoiW3rt8et1wDA==
X-Received: by 2002:a05:6000:24a:b0:26c:bc17:f3ba with SMTP id m10-20020a056000024a00b0026cbc17f3bamr42085441wrz.61.1673254175704;
        Mon, 09 Jan 2023 00:49:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm15039619wmb.14.2023.01.09.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:49:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 09:49:29 +0100
Subject: [PATCH v2 1/2] dt-bindings: display: panel: document the Visionox
 VTDR6130 AMOLED DSI Panel bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-1-dd6200f47a76@linaro.org>
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the 1080x2400 Visionox VTDR6130 AMOLED DSI Panel bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/visionox,vtdr6130.yaml  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
new file mode 100644
index 000000000000..49e2fd4b4e99
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/visionox,vtdr6130.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Visionox VTDR6130 AMOLED DSI Panel
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: visionox,vtdr6130
+
+  vddio-supply: true
+  vci-supply: true
+  vdd-supply: true
+  port: true
+  reset-gpios: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - vddio-supply
+  - vci-supply
+  - vdd-supply
+  - reset-gpios
+  - port
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    panel {
+        compatible = "visionox,vtdr6130";
+
+        vddio-supply = <&vreg_l12b_1p8>;
+        vci-supply = <&vreg_l13b_3p0>;
+        vdd-supply = <&vreg_l11b_1p2>;
+
+        reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+        port {
+            panel0_in: endpoint {
+                remote-endpoint = <&dsi0_out>;
+            };
+        };
+    };
+...

-- 
2.34.1
