Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991DB7196BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjFAJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjFAJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:21:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E491011F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:21:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a6777dd8so1181371fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685611290; x=1688203290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwGK0qoDjGX0JH8bcYXPEvdmm3zCPiYfNZofJMi9QKI=;
        b=rAFWauAF17PGOXMAq/kd+bXYCQ1iwep6dFR8vGPz2mHFudp2idnj7HWqxSIhF9ksmc
         qNkXWboTdiNuoJGNSipQbprbEHLZ5t6AHT5f8UqseLKTp92f33v4ovXk7Cqs3qZpC6MW
         PV9NRNIn/7Ap0ZyWW9+RuJ9S0jsgnGZl8B5bwLfZUF6kceKOfkTT7/NjjezCKTHVJM6i
         bSmwJg1ZebZxSLFmJBP8HSIg0Fv566triJH3OBccOERv6HVR5kwp84iDOyDJ46C3YLcC
         K7mRT+L3x/Lf+7mIYwC7l4HlOOzPoHveIfJAwBudH+lWafvZiaBZYRz72MywxQLpnOEv
         99mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611290; x=1688203290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwGK0qoDjGX0JH8bcYXPEvdmm3zCPiYfNZofJMi9QKI=;
        b=M7rPucpAlzaI5khvaeYLu+xmv1DSn7LtAisvUicNCCSKyxW7PG7pMcSjVTwgFbiuiU
         Gt54VoOEmXxn8X0aIDNCLq40ed/CwwfXDe+wbrjdbdxb5KjVPHiTmXNioVcBXyRYfRxo
         /t96ph9dUFVDBgWT79c0c9D4bwLQ1wMUByVrwpMrBmPmAPfgpuqyes6hIguCXbp1MOIF
         zkGq2VBTXi2dY1CVSq3d+LreJcARUnlDUWvDAsSxMNMJhnhqjnL8KFTZ5t3ATbj6D7+H
         3yzdxihLzzf8C462/e9lIkSUiVk6eH1CV9o9jNN41wOi2z25pMeDxNiSSRk5Tli/bR26
         X0yg==
X-Gm-Message-State: AC+VfDyS2I3Pf6BNIGPVgUf7r+f2tB9a5uF1qi4RUxNvLb6Z52Z6v5Im
        m1yinwhMMVkvINCwBTqAFYsxgQ==
X-Google-Smtp-Source: ACHHUZ7qj2PQGJs0JEW5DzuvuFrnOFTDItB2hIL41o+/4K+ucT8qI4A7vPZz6M4HpA6nLqP9CpRlLw==
X-Received: by 2002:a2e:8302:0:b0:2b0:4c72:98fe with SMTP id a2-20020a2e8302000000b002b04c7298femr4318556ljh.45.1685611290053;
        Thu, 01 Jun 2023 02:21:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a2-20020a1cf002000000b003f3157988f8sm1671572wmb.26.2023.06.01.02.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:21:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 11:21:12 +0200
Subject: [PATCH 1/2] dt-bindings: usb: add ON Semiconductor nb7vpq904m
 Type-C Linear Redriver bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v1-1-6ad21094ff6f@linaro.org>
References: <20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org>
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5069;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WmTA18+aiJspbeMjHnTmU5gXepbbKxIUGkdpuOjC9jc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGMXJSmFhv9l6JaOu2SonWjyzGOh7sKyN2Jg3tyh
 /yd5H3GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhjFwAKCRB33NvayMhJ0erGD/
 4iXpJ4x0bImiPTaRl+EdzU6rRq3mtw9G/6AWwlgAZ4+EXR9SNLyubioL7mF2hmXzI59q4xAP6nDtPn
 2EjlQAXxCtdL0zT5IJVanrlmWGzDCj+e+1GFNPldn5b8dduhztrhxS3Usfn/fbZij1yu7XaHOk+8sm
 H+Pq4jUMEOQm9ppVDJWQe5zCo+GnSq8oGLKG5NGREm0h+fbJo8JFewK5UxGrHQUbtAZPz6+oDKfoN0
 Y1ZVxd0SFn7OTJDSZhGPH3a6myjiWuEHVshFeO+2hbGsLBhonZ4zPwV8bYB85Yx3m6Fd4UTfwq+PXl
 r6jh5DGvr5kqeooVZ0zZWpd7mBjyPn5SvLOW1oIUDBIL5ibCggn9FOg60RcOy8TG29z6/J113XDv1Z
 kQ0f/YgppqTNrYGanv8i5rdcWzfthaxFCmSjCnlP3pVbwO0kp6RX5ClYPGak+J4aRFNBRkB8y6r7M+
 38EajVxYN9Lo7A/5WKBTQWo68FBrUU0icRNkzmbXUsM6zT2REXzHSljPOpNgs3DNbFrLu8/NoOA6SZ
 mzOcdRoOv2i8CmEaM/sslZ83GGxqMhG4DoAoSDLkpb4Zjs1pLcpcVlg2qafJmv2YyrpcbQ0lGsxxXW
 v/pU/uOwUmboLB8TVh2iv/CcJgYXbSKeblkb3ooXVGFVwsFiQuwYc4OGVYaQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for this ON Semiconductor Type-C USB SuperSpeed
and DisplayPort ALT Mode Linear Redriver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml b/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml
new file mode 100644
index 000000000000..c0989dc4d5bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/onnn,nb7vpq904m.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ON Semiconductor Type-C DisplayPort ALT Mode Linear Redriver
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - onnn,nb7vpq904m
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: power supply (1.8V)
+
+  enable-gpios: true
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Super Speed (SS) Output endpoint to the Type-C connector
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Super Speed (SS) Input endpoint from the Super-Speed PHY
+        unevaluatedProperties: false
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical data lane indexes. Position determines how
+                  lanes are connected to the redriver, It is assumed the same order
+                  is kept on the other side of the redriver.
+                  Lane number represents the following
+                  - 0 is RX2 lane
+                  - 1 is TX2 lane
+                  - 2 is TX1 lane
+                  - 3 is RX1 lane
+                  The position determines the physical port of the redriver, in the
+                  order A, B, C & D.
+                oneOf:
+                  - items:
+                      - const: 0
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                    description: |
+                      This is the lanes default layout
+                      - Port A to RX2 lane
+                      - Port B to TX2 lane
+                      - Port C to TX1 lane
+                      - Port D to RX1 lane
+                  - items:
+                      - const: 2
+                      - const: 3
+                      - const: 0
+                      - const: 1
+                    description: |
+                      This is the USBRX2/USBTX2 and USBRX1/USBTX1 swapped lanes layout
+                      - Port A to RX1 lane
+                      - Port B to TX1 lane
+                      - Port C to TX2 lane
+                      - Port D to RX2 lane
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
+          handling altmode muxing and orientation switching.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c13 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec-mux@32 {
+            compatible = "onnn,nb7vpq904m";
+            reg = <0x32>;
+
+            vcc-supply = <&vreg_l15b_1p8>;
+
+            mode-switch;
+            orientation-switch;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    usb_con_ss: endpoint {
+                        remote-endpoint = <&typec_con_ss>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    phy_con_ss: endpoint {
+                        remote-endpoint = <&usb_phy_ss>;
+                        data-lanes = <2 3 0 1>;
+                    };
+                };
+                port@2 {
+                    reg = <2>;
+                    usb_con_sbu: endpoint {
+                        remote-endpoint = <&typec_dp_aux>;
+                    };
+                };
+            };
+        };
+    };
+...

-- 
2.34.1

