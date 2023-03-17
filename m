Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72126BE10B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCQGJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCQGJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:09:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232F28E92;
        Thu, 16 Mar 2023 23:09:26 -0700 (PDT)
X-UUID: 41493084c48a11ed91027fb02e0f1d65-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Qiisn0SZ8xnyE1jSZqMUYY2XLTR8PnkxfVYSGRLnZpk=;
        b=U4KVvZ0NUgN8jKIfINJoNAiG/1dbiSH2xFNoei/pxscdhYUcHtnaWQuNT49dChkKJ92d2eFvPUOH/LPtaXyIr47EIhA1M0ER7buu5l2ADXgvXlM0a37eHVukKuJNhFNNJhy+aPL3b5WXFRGg2laho/YxUpHlzDgUVzt1SRkVlL0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:e5a79876-70df-4ad7-af7b-2aef60e597cf,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:83295aa,CLOUDID:e74916f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 41493084c48a11ed91027fb02e0f1d65-20230317
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 699823686; Fri, 17 Mar 2023 14:09:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 14:09:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 14:09:18 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v4 0/7] Add and update some driver nodes for MT8186 SoC
Date:   Fri, 17 Mar 2023 14:09:10 +0800
Message-ID: <20230317060917.15175-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux for-next.

Changes since v3:
 - Add index for ovl in aliases

Changes since v2:
 - Remove some unnecessary linebreaks for some nodes
 - Use one line for some properties
 - Drop "Fix the fallback for mediatek, mt8186-disp-ccorr" patch
   (since this is applied in chunkuang.hu/linux.git/log/?h=mediatek-drm-next)
 - Separate GCE into another patch
 - Drop some patches which are appied in matthias github

Changes since v1:
 - Remove the unnecessary trailing number
 - Add aliases for ovl* and rdma*

Allen-KH Cheng (7):
  arm64: dts: mediatek: mt8186: Add MTU3 nodes
  dt-bindings: spmi: spmi-mtk-pmif: Document mediatek,mt8195-spmi as
    fallback of mediatek,mt8186-spmi
  arm64: dts: mediatek: mt8186: Add SPMI node
  arm64: dts: mediatek: mt8186: Add ADSP node
  arm64: dts: mediatek: mt8186: Add audio controller node
  arm64: dts: mediatek: mt8186: Add GCE node
  arm64: dts: mediatek: mt8186: Add display nodes

 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  11 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 296 ++++++++++++++++++
 2 files changed, 304 insertions(+), 3 deletions(-)

-- 
2.18.0

