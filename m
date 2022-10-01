Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2455F195C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiJADM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiJADJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:09:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318E1BE79D;
        Fri, 30 Sep 2022 20:08:01 -0700 (PDT)
X-UUID: 5e1126fba7674c5791612e256a3b95c4-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RTwyJ78EQUlreAtuk6YGiJk7F5TanCDI8cS4Z2YDkMY=;
        b=SYhN476sGFHYdMmwJ3FGAdrvQt3WT4EYHvawTOwjFwR5EBBphXGR0Jt/zXFlfEGE72R+R1DTtD6Z4jMB9vuRvP7BIghrdoKPXAxyTvApuCMEytW+ILbqJO+SbTEHpW/RIYevY50f8dhS7v1BsZvjaE0TSMzJbQ/lNfRKYaLv3IU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4828be03-ed2c-4ed0-b79f-fcb2377efed2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:4828be03-ed2c-4ed0-b79f-fcb2377efed2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:9b83a107-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:221001110759BOBPXVS8,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:n
        il,COL:0
X-UUID: 5e1126fba7674c5791612e256a3b95c4-20221001
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 83364288; Sat, 01 Oct 2022 11:07:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:07:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:07:55 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: [PATCH] dt-bindings: mediatek: vcodec: Add the platform compatible to schema
Date:   Sat, 1 Oct 2022 11:07:52 +0800
Message-ID: <20221001030752.14486-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_PASS,
        T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are venc node warnings when running dtbs_check, the clock-names
was unexpected, missing properties '#address-cells' and '#size-cells'.
Add the corresponding platform compatible to schema.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../bindings/media/mediatek,vcodec-encoder.yaml      | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index 32aee09aea33..0f2ea8d9a10c 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -67,6 +67,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
 required:
   - compatible
   - reg
@@ -84,7 +90,9 @@ allOf:
           contains:
             enum:
               - mediatek,mt8183-vcodec-enc
+              - mediatek,mt8188-vcodec-enc
               - mediatek,mt8192-vcodec-enc
+              - mediatek,mt8195-vcodec-enc
 
     then:
       required:
@@ -107,7 +115,9 @@ allOf:
         compatible:
           enum:
             - mediatek,mt8173-vcodec-enc
+            - mediatek,mt8188-vcodec-enc
             - mediatek,mt8192-vcodec-enc
+            - mediatek,mt8195-vcodec-enc
 
     then:
       properties:
@@ -118,7 +128,7 @@ allOf:
         clock-names:
           items:
             - const: venc_sel
-    else:  # for vp8 hw decoder
+    else:  # for vp8 hw encoder
       properties:
         clock:
           items:
-- 
2.18.0

