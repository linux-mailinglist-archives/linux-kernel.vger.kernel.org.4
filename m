Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5EE64DACE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLOMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLOMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:00:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474E2C64B;
        Thu, 15 Dec 2022 04:00:32 -0800 (PST)
X-UUID: 25d0e7faba5748e68197eeded3ed898f-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oqiLG4bTjy4LKDdKavagAAOMkmtgSgEQVjWMF2eRyWg=;
        b=XrIn9qHqrlstUaM3CYzksVj5FYstvMRPrSL6ttNmH70nn/cZ7HSwVxLfenYKptPaW8QpNx/tIvIyjjcV+eI7beybAfUm4Ovs9z0WN9qExsINwA25Nb45Ai4x8ZRQyLOXSWdvNAfwuo9v37ww1x5douJYh0QVJpP9LL0X28GHKek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ec39f3ef-d18f-46e9-acac-3d4a4eb0d8e8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:e9c4b0b4-d2e2-434d-b6d3-aeae88dfcc78,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 25d0e7faba5748e68197eeded3ed898f-20221215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 929928261; Thu, 15 Dec 2022 20:00:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Dec 2022 20:00:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Dec 2022 20:00:18 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 0/4] Add ADSP power domains controller support for MT8192
Date:   Thu, 15 Dec 2022 20:00:12 +0800
Message-ID: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
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

This series is based on matthias github, v6.1-next.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20221201073328.1559-1-allen-kh.cheng@mediatek.com/

Allen-KH Cheng (4):
  dt-bindings: power: Add MT8192 ADSP power domain
  soc: mediatek: pm-domains: Add ADSP power domain data for MT8192
  dt-bindings: arm: mediatek: Add missing power-domains property
  arm64: dts: mediatek: Add the missing ADSP power domains controller
    for MT8192

 .../arm/mediatek/mediatek,mt8192-clock.yaml     | 17 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi        |  9 +++++++++
 drivers/soc/mediatek/mt8192-pm-domains.h        | 16 ++++++++++++++++
 include/dt-bindings/power/mt8192-power.h        |  1 +
 4 files changed, 43 insertions(+)

-- 
2.18.0

