Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64B66D4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjAQD1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjAQD05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:26:57 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91649227A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:26:50 -0800 (PST)
X-UUID: c5c17274961611ed945fc101203acc17-20230117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=izQlGGt5FZNdfcVfV+ZwBHdU6OcNmPO68g0341IO2+8=;
        b=SoRcV3od8EP2fURNxss6x4Gp0BRiIIkz9oTyZO12VbCuSAN5lovjUcCx5YoEoY83rJtzF8VjdOkN5MvRy5lBh5ceHfCH9EXhIjQBAhK8psIf5U5B8Y41TLcEbjxQQ5t3whVDGzS1ICRsuxy/+wkdr1VR4AIdvPyXcAONObomeWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:0885e242-79f9-49ef-a1e9-7f17ca45e37d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:cd4002f6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: c5c17274961611ed945fc101203acc17-20230117
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1853940640; Tue, 17 Jan 2023 11:26:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 17 Jan 2023 11:26:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 17 Jan 2023 11:26:45 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 0/2] mediatek: pm-domains: Add buck isolation setting support
Date:   Tue, 17 Jan 2023 11:26:38 +0800
Message-ID: <20230117032640.13504-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We send a independent series from [1].
Add buck isolation setting support for the specific power pm-domains (mtcmos)
in some chipsets, such as ADSP in MT8192 and CAM_VCORE in MT8188.

Changes since [1]:
 - Add the conditional for ext_buck_iso_offs

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=706103

Allen-KH Cheng (2):
  soc: mediatek: pm-domains: Add buck isolation offset and mask to power
    domain data
  soc: mediatek: pm-domains: Add buck isolation setting in power domain

 drivers/soc/mediatek/mtk-pm-domains.c | 8 ++++++++
 drivers/soc/mediatek/mtk-pm-domains.h | 5 +++++
 2 files changed, 13 insertions(+)

-- 
2.18.0

