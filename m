Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122456455AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLGIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiLGIor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:44:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F52AE1E;
        Wed,  7 Dec 2022 00:44:20 -0800 (PST)
X-UUID: ff14731af6984faaa8cc3ec7091519d2-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ud7YIAEYaWGEcoDTTgKxmMn9Mr1u/rV/keE/O8rmB3k=;
        b=rZdMKVFJYQk4ohbSK+QTEhOe7P4cprK11Fu+0mW1jpSXYrs8CGWmHR6DHDtV4B8I3Ot72FitsnpE0UCwhnf4xTZz8RfVF17T1YXgmqtjV6BUDdRKk+3yFpxVLSj3thAdmxVxwmCSXWARu1tMlgy7vdDTIk/+vzelstQ7i1+JR4c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:1464509e-2638-4e85-b185-b197f5eba73a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:03f79024-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ff14731af6984faaa8cc3ec7091519d2-20221207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1745602921; Wed, 07 Dec 2022 16:44:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 16:44:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 16:44:13 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        mtk18742 <moudy.ho@mediatek.com>
Subject: [PATCH v2 00/12] add support MDP3 on MT8195 platform
Date:   Wed, 7 Dec 2022 16:44:00 +0800
Message-ID: <20221207084412.14075-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

From: mtk18742 <moudy.ho@mediatek.com>

Changes since v1:
- Depend on :
  [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/?series=698872
  [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=684959
- Fix compilation failure due to use of undeclared identifier in file "mtk-mdp3-cmdq.c"

Hello,

This patch is used to add support for MDP3 on the MT8195 platform that
contains more picture quality components, and can arrange more pipelines
through two sets of MMSYS and MUTEX respectively.

Moudy Ho (12):
  dt-binding: mediatek: add bindings for MediaTek 8195 MDP3 components
  arm64: dts: mediatek: mt8195: add MDP3 nodes
  media: platform: mtk-mdp3: add support second sets of MMSYS
  media: platform: mtk-mdp3: add support second sets of MUTEX
  media: platform: mtk-mdp3: introduce more pipelines from 8195
  media: platform: mtk-mdp3: introduce more MDP3 components
  media: platform: mtk-mdp3: add checks for dummy components
  media: platform: mtk-mdp3: avoid multiple driver registrations
  media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
  media: platform: mtk-mdp3: add 8195 platform configuration
  media: platform: mtk-mdp3: add 8195 shared memory configurations
  media: platform: mtk-mdp3: add 8195 component settings

 .../bindings/media/mediatek,mdp3-aal.yaml     |  64 ++
 .../bindings/media/mediatek,mdp3-color.yaml   |  64 ++
 .../bindings/media/mediatek,mdp3-fg.yaml      |  64 ++
 .../bindings/media/mediatek,mdp3-hdr.yaml     |  63 ++
 .../bindings/media/mediatek,mdp3-merge.yaml   |  64 ++
 .../bindings/media/mediatek,mdp3-ovl.yaml     |  64 ++
 .../bindings/media/mediatek,mdp3-pad.yaml     |  64 ++
 .../bindings/media/mediatek,mdp3-rdma.yaml    |   5 +-
 .../bindings/media/mediatek,mdp3-split.yaml   |  76 ++
 .../bindings/media/mediatek,mdp3-stitch.yaml  |  64 ++
 .../bindings/media/mediatek,mdp3-tcc.yaml     |  63 ++
 .../bindings/media/mediatek,mdp3-tdshp.yaml   |  64 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 398 +++++++++
 .../platform/mediatek/mdp3/mdp_reg_aal.h      |  25 +
 .../platform/mediatek/mdp3/mdp_reg_color.h    |  31 +
 .../media/platform/mediatek/mdp3/mdp_reg_fg.h |  23 +
 .../platform/mediatek/mdp3/mdp_reg_hdr.h      |  31 +
 .../platform/mediatek/mdp3/mdp_reg_merge.h    |  25 +
 .../platform/mediatek/mdp3/mdp_reg_ovl.h      |  25 +
 .../platform/mediatek/mdp3/mdp_reg_pad.h      |  21 +
 .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  24 +
 .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   2 +
 .../platform/mediatek/mdp3/mdp_reg_tdshp.h    |  34 +
 .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   8 +
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   |  46 +-
 .../mediatek/mdp3/mt8195/mdp3-comp-mt8195.h   | 283 ++++++
 .../mediatek/mdp3/mt8195/mdp3-plat-mt8195.h   | 652 ++++++++++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      |   4 +
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 257 +++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 834 +++++++++++++++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  86 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  94 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  21 +
 33 files changed, 3529 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8195/mdp3-comp-mt8195.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8195/mdp3-plat-mt8195.h

-- 
2.18.0

