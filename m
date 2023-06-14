Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E872F72D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbjFNH7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbjFNH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:59:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C011FD4;
        Wed, 14 Jun 2023 00:59:23 -0700 (PDT)
X-UUID: 834191200a8511ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3d3+nqKfc7WyVFylcs5QJ0W6Qn3i6zaoXuAGBfq4eVw=;
        b=Yudy8m7RD8kWAhZSZX6KFUir0rKPpqT+4B7AtsRpTu8csHjg74Q4b2KACKTR66hKNMtSAZGQ9J5/6oYi4tLzztD6NxHjkAI6Mym3CdFKWd7g/iZzL8nWD/j1XQ8StoVMuPMyvWoybsJVfUnJ0uazbdsvFygYX6k0+wmAkp1jx3k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:6a019666-103f-4fe0-a928-6971dac14184,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:f908076f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 834191200a8511ee9cb5633481061a41-20230614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 585949631; Wed, 14 Jun 2023 15:31:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:31:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:31:43 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v2 00/15] Add display driver for MT8188 VDOSYS1
Date:   Wed, 14 Jun 2023 15:31:10 +0800
Message-ID: <20230614073125.17958-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support MT8188 VDOSYS1 in display driver.

v2:
- Separate dt-bindings by modules
- Support reset bit mapping in mmsys driver
- Remove redundant compatibles of MT8188 because it shares the same
  configuration with MT8195

Hsiao Chien Sung (15):
  dt-bindings: display: mediatek: ethdr: Add compatible for MT8188
  dt-bindings: display: mediatek: mdp-rdma: Add compatible for MT8188
  dt-bindings: display: mediatek: merge: Add compatible for MT8188
  dt-bindings: display: mediatek: padding: Add documentation for MT8188
  dt-bindings: arm: mediatek: Add compatible for MT8188
  dt-bindings: reset: mt8188: Add VDOSYS0 reset control bits
  dt-bindings: reset: mt8188: Add VDOSYS1 reset control bits
  soc: mediatek: Support MT8188 VDOSYS1 in mtk-mmsys
  soc: mediatek: Support MT8188 VDOSYS1 PADDING in mtk-mmsys
  soc: mediatek: Support reset bit mapping in mmsys driver
  soc: mediatek: Add MT8188 VDO0 reset bit map
  soc: mediatek: Add MT8188 VDO1 reset bit map
  drm/mediatek: Support MT8188 VDOSYS1 in display driver
  drm/mediatek: Improve compatibility of display driver
  drm/mediatek: Support MT8188 VDOSYS1 PADDING in display driver

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../display/mediatek/mediatek,ethdr.yaml      |   6 +-
 .../display/mediatek/mediatek,mdp-rdma.yaml   |   6 +-
 .../display/mediatek/mediatek,merge.yaml      |   3 +
 .../display/mediatek/mediatek,padding.yaml    |  81 +++++++
 drivers/gpu/drm/mediatek/Makefile             |   3 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 170 +++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   4 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_padding.c        | 127 +++++++++++
 drivers/soc/mediatek/mt8188-mmsys.h           | 210 ++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  26 +++
 drivers/soc/mediatek/mtk-mmsys.h              |  30 +++
 drivers/soc/mediatek/mtk-mutex.c              |  51 +++++
 include/dt-bindings/reset/mt8188-resets.h     |  75 +++++++
 include/linux/soc/mediatek/mtk-mmsys.h        |   8 +
 17 files changed, 751 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_padding.c

--
2.18.0

