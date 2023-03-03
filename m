Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBDD6A8EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCCBtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCCBtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:49:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306A12590;
        Thu,  2 Mar 2023 17:49:48 -0800 (PST)
X-UUID: aa295e42b96511ed945fc101203acc17-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WKJvKXB5YKyWhjfVBwPiOdC8Y9I4gWmgvLERUsZbs6E=;
        b=jDg5zW2OXo1mrsd6zfNK1C70snV8HR3nQ8iEV186FPztm5pYXCj9qpcTSxNNEnENXhXoOEJiGMLJxcOIadgdaJu5QCVS50Fvqe5fpxEOHrfuXhU2DWwwEUFTFacKJt4iszMEAcsnQXoBreoiKRkn18dzFpoWpXRUXQpLJXzER1w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:45020022-d76a-4156-8bf4-96a409704d9e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:ff542d27-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: aa295e42b96511ed945fc101203acc17-20230303
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jing.cai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1116543198; Fri, 03 Mar 2023 09:49:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 09:49:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 09:49:39 +0800
From:   <jing.cai@mediatek.com>
To:     <jwboyer@kernel.org>, <dwmw2@infradead.org>,
        <johan.hedberg@gmail.com>
CC:     <deren.wu@mediatek.com>, <chris.lu@mediatek.com>,
        <YN.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <linux-firmware@kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jing Cai <Jing.Cai@mediatek.com>,
        Jing Cai <jing.cai@mediatek.com>
Subject: [PATCH 0/1] linux-firmware: update firmware for mediatek
Date:   Fri, 3 Mar 2023 09:49:29 +0800
Message-ID: <20230303014930.21794-1-jing.cai@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Cai <Jing.Cai@mediatek.com>

Update binary firmware for MT7921 BT devices.

File: mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
Version: 20230302151355

Signed-off-by: Jing Cai <jing.cai@mediatek.com>

Jing Cai (1):
  linux-firmware: update firmware for mediatek bluetooth chip  (MT7921)

 WHENCE                                  |   2 +-
 mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin | Bin 528366 -> 529454 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

