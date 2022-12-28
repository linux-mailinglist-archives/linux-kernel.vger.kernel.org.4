Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84262657342
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiL1Gdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiL1Gdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:33:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDDBC07;
        Tue, 27 Dec 2022 22:33:41 -0800 (PST)
X-UUID: e744cec906a04018814d323291558934-20221228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZQtki9cjS456yItlFDFoypb+Uyo9A59Q46rWl6WroCI=;
        b=ZJ5pz0GIDQbrDthYBJYUie0s0wZziX9EHivHKAsIJdMcyf9PQyb1DIy3tKI7FtzFwH65pY+zcaeLBG9ZMOwAmHwnXQCCEswoD51/40n7oMVaBRugC+Fs+R23iNajxvawHSqqcDuBfvlWP4qwhWggQaZIyR5yXfj59e+rijnCjas=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:d4a5b7ca-21dc-4ba5-bb2b-558237caa246,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:f49b0053-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e744cec906a04018814d323291558934-20221228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1794413813; Wed, 28 Dec 2022 14:33:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Dec 2022 14:33:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 28 Dec 2022 14:33:32 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Biao Huang" <biao.huang@mediatek.com>, <macpaul.lin@mediatek.com>
Subject: [PATCH v6 0/2] arm64: dts: mt8195: Add Ethernet controller
Date:   Wed, 28 Dec 2022 14:33:28 +0800
Message-ID: <20221228063331.10756-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes in v6:
1. add reviewed-by as Angelo's comments
2. remove fix_mac_speed in driver as Andrew's comments.

Changes in v5:
1. reorder the clocks as Angelo's comments
2. add a driver patch to fix rgmii-id issue, then we can
use a ususal way rgmii/rgmii-id as Andrew's comments.

Changes in v4:
1. remove {address,size}-cells = <0> to avoid warning as Angelo's feedback.
2. Add reviewd-by as Angelo's comments.

Changes in v3:
1. move stmmac-axi-config, rx-queues-config, tx-queues-configs inside ethernet
node as Angelo's comments.
2. add {address,size}-cells = <0> in ethernet node as Angelo's comments.

Changes in v2:
1. modify pinctrl node used by ethernet to match rules in pinctrl-mt8195.yaml,
which is pointed by Krzysztof.
2. remove "mac-address" property in ethernet node as comments of Krzysztof.

Changes in v1:
add dts node for MT8195 Ethernet controller

Biao Huang (2):
  stmmac: dwmac-mediatek: remove the dwmac_fix_mac_speed
  arm64: dts: mt8195: Add Ethernet controller

 arch/arm64/boot/dts/mediatek/mt8195-demo.dts  | 81 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 86 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-mediatek.c  | 26 ------
 3 files changed, 167 insertions(+), 26 deletions(-)

-- 
2.18.0


