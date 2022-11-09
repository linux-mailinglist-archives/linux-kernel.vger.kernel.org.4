Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D4622D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKIOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKIOTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:19:21 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082191C92C;
        Wed,  9 Nov 2022 06:19:19 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id F16C5FF807;
        Wed,  9 Nov 2022 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8rIUrLhA+Lys0DpzxE+dR11SBu/CxJni8I2xKpyyL0=;
        b=LNvLhUNmruqY3aFYVWygJ5mj7BGfU3/OFjXHcwjsKMkpX23BVk/O87yGy6QTFckRxkzWB+
        fnDY3VSanqka07MED0xdqZzF5AubTy8tGiCDXYJDI7AufVWTtdZ9g3Jn3A/08sQm9M3Xzh
        OnqxDPjP6cYu4jF75ihgrIsliIaPSbYLfsuJwIMFn8t4ln/iP300IOeapxnqJm3QUjrdwt
        8s2oh6e5I2agyeADPzhaqRDvY7DX6atDnjEDU6+SQG9T0whHq5mXlNHtUizxy7fA1naL9m
        BjDiI6M2Ryk38vv6J5+U8v/509v81Jv9acb/dhc/ugl3UDQYX0Fk0SaYvLl3rA==
From:   luca.ceresoli@bootlin.com
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 01/23] dt-bindings: display: tegra: add bindings for Tegra20 VIP
Date:   Wed,  9 Nov 2022 15:18:30 +0100
Message-Id: <20221109141852.729246-2-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

VIP is the parallel video capture component within the video input
subsystem of Tegra20 (and other Tegra chips, apparently).

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../display/tegra/nvidia,tegra20-vip.yaml     | 64 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
new file mode 100644
index 000000000000..934dabfd2307
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-vip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra VIP (parallel video capture) controller
+
+maintainers:
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
+
+properties:
+  $nodename:
+    const: vip
+
+  compatible:
+    enum:
+      - nvidia,tegra20-vip
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  channel@0:
+    type: object
+
+    properties:
+      reg: true
+
+      ports:
+        $ref: /schemas/graph.yaml#/properties/ports
+
+        properties:
+          port@0:
+            $ref: /schemas/graph.yaml#/properties/port
+            description:
+              Port receiving the video stream from the sensor
+
+          port@1:
+            $ref: /schemas/graph.yaml#/properties/port
+            description:
+              Port sending the video stream to the VI
+
+        required:
+          - port@0
+          - port@1
+
+    additionalProperties: false
+
+    required:
+      - reg
+      - ports
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - channel@0
+
+# see nvidia,tegra20-vi.yaml for an example
diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97f..b43f6f4e8ccf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20279,6 +20279,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
 F:	drivers/staging/media/tegra-video/
 
+TEGRA VIDEO DRIVER FOR TEGRA20 VIP (PARALLEL VIDEO CAPTURE)
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+L:	linux-media@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
+
 TEGRA XUSB PADCTL DRIVER
 M:	JC Kuo <jckuo@nvidia.com>
 S:	Supported
-- 
2.34.1

