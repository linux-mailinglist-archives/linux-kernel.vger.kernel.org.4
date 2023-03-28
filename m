Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532DE6CB409
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjC1C2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjC1C2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:28:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E019A0;
        Mon, 27 Mar 2023 19:28:02 -0700 (PDT)
X-UUID: 2648fca4cd1011eda9a90f0bb45854f4-20230328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=X5BMOUCftBqUoS89OY1vJghk0U8zsFcVshTFWmsRm4E=;
        b=Te6hZgZxmE+9ZlNp0EIBpyaoKkkJx2zzUlGOalF4wWVQYjNnDSgF4DKtv/RTrO+iW5U9SRvAjmsb+I5wwWsItxEffFumVsz+KdLsQHABJMOLUmGJf36IkKZ8YPzF2HgOo6rOhaPw9MlC6dfNEWpklEWAdobHp8agJFTQ7JBxBJQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8cccf62e-6d00-4d0a-b45c-672bcf2be83e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:8cccf62e-6d00-4d0a-b45c-672bcf2be83e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:94e98db4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:23032810275947VRII9Y,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2648fca4cd1011eda9a90f0bb45854f4-20230328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1933316158; Tue, 28 Mar 2023 10:27:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 28 Mar 2023 10:27:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 28 Mar 2023 10:27:54 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v9 01/11] dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode definition
Date:   Tue, 28 Mar 2023 10:27:23 +0800
Message-ID: <20230328022733.29910-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230328022733.29910-1-tinghan.shen@mediatek.com>
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the definition of the rpmsg subnode by
assigning a distinct node name and adding the
definition source of node properties.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/remoteproc/mtk,scp.yaml          | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 895415772d1d..271081df0e46 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -58,6 +58,18 @@ properties:
   memory-region:
     maxItems: 1
 
+  cros-ec-rpmsg:
+    $ref: /schemas/mfd/google,cros-ec.yaml
+    description:
+      This subnode represents the rpmsg device. The properties
+      of this node are defined by the individual bindings for
+      the rpmsg devices.
+
+    required:
+      - mediatek,rpmsg-name
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -89,21 +101,7 @@ allOf:
         reg-names:
           maxItems: 2
 
-additionalProperties:
-  type: object
-  description:
-    Subnodes of the SCP represent rpmsg devices. The names of the devices
-    are not important. The properties of these nodes are defined by the
-    individual bindings for the rpmsg devices.
-  properties:
-    mediatek,rpmsg-name:
-      $ref: /schemas/types.yaml#/definitions/string-array
-      description:
-        Contains the name for the rpmsg device. Used to match
-        the subnode to rpmsg device announced by SCP.
-
-  required:
-    - mediatek,rpmsg-name
+additionalProperties: false
 
 examples:
   - |
@@ -118,7 +116,8 @@ examples:
         clocks = <&infracfg CLK_INFRA_SCPSYS>;
         clock-names = "main";
 
-        cros_ec {
+        cros-ec-rpmsg {
+            compatible = "google,cros-ec-rpmsg";
             mediatek,rpmsg-name = "cros-ec-rpmsg";
         };
     };
-- 
2.18.0

