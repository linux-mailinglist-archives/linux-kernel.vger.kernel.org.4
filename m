Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A8690AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBINmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBINls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:41:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3571558C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:41:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso3884623wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjLQ6k0eKtXjQgrCbXriLkzXKMYzM/hKWrkASWGobfc=;
        b=mLWrjSKmdpGUaYDAQZICxLSAs7ZKrnHVZVKfVMia/8ggNhMzJKm1PbELGzCVEp4P6P
         GV5X7yqJYTmZKPs7A1B73sYqHrQtxASN0f4t9HJnf8snZPE52n4bn4AdbaerH68pSmrH
         4430KlCz4zA/sGWku5Dvsq3e5Yq/b/Wkxe419l/FC6AcWdy1HJ31dCU00yftQLoto8qZ
         9729k5Draj6qbMyc+XufEqxgtLatzbXK/Mf2+ggx9OisMzo/xoLmVsxGqSnaoogqIrLl
         pnAGufiAbevEvkTHgCXWgr+pPAjdrO98VbecW+t0wA8kj3rzheusqdkdRI6tkMWHD/zm
         ABXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjLQ6k0eKtXjQgrCbXriLkzXKMYzM/hKWrkASWGobfc=;
        b=T9D+056EIERpnVV34ivwSQNIupHCv4xQ7R76kP4Ukqa9T/diZxe5vNvoXS22kFPu24
         BabPrRdCROyKg89FdnKFB5RMQxKExZ6rLs7wC5iUs5viEfclDEo9ZqhY+CSbqp2Yb7VS
         o9i7RtYZcZLxubvafusmM6Gbs8ycpJGCOWkiK/tTV1XdckI5mVj3GRm5r2mUUk4b5qby
         bueoxStV5gjTfQZteSIuN2Ai+6UDC3ZBmUZ/pP/hZr8hK66dJhiZFGnP1QQZPhti2sKI
         I6R4CxdjeA0PAUUl2DQ/+CDpebwAWq+IRYGZKp+4l6FXqWCU5ZQa3WODjPSS+ybaas5l
         r3lg==
X-Gm-Message-State: AO0yUKUbnmKU8kWFoNUdx3q/MG1pfBEDYEt8EzBuZGYcAE9+MjLHpQ4r
        80G7nGRLHcAhGhMPx5BZHKG7Zg==
X-Google-Smtp-Source: AK7set9vgmNMX33CebLjgnK/NCuxhWo3nDtnIa0yVi6jVPXlG+ofn9yTRMMHHwUsy0duwDeSmANpIQ==
X-Received: by 2002:a05:600c:511e:b0:3df:9858:c038 with SMTP id o30-20020a05600c511e00b003df9858c038mr6116913wms.13.1675950102431;
        Thu, 09 Feb 2023 05:41:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm4946991wmi.18.2023.02.09.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:41:42 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Feb 2023 14:41:39 +0100
Subject: [PATCH 3/6] dt-bindings: soc: amlogic: document System Control
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230209-b4-amlogic-bindings-convert-take2-v1-3-c4fe9049def9@linaro.org>
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the System Control registers regions found on all Amlogic
SoC families and it's clock, power, pinctrl and phy subnodes.

The regions has various independent registers tied to other
hardware devices, thus the syscon compatible.

Clock controllers and Pinctrl devices are not yet documented, the
definition of those will be updated in a second time.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
new file mode 100644
index 000000000000..672eabd90c09
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson System Control registers
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amlogic,meson-gx-hhi-sysctrl
+          - amlogic,meson-gx-ao-sysctrl
+          - amlogic,meson-axg-hhi-sysctrl
+          - amlogic,meson-axg-ao-sysctrl
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    type: object
+
+  power-controller:
+    $ref: /schemas/power/amlogic,meson-ee-pwrc.yaml
+
+  pinctrl:
+    type: object
+
+  phy:
+    type: object
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gx-hhi-sysctrl
+            - amlogic,meson-axg-hhi-sysctrl
+    then:
+      required:
+        - power-controller
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gx-ao-sysctrl
+            - amlogic,meson-axg-ao-sysctrl
+    then:
+      required:
+        - pinctrl
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-hhi-sysctrl
+    then:
+      properties:
+        phy:
+          oneOf:
+            - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
+            - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+
+required:
+  - compatible
+  - reg
+  - clock-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sysctrl: system-controller@0 {
+        compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
+        reg = <0 0x400>;
+
+        clock-controller { };
+
+        power-controller {
+            compatible = "amlogic,meson-gxbb-pwrc";
+            #power-domain-cells = <1>;
+            amlogic,ao-sysctrl = <&sysctrl_AO>;
+
+            resets = <&reset_viu>,
+                     <&reset_venc>,
+                     <&reset_vcbus>,
+                     <&reset_bt656>,
+                     <&reset_dvin>,
+                     <&reset_rdma>,
+                     <&reset_venci>,
+                     <&reset_vencp>,
+                     <&reset_vdac>,
+                     <&reset_vdi6>,
+                     <&reset_vencl>,
+                     <&reset_vid_lock>;
+            reset-names = "viu", "venc", "vcbus", "bt656", "dvin",
+                          "rdma", "venci", "vencp", "vdac", "vdi6",
+                          "vencl", "vid_lock";
+            clocks = <&clk_vpu>, <&clk_vapb>;
+            clock-names = "vpu", "vapb";
+        };
+    };

-- 
2.34.1

