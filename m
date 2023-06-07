Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FED725671
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjFGHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbjFGHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:51:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E61FC4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:51:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30ae4ec1ac7so5381613f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686124277; x=1688716277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wH2CsCx7+x3Jzc+j/GbOX9j20blCsxJNxD0bmB92+8=;
        b=OBfIujyh18O3mL7vsnMlO2mgWpZvnFgGq/MUXcRKQkmYFcaFqiPTc3E/kpDNEr0Pxp
         PKxdouELfvGMFOMrhDlkWKuH2vcucIBd09LUabWtYQX+C8LXfnEt/eJLEGNg+n0CCcT1
         G1FPhOF9rRURKG2ukjk/bC0mm0o/umxWmmrpB1MOHuLTXqs9VLzoXtMjqCtWDs/5SK++
         4MtLKTwNRTEYzsht0Cm8p5FEPKal5ukFdxXeNqVSgfbvIqkYrPlsGwa/M4cOZfG4CMtD
         Z114sm7NO24k9RLIZ1l3VcU1cW+LxBjP8769VqXQ9vD7egqGEOxStYSRpkGCchLwECAK
         FuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686124277; x=1688716277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wH2CsCx7+x3Jzc+j/GbOX9j20blCsxJNxD0bmB92+8=;
        b=dzLwrnlKVNj4jsNtrbqz926pwK8aYopSgS60goG5ovI08TyR8pKT5qu3GrgJ4uT+q5
         k1RA/uEPazKjuQdXffpIMO3KcYtGLxWP2PAmXCQXKL9bRYvXYCT//dW/qXrSM663Fzrt
         vMaStKGx2AVuujvmRl5yDYkdlu7sUcCkyCxouO1HGQELrCiIRBAzwiE4GqNpCXMRwp9e
         vzg63P3uaHivBnnSlCo3tBmouYq/v1JyMMlR/zTuUybJ7SoeWASh4/ygCsKP0gOXjxkb
         n94urk5Tp0LOqP1qFuYj50pATmZQuIbeWcP9c6k/xmpWnCQUglEatssDJ9Uz4WT9rmGY
         Asgw==
X-Gm-Message-State: AC+VfDwbq43Y4aeYpoeumGS7cbLdhKBpPXvs0Tkg9xqZbY77zr9ma+kG
        HpzqT7Tm6LF45fOVWMD3OB2Mjg==
X-Google-Smtp-Source: ACHHUZ5ZtciLNxjANuiXgV8OlpxPRyEhgCFqfmg8seNacnBXdMj12D39FogGzfALUZ9iMsB9EeRlNw==
X-Received: by 2002:a5d:4644:0:b0:30e:5efb:a108 with SMTP id j4-20020a5d4644000000b0030e5efba108mr37059wrs.12.1686124277232;
        Wed, 07 Jun 2023 00:51:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d5689000000b0030ae93bd196sm14726343wrv.21.2023.06.07.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:51:16 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 09:51:08 +0200
Subject: [PATCH v2 1/2] dt-bindings: usb: add ON Semiconductor nb7vpq904m
 Type-C Linear Redriver bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v2-1-dda89b22b1c0@linaro.org>
References: <20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org>
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDbyBi/Xfa22T+YfafsRskj31TBgis2b89l/XfvL
 EHpVmxGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA28gAKCRB33NvayMhJ0e6qEA
 CmRmmQdxTSmMoWxCHS5EO0Zho1XFdstILrTuy7zsfmszJWAEXl+WLEp6NLW4TsikJ6WZ8lN8yZVGAr
 OuGwYECJLjcqD6LTm4m/E8W7FDIjrzuUtk6cCQSnDAaK0uf8KPtEyMqiYDgTyhSgcd7PBjL1uZTPFR
 ZB9aCyDPto4bmoAvJUokh8sJMkHO04QjITBMfsaC1EcQtiUtYnNgstcCcIp7Lhdg+qqmd1GBUAyLBq
 gmmeQ58TK+gwVeqydy+oCqr2zm44HeChOjUPZTQs1bMlL+rlTNhqm3zXygDUhv/OJ82aykVuaidw/P
 diYWZR6ubJ7GToJhuD/ImMbqFi01QSMh/c4+kgEOfXaIuibMtsz1D/X05GssOSNzWyFy5/wgN4G17a
 0rr3SLeZdSQLOvXjsUGAvMVJgq6EysVDLZntwgCqi554JSa6I9/tnf7JwM9X/MvKMOE/hLBgWwwHPf
 vIAt1a/+Q/Plp7dxZHHplDbaygyekHqd58hMHkWVDzEE6Z/o5UFJXS1qGP0gjehrFZN7Aibmhtzh/4
 L/O1wwPnoK7exGCmGzXsrgom8e/k0RC9tZ4kgk9RKHkcRsYCsBvwcNFvLZ7wdkbDW4bumMZyoPcBB0
 oRvX/txA5G1JH4amfT4KzR84m0xVG8MrVLyMKEPRsw78HHhwgsLQ8PqjMxjw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

