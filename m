Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6EB697648
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjBOG0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjBOG0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:26:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9E3430E;
        Tue, 14 Feb 2023 22:26:11 -0800 (PST)
X-UUID: a07667b4acf911eda06fc9ecc4dadd91-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tj7gc9/ETJfThMX11/SvkW6RSCkvj56c1pXVSNQqS0I=;
        b=IWIuv3M7q5I3dMccMc+w5CAIQ084gVGTpDRjWqE8kp1F4scGqidZxhb7iWFR0gGY9i/YBipbihO+tSQdHTl+AIBAHOXJuK9e7sTec0eUyCCOq9m3GJfs6dRQG4w9Se2JAokjgJUTH56VZrRr8sukEHCrm5KF/SyqPdjzA2dCoPY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:7e0446b2-64b7-475e-9b25-49e424f9796f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:4c3e9f25-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: a07667b4acf911eda06fc9ecc4dadd91-20230215
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 459445041; Wed, 15 Feb 2023 14:26:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 15 Feb 2023 14:26:04 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 15 Feb 2023 14:26:03 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <jianjiao.zeng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Subject: [PATCH v4 01/11] dt-bindings: media: mediatek,vcodec: Remove dma-ranges property
Date:   Wed, 15 Feb 2023 14:25:34 +0800
Message-ID: <20230215062544.8677-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230215062544.8677-1-yong.wu@mediatek.com>
References: <20230215062544.8677-1-yong.wu@mediatek.com>
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

After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
controllers"), the dma-ranges of the leaf node doesn't work. Remove
it for vcodec here.

1) For mediatek,vcodec-decoder.yaml and mediatek,vcodec-encoder.yaml,
this property is in the leaf node, it is invalid as the above comment.

Currently there is only mt8195 VENC node has this property in upstream.
Indeed, VENC is affected, but it is not a fatal issue. Originally it
expects its iova range locate at 4GB-8GB. However after that commit, its
expectation doesn't come true, it will fall back to 0-4GB iova and also
could work well.

2) For mediatek,vcodec-subdev-decoder.yaml, It already uses parent-child
node, this property works. Instead, MediaTek iommu will control the
masters' iova ranges by the master's larb/port id internally, then the
dma-ranges property is unnecessary for the master's node.

Cc: Tiffany Lin <tiffany.lin@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml | 5 -----
 .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 5 -----
 .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
 3 files changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index aa55ca65d6ed..fad59b486d5d 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -56,11 +56,6 @@ properties:
       List of the hardware port in respective IOMMU block for current Socs.
       Refer to bindings/iommu/mediatek,iommu.yaml.
 
-  dma-ranges:
-    maxItems: 1
-    description: |
-      Describes the physical address space of IOMMU maps to memory.
-
   mediatek,vpu:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index 0f2ea8d9a10c..a2051b31fa29 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -49,11 +49,6 @@ properties:
       List of the hardware port in respective IOMMU block for current Socs.
       Refer to bindings/iommu/mediatek,iommu.yaml.
 
-  dma-ranges:
-    maxItems: 1
-    description: |
-      Describes the physical address space of IOMMU maps to memory.
-
   mediatek,vpu:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index c4f20acdc1f8..290594bc91cc 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -76,11 +76,6 @@ properties:
       The node of system control processor (SCP), using
       the remoteproc & rpmsg framework.
 
-  dma-ranges:
-    maxItems: 1
-    description: |
-      Describes the physical address space of IOMMU maps to memory.
-
   "#address-cells":
     const: 2
 
@@ -203,7 +198,6 @@ required:
   - reg
   - iommus
   - mediatek,scp
-  - dma-ranges
   - ranges
 
 if:
@@ -236,7 +230,6 @@ examples:
             compatible = "mediatek,mt8192-vcodec-dec";
             mediatek,scp = <&scp>;
             iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
-            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
             #address-cells = <2>;
             #size-cells = <2>;
             ranges = <0 0 0 0x16000000 0 0x40000>;
-- 
2.18.0

