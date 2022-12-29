Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E732A658D29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiL2Ncs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiL2NcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:32:19 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943311157;
        Thu, 29 Dec 2022 05:32:17 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id BEE2AFF804;
        Thu, 29 Dec 2022 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672320735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYFhpIFJiKUL0dNC7iOtUPI3WT1NHiJuQjKvEVnXtFQ=;
        b=BUQVqSI1muywST3IF1vYmQ/z5dZlPmdeRrE50exL+Y5Dwkz9Wd0A636GK+wlhQXTKFU/Uo
        JAqnyqGBBE31PvB+ugqmqoCiq1dcD1FbWdXK0goe4vWFqXFQFzuGxlVJ3kt9Hn66v6I3Au
        taMbHJUeCKjRUZ4UotvUrSl8sONKog/TzBEi1APHlx3u1F+/JYFWeJKmJgpL5vJ7PLwJMe
        SnUkv8JTO770db1jQcQ8Jsh1Q8gtSE3mvKs3S1VDrkmWpqfGJUFoJ/wTDJLVwkRSpAmRYb
        HX5Pu5QV19+U8T/hCVOERdTzDMTRgDTcFddN6AJna959iYWukgKu9xE7Jq3wQA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v3 01/21] dt-bindings: display: tegra: add Tegra20 VIP
Date:   Thu, 29 Dec 2022 14:31:45 +0100
Message-Id: <20221229133205.981397-2-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
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

VIP is the parallel video capture component within the video input
subsystem of Tegra20 (and other Tegra chips, apparently).

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v3:
 - remove channel@0 node (Krzysztof, Rob, Dmitry)
 - add myself as a maintainer of the whole Tegra video driver (Dmitry)

Changed in v2 (suggested by Krzysztof Kozlowski):
 - remove redundant "bindings" from subject line
 - remove $nodename
 - add channel@0 description
 - add reg: const: 0
---
 .../display/tegra/nvidia,tegra20-vip.yaml     | 49 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
new file mode 100644
index 000000000000..c23fd02dd18e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
@@ -0,0 +1,49 @@
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
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port receiving the video stream from the sensor
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port sending the video stream to the VI
+
+    required:
+      - port@0
+      - port@1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ports
+
+# see nvidia,tegra20-vi.yaml for an example
diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..4feb2e1258ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20563,10 +20563,12 @@ TEGRA VIDEO DRIVER
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Jonathan Hunter <jonathanh@nvidia.com>
 M:	Sowjanya Komatineni <skomatineni@nvidia.com>
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 L:	linux-media@vger.kernel.org
 L:	linux-tegra@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
 F:	drivers/staging/media/tegra-video/
 
 TEGRA XUSB PADCTL DRIVER
-- 
2.34.1

