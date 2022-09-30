Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A215F0E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiI3O51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3O5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:57:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6927E844CB;
        Fri, 30 Sep 2022 07:57:13 -0700 (PDT)
X-UUID: fa54f4adcc2044eb94333815e52daad3-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Tt1QECZtZefC/UTgm9or5z8I2XvrYjCa1pogvR3ApGI=;
        b=WmCgYS++tKCJToXgaNdJowkmdLx9g0cwHObJVfEFc0nh0ND//7Tg0fabRQEkvFUYoiqryTxrn+GndNwVItCzcjUlYOft8T0j5HKaNEsiUGsAUb3al5YDVk54LiUN+Mtb04y5rqCzT5dW86XJDT1kiwEppMXPHzetFyoAMdY0i1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:01b0eccf-3fb7-4f7f-ab50-76c625654ce0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:01b0eccf-3fb7-4f7f-ab50-76c625654ce0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:2c35a6a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:22093022570969LZE2DI,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: fa54f4adcc2044eb94333815e52daad3-20220930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1511614647; Fri, 30 Sep 2022 22:57:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 22:57:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 22:57:05 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 00/12] ASoC: mediatek: Add support for MT8188 SoC
Date:   Fri, 30 Sep 2022 22:56:49 +0800
Message-ID: <20220930145701.18790-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for Mediatek AFE of MT8188 SoC.
Patches are based on broonie tree "for-next" branch.

Trevor Wu (12):
  ASoC: mediatek: common: add SMC ops ID
  ASoC: mediatek: mt8188: add common header
  ASoC: mediatek: mt8188: support audsys clock
  ASoC: mediatek: mt8188: support adda in platform driver
  ASoC: mediatek: mt8188: support etdm in platform driver
  ASoC: mediatek: mt8188: support pcmif in platform driver
  ASoC: mediatek: mt8188: support audio clock control
  ASoC: mediatek: mt8188: add platform driver
  ASoC: mediatek: mt8188: add control for timing select
  dt-bindings: mediatek: mt8188: add audio afe document
  ASoC: mediatek: mt8188: add machine driver with mt6359
  dt-bindings: mediatek: mt8188: add mt8188-mt6359 document

 .../bindings/sound/mt8188-afe-pcm.yaml        |  202 +
 .../bindings/sound/mt8188-mt6359.yaml         |   70 +
 sound/soc/mediatek/Kconfig                    |   23 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/common/mtk-base-afe.h      |   16 +
 sound/soc/mediatek/mt8188/Makefile            |   15 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c    |  656 ++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h    |  114 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |  151 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 3451 +++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c |  206 +
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h |   15 +
 .../soc/mediatek/mt8188/mt8188-audsys-clkid.h |   83 +
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |  639 +++
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c   | 2598 +++++++++++++
 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c    |  362 ++
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     |  810 ++++
 sound/soc/mediatek/mt8188/mt8188-reg.h        | 3300 ++++++++++++++++
 18 files changed, 12712 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
 create mode 100644 sound/soc/mediatek/mt8188/Makefile
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-mt6359.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-reg.h

-- 
2.18.0

