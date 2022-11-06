Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7C61E033
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKFDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKFDkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:40:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC1C770;
        Sat,  5 Nov 2022 20:40:38 -0700 (PDT)
X-UUID: 91d4ca04d8de4ce499f675beab80eef0-20221106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SiJd/cbIFHc0t29rG3pUwRbp3B0gNob0JkC9ON4oH/Y=;
        b=kBeAHwseCHRvvlYzp5mUSoSUVeX44XSrrjGjy7R9mcs8OYcbHQiZebcqMW2cCTm3aSY0Uy+FlIUbP050AWKTmzSM7PMJ11AWG7tAwzM5hrKlloZX5lT4ypkxkWXK5yZZdDGGRmdus1O7lr9PF6rKhd6ock7pyFJffRnoOSnGVv0=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.12,REQID:60490f50-08ac-4c03-be96-07ae13c209dc,IP:0,U
        RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:115
X-CID-INFO: VERSION:1.1.12,REQID:60490f50-08ac-4c03-be96-07ae13c209dc,IP:0,URL
        :0,TC:0,Content:-5,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:115
X-CID-META: VersionHash:62cd327,CLOUDID:361db390-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:221104180502221YZ78P,BulkQuantity:7,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:5,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 91d4ca04d8de4ce499f675beab80eef0-20221106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 37866013; Sun, 06 Nov 2022 11:40:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 6 Nov 2022 11:40:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sun, 6 Nov 2022 11:40:30 +0800
From:   Mengqi Zhang <mengqi.zhang@mediatek.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <mengqi.zhang@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND v2 2/2] dt-bindings: mmc: mtk-sd: add Inline Crypto Engine clock
Date:   Sun, 6 Nov 2022 11:39:26 +0800
Message-ID: <20221106033924.9854-3-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
References: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional crypto clock of the Inline Crypto Engine of Mediatek SoCs.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 6f8ecb4788eb..8ed94a12a03b 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -263,6 +263,28 @@ allOf:
             - const: bus_clk
             - const: sys_cg
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8186-mmc
+            - mediatek,mt8188-mmc
+            - mediatek,mt8195-mmc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: crypto clock used for data encrypt/decrypt (optional)
+        clock-names:
+          items:
+            - const: source
+            - const: hclk
+            - const: source_cg
+            - const: crypto
+
   - if:
       properties:
         compatible:
-- 
2.25.1

