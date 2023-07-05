Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05DF747DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGEG60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGEG6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:58:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18518E;
        Tue,  4 Jul 2023 23:58:18 -0700 (PDT)
X-UUID: 4e97302e1b0111eeb20a276fd37b9834-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZXox+jFYAE4BphrVQEZrO1m4Hit0F7XQhbXgD7y3N+o=;
        b=mPmi+TiJy68M03CkhgOVk1K1mc/c4+TIBnTwadwSuc80gI3D/iXd2Lu6XEzLH4TjxQB5inLvzx9LX9HJdGpLXm9ixz2Q0e4xslno4v+QITQe+jh0RY34Myd+98+jvwsWm/cp4TDbg8J3un3SIn5crmrozAaqLZDTP5d9P5cmeX0=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.27,REQID:d344c661-d975-4284-aae6-c8111e39ab42,IP:0,U
        RL:0,TC:0,Content:100,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,A
        CTION:quarantine,TS:200
X-CID-INFO: VERSION:1.1.27,REQID:d344c661-d975-4284-aae6-c8111e39ab42,IP:0,URL
        :0,TC:0,Content:100,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_HTS54396,ACT
        ION:quarantine,TS:200
X-CID-META: VersionHash:01c9525,CLOUDID:f238950d-26a8-467f-b838-f99719a9c083,B
        ulkID:230705145812U1T1A6Z3,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48|8
        01,TC:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 4e97302e1b0111eeb20a276fd37b9834-20230705
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 944498501; Wed, 05 Jul 2023 14:58:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 14:58:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 14:58:10 +0800
From:   Jason-ch Chen <jason-ch.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        jason-ch chen <Jason-ch.Chen@mediatek.com>
Subject: [PATCH 2/3] dt-bindings: arm: mediatek: Add mt8188 pericfg compatible
Date:   Wed, 5 Jul 2023 14:57:43 +0800
Message-ID: <20230705065744.25848-3-jason-ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230705065744.25848-1-jason-ch.chen@mediatek.com>
References: <20230705065744.25848-1-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jason-ch chen <Jason-ch.Chen@mediatek.com>

Add mt8188 pericfg compatible to binding document.

Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index 26158d0d72f3..33c94c491828 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -28,6 +28,7 @@ properties:
               - mediatek,mt8173-pericfg
               - mediatek,mt8183-pericfg
               - mediatek,mt8186-pericfg
+              - mediatek,mt8188-pericfg
               - mediatek,mt8195-pericfg
               - mediatek,mt8516-pericfg
           - const: syscon
-- 
2.18.0

