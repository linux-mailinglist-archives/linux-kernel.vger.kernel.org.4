Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1773D5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFZCf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFZCfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:35:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409ECE5A;
        Sun, 25 Jun 2023 19:35:32 -0700 (PDT)
X-UUID: 19b1dee213ca11eeb20a276fd37b9834-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Iwm0zG4h3gdP7jHydJXH0fWBg1eTZidbjOVJW6/TgdU=;
        b=SnoQq1dU0WmTTMLJIWRB6QFoCIsbegxc2VK7dDC3xJVMV8megKtP4Qh2CSxign9Bwv2yHi2RaesfwyONrlsIA3pAZXOnPlKR58C/0m6ZzuaRKQ/71klhZWowFY5SlBF+QY9R0Gz5auPnAxpuzOJyAImvhxrJ+jZZVM2xi8LUrko=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:41937417-b15c-444f-ac88-b8ba1722d666,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:9bd3a03f-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 19b1dee213ca11eeb20a276fd37b9834-20230626
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 881512161; Mon, 26 Jun 2023 10:35:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 10:35:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 10:35:21 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v2 0/7] ASoC: mediatek: Add support for MT7986 SoC
Date:   Mon, 26 Jun 2023 10:34:54 +0800
Message-ID: <20230626023501.11120-1-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - v1 title: [PATCH 0/7] ASoC: mediatek: Add support for MT79xx SoC
 - add missing maintainers
 - rename mt79xx to mt7986 in all files
 - use clk bulk api in mt7986-afe-clk.c [2/7]
 - refine mt7986-afe-pcm.c based on reviewer's suggestions [4/7]
 - refine dt-binding files based on reviewer's suggestions [6/7] [7/7]
 - transpose [3/7] and [4/7] in v1 to fix test build errors
 
This series of patches adds support for MediaTek AFE of MT7986 SoC.
Patches are based on broonie tree "for-next" branch.

Maso Huang (7):
  ASoC: mediatek: mt7986: add common header
  ASoC: mediatek: mt7986: support audio clock control
  ASoC: mediatek: mt7986: support etdm in platform driver
  ASoC: mediatek: mt7986: add platform driver
  ASoC: mediatek: mt7986: add machine driver with wm8960
  ASoC: dt-bindings: mediatek,mt7986-wm8960: add mt7986-wm8960 document
  ASoC: dt-bindings: mediatek,mt7986-afe: add audio afe document

 .../bindings/sound/mediatek,mt7986-afe.yaml   |  89 +++
 .../sound/mediatek,mt7986-wm8960.yaml         |  53 ++
 sound/soc/mediatek/Kconfig                    |  20 +
 sound/soc/mediatek/Makefile                   |   1 +
 sound/soc/mediatek/mt7986/Makefile            |  10 +
 sound/soc/mediatek/mt7986/mt7986-afe-clk.c    |  75 +++
 sound/soc/mediatek/mt7986/mt7986-afe-clk.h    |  18 +
 sound/soc/mediatek/mt7986/mt7986-afe-common.h |  51 ++
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c    | 598 ++++++++++++++++++
 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c   | 421 ++++++++++++
 sound/soc/mediatek/mt7986/mt7986-reg.h        | 206 ++++++
 sound/soc/mediatek/mt7986/mt7986-wm8960.c     | 184 ++++++
 12 files changed, 1726 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
 create mode 100644 sound/soc/mediatek/mt7986/Makefile
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-common.h
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-reg.h
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-wm8960.c

-- 
2.18.0

