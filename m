Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962773156D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbjFOKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbjFOKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:33:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515382729
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:33:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso14972145e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686825180; x=1689417180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJvOPxAjR38vBjma/GW/csS5Z/Q1Th4hIj7rOuZ5OGw=;
        b=zG9NaLzvXZ/+pZZ4/uCzxJ9pDCOGl2JeG6p317ITLdr2F+ku3FFwx1BoLvlVm6PUe+
         NbvPkTE0Mwve+vhiP7xsHpDdOo7nR+m939RtELltUO+48FA4BGijFFFLKY9rQKrvHtxS
         DCCD78qW6mgdaJYsSVj0wSPr4s7fAelTAD8Xqg3uZspFteMVmCgGO0lxm5s88PqGuIzb
         9+k6KZp+ecPm42HkfU8IPhA6vvlZZCZdmAVMGZ3RqixLLMZDTILys3tAHisoveC9lr1X
         LdLAHACsoXY36S5+GrsHubsUQlUk5Xfl7BgFjPpm8/Ae0G2uaGz1vDTHSS8koUwJ9nGF
         iBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825180; x=1689417180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJvOPxAjR38vBjma/GW/csS5Z/Q1Th4hIj7rOuZ5OGw=;
        b=PwykhyjuNJdjD77sbPP7bafDAWZG0HJJxSMzUpvBCTI5Qi1gFDAhj82NZzLDwCY/o0
         9MrDK3cLMotaVOalVwa/RulvJiVOraaLFnwPgadtS4ANUrdDoU5NldDd51Q8Sw8rIgi1
         ge5wotm9j3AbUUP8FpbUlJWGTxlgwk645oaT3af4MNNr1Durzlv+o582/6EIaS2EUFjv
         UkouE6H2iWmhonh8+KDpvzCi2oj6OsJ79AMnpzp8qs7F/GLfcxSk/IFSE9kdxcOO4SgU
         lcOuRnprp146O/TqKBEXv0Hr2pzf+hlC2gm5d5H9ouis5UQ2ghzQCpFGcmdEIvKlNEVz
         oF1w==
X-Gm-Message-State: AC+VfDzpXdXFobpFpHxq/iygh66MpMhueJGe29C7rSwbQBRtWIwVZ46u
        PKUqp03Mn28IJBbU2u6Eypel0g==
X-Google-Smtp-Source: ACHHUZ5w//+IxbJ8O+04MRcFXmh/4+gSMSCZOuFh8/0HDYOw9YCJjGIR2loTbFyPsrXBjdUHpPDHxQ==
X-Received: by 2002:a05:600c:590:b0:3f8:c59d:b070 with SMTP id o16-20020a05600c059000b003f8c59db070mr5492205wmd.7.1686825179621;
        Thu, 15 Jun 2023 03:32:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f17848673fsm20072088wmj.27.2023.06.15.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:32:59 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 15 Jun 2023 12:32:54 +0200
Subject: [PATCH v4 1/2] dt-bindings: usb: add ON Semiconductor nb7vpq904m
 Type-C Linear Redriver bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v4-1-91d5820f3a03@linaro.org>
References: <20230601-topic-sm8x50-upstream-redriver-v4-0-91d5820f3a03@linaro.org>
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v4-0-91d5820f3a03@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5148;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ph3hROfPhcjdps4g1mBQh06R3XwNzhjRa/ksWVEUQ6A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiujYCOGJjDRGtKiaShce0hlqZw2Si7mEjZSxT+KL
 OgQMqRqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIro2AAKCRB33NvayMhJ0Qw0D/
 4+cNMyLWBYEEvG1U9jjloHhwSGGEQDBd2nB1rRCbz+o0mCryfJiNhWnWtwuYz+lxvP1MD1diueQVqK
 wzizEIQhAIpdqcekWtbAZaf733DFOd7I9n2FTBxNUlKm7eS4lNJr9Y4JTZMo07X9YCNiMyjqDz28hN
 6HAwjrb6oAxB+P2VXktdgUjib/wh9auNeuTd4u5AirvRLuBgROZnw3ONbeZSwRJG6KpUlStfRSxIZh
 R7QSPeiVcyF75C/yggYaR0vUOZY/pBqsNkhSjsIOUS6WgTJquaf3lapmoiqdeBzYgP52DmCM020urz
 QFMwkIbB11pVXOPZttGerv1hmHa5tmB1EaHguUNjmBVbhMRhsEZWGdWlleJTltos5BIPqjy2S3FelT
 ctvy5RRi7CkQJF40fOTdSjAxKGa14rDsoTHaAm7yu4ws/2hjVCqlcOm8US7uLYhlszlHhZw2+VZ/4R
 cBGSBERMlyz/SE58XEgA+NF+SRx9EFF7VafBLyZovpl+3AAljKP6eIi0DylX7Hr+QSH5DQB/N0j+ef
 wDGAD1IymXvcBkU69w3yMuonGNDBMN9AzOvwv0oBopqfxuPt67WKNdotJi6g4rPpwpgJfQHhfIXFzG
 DV/WcqXTxwXz3t4zR5bU1KjcH8x/pBhXD2ikC8Z44GdlDcHdqZXsltl3lPUg==
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

