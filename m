Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D5645393
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLGFvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:51:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480EB58BD3;
        Tue,  6 Dec 2022 21:51:16 -0800 (PST)
X-UUID: adf3265307fe4cd08845ac152050598e-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/vg4719+76MXc675xcgguoaMGBhivbvFc7/9h2WKmk8=;
        b=pog11NIsQk69P7XnH02tBmUnv6Nfdc7oIjGmuNpxej6Zru+HKtRe7zDZliVGQKOZrD+RVxgrGXGUxjbHhiGASpjmxaNprWDOOqvnw8iukVX9fqFQLap0WRRCx79R7uWzvqWzpbMxbdnKlQ0ctYAQx5nbdCG6wYZm02HoqXl8aZw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:3edc3dfe-9f5e-4d38-a5ac-085d9e3aef02,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:3edc3dfe-9f5e-4d38-a5ac-085d9e3aef02,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:f52cc616-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:221207135112I7SE42J3,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: adf3265307fe4cd08845ac152050598e-20221207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1358516483; Wed, 07 Dec 2022 13:51:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:51:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 13:51:08 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yunfei.dong@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v6 0/3] Add vcodec lat and core nodes for mt8192
Date:   Wed, 7 Dec 2022 13:51:04 +0800
Message-ID: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-next.

Change from v5:
 - Add required interrupts for mediatek,mtk-vcodec-core
 - Rewrite commit message for 'Remove "dma-ranges" property for decoder' PATCH

Change from v4:
 - Add patch for removing dma-ranges
 - Update child names to video-codec
 - Update patch title and message

Change from v3:
 - Drop `vcodec_lat:` and `vcodec_core:`

Change from v2:
 - Add a dt-bindings patch for changing "vcodec" to "video-codec"
 - Rename child names for vcodec lat and core nodes

Change from v1:
 - Replace node names with video-codec
  [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]

Allen-KH Cheng (3):
  media: dt-bindings: media: mediatek: Rename child node names for
    decoder
  media: dt-bindings: media: mediatek: Remove "dma-ranges" property for
    decoder
  arm64: dts: mt8192: Add video-codec nodes

 .../media/mediatek,vcodec-subdev-decoder.yaml | 68 ++-----------------
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 59 ++++++++++++++++
 2 files changed, 64 insertions(+), 63 deletions(-)

-- 
2.18.0

