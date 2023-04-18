Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2CC6E5B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjDRIBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjDRIB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:01:27 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FB6E82;
        Tue, 18 Apr 2023 01:01:12 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E2758240008;
        Tue, 18 Apr 2023 08:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KUWvGYikatFyyoz0R9fUwy3FH2dfnuJpHoufok0Upc=;
        b=KMKSV/hpssetkSA9DSlp2h/+T8gLtAkR4PiCPjWV8Q5A8rfTd5n+fzGuGA2sZT7WW4wOep
        3rdeXAGGHXAjkxACULVhomVslIz2auUnbyC49XTV17u73XX991uZU+YNOHd1VkT3jv1J/8
        rzfXx+9szN8l7JxjcFCeDVccc6ok1ptf/2kUk59rd88TxQdNCKz/OMUXA6NNK9KI5rtnaC
        h9CadxaW7tc/N2QmBm6aSdZFj+gVoU1i6Pq+F8NP7RtoS751oZP64UEYbaKtzfkTjEL5EE
        fJYK0q9kxrJmlU9+MXpHhThJf9egPYZ7Ny2Nt97RJxeL/EF2oRHHchxyHtAFKw==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 02/20] dt-bindings: display: tegra: vi: add 'vip' property and example
Date:   Tue, 18 Apr 2023 10:00:36 +0200
Message-Id: <20230418080054.452955-3-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra20 VI peripheral can receive parallel input from the VIP parallel
input module. Add it to the allowed properties and augment the existing
nvidia,tegra20-vi example to show a 'vip' property.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

No changes in v6
No changes in v5

Changed in RESEND,v4:
 - Add Reviewed-by: Rob Herring <robh@kernel.org>

Changed in v4:
 - complete the removal of 'channel@0'

Changed in v3 (suggested by Rob Herring):
 - drop 'endpoint', unneeded as there's no extra properties in the
   endpoints

Changed in v2 (suggested by Krzysztof Kozlowski):
 - rename "i2c3" -> "ic2"
 - add review tag
---
 .../display/tegra/nvidia,tegra20-vi.yaml      | 59 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
index a42bf33d1e7d..2181855a0920 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
@@ -73,6 +73,18 @@ properties:
   avdd-dsi-csi-supply:
     description: DSI/CSI power supply. Must supply 1.2 V.
 
+  vip:
+    $ref: /schemas/display/tegra/nvidia,tegra20-vip.yaml
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input from the VIP (parallel input capture) module
+
 patternProperties:
   "^csi@[0-9a-f]+$":
     type: object
@@ -108,6 +120,22 @@ examples:
     #include <dt-bindings/clock/tegra20-car.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        camera@48 {
+            compatible = "aptina,mt9v111";
+            reg = <0x48>;
+            clocks = <&camera_clk>;
+
+            port {
+                mt9v111_out: endpoint {
+                    remote-endpoint = <&vi_vip_in>;
+                };
+            };
+        };
+    };
+
     vi@54080000 {
         compatible = "nvidia,tegra20-vi";
         reg = <0x54080000 0x00040000>;
@@ -115,6 +143,37 @@ examples:
         clocks = <&tegra_car TEGRA20_CLK_VI>;
         resets = <&tegra_car 100>;
         reset-names = "vi";
+
+        vip {
+            compatible = "nvidia,tegra20-vip";
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    vi_vip_in: endpoint {
+                        remote-endpoint = <&mt9v111_out>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    vi_vip_out: endpoint {
+                        remote-endpoint = <&vi_in>;
+                    };
+                };
+            };
+        };
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                vi_in: endpoint {
+                    remote-endpoint = <&vi_vip_out>;
+                };
+            };
+        };
     };
 
   - |
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d8b0aa8e009..90594131be4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20615,6 +20615,7 @@ L:	linux-media@vger.kernel.org
 L:	linux-tegra@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
 F:	drivers/staging/media/tegra-video/
 
-- 
2.34.1

