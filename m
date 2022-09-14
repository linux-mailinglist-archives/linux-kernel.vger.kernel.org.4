Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2ED5B8885
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiINMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiINMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:46:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C747969E;
        Wed, 14 Sep 2022 05:45:59 -0700 (PDT)
X-UUID: 490d2d4d0cf043c5b3f2b2624bdf58ee-20220914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1WJfzgGyc/RdkhB8YoMvTc7KpSrhJc6zReOlwA2QmYY=;
        b=jZY5xXyMKWPxY1DQW1/FtpDb8gj18U8hbUtXzmj2MhOlpUqhqjAHaqpKVDoYytzzu46HH79yVVXyaf661qdhI/qlw5dQrNjtEO2lI4F8EaQ77nYXJ+fNw/tHlmqwoEKxnTtEvLDgRsmvwwtJb/CLcCywUzwwDqmwE6sxhyAa2OY=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.11,REQID:a3c33b73-d23b-4cac-903b-3f4730362522,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,ACT
        ION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.11,REQID:a3c33b73-d23b-4cac-903b-3f4730362522,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:120
X-CID-META: VersionHash:39a5ff1,CLOUDID:91ae6bec-2856-4fce-b125-09d4c7ebe045,B
        ulkID:220914204556VWXQQ3R7,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 490d2d4d0cf043c5b3f2b2624bdf58ee-20220914
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 43009186; Wed, 14 Sep 2022 20:45:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 14 Sep 2022 20:45:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Sep 2022 20:45:53 +0800
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
Subject: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency hopping
Date:   Wed, 14 Sep 2022 20:45:50 +0800
Message-ID: <20220914124552.16964-3-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220914124552.16964-1-johnson.wang@mediatek.com>
References: <20220914124552.16964-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../bindings/arm/mediatek/mediatek,fhctl.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
new file mode 100644
index 000000000000..7b0fd0889bb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
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
+
+  mediatek,hopping-ssc-percents:
+    description: The percentage of spread spectrum clocking for one PLL.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 8
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
+        reg = <0x1000c000 0xe00>;
+        clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
+        mediatek,hopping-ssc-percents = <3>;
+    };
-- 
2.18.0

