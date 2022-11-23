Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAB6360D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiKWOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiKWOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:00:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953861534;
        Wed, 23 Nov 2022 05:55:42 -0800 (PST)
X-UUID: 7de280f9553b40a684761cf5f413b781-20221123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rykZ2WGd1tRUbOPtTIsV57nz4AcJxx2AvMYWyGHdjl8=;
        b=GjxmyUnBe0msc3frO4UzhkBYZMUfwe8DOLhJblQCiml2xMQS7P9EGhcgO1FVid1swphOlhCnUdpK+lCbSY6lIPKpSTlSAi8S0z9DTENFzbpBnObA55cak08tpfHIewqaqN8Tn1b1fVipe3QPQspBHMv3OiCpBY87inpxOrLfrbw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e19949c5-8f95-4a38-9830-895b6088ecbe,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:70289f2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7de280f9553b40a684761cf5f413b781-20221123
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1180831467; Wed, 23 Nov 2022 21:55:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 23 Nov 2022 21:55:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 23 Nov 2022 21:55:36 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/5] Add some driver nodes for MT8186 SoC
Date:   Wed, 23 Nov 2022 21:55:26 +0800
Message-ID: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on matthias github, v6.1-next.

Changes since v1:
 - Add mtu3 nodes intead of xhci
 - Add mtu3 compatible for mt8186
 - Change clk names for power domains controllers
 - Reorder properties in some driver nodes
 - Correct commit title and message for dsi node

Allen-KH Cheng (5):
  dt-bindings: usb: mtu3: add compatible for mt8186
  arm64: dts: mt8186: Add power domains controller
  arm64: dts: mt8186: Add IOMMU and SMI nodes
  arm64: dts: mt8186: Add dsi node
  arm64: dts: mt8186: Add mtu3 nodes

 .../bindings/usb/mediatek,mtu3.yaml           |   1 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 455 ++++++++++++++++++
 2 files changed, 456 insertions(+)

-- 
2.18.0

