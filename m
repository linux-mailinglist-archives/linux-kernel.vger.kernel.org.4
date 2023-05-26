Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CE7123A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbjEZJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbjEZJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:32:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65E2A4;
        Fri, 26 May 2023 02:31:58 -0700 (PDT)
X-UUID: 26291ad0fba811edb20a276fd37b9834-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=908mJvgM7Ffh4vh5j/v5y7glqS/XQvRCpUkMddBwUKc=;
        b=Y8qmVRwu0EX/DJfKSw/0kMd7hqfiexFb08yrTvVTtI9M9jg4rXu9Yf2JKLc2bzgG8ybuFYtD1nQZzUN4xIY2f+jdnf0nMXOsoE0v2Eeah5MrcQDloqtN/yGs0okhUXvVBekjneUhSIMxs/1QwHcZ6ap7nN4r64gd8SHPGdINqlY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:29ed3b9c-878b-41e9-95ba-a8c475b7060c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:fbcca53c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 26291ad0fba811edb20a276fd37b9834-20230526
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2076542957; Fri, 26 May 2023 17:31:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 17:31:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 17:31:51 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <amergnat@baylibre.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/7] ASoC: mt8188: add new board support
Date:   Fri, 26 May 2023 17:31:43 +0800
Message-ID: <20230526093150.22923-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the series, we extend the capability of mt8188-mt6359 driver.

The following changes are included.
1. Divide ADDA BE dai into two dais for SOF.
2. Register hdmi/dp jack pins.
3. dai_fmt can be configured from device tree.
4. Add some I2S codecs support.

In addition, new compatible string "mediatek,mt8188-nau8825" is
included for a new board support.

Changes since v2:
  - unify coding style based on reviewer's suggestion
  - fix typo
  
Changes since v1:
  - add "Headphone Jack" for Nau8825
  - separate binding patch 2 from patch 6, and rename the subject
  - clean up debugfs for freed widget

Trevor Wu (7):
  ASoC: mediatek: mt8188: separate ADDA playback dai from capture dai
  ASoC: dt-bindings: mediatek,mt8188-mt6359: remove ADDA_BE from
    link-name
  ASoC: mediatek: mt8188-mt6359: register hdmi/dp jack pins
  ASoC: mediatek: common: soundcard driver add dai_fmt support
  ASoC: soc-dapm.c: clean up debugfs for freed widget
  ASoC: mediatek: mt8188-mt6359: support new board with nau88255
  ASoC: dt-bindings: mediatek,mt8188-mt6359: add NAU8825 support

 .../sound/mediatek,mt8188-mt6359.yaml         |  27 +-
 sound/soc/mediatek/Kconfig                    |   4 +
 .../mediatek/common/mtk-soundcard-driver.c    |  53 ++-
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |   3 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |  73 ++--
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 386 +++++++++++++++++-
 sound/soc/soc-dapm.c                          |  16 +
 7 files changed, 507 insertions(+), 55 deletions(-)

-- 
2.18.0

