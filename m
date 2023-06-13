Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23472E63A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbjFMOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbjFMOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:50:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993241BF0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:50:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fceb009faso517827f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686667812; x=1689259812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wH2CsCx7+x3Jzc+j/GbOX9j20blCsxJNxD0bmB92+8=;
        b=vqsfX/5teKL+EI+5LMnz2dE7BVO8sIdgalf4AKSUInSKmIBYbYWaRLnfLXlyXPAM0E
         91bIM/wMF33ZEOzyv4jhsuAZwbxakzgBZuqgWwukf8LrmNIu/OIs2GK0IhY98TkjHZ7K
         PhaLJNYTM1gc+Nq7uwGb1F69f5kt3l0pSqtJql3ResXYNZnTLk9XSwGlFQHSXqFw9xvO
         oWmM8zDAYFan944bKPKONuq5hUQAgRjYdxLHPscX2VNnbtOHaCpMId1OEGXgY/o51FMV
         dOHJTEUBqxCNkCHF/gjlgkH26uEY7oligkycNI1LniGZ1Q0mWVBCxMcXYSvgmmR2Voj7
         Os7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667812; x=1689259812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wH2CsCx7+x3Jzc+j/GbOX9j20blCsxJNxD0bmB92+8=;
        b=gqzCtQkaTc9XfvPpOx6seqK/p7TJrk7h5O7FXiaV+hgGy/JZk3LBX8JHCme6VEgrrF
         vJ9tPtYNiUHKKCV1fa+cmKjee4Xz/cJ37MQCviIi8myQ9lq3s5fAmKB3689UD9/A+iDU
         at14TxlvmJJMickvHzjCVQoZ6fK5Clxh5d0/iQ3qtNbCszWgmL5pZFIzHl9d9UjpYSoz
         MTPI2VlXcc8KeosqQt7M958S0bRlS+/Top1G4X2O+UIl0t9ypzrx8BDQWOiAkP8MfKEU
         UK6G7gXk4nAZYGKJm82NrbOOBBrDpV2OESoDUkP7xSGadaIV66S/5l2ahZ8e8fOSCyG+
         UmZw==
X-Gm-Message-State: AC+VfDz+dALb9+1EZBmI9udlow2ePRGBH2BVevUiOZDddtV2GXoeHUt3
        kMJISFwZ6jIKikySpoIuDazqgg==
X-Google-Smtp-Source: ACHHUZ5eR1pT9PKayWpebDvk92ibUcL+HLxRvYWARDzck5wf4D+XZ6Xp3Bi/VBF4WEF7ULAHOHiD3A==
X-Received: by 2002:adf:ef8b:0:b0:30f:bde3:aa6 with SMTP id d11-20020adfef8b000000b0030fbde30aa6mr5587262wro.15.1686667811912;
        Tue, 13 Jun 2023 07:50:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm15623356wro.95.2023.06.13.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:50:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 16:50:07 +0200
Subject: [PATCH v3 1/2] dt-bindings: usb: add ON Semiconductor nb7vpq904m
 Type-C Linear Redriver bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v3-1-988c560e2195@linaro.org>
References: <20230601-topic-sm8x50-upstream-redriver-v3-0-988c560e2195@linaro.org>
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v3-0-988c560e2195@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5081;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dL76UrfLBQ6NLFixzbwIYjFzKBYS7ny1GhYc6Sf8tJ4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiIIhT2X1Bg2vkPtm0JQliNDzKOZzKmpPFLoeCb78
 viEjDcSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIiCIQAKCRB33NvayMhJ0UjeEA
 CxEovMfrGwKn0dvnRH4ULuxbH7PNewLTQAfSH686l7zSKtyIpHNVdv8pRoFotpzm8uokoV1WH6B6Og
 K5OhXtqGWUmrIoc1YpYf2X/HQBpDvRofOMEU1/Y1sGQEBQjapqvx3MQ9A0JbMctJYyPoaKLZqcvvIW
 +4vt1HlZSpET4WjnjqKN2bFxJ1fNG0hCxVqzeCtuZeuJF0KUeNdLCUt82d414uZGW/AMBxoIyf2Wav
 opytsGYWfDDjGPZCVkhoKu+e3AVV8MIL6JdqfaAsQ8kz2zolRo+AcuiPunqM6D+/Tf3geKJRwv687V
 0sETLCJtHScuJm0y95QLE7i45fImmkYQaImc9mlp6YB8CK4V9hVIVXjVA68qeizJLliYf3mCXL3org
 C+6emuLdLxpeUSCdO28wHNhnI53fj6oe1nt2WtnDmkQauhwemgH1/lNZ8D1UIvCEM6OWpxXF96Hc+G
 cGQCca0IWq8IbLD7mABiLmF04m7TI6UEHjnZh0202mRuC9hkZiDS9y908v/dQQI2GNaxLMulfkftCP
 B7xfB3DZoPGcerIzZcSqsSiiT5zHzExbIJH6RLt3T/glS/O0fycZBvCzGIoDvyzcosCZDJPnHQT8PP
 RGyHWJ255xtmtgy+WFBpZqwY9j9hiGE9wGPIxlrnG4LHS9ZtVdEQvEge9ENA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..c0201da002f6
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
+  - Neil Armstrong <neil.armstrong@linaro.org>
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
+  retimer-switch:
+    description: Flag the port as possible handle of SuperSpeed signals retiming
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
+                      - const: 3
+                      - const: 2
+                      - const: 1
+                      - const: 0
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec-mux@32 {
+            compatible = "onnn,nb7vpq904m";
+            reg = <0x32>;
+
+            vcc-supply = <&vreg_l15b_1p8>;
+
+            retimer-switch;
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
+                        data-lanes = <3 2 1 0>;
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

