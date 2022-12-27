Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC11656CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiL0QXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiL0QXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:23:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737E241;
        Tue, 27 Dec 2022 08:23:00 -0800 (PST)
X-UUID: dcf7859e10b24e67ae363b780223352a-20221228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GmwG34WOnnehmf+JqdIsNLaLLdUUliz/XW6HtiMKxJo=;
        b=OkuHOdOwRd3J6Tc+OmcttU1C+Raq0QJK5xNi/GUl442HEuIVlERN8yQ5QoSWXTjfLyJWw05vWMCp7imD8/+qHSxnQ+kb9KCYMR4kil89V9yMUCxnsFy9nP6a4vRpLSaJR02tqVcK94dE014tdArWNU1COMqi/wh77AdCz2+tJ0o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:fda8d6a2-47ab-45a2-b386-1ea3990536ec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:b0868c8a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: dcf7859e10b24e67ae363b780223352a-20221228
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1434721578; Wed, 28 Dec 2022 00:22:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 28 Dec 2022 00:22:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Dec 2022 00:22:54 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>, <daniel@makrotopia.org>,
        <devicetree@vger.kernel.org>, <fparent@baylibre.com>,
        <ikjn@chromium.org>, <johnson.wang@mediatek.com>,
        <jose.exposito89@gmail.com>, <kernel@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <msp@baylibre.com>,
        <mturquette@baylibre.com>, <nfraprado@collabora.com>,
        <pablo.sun@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <robh+dt@kernel.org>, <ryder.lee@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <weiyi.lu@mediatek.com>, <wenst@chromium.org>,
        <y.oudjana@protonmail.com>, <yangyingliang@huawei.com>
Subject: Re: [PATCH v2 12/23] clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
Date:   Wed, 28 Dec 2022 00:22:54 +0800
Message-ID: <20221227162254.18359-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221223094259.87373-13-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-13-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
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

> As a preparation to increase probe functions commonization across
> various MediaTek SoC clock controller drivers, extend function
> mtk_clk_simple_probe() to be able to register not only gates, but
> also fixed clocks, factors, muxes and composites.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks for doing this! I read the patch 23 first and I thought the
mtk_clk_simple_probe() cannot be used like that. So I got the whole series
and found this patch to extend mtk_clk_simple_probe. Cool.

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
