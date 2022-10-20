Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2282A605A43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJTIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJTIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:52:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A8318F0C9;
        Thu, 20 Oct 2022 01:52:14 -0700 (PDT)
X-UUID: d10e2467e8a143d6a603cab6ed818a31-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tZ4uLe20MrO0FdMMWxarlY5mppNaTM9jlYJASSy75lo=;
        b=Ve7AnECpwN/Po8tAV+uSj+frkhjWOaxNbM/QU9pRcU+jPjqeC1W1qZSI9taLOCN0fwYnhIQhj2/AtPprrilQclR+4xuii/TZzCuiLQC4EY7C2wFDdUheWQGO1LgjlgS/7I1ZTo7EvrFD7SmkuwXqNLh3Rapx4H/6BVJKHf0zq3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b591817b-86bf-45f4-9567-fdf9d81edca2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:2b75e3ee-314c-4293-acb8-ca4299dd021f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d10e2467e8a143d6a603cab6ed818a31-20221020
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 720150427; Thu, 20 Oct 2022 16:52:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 20 Oct 2022 16:52:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 20 Oct 2022 16:52:05 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Biao Huang <biao.huang@mediatek.com>,
        <macpaul.lin@mediatek.com>
Subject: [PATCH v4 0/1] arm64: dts: mt8195: Add Ethernet controller
Date:   Thu, 20 Oct 2022 16:52:02 +0800
Message-ID: <20221020085203.1974-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
1. remove {address,size}-cells = <0> to avoid warning as Angelo's feedback.
2. Add reviewd-by as Angelo's comments.

Changes in v3:
1. move stmmac-axi-config, rx-queues-config, tx-queues-configs inside ethernet node
as Angelo's comments.
2. add {address,size}-cells = <0> in ethernet node as Angelo's comments.

Changes in v2:
1. modify pinctrl node used by ethernet to match rules in pinctrl-mt8195.yaml,
which is pointed by Krzysztof.
2. remove "mac-address" property in ethernet node as comments of Krzysztof.

Changes in v1:
add dts node for MT8195 Ethernet controller

Biao Huang (1):
  arm64: dts: mt8195: Add Ethernet controller

 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 86 +++++++++++++++++++
 2 files changed, 174 insertions(+)

-- 
2.18.0


