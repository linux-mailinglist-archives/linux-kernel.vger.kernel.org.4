Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B06F8398
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjEENN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjEENNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:13:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD031D940;
        Fri,  5 May 2023 06:13:15 -0700 (PDT)
X-UUID: 96a42222eb4611edb20a276fd37b9834-20230505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KhlDRAeeJnqkQ1VfZCBZx7biLs8pcsS1txRadTISsq4=;
        b=jDixcrQ7lPlvYO2G0wFpiQmKirIOG86JVoZGLWdOwc4c/tsYI4dr8nyJP5ZdqeVNY6WGg8acjFknn2DKLVBZ7XwKhTLpf2spfcEAbKIrkfr4mwekl00+8BQtHEotZS4Z925pqMPU1LPSnti8aB+5nDj1qV/DZ0i0PMivLp3fqo8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:aad7892b-d7d8-4dd8-88bc-9e1e2ac3f386,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.23,REQID:aad7892b-d7d8-4dd8-88bc-9e1e2ac3f386,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:697ab71,CLOUDID:ecc4de30-6935-4eab-a959-f84f8da15543,B
        ulkID:230505211313PVDQG6R8,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 96a42222eb4611edb20a276fd37b9834-20230505
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 661025566; Fri, 05 May 2023 21:13:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 May 2023 21:13:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 May 2023 21:13:10 +0800
From:   Runyang Chen <runyang.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [PATCH v2 0/2] Add infra_ao reset support for MT8188 Soc
Date:   Fri, 5 May 2023 21:13:06 +0800
Message-ID: <20230505131308.27190-1-runyang.chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on tag: next-20230504, linux-next/master

v2:
1. Modify SoB to match author name.

v1:
1. Add thermal reset bit for MT8188.
2. Add infra_ao reset support for MT8188.


Runyang Chen (2):
  dt-bindings: reset: mt8188: add thermal reset control bit
  clk: mediatek: reset: add infra_ao reset support for MT8188

 drivers/clk/mediatek/clk-mt8188-infra_ao.c | 24 ++++++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h  |  5 +++++
 2 files changed, 29 insertions(+)


base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
-- 
2.18.0

