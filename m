Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6755EF62A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiI2NNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiI2NN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:13:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169ED979CE;
        Thu, 29 Sep 2022 06:13:22 -0700 (PDT)
X-UUID: b785c75b4fd94d8b81c88c6df69ac657-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IMLNBA/41uKU2E2kzr4vnTnRFWJkZhSlGuj3u6dp8Sc=;
        b=O4E4JzUBNeSMiP8e2LX9mWagfHy9ZTgG2qXRnnIGrF6uv6SSPwM0gn/Krl/nPMhMG567YgonBxO82tism+UcVJckbdwZnchYSvd7HYsMI1D0bIc3wl/sTpGyc93RAhXuG1iETU0DuS2L3iLVZ0VJu1hP0Fn9xWAJehQjT8XU/30=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b14478b8-3808-48b3-88f0-85a9473f73d8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:b14478b8-3808-48b3-88f0-85a9473f73d8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:6e78a9e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220929211319ANWWCS9P,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: b785c75b4fd94d8b81c88c6df69ac657-20220929
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1102980675; Thu, 29 Sep 2022 21:13:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Sep 2022 21:13:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 29 Sep 2022 21:13:17 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 1/2] media: dt-bindings: mediatek: Rename child node names for decoder
Date:   Thu, 29 Sep 2022 21:13:08 +0800
Message-ID: <20220929131309.18337-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
References: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the names of the child nodes more generic, we rename
"vcodec" to "video-codec" for decoder in patternProperties and example.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index c4f20acdc1f8..67fde48f991c 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -91,7 +91,7 @@ properties:
 
 # Required child node:
 patternProperties:
-  '^vcodec-lat@[0-9a-f]+$':
+  '^video-codec-lat@[0-9a-f]+$':
     type: object
 
     properties:
@@ -145,7 +145,7 @@ patternProperties:
 
     additionalProperties: false
 
-  '^vcodec-core@[0-9a-f]+$':
+  '^video-codec-core@[0-9a-f]+$':
     type: object
 
     properties:
@@ -241,7 +241,7 @@ examples:
             #size-cells = <2>;
             ranges = <0 0 0 0x16000000 0 0x40000>;
             reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
-            vcodec-lat@10000 {
+            video-codec-lat@10000 {
                 compatible = "mediatek,mtk-vcodec-lat";
                 reg = <0 0x10000 0 0x800>;
                 interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -264,7 +264,7 @@ examples:
                 power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
             };
 
-            vcodec-core@25000 {
+            video-codec-core@25000 {
                 compatible = "mediatek,mtk-vcodec-core";
                 reg = <0 0x25000 0 0x1000>;
                 interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.18.0

