Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4506010F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJQOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJQOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:20:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF35A825;
        Mon, 17 Oct 2022 07:20:14 -0700 (PDT)
X-UUID: 46a7cbab5bdd4a2a8d1b9a504833891f-20221017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9nM+HJkIZYFDdoIM0Yw1SMU/i8YQxRIRZyTgOy4hyyU=;
        b=ROd+uF908endJGyK+g1D0dHapZNUj9TACl6FN9I6P94plGkK5K3XH9Xc/Sex6CMbVuAqyiIEBFGfCHmPjf708GQ8yCisO2no4VeJaTddsQPDDKRwLL/UWxrCEclz5/iF2Ay5q1yVVSM/+UXxviq1CW/ROYJWoCDbwGY109aSoos=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:38ec97d0-15d3-4fa4-9130-42fe32c258f8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:38ec97d0-15d3-4fa4-9130-42fe32c258f8,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:bcd70aa4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:221017222011XYZ374TR,BulkQuantity:0,Recheck:0,SF:38|28|16|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 46a7cbab5bdd4a2a8d1b9a504833891f-20221017
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 400136033; Mon, 17 Oct 2022 22:20:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 17 Oct 2022 22:20:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 17 Oct 2022 22:20:09 +0800
From:   Mengqi Zhang <mengqi.zhang@mediatek.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] MediaTek eMMC inline encryption support
Date:   Mon, 17 Oct 2022 22:20:05 +0800
Message-ID: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Mediatek eMMC hardware IP has Inline Crypto Engine (ICE), we support inline encryption now.

This patchset supports Mediatek eMMC inline encryption which meets the upcoming version of the eMMC specification such as v5.1 or v5.2.

Patch 1, add crypto clock control flow in mtk-sd driver, patch 2, document the device tree description about crypto clock.


Mengqi Zhang (2):
  mmc: mtk-sd: add Inline Crypto Engine support
  dt-bingdings: mmc: Mediatek: add ICE clock

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  4 ++++
 drivers/mmc/host/mtk-sd.c                         | 12 ++++++++++++
 2 files changed, 16 insertions(+)


