Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3586465739F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiL1HYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiL1HY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:24:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42683F03E;
        Tue, 27 Dec 2022 23:24:22 -0800 (PST)
X-UUID: d1a55c853375401c99250af0c921bfa3-20221228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8TGwloJUAR+sWvzTu+xAmrTJk0LoQNxpn5wak0pwHT4=;
        b=LaxXbvQy8galBgQuPMrHSrwBJ/J5gKF9BqV7tc3eR4K6X57Cyzqy4Ww4nghH5daf/ilmsXg2QcBPLsUIfQOgHIYLA5t2yc5bsn+JrLYfyZfhwtBMVhDwOyvDIT49An3e7GkqoT8/gPMsqOAdTv5nvjkC0xnLzoyGL5dFZLS1yAU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:2115ecdf-936b-47f0-8317-d70b3ff57ced,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:71220253-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d1a55c853375401c99250af0c921bfa3-20221228
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 523258031; Wed, 28 Dec 2022 15:24:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Dec 2022 15:24:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Dec 2022 15:24:14 +0800
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
Subject: Re: [PATCH v2 07/23] clk: mediatek: clk-mtk: Add dummy clock ops
Date:   Wed, 28 Dec 2022 15:24:14 +0800
Message-ID: <20221228072414.26391-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221223094259.87373-8-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-8-angelogioacchino.delregno@collabora.com>
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

Hi Angelo,

> In order to migrate some (few) old clock drivers to the common
> mtk_clk_simple_probe() function, add dummy clock ops to be able
> to insert a dummy clock with ID 0 at the beginning of the list.
>

...snip...
 
> +/*
> + * We need the clock IDs to start from zero but to maintain devicetree
> + * backwards compatibility we can't change bindings to start from zero.
> + * Only a few platforms are affected, so we solve issues given by the
> + * commonized MTK clocks probe function(s) by adding a dummy clock at
> + * the beginning where needed.
> + */
> +#define CLK_DUMMY		0
>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 


-- 
2.39.0


