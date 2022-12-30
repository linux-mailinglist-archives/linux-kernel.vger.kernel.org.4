Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30D1659556
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiL3GNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiL3GNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:13:21 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E813D09;
        Thu, 29 Dec 2022 22:13:18 -0800 (PST)
X-UUID: bd32c86acdc34534b6fac2e47ea9034c-20221230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bLUmYVMEkr7GkCeQonlOFTdxd8xgj9pInHaBtZ4xGv8=;
        b=LcC6plm3opigBM4d+yMaxOQzXvW+dml69aYP1+UpQIKcneNk5MZWIQLqzefZ0Udfyitqbk2h6Zvg8Trp9yWA1QTNzTuuRdW9tIzznYfTR0hv5VhkpXNDRQwPssrTVf98Y+F9cPq8jSwvKYUCiIsjCc4IzAXeQOiNXIJQhqG3Tjo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:a50f772c-442d-44df-8f0a-6a30046c6d4a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.16,REQID:a50f772c-442d-44df-8f0a-6a30046c6d4a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:09771b1,CLOUDID:e68a60f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:221230141313VZASS3OZ,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0
X-CID-BVR: 1,FCT|NGT
X-UUID: bd32c86acdc34534b6fac2e47ea9034c-20221230
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1462043035; Fri, 30 Dec 2022 14:13:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Dec 2022 14:13:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Dec 2022 14:13:09 +0800
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
Subject: Re: [PATCH v2 00/23] MediaTek clocks cleanups and improvements
Date:   Fri, 30 Dec 2022 14:13:09 +0800
Message-ID: <20221230061309.16643-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
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


> Changes in v2:
>  - Moved dt-bindings CLK_DUMMY to clk-mtk.h instead
> 
> 
> This series performs cleanups and improvements on MediaTek clock
> drivers, greatly reducing code duplication (hence also reducing
> kernel size).
> 
> There would be a lot to say about it, but summarizing:
> 
> * Propagates struct device where possible in order to introduce the
>   possibility of using Runtime PM on clock drivers as needed,
>   possibly enhancing reliability of some platforms (obviously, this
>   will do nothing unless power-domains are added to devicetree);
> 
> * Cleans up some duplicated clock(s) registration attempt(s): on
>   some platforms the 26M fixed factor clock is registered early,
>   but then upon platform_driver probe, an attempt to re-register
>   that clock was performed;
> 
> * Removes some early clock registration where possible, moving
>   everything to platform_driver clock probe;
> 
> * Breaks down the big MT8173 clock driver in multiple ones, as it's
>   already done with the others, cleans it up and adds possibility
>   possibility to compile non-boot-critical clock drivers (for 8173)
>   as modules;
> 
> * Extends the common mtk_clk_simple_probe() function to be able to
>   register multiple MediaTek clock types;
> 
> * Removes duplicated [...]_probe functions from multiple MediaTek SoC
>   clock drivers, migrating almost everything to the common functions
>   mtk_clk_simple_probe();
> 
> * Adds a .remove() callback, pointing to the common mtk_clk_simple_remove()
>   function to all clock drivers that were migrated to the common probe;
> 
> * Some more spare cleanups here and there.
> 
> All of this was manually tested on various Chromebooks (with different MTK
> SoCs) and no regression was detected.
> 
> Cheers!

I tested this v2 series on mt6779 and mt8192 without any problem.

thanks,
Miles
