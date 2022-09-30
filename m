Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E875F0A88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiI3Lcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3Lb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:31:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB723E768;
        Fri, 30 Sep 2022 04:22:47 -0700 (PDT)
X-UUID: f8810dc3ec9d47d6b3ec8b7228470ac8-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3oUSdorY1iUy0g7JUWPQIoK/saXauUwkw9QgJJn51gM=;
        b=AnIxh0i6BED1Xr+tbiV8FV31sNHmJ1yiBxpS7tTCCwldOKz8cnyAkjhg+KmJt5W1Eqqw5MdgzW2AvILQ8cG9pi8HMDpMh9RMszNVhbx5c8PO8pO9jBQt8RpgHy6f+ghCiqEMV5TsKzoY2Vt/rl3qCLmInRSusifiRdeSVWl5Upo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b13ed560-4c2f-4775-ae0c-383afa6594a2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:b13ed560-4c2f-4775-ae0c-383afa6594a2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:4ac4a2a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220930192243JZD2MB26,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f8810dc3ec9d47d6b3ec8b7228470ac8-20220930
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2054658982; Fri, 30 Sep 2022 19:22:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 19:22:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 19:22:40 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v4 0/2] Add vcodec lat and core nodes for mt8192
Date:   Fri, 30 Sep 2022 19:22:35 +0800
Message-ID: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-next, tag: next-20220929.

Change in v3:
  - Drop `vcodec_lat:` and `vcodec_core:`

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

