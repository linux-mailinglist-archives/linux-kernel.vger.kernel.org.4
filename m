Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9786456D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLGJtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLGJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:49:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225302E9D2;
        Wed,  7 Dec 2022 01:49:36 -0800 (PST)
X-UUID: 2ae7fba27713489f97648e931b417b1d-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+DlieiQH5x/y67QutSHJcSuOjfcivZx2Dzr1Dzpgv0E=;
        b=SRUur7vy1a+HaAGFca6Ez+G687Ob+E2JnOn2BRYukFT6Ow1VQOg0yc06PdpMzYgJW4pA5HIxUpQirfMJwa+AhiukYoq4O2ekxupjNNtfVP0gnmFeK54HvgSyQdZiOKdwhTap5N0B8FkOIn1ZJDMpLLwab5XEZQ/4+31L4xVvXDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:7bf139e7-77ba-403e-9e5e-8d7973dd8582,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:e600ce16-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2ae7fba27713489f97648e931b417b1d-20221207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1645931037; Wed, 07 Dec 2022 17:49:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 17:49:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 17:49:23 +0800
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
Subject: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Date:   Wed, 7 Dec 2022 17:49:13 +0800
Message-ID: <20221207094921.15450-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

From: mtk18742 <moudy.ho@mediatek.com>

Changes since v3:
- Rebase on linux-next

Changes since v2:
- Depend on :
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
- Split dts settings into two patches based on belonging to MMSYS or MUTEX.

Changes since v1:
- Depend on :
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
- Add compatible names to VPPSYS0 and VPPSYS1 in MMSYS binding file.
- Fix VPPSYS's MMSYS and MUTEX dts to pass the dtsb_check.
- Rename mtk_mmsys_merge_config() and mtk_mmsys_rsz_dcm_config() to
  mtk_mmsys_vpp_rsz_merge_config() and mtk_mmsys_vpp_rsz_dcm_config().
- Clean up mtk_mmsys_vpp_rsz_dcm_config().
- Add a comment to mtk_mutex_write_mod() and clean it up for use in more
  than 32 mods.

Hi,

This series add support for MT8195's two VPPSYS(Video Processor Pipe Subsystem),
under which there will be corresponding MMSYS and MUTEX settings that
need to be configured.

Moudy Ho (2):
  dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS
  arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS

Roy-CW.Yeh (6):
  dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
  arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS
  soc: mediatek: mmsys: add support for MT8195 VPPSYS
  soc: mediatek: mmsys: add config api for RSZ switching and DCM
  soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
  soc: mediatek: mutex: support MT8195 VPPSYS

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   5 +-
 .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  28 +++-
 drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
 drivers/soc/mediatek/mtk-mmsys.c              |  64 +++++++++
 drivers/soc/mediatek/mtk-mmsys.h              |   1 +
 drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
 include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
 include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
 9 files changed, 274 insertions(+), 12 deletions(-)

-- 
2.18.0

