Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78E5B9809
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIOJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiIOJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:47:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ED29A6B0;
        Thu, 15 Sep 2022 02:46:47 -0700 (PDT)
X-UUID: 33d25d3240ec4e17bb307b443c92fceb-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Le3LjlqTlqNwk0qKU4668eOFBrkxOwrZLqgFvOKNEnQ=;
        b=tV7uGwUByW/mxn/YIRWAtuUxbhprIx//H0OwJCA4FEuAMDCGbpGGYazU/hdvQrPFL9YoGzU+3InULYJikK0ywb2bLqVg5vQ3PHvz6dlJ3RoH6VXTYFbx8cErfPO4jn8xIrK2n6QYXasuMlbfa0yNkYYbJebzxcCku+oiwGwvz/c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:982b6c43-cbfc-459c-962c-867e9e5ab861,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:7302c35d-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 33d25d3240ec4e17bb307b443c92fceb-20220915
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1138290454; Thu, 15 Sep 2022 17:46:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 17:46:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 17:46:40 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 0/4] Add dp-intf and dp nodes
Date:   Thu, 15 Sep 2022 17:46:36 +0800
Message-ID: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add MediaTek dp-intf nodes and dp nodes.
This series is based on linux-next-20220914.

Changes for v2:
1. Update commit messages.
2. reorder the place of "status = "disabled";"
3. reorder the place of dp-intf.

Bo-Chen Chen (4):
  arm64: dts: mt8195: Add dp-intf nodes
  arm64: dts: mt8195: Add edptx and dptx nodes
  arm64: dts: mediatek: cherry: Add dp-intf ports
  arm64: dts: mediatek: cherry: Add edptx and dptx support

 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 86 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 48 +++++++++++
 2 files changed, 134 insertions(+)

-- 
2.18.0

