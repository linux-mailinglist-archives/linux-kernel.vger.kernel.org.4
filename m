Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8461061E02D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKFDj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKFDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:39:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0259C75E;
        Sat,  5 Nov 2022 20:39:45 -0700 (PDT)
X-UUID: 44dc4fc11a304993b9166536d0b014a2-20221106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vWDvI9g2pRQ52ZMOm1a7Y9bqu87BMMp4jVyuY1u4zSw=;
        b=GG1jFMIQmLxHd7H4Lt+Zn9M4ki4f1kpPvjW6XLtv4Wa9GFYqU3pi9kcOQB3nLO+7k0ceqzTjalqTpnNcGk33Q1RS7WDY28FQ8i+b15V6X0/AVnvbPiHG6Uz424KLFmMmDB97r4QStMSr3hY4FbG5O+mi0xfDpf2VvBeMwkF459I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e4863fda-0c47-42c2-af47-8274e5f4e7d6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:e4863fda-0c47-42c2-af47-8274e5f4e7d6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:eeb2c7f3-a19e-4b45-8bfe-6a73c93611e9,B
        ulkID:221104175140AN13NCB4,BulkQuantity:13,Recheck:0,SF:38|28|17|19|48,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 44dc4fc11a304993b9166536d0b014a2-20221106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1137927004; Sun, 06 Nov 2022 11:39:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 6 Nov 2022 11:39:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sun, 6 Nov 2022 11:39:34 +0800
From:   Mengqi Zhang <mengqi.zhang@mediatek.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <mengqi.zhang@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND v2 0/2] Mediatek eMMC Inline Crypto Engine support
Date:   Sun, 6 Nov 2022 11:39:22 +0800
Message-ID: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v2
- change patch 1 commit title
- change patch 2 commit title, and correct commit message
- add crypto clock description base on new code base

Mediatek eMMC hardware IP has Inline Crypto Engine (ICE), we support inline encryption now.

This patchset supports Mediatek eMMC inline encryption which meets the upcoming version of the eMMC specification such as v5.1 or v5.2.

Patch 1, add crypto clock control flow in mtk-sd driver, patch 2, document the device tree description about crypto clock.

Mengqi Zhang (2):
  mmc: mtk-sd: add Inline Crypto Engine clock control
  dt-bindings: mmc: mtk-sd: add Inline Crypto Engine clock

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.c                     | 12 ++++++++++
 2 files changed, 34 insertions(+)

--
2.25.1


