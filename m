Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCFD6A8ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCCBi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCCBit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:38:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E16CC30;
        Thu,  2 Mar 2023 17:38:48 -0800 (PST)
X-UUID: 22929828b96411eda06fc9ecc4dadd91-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NPDcbWjUVSoLLjMtO/Z1QwJgNEyxQ1YYYXl9gvsi2R0=;
        b=mwVx8okudEN/QBfAKR/FusnfwemjkOe5nZJnJih36Hv7O8m9RIK9WygvzSfe8vnZsaX6exbl4+U2G72CXoPnVJKJDsoN6hXSDmujTTjIXi6a5bXMBBURloxt77aXfI4WMCi1OZqdeDBo5jqFAdUK4W0FL4ui8JBTV9HalrsgIXs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:455c1fa1-6c9a-49c4-b21b-562cdc834dc6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:faf02c27-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 22929828b96411eda06fc9ecc4dadd91-20230303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1370251418; Fri, 03 Mar 2023 09:38:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 09:38:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 09:38:44 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yunfei.dong@mediatek.com>,
        "Allen-KH Cheng" <allen-kh.cheng@mediatek.com>
Subject: [RESEND 0/6] media: mediatek: Update video decoder nodes for MT8195 and MT8192
Date:   Fri, 3 Mar 2023 09:38:36 +0800
Message-ID: <20230303013842.23259-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

This series is based on matthias github v6.3-tmp. Since there is a
dependence in the following series, I resend a series for them.

patchwork.kernel.org/project/linux-mediatek/list/?series=702423
patchwork.kernel.org/project/linux-mediatek/list/?series=702078

Allen-KH Cheng (3):
  media: dt-bindings: media: mediatek: Rename child node names for
    decoder
  media: dt-bindings: media: mediatek: Remove "dma-ranges" property for
    decoder
  arm64: dts: mt8192: Add video-codec nodes

Yunfei Dong (3):
  media: dt-bindings: media: mediatek: vcodec: adapt to the
    'clock-names' of different platforms
  media: dt-bindings: media: mediatek: vcodec: Change the max reg value
    to 2
  arm64: dts: mt8195: Add video decoder node

 .../media/mediatek,vcodec-subdev-decoder.yaml | 113 +++++++-----------
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  59 +++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  70 +++++++++++
 3 files changed, 173 insertions(+), 69 deletions(-)

-- 
2.18.0

