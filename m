Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2813656198
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiLZJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLZJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:43:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628B2664;
        Mon, 26 Dec 2022 01:42:58 -0800 (PST)
X-UUID: 137b51f9acee48b88c09b044779c4c8d-20221226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wO/YlaAH2Y8g68ssS2G0vi1odeG2J8FOazjyVtZ7WaE=;
        b=OLDnyltbOD+xTBPL9FjUEBln8vxhHiSgFQuvsuIBTMOUv1kU78iWCfV+wN9UtB4PYCQe75+0OcW3pvBq5FgZfrfdS5cm1js1LN9aAzI5Nmpkc2+c6dF+wUrvkpKWWXrKZL/DKgz8ToC2eWsTDEYMuomWTiYawhUb499ZC+A7sH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9f24a36a-77df-4c10-9cbf-3b57c36c38a4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:9fb7f8f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 137b51f9acee48b88c09b044779c4c8d-20221226
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 675022121; Mon, 26 Dec 2022 17:42:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Dec 2022 17:42:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 26 Dec 2022 17:42:49 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 0/13] Enahance SVS's robustness
Date:   Mon, 26 Dec 2022 17:42:35 +0800
Message-ID: <20221226094248.4506-1-roger.lu@mediatek.com>
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

SVS driver got accepted upstream but still has room to be improved.
Therefore, we add these patches to fix issues and coding style.

Matthias Brugger (4):
  soc: mediatek: mtk-svs: clean up platform probing
  soc: mediatek: mtk-svs: improve readability of platform_probe
  soc: mediatek: mtk-svs: move svs_platform_probe into probe
  soc: mediatek: mtk-svs: delete superfluous platform data entries

Ricardo Ribalda (1):
  soc: mediatek: mtk-svs: enable the IRQ later

Roger Lu (7):
  soc: mediatek: mtk-svs: use svs get efuse common function
  soc: mtk-svs: mt8183: refactor o_slope calculation
  soc: mediatek: mtk-svs: add main_clk check during system-wide suspend
  soc: mediatek: mtk-svs: use common function to disable restore
    voltages
  soc: mediatek: mtk-svs: restore default voltages when svs init02 fail
  soc: mediatek: mtk-svs: add thermal voltage compensation if needed
  soc: mediatek: mtk-svs: keep svs alive even though debug cmd create
    fail

Shang XiaoJing (1):
  soc: mediatek: mtk-svs: Use pm_runtime_resume_and_get() in
    svs_init01()

 drivers/soc/mediatek/mtk-svs.c | 279 +++++++++++++++------------------
 1 file changed, 124 insertions(+), 155 deletions(-)


