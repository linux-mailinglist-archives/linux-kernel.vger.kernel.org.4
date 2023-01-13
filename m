Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B07669234
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbjAMJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbjAMJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:03:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39525C4;
        Fri, 13 Jan 2023 01:03:31 -0800 (PST)
X-UUID: 2297fb42932111eda06fc9ecc4dadd91-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jVSBXePscyAR1IBlhg2abs0nVfWiz7yFEJuZRdMiMP0=;
        b=OBOJPha4toR9CUWbgq8gA0h/WwUZeA8ZrJHbJ+Ji49lg2t8SEsTTVcwKyazGIvp2hAQcS6WDFQm0zU+PEMlbHq0iTMQzwYYeFfeuBOH97iyEbG+n8A7goMxFbjS37H2XPzuu9a58bom5U2rMB8vsx2Bqbh0uA/LneBLV6UQd+74=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.17,REQID:43e17f74-413a-44af-ae78-58525cb6af7e,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:115
X-CID-INFO: VERSION:1.1.17,REQID:43e17f74-413a-44af-ae78-58525cb6af7e,IP:0,URL
        :25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:115
X-CID-META: VersionHash:543e81c,CLOUDID:0a74baf5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230113170325BIMKJSRP,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:12,Malicious:0
X-CID-BVR: 0
X-UUID: 2297fb42932111eda06fc9ecc4dadd91-20230113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1889227801; Fri, 13 Jan 2023 17:03:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 13 Jan 2023 17:03:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 17:03:22 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v3 01/13] dt-binding: mediatek: add bindings for MediaTek mt8195 MDP3 components
Date:   Fri, 13 Jan 2023 17:03:09 +0800
Message-ID: <20230113090321.25128-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113090321.25128-1-moudy.ho@mediatek.com>
References: <20230113090321.25128-1-moudy.ho@mediatek.com>
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
 .../bindings/media/mediatek,mdp3-aal.yaml     | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-color.yaml   | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-fg.yaml      | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-hdr.yaml     | 62 +++++++++++++++
 .../bindings/media/mediatek,mdp3-merge.yaml   | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-ovl.yaml     | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-pad.yaml     | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 30 +++++---
 .../bindings/media/mediatek,mdp3-rsz.yaml     | 11 ++-
 .../bindings/media/mediatek,mdp3-split.yaml   | 75 +++++++++++++++++++
 .../bindings/media/mediatek,mdp3-stitch.yaml  | 63 ++++++++++++++++
 .../bindings/media/mediatek,mdp3-tcc.yaml     | 62 +++++++++++++++
 .../bindings/media/mediatek,mdp3-tdshp.yaml   | 63 ++++++++++++++++
 13 files changed, 731 insertions(+), 13 deletions(-)
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
index 000000000000..d2e1b5245778
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-aal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 AAL
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-aal";
+        reg = <0x14005000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
new file mode 100644
index 000000000000..1d8aa5dc76b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-color.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 COLOR
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-color";
+        reg = <0x14008000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x8000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_COLOR>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
new file mode 100644
index 000000000000..4e7dd18dc5ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 FG
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-fg";
+        reg = <0x14002000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x2000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_FG>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
new file mode 100644
index 000000000000..6a2486b420c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-hdr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 HDR
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-hdr";
+        reg = <0x14004000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x4000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_HDR>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
new file mode 100644
index 000000000000..e561f43aea65
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-merge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 MERGE
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-merge";
+        reg = <0x14f1a000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xa000 0x1000>;
+        clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_MERGE>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
new file mode 100644
index 000000000000..5d0e7f44339b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-ovl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 OVL
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-ovl";
+        reg = <0x14009000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x9000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_OVL>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
new file mode 100644
index 000000000000..6041e3d27f73
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-pad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 PADDING
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-pad";
+        reg = <0x1400a000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xa000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_PADDING>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index 9cfc0c7d23e0..4917dc8132a0 100644
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
@@ -46,20 +47,28 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   power-domains:
-    maxItems: 1
+    oneOf:
+      - items:
+          - description: for RDMA
+      - items:
+          - description: for vppsys 0
+          - description: for vppsys 1
 
   clocks:
-    items:
-      - description: RDMA clock
-      - description: RSZ clock
+    minItems: 2
+    maxItems: 19
 
   iommus:
-    maxItems: 1
+    oneOf:
+      - items:
+          - description: RDMA port
+      - items:
+          - description: RDMA port
+          - description: RDMA to WROT DL port
 
   mboxes:
-    items:
-      - description: used for 1st data pipe from RDMA
-      - description: used for 2nd data pipe from RDMA
+    minItems: 1
+    maxItems: 5
 
 required:
   - compatible
@@ -69,7 +78,6 @@ required:
   - power-domains
   - clocks
   - iommus
-  - mboxes
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
index 78f9de6192ef..fd7f495c2a43 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
@@ -42,13 +42,20 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   clocks:
-    minItems: 1
+    oneOf:
+      - items:
+          - description: rsz clock
+      - items:
+          - description: rsz clock
+          - description: the blended component's clock
+
+  power-domains:
+    maxItems: 1
 
 required:
   - compatible
   - reg
   - mediatek,gce-client-reg
-  - mediatek,gce-events
   - clocks
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
new file mode 100644
index 000000000000..fc9c85334af2
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-split.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 SPLIT
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-split";
+        reg = <0x14f06000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x6000 0x1000>;
+        clocks = <&vppsys1 CLK_VPP1_VPP_SPLIT>,
+                 <&vppsys1 CLK_VPP1_HDMI_META>,
+                 <&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>,
+                 <&vppsys1 CLK_VPP1_DGI_IN>,
+                 <&vppsys1 CLK_VPP1_DGI_OUT>,
+                 <&vppsys1 CLK_VPP1_VPP_SPLIT_DGI>,
+                 <&vppsys1 CLK_VPP1_VPP_SPLIT_26M>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
new file mode 100644
index 000000000000..234d80873543
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-stitch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 STITCH
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-stitch";
+        reg = <0x14003000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x3000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_STITCH>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
new file mode 100644
index 000000000000..60acc00fb10f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-tcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 TCC
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-tcc";
+        reg = <0x1400b000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xb000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_TCC>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
new file mode 100644
index 000000000000..d2bc99ead190
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-tdshp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 TDSHP
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
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
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+        compatible = "mediatek,mt8195-mdp3-tdshp";
+        reg = <0x14007000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x7000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_TDSHP>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+    };
-- 
2.18.0

