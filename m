Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6175BDC35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiITFU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITFUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3774D4DD;
        Mon, 19 Sep 2022 22:20:17 -0700 (PDT)
X-UUID: 6b2f51a95ee34dba9f655cd2de500e67-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4nQv18pCIw8SGLAwbUpmj6Xh8P4iaLkLy7yN+PyXPvI=;
        b=ftoappUONeA+80T7w6O2ECTcXJcnSpyidrKcC7xrNaMjdfok5XVcrhgugjhpKUm7p3+KOWhrfO42G4mNNnEd6tpaj/iFWpzHLQJ/LfOiu7bltJSrJyoFPtk9LQ2J9mLHO/mCUO4mK6AaXQ1P88q2Z36j7wGLX7DP3V7JvM6gqP8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b0a522f0-dc95-4ff5-9824-b6fcf3532214,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:b0a522f0-dc95-4ff5-9824-b6fcf3532214,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:ad983b5e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:220920132013CR5P9A5R,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6b2f51a95ee34dba9f655cd2de500e67-20220920
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 196326677; Tue, 20 Sep 2022 13:20:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 20 Sep 2022 13:20:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 20 Sep 2022 13:20:11 +0800
Message-ID: <4a7e5e729f85c112a235e6bdd8bd337f90eabbf5.camel@mediatek.com>
Subject: Re: [PATCH RESEND] dt-bindings: timer: Add compatible for MediaTek
 MT8188
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <daniel.lezcano@linaro.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 20 Sep 2022 13:20:11 +0800
In-Reply-To: <20220818124602.20394-1-johnson.wang@mediatek.com>
References: <20220818124602.20394-1-johnson.wang@mediatek.com>
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

On Thu, 2022-08-18 at 20:46 +0800, Johnson Wang wrote:
> Add dt-binding documentation of timer for MediaTek MT8188 SoC
> platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-
> timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-
> timer.txt
> index f1c848af91d3..8bbb6e94508b 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -25,6 +25,7 @@ Required properties:
>  	For those SoCs that use SYST
>  	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
>  	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
> +	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
>  	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
>  	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
>  	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)

Hi Daniel,

Just a gentle ping on this.
Could you please review this patch and give us some suggestion?

Thanks.


BRs,
Johnson Wang

