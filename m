Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D48604078
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiJSJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiJSJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:58:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBD111BA9;
        Wed, 19 Oct 2022 02:35:44 -0700 (PDT)
X-UUID: 76276290a9ed4666a853127c63a000b2-20221019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7PYeSbs1rJ/yIu6lL50fcsiJCbAbHIheAPMIeRRMdDA=;
        b=mvHx6cltk6O2/41eJEo462t/zsdjV32ufzZLzwQ7wtLnm7ttPPchtOkILVMHFtRwqxSOZPzTKsZ9zY57+BXZo/JZQkrkwUfEfMVvJSzo+5hexbgDTv2+RAdVrRJeeAFLoA0ISwe1CJk9La/Ig+L+d/6EyjZFe5XSvyKZp7Vrri0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b9912910-db81-4c5f-a9a8-a1d1b16778ce,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:b9912910-db81-4c5f-a9a8-a1d1b16778ce,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:611d4aa4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:2210191715202JY9RVF3,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 76276290a9ed4666a853127c63a000b2-20221019
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1251354093; Wed, 19 Oct 2022 17:15:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 19 Oct 2022 17:15:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Oct 2022 17:15:17 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Biao Huang <biao.huang@mediatek.com>,
        <macpaul.lin@mediatek.com>
Subject: [PATCH v2 0/1] arm64: dts: mt8195: Add Ethernet controller
Date:   Wed, 19 Oct 2022 17:15:14 +0800
Message-ID: <20221019091515.21878-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
1. modify pinctrl node used by ethernet to match rules in pinctrl-mt8195.yaml,
as comments from Krzysztof.
2. remove "mac-address" property in ethernet node as comments from Krzysztof.

Changes in v1:
add dts node for MT8195 Ethernet controller

Biao Huang (1):
  arm64: dts: mt8195: Add Ethernet controller

 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 86 +++++++++++++++++++
 2 files changed, 174 insertions(+)

-- 
2.18.0


