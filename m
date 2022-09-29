Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFE5EF62B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiI2NNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiI2NN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:13:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD76DF694;
        Thu, 29 Sep 2022 06:13:22 -0700 (PDT)
X-UUID: 09c17d8be2424325a166fc471c26ca30-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=STCDn5QB+UXKv417LvXk9TQm3f2P+5X47QlKUCTyQiE=;
        b=qIkK7wA89/pwvKvho/+JHpsAPatm1nxC4qkZ1fK7NbRO1PAsCSQQattw5ppV1SwO0+GrpfULiNgv9ZXVWlpQradwAfXl1ZE24NM5xLjRXa2CL8tN+7/8JW5reGUXm5A+4bbevH/xhHjz6qzet+Qw4sKQpFst2hF1Eu/8YfHd/4Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:2ffe6ed5-7cad-440a-9089-edd560b9036f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:2ffe6ed5-7cad-440a-9089-edd560b9036f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:a1ee7407-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220929211317CMUFBLT7,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 09c17d8be2424325a166fc471c26ca30-20220929
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 975782009; Thu, 29 Sep 2022 21:13:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Sep 2022 21:13:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 29 Sep 2022 21:13:14 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 0/2] Add vcodec lat and core nodes for mt8192
Date:   Thu, 29 Sep 2022 21:13:07 +0800
Message-ID: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on linux-next, tag: next-20220928.
We update the child node names from "vcodec" to "video-codec" based on
the discussion in [1].

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220926105047.19419-1-allen-kh.cheng@mediatek.com/

Change in v2:
  - Add a dt-bindings patch for changing "vcodec" to "video-codec"
  - Rename child names for vcodec lat and core nodes

Change in v1:
  - Replace node names with video-codec
    [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]

Allen-KH Cheng (2):
  media: dt-bindings: mediatek: Rename child node names for decoder
  arm64: dts: mt8192: Add vcodec lat and core nodes

 .../media/mediatek,vcodec-subdev-decoder.yaml |  8 +--
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 60 +++++++++++++++++++
 2 files changed, 64 insertions(+), 4 deletions(-)

-- 
2.18.0

