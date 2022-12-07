Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316136455B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLGIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:44:51 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEEC31FA2;
        Wed,  7 Dec 2022 00:44:23 -0800 (PST)
X-UUID: 63e2dfc65d8f4c9dbec735ab57c026bd-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K4KyRbv9cRU2Q5uuf1kOVGvmfEK3c5rT8jaFT3bGCaY=;
        b=d9OqdMXhCq3PJsdn6v5cMFvCgwPF8lGvLvfHObnIEyBiYxVtUS344x6+YgV+7JmfEv5mWpQphdp141iwKPLG38xywiV7vBnub3/L14Ud3OXrAQYizwAJpEOK3etI43Qq6JJcdK2vla7eJDOu0IVlPnvESrCmEGIveXwv9knah38=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a003220a-53d8-4215-a678-569d03718493,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:dcaaed0,CLOUDID:c0c6e5d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 63e2dfc65d8f4c9dbec735ab57c026bd-20221207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 211861153; Wed, 07 Dec 2022 16:44:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 16:44:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 16:44:13 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v2 01/12] dt-binding: mediatek: add bindings for MediaTek 8195 MDP3 components
Date:   Wed, 7 Dec 2022 16:44:01 +0800
Message-ID: <20221207084412.14075-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221207084412.14075-1-moudy.ho@mediatek.com>
References: <20221207084412.14075-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for MT8195 MDP3 RDMA, and introduce more
MDP3 components present in MT8195.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../bindings/media/mediatek,mdp3-aal.yaml     | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-color.yaml   | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-fg.yaml      | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-hdr.yaml     | 63 +++++++++++++++
 .../bindings/media/mediatek,mdp3-merge.yaml   | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-ovl.yaml     | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-pad.yaml     | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-rdma.yaml    |  5 +-
 .../bindings/media/mediatek,mdp3-split.yaml   | 76 +++++++++++++++++++
 .../bindings/media/mediatek,mdp3-stitch.yaml  | 64 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-tcc.yaml     | 63 +++++++++++++++
 .../bindings/media/mediatek,mdp3-tdshp.yaml   | 64 ++++++++++++++++
 12 files changed, 717 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
new file mode 100644
index 000000000000..5b59e0802357
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-aal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 AAL Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components is responsible for backlight
+  power saving and sunlight visibility improving.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-aal
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-aal0@14005000 {
+      compatible = "mediatek,mt8195-mdp3-aal";
+      reg = <0x14005000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
new file mode 100644
index 000000000000..7a34d8af11a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-color.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 COLOR Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to adjust hue, luma and
+  saturation to get better picture quality.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-color
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-color0@14008000 {
+      compatible = "mediatek,mt8195-mdp3-color";
+      reg = <0x14008000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x8000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_COLOR>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
new file mode 100644
index 000000000000..1e17b3908d3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 FG Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to add film grain
+  according to AV1 spec.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-fg
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-fg0@14002000 {
+      compatible = "mediatek,mt8195-mdp3-fg";
+      reg = <0x14002000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x2000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_FG>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
new file mode 100644
index 000000000000..ad27f60e5825
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-hdr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 HDR Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to perform HDR to SDR
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-hdr
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-hdr0@14004000 {
+      compatible = "mediatek,mt8195-mdp3-hdr";
+      reg = <0x14004000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x4000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_HDR>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
new file mode 100644
index 000000000000..4e0ef4a9f77d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-merge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 MERGE Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to merge
+  two slice-per-line inputs into one side-by-side output.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-merge
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-merge0@14f1a000 {
+      compatible = "mediatek,mt8195-mdp3-merge";
+      reg = <0x14f1a000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xa000 0x1000>;
+      clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_MERGE>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
new file mode 100644
index 000000000000..388e6dbab1e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-ovl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 OVL Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to perform
+  alpha blending from the memory.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-ovl
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-ovl0@14009000 {
+      compatible = "mediatek,mt8195-mdp3-ovl";
+      reg = <0x14009000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x9000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_OVL>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
new file mode 100644
index 000000000000..a66b1dcb7d43
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-pad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 PADDING Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to insert
+  pre-defined color or alpha value to arbitrary side of image.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-pad
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-pad0@1400a000 {
+      compatible = "mediatek,mt8195-mdp3-pad";
+      reg = <0x1400a000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xa000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_PADDING>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index 9cfc0c7d23e0..7fe9ed62aadf 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -20,8 +20,9 @@ description: |
 
 properties:
   compatible:
-    items:
-      - const: mediatek,mt8183-mdp3-rdma
+    enum:
+      - mediatek,mt8183-mdp3-rdma
+      - mediatek,mt8195-mdp3-rdma
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
new file mode 100644
index 000000000000..25824a0ace75
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-split.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 SPLIT Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to split hdmi rx into two stream
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-split
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    items:
+      - description: Engine Clock
+      - description: HDMI Clock
+      - description: MDHI Clock
+      - description: Digital Clock
+      - description: Digital Clock
+      - description: Digital Clock
+      - description: HS Clock
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-split0@14f06000 {
+      compatible = "mediatek,mt8195-mdp3-split";
+      reg = <0x14f06000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x6000 0x1000>;
+      clocks = <&vppsys1 CLK_VPP1_VPP_SPLIT>,
+               <&vppsys1 CLK_VPP1_HDMI_META>,
+               <&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>,
+               <&vppsys1 CLK_VPP1_DGI_IN>,
+               <&vppsys1 CLK_VPP1_DGI_OUT>,
+               <&vppsys1 CLK_VPP1_VPP_SPLIT_DGI>,
+               <&vppsys1 CLK_VPP1_VPP_SPLIT_26M>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
new file mode 100644
index 000000000000..6bf15a65047e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-stitch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 STITCH Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to combine multiple video frame
+  with overlapping fields of view to produce a segmented panorame.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-stitch
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-stich0@14003000 {
+      compatible = "mediatek,mt8195-mdp3-stitch";
+      reg = <0x14003000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x3000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_STITCH>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
new file mode 100644
index 000000000000..396cdf1e94e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-tcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 TCC Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to support
+  HDR gamma curve conversion HDR displays.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-tcc
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-tcc0@1400b000 {
+      compatible = "mediatek,mt8195-mdp3-tcc";
+      reg = <0x1400b000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xb000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_TCC>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
new file mode 100644
index 000000000000..90ce0c5ea151
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-tdshp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 TDSHP Device Tree Bindings
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to improve image
+  sharpness and contrast.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-tdshp
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property. Each GCE subsys id is mapping to
+      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    mdp3-tdshp0@14007000 {
+      compatible = "mediatek,mt8195-mdp3-tdshp";
+      reg = <0x14007000 0x1000>;
+      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x7000 0x1000>;
+      clocks = <&vppsys0 CLK_VPP0_MDP_TDSHP>;
+      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
-- 
2.18.0

