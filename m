Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A75E744D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIWGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIWGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:43:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE8127CB8;
        Thu, 22 Sep 2022 23:43:24 -0700 (PDT)
X-UUID: 41f1f5f29b23414d915d90a967f1ed9d-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MvX74CEhQuUzV4Pbi5ukv/Mw42iVYl5SgITUV6v196c=;
        b=ssnM09Xok/Ic9vweBSG3zmBW7DglSmrBxeDToIXWz9QpBEdbkTKsuruUndFaPY9Vo6OJHdvlnUPs/OIvPm030rfivxv7RMQW3v9WrCxU5xoVDikWa6E/+74T5f4+HG+BCfLweYGtndHiD42WtMx6RhWxI7B7W4KKDCV9Lr386Uk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b72a832a-38c8-4c92-84a1-c36a8e5eb95f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:b72a832a-38c8-4c92-84a1-c36a8e5eb95f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:5b15d4a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220923144320925B65PQ,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 41f1f5f29b23414d915d90a967f1ed9d-20220923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 289966123; Fri, 23 Sep 2022 14:43:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 14:43:17 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Sep 2022 14:43:16 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <jitao.shi@mediatek.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@list.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        xinlei lee <xinlei.lee@mediatek.com>
Subject: [PATCH,v2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Date:   Fri, 23 Sep 2022 14:43:14 +0800
Message-ID: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xinlei lee <xinlei.lee@mediatek.com>

Add dt-binding documentation of pwm for MediaTek MT8188 SoC.

Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index e4fe2d1..2dd93e8 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8186-disp-pwm
+              - mediatek,mt8188-disp-pwm
               - mediatek,mt8192-disp-pwm
               - mediatek,mt8195-disp-pwm
           - const: mediatek,mt8183-disp-pwm
-- 
2.6.4

