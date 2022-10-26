Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3B60DB61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiJZGdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiJZGdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:33:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08DBAB800;
        Tue, 25 Oct 2022 23:33:40 -0700 (PDT)
X-UUID: 8c18830621ef4ba0a04edebc85bcbb2c-20221026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KiwPmbDD1MhVA6n6KkWt9LbHMoM8EQb6aIvzu6stn04=;
        b=NY/O4RpU4pv+vgoFbso7GBSvtxp55scnsmJYfWElpFYt/UyVNtsY6euq5TakyRTCsbC8nj03+6TiUkg4R+R2HY5TQIKHAqGKbUIz9Xa3KtPH0D7PHaG0SC961MpYj/BS8v+zAMQ7B7eTcn7CY2BHPhhgRbX3RLrlJQTV5W3DeGg=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:113a3f29-ba27-4e61-b940-9da18d091b55,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:113a3f29-ba27-4e61-b940-9da18d091b55,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:081a2b27-9eb1-469f-b210-e32d06cfa36e,B
        ulkID:221026143335X2NGHB5K,BulkQuantity:0,Recheck:0,SF:38|28|16|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8c18830621ef4ba0a04edebc85bcbb2c-20221026
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1583305563; Wed, 26 Oct 2022 14:33:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Oct 2022 14:33:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Oct 2022 14:33:30 +0800
From:   Runyang Chen <Runyang.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [RESEND v3 0/3] Add watchdog support for MT8188 Soc
Date:   Wed, 26 Oct 2022 14:33:24 +0800
Message-ID: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Runyang Chen <runyang.chen@mediatek.com>

Based on tag: next-20220919, linux-next/master

Refer to the discussion in the link:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220721014845.19044-2-allen-kh.cheng@mediatek.com/
The other wdt compatible strings are unchanged.So, won't apply the
series above

v3:
Rebase on 6.0-rc5 and add reviewed-by and acked-by tag.

v2:
Revert wdt compatible for MT8188.

v1:
1. Add mt8188-resets.h to define definition of reset bits.
2. Add wdt compatible for MT8188.*

Runyang Chen (3):
  dt-bindings: watchdog: Add compatible for MediaTek MT8188
  dt-bindings: reset: mt8188: add toprgu reset-controller header file
  watchdog: mediatek: mt8188: add wdt support

 .../devicetree/bindings/watchdog/mtk-wdt.txt  |  1 +
 drivers/watchdog/mtk_wdt.c                    |  6 ++++
 include/dt-bindings/reset/mt8188-resets.h     | 36 +++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt8188-resets.h


base-commit: 4c9ca5b1597e3222177ba2a94658f78fa5ef4f58
-- 
2.18.0

