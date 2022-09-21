Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824645BF3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIUCtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIUCs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:48:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44734BD21;
        Tue, 20 Sep 2022 19:48:51 -0700 (PDT)
X-UUID: bb899c095730417f8550dbb20c369c24-20220921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LZ8TKW4921hpmzu6cbHG4qSi1zO+4c+6IQ2eX6a4QM4=;
        b=CmDrPdM/jhHPPWeKlLGjCQBSTtFlSwi1cyd2vsnDYHoT99pZ0pCs0t2CRnwIvj63ELpMM/L11PrE8rQHXtKy+IvHgcT7/XWcKYCmDAQJsJB3PqDDDD4YguAardt4J0h8vwR+l/rtBP8JiHyB5a1Gga5kdN2dc/dqEzKrde5gO/4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:cc08c40f-088e-4c65-82e5-910d3d0df1aa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:d3ed595e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: bb899c095730417f8550dbb20c369c24-20220921
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1279531616; Wed, 21 Sep 2022 10:48:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 21 Sep 2022 10:48:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 21 Sep 2022 10:48:44 +0800
Message-ID: <ca635a06d36a7815ae16013fd916cda682c3ab7c.camel@mediatek.com>
Subject: Re: [PATCH v1 01/17] dt-bindings: clk: mediatek: Add MT8195 DPI
 clocks
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        Pablo Sun <pablo.sun@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>
Date:   Wed, 21 Sep 2022 10:48:44 +0800
In-Reply-To: <20220919-v1-1-4844816c9808@baylibre.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
         <20220919-v1-1-4844816c9808@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Mon, 2022-09-19 at 18:55 +0200, Guillaume Ranquet wrote:
> From: Pablo Sun <pablo.sun@mediatek.com>
> 
> Expand dt-bindings slot for VDOSYS1 of MT8195.
> This clock is required by the DPI1 hardware
> and is a downstream of the HDMI pixel clock.
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> diff --git a/include/dt-bindings/clock/mt8195-clk.h b/include/dt-
> bindings/clock/mt8195-clk.h
> index 95cf812a0b37..d70d017ad69c 100644
> --- a/include/dt-bindings/clock/mt8195-clk.h
> +++ b/include/dt-bindings/clock/mt8195-clk.h
> @@ -859,6 +859,8 @@
>  #define CLK_VDO1_DPINTF				47
>  #define CLK_VDO1_DISP_MONITOR_DPINTF		48
>  #define CLK_VDO1_26M_SLOW			49
> -#define CLK_VDO1_NR_CLK				50
> +#define CLK_VDO1_DPI1_HDMI			50
> +#define CLK_VDO1_NR_CLK				51
> +
>  
>  #endif /* _DT_BINDINGS_CLK_MT8195_H */

Hello Guillaume,

I am not sure the reason, but it seems patches in this series lack of
something like this for whole series:

---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

BRs,
Bo-Chen

