Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40272C265
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbjFLLFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbjFLLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:05:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D780270F;
        Mon, 12 Jun 2023 03:53:29 -0700 (PDT)
X-UUID: 5a1f80c6090f11eeb20a276fd37b9834-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HWQ9wrT35b6pkEnZ34pjf2szFkbwSXUpw/iZR2OP2Sg=;
        b=BkvTrXt7qmssolIPIqsy99D/5EEBn1/gDglCxoFcMmSaxiXqkaQAFvt5RhdJ+KjU3Stfs+DqLSuzekLd65hfYiljRr1RBuTNjTZZtzKymv/ZEZ/OVDoRiNUj7vC3ON/etiwwaRv9N9WhPk6S+aaIKpB3LIGx/CJIzvwl/I67ghU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:a02e8225-0875-415c-8895-ac3693ae37df,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:2b945a3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5a1f80c6090f11eeb20a276fd37b9834-20230612
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 577519842; Mon, 12 Jun 2023 18:53:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 18:53:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 18:53:22 +0800
From:   Maso Hunag <maso.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH 0/7] ASoC: mediatek: Add support for MT79xx SoC
Date:   Mon, 12 Jun 2023 18:52:43 +0800
Message-ID: <20230612105250.15441-1-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maso Huang <maso.huang@mediatek.com>

This series of patches adds support for MediaTek AFE of MT79xx SoC.
Patches are based on broonie tree "for-next" branch.

Maso Huang (7):
  ASoC: mediatek: mt79xx: add common header
  ASoC: mediatek: mt79xx: support audio clock control
  ASoC: mediatek: mt79xx: add platform driver
  ASoC: mediatek: mt79xx: support etdm in platform driver
  ASoC: mediatek: mt79xx: add machine driver with wm8960
  ASoC: dt-bindings: mediatek,mt79xx-wm8960: add mt79xx-wm8960 document
  ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe document

 .../bindings/sound/mediatek,mt79xx-afe.yaml   | 102 +++
 .../sound/mediatek,mt79xx-wm8960.yaml         |  53 ++
 sound/soc/mediatek/Kconfig                    |  20 +
 sound/soc/mediatek/Makefile                   |   1 +
 sound/soc/mediatek/mt79xx/Makefile            |  10 +
 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c    | 123 ++++
 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h    |  18 +
 sound/soc/mediatek/mt79xx/mt79xx-afe-common.h |  49 ++
 sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c    | 608 ++++++++++++++++++
 sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c   | 421 ++++++++++++
 sound/soc/mediatek/mt79xx/mt79xx-reg.h        | 206 ++++++
 sound/soc/mediatek/mt79xx/mt79xx-wm8960.c     | 185 ++++++
 12 files changed, 1796 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml
 create mode 100644 sound/soc/mediatek/mt79xx/Makefile
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-dai-etdm.c
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-reg.h
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-wm8960.c

-- 
2.18.0

