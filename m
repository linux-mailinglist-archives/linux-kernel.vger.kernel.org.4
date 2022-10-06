Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7ED5F65BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJFMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJFMHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:07:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856AEBEC;
        Thu,  6 Oct 2022 05:07:24 -0700 (PDT)
X-UUID: 02df975237a247e195f5398ce29e8ba3-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SNCyKo7BJ06ez7HIFpg2DZDI4Pi9Scjoe6iZS/AjYgQ=;
        b=EpJCcbljFGcKkSNUxcY4eDsJ4MzKMvHGl+Wpy4FkvxIqQTra4up+qAgRyzelrOxFI/B++zT8L/5sVXVIjH55UU0YHzis+F9DfCp9svdiTfxdiPMtkE0WDQu2WdJ/zwNLeBTiqZUQW5Ti68h2uOuZfkM7rykld/MisIO8G3ozamM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0374f38d-b8a6-4a65-b2bb-96fcdc035c11,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:85241ce1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 02df975237a247e195f5398ce29e8ba3-20221006
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 489677683; Thu, 06 Oct 2022 20:07:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 20:07:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 6 Oct 2022 20:07:16 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 0/8] MediaTek watchdog: Convert mtk-wdt.txt to dt-schema
Date:   Thu, 6 Oct 2022 20:07:07 +0800
Message-ID: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Based on tag: next-20221006 linux-next/master, We use [1] and [2] as
references to send a new series.

This series converts mtk-wdt.txt to dt-schema and contains
 - Fix watchdog compatibles for MT8186, MT7986 and MT8195,
 - Fix the watchdog name of mt8516
 - Add mt6795 and MT8173 watchdog compatible
 - Add support for toprgu reset on the MediaTek Helio X10 MT6795 SoC.

Changes since [1]:
 - Drop "timeout-sec: true" and use unevaluatedProperties

[1] https://lore.kernel.org/all/20221005113517.70628-1-angelogioacchino.delregno@collabora.com/
[2] https://lore.kernel.org/all/20220422121017.23920-3-allen-kh.cheng@mediatek.com/

Allen-KH Cheng (3):
  arm64: dts: mediatek: mt7986: Fix watchdog compatible
  arm64: dts: mediatek: mt8516: Fix the watchdog node name
  dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT8173

AngeloGioacchino Del Regno (5):
  arm64: dts: mediatek: mt8186: Fix watchdog compatible
  arm64: dts: mediatek: mt8195: Fix watchdog compatible
  dt-bindings: watchdog: mediatek: Convert mtk-wdt to json-schema
  dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6795
  watchdog: mtk_wdt: Add support for MT6795 Helio X10 watchdog and
    toprgu

 .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 80 +++++++++++++++++++
 .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  3 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8516.dtsi      |  2 +-
 drivers/watchdog/mtk_wdt.c                    |  6 ++
 7 files changed, 90 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt

-- 
2.18.0

