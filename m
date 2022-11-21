Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08136632211
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKUMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiKUMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:30:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C816121264;
        Mon, 21 Nov 2022 04:30:08 -0800 (PST)
X-UUID: 561be8b00c1947edad2e3c687d520082-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=chwOzhzqZetC3MhgqfNY3NF6RywTjwGetB7f0sa8uTc=;
        b=lLYZivN2/S1nwx6oLSNyIpCcHWdfX8tjwWhMlfJNySMOA/FgVxDqznoVDSFFTm7qgKQjZzU23gn1yoUDtSnpb2XznPH4lo+fI5T+BU+Qhx5s+QxuTj/dezU2+GzMJzzHeIN2GK8fk8ftt9KrrV5ARYb0P3vsLVy4AWq9sczM2GI=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.13,REQID:418dd751-eaec-42b1-a089-306f342d4e48,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,ACT
        ION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.13,REQID:418dd751-eaec-42b1-a089-306f342d4e48,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:120
X-CID-META: VersionHash:d12e911,CLOUDID:c01f622f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121203003XVC9FD9T,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 561be8b00c1947edad2e3c687d520082-20221121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1580543132; Mon, 21 Nov 2022 20:30:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 20:29:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 20:29:59 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: [PATCH v5 2/4] dt-bindings: clock: mediatek: Add new bindings of MediaTek frequency hopping
Date:   Mon, 21 Nov 2022 20:29:55 +0800
Message-ID: <20221121122957.21611-3-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221121122957.21611-1-johnson.wang@mediatek.com>
References: <20221121122957.21611-1-johnson.wang@mediatek.com>
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

Add the new binding documentation for MediaTek frequency hopping
and spread spectrum clocking control.

Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/mediatek,mt8186-fhctl.yaml | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
new file mode 100644
index 000000000000..cfd042ac1e14
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8186-fhctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek frequency hopping and spread spectrum clocking control
+
+maintainers:
+  - Edward-JW Yang <edward-jw.yang@mediatek.com>
+
+description: |
+  Frequency hopping control (FHCTL) is a piece of hardware that control
+  some PLLs to adopt "hopping" mechanism to adjust their frequency.
+  Spread spectrum clocking (SSC) is another function provided by this hardware.
+
+properties:
+  compatible:
+    const: mediatek,mt8186-fhctl
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Phandles of the PLL with FHCTL hardware capability.
+    minItems: 1
+    maxItems: 30
+
+  mediatek,hopping-ssc-percent:
+    description: The percentage of spread spectrum clocking for one PLL.
+    minItems: 1
+    maxItems: 30
+    items:
+      default: 0
+      minimum: 0
+      maximum: 8
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8186-clk.h>
+    fhctl: fhctl@1000ce00 {
+        compatible = "mediatek,mt8186-fhctl";
+        reg = <0x1000ce00 0x200>;
+        clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
+        mediatek,hopping-ssc-percent = <3>;
+    };
-- 
2.18.0

