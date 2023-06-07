Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCEF7253E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjFGGLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFGGLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:11:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A59C1712;
        Tue,  6 Jun 2023 23:11:36 -0700 (PDT)
X-UUID: 25fd442204fa11ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HHiIt6KcZrob2B/zrQRVJb5juS9lJddR2M2H5zQFyVk=;
        b=SW2De24aCS8oIbOQEXU0mk5Q5i55diHvSvxd7GBteD9u3AsKLJW5HrvGmSjT2gSKAVV4ZfHi3hMib7yyfKRjEowDYhNpmQcXtQI6j3bMf+ZkTyW6YbdcEToJ4g4eVmOIADL3QKUDvtpf3iGuWExhKPWkIfEiB1umlSpE6/U40s4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:bb0580d0-4398-4248-8453-f0436d3b1ede,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ab0aa33d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 25fd442204fa11ee9cb5633481061a41-20230607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2049118073; Wed, 07 Jun 2023 14:11:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 14:11:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 14:11:30 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        "Hsiao Chein Sung" <shawn.sung@mediatek.com>,
        Fei Shao <fshao@google.com>
Subject: [PATCH v1 0/6] Add display driver for MT8188 VDOSYS1
Date:   Wed, 7 Jun 2023 14:11:15 +0800
Message-ID: <20230607061121.6732-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

[PATCH v1 1/6] dt-bindings: display/mediatek: mt8188: Add documentations
[PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits for VDOSYS1
[PATCH v1 3/6] soc: mediatek: mt8188: Support VDOSYS1 in mtk-mmsys
[PATCH v1 4/6] drm/mediatek: mt8188: Modify display driver for VDOSYS1
[PATCH v1 5/6] soc: mediatek: mt8188: Support VDOSYS1 PADDING in mtk-mmsys
[PATCH v1 6/6] drm/mediatek: mt8188: Add VDOSYS1 PADDING driver

Hsiao Chien Sung (6):
  dt-bindings: display/mediatek: mt8188: Add documentations for VDOSYS1
  dt-bindings: reset: mt8188: Add reset control bits for VDOSYS1
  soc: mediatek: mt8188: Support VDOSYS1 in mtk-mmsys
  drm/mediatek: mt8188: Modify display driver for VDOSYS1
  soc: mediatek: mt8188: Support VDOSYS1 PADDING in mtk-mmsys
  drm/mediatek: mt8188: Add VDOSYS1 PADDING driver

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../display/mediatek/mediatek,ethdr.yaml      |   5 +-
 .../display/mediatek/mediatek,mdp-rdma.yaml   |   5 +-
 .../display/mediatek/mediatek,merge.yaml      |   1 +
 .../display/mediatek/mediatek,padding.yaml    |  80 ++++++++++
 drivers/gpu/drm/mediatek/Makefile             |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   3 +-
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 143 +++++++++++------
 drivers/gpu/drm/mediatek/mtk_disp_padding.c   | 134 ++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  29 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_ethdr.c          |   1 +
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |   1 +
 drivers/soc/mediatek/mt8188-mmsys.h           | 149 ++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  13 ++
 drivers/soc/mediatek/mtk-mmsys.h              |   1 +
 drivers/soc/mediatek/mtk-mutex.c              |  51 ++++++
 include/dt-bindings/reset/mt8188-resets.h     |  12 ++
 include/linux/soc/mediatek/mtk-mmsys.h        |   8 +
 21 files changed, 589 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_padding.c

--
2.18.0

