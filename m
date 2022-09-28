Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2615EDB57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiI1LJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiI1LIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05BC49B5C;
        Wed, 28 Sep 2022 04:05:46 -0700 (PDT)
X-UUID: 2c2c0dde81664f40882e24e0c5611397-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MN3nxq5g6hX09F9vsW86ESfKbMSAEPh2i6PCUaRTs6Y=;
        b=BSxKNic9rFL6Oo2GPBdxe9AWXaK1xiOhgGtQSukrQ9dv8QqGyZtOm1BNi9s84KRPkK5R1Vs1qlcwKIZgvghvJ/CXVbkUzc+XpTTmrX/a7ChK8PKxeT/AP6b7G03SGHG+zoALrO8Bw1T4mrwR/7lxihLrZzJBGLRSeTqPddX42Ac=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3d0d577e-09ab-4fa9-97bb-a825ee906b08,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:e1e55007-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2c2c0dde81664f40882e24e0c5611397-20220928
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianhua.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 159100435; Wed, 28 Sep 2022 19:05:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Sep 2022 19:05:38 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 28 Sep 2022 19:05:37 +0800
From:   Jianhua Lin <jianhua.lin@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jianhua Lin <jianhua.lin@mediatek.com>
Subject: [PATCH v2, 0/2] Add MT8188 jpeg encoder and decoder compatible
Date:   Wed, 28 Sep 2022 19:05:32 +0800
Message-ID: <20220928110534.4756-1-jianhua.lin@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches dependent on: 
media_stage tree:
https://git.linuxtv.org/media_stage.git/
commit/?id=7ce22e9229f216c638426a854efd5bd127b24

Changes compared with v1:
- rebase v1, no change.
 
Jianhua Lin (2):
  dt-bindings: media: mediatek-jpeg-decoder: Add MT8188 compatible
    string
  dt-bindings: media: mediatek-jpeg-encoder: Add MT8188 compatible
    string

 .../devicetree/bindings/media/mediatek-jpeg-decoder.yaml         | 1 +
 .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 1 +
 2 files changed, 2 insertions(+)

-- 
2.18.0

