Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47A3621AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiKHRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiKHRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:37:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AC15FDA;
        Tue,  8 Nov 2022 09:37:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso12194732wma.1;
        Tue, 08 Nov 2022 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lL7ib0fQfHAIVHKNMEUfuV2w/rUMbmu/eMiez+EADGc=;
        b=YT8bDUSuYGlX0nSv0Gmye3eRq5y7UbhWrZlTinDOm2D4cvZMf0uBi7FXOD/RD83xQD
         ftEA8Oy9SJ2khn9xHaudJCfy0C5C8+J1XVTe/TZJqrUQboYjz9T+6Auu5BcqxQMiJCk9
         UdOU0NgLAak/vV5X9oK8gPFcxQyRDiTPOq0WF1zieFiXoksfSP6SM7MuznRRMKFDeSTs
         vr4uFMd5goEZAPH8EnCKiqptmLyIk0JdgcQYHSmHAS5ZLUJ+8z37Ot2CbG4HKOMt1Rje
         80KqeqTvSDNFxAUoK0/7qt428CD+a2206fRXAs2pSszQXryGl280+QJPRi/VyEnH3o53
         /AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL7ib0fQfHAIVHKNMEUfuV2w/rUMbmu/eMiez+EADGc=;
        b=r7IrAgmOmJNGS+R07l4UcUuDQpY6ouzAkTW4kvyDXD4GohpOM5OO0p3AqjhMAtwG+C
         LNuQbyzPOE1lGJAnLRiTrrY3Yi6Uz96f5cEyumAXDyA1f2g3eXlZN6h9/Yh2R9KFQgXM
         6P1iSNVxRCZIgS1MXR8xJcENsRX0Nj0b00ZGEErKVjqWFmOHyc/pUDXpS5UzwRPhPVsJ
         YpnwcE/sZHfqCd2nBlaERrusBJjzuXia5iFgouJYuWv4odmxIurAUCL2kw0PcgxDKfQn
         nraRm6OivvaMBCXx/++t6dr4rWqUji5B5hALARLJIvZclAiIqy75C2yQvU8PoXV6bIiM
         cyAA==
X-Gm-Message-State: ACrzQf3zdHymFheXUdr1+NL+yB0x9J5gPRfraEvwSTnAtNKHHjPLfD3j
        lDnjxvrWCEdrwKpdfJ7oOTc=
X-Google-Smtp-Source: AMsMyM4ZRxL1bJwjZOpkyyyJeMjJb4TNMK6d9bQf6wA8GOKPj1utSTr6/nojgUJfPKlu3A5LPUB2tA==
X-Received: by 2002:a05:600c:4ecf:b0:3cf:8762:1a67 with SMTP id g15-20020a05600c4ecf00b003cf87621a67mr24970726wmq.41.1667929042011;
        Tue, 08 Nov 2022 09:37:22 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d4b12000000b002365f326037sm13165230wrq.63.2022.11.08.09.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 09:37:20 -0800 (PST)
Message-ID: <58d55016-afc7-e560-32cf-8228794b5752@gmail.com>
Date:   Tue, 8 Nov 2022 18:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v28 05/11] soc: mediatek: refine code to use
 mtk_mmsys_update_bits API
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        nfraprado@collabora.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221107072243.15748-1-nancy.lin@mediatek.com>
 <20221107072243.15748-6-nancy.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221107072243.15748-6-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 08:22, Nancy.Lin wrote:
> Simplify code for update  mmsys reg.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 45 ++++++++++++--------------------
>   1 file changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 9a327eb5d9d7..73c8bd27e6ae 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -99,22 +99,27 @@ struct mtk_mmsys {
>   	struct reset_controller_dev rcdev;
>   };
>   
> +static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(mmsys->regs + offset);
> +	tmp = (tmp & ~mask) | (val & mask);

I'm not sure about the change in the implementation of mtk_mmsys_update_bits(). 
Nicolas tried to explain it to me on IRC but I wasn't totally convincing. As we 
have to go for at least another round of this patches, I'd like to get a clear 
understanding while it is needed that val bits are set to 1 in the mask.

Regards,
Matthias

> +	writel_relaxed(tmp, mmsys->regs + offset);
> +}
> +
>   void mtk_mmsys_ddp_connect(struct device *dev,
>   			   enum mtk_ddp_comp_id cur,
>   			   enum mtk_ddp_comp_id next)
>   {
>   	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
>   	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
> -	u32 reg;
>   	int i;
>   
>   	for (i = 0; i < mmsys->data->num_routes; i++)
> -		if (cur == routes[i].from_comp && next == routes[i].to_comp) {
> -			reg = readl_relaxed(mmsys->regs + routes[i].addr);
> -			reg &= ~routes[i].mask;
> -			reg |= routes[i].val;
> -			writel_relaxed(reg, mmsys->regs + routes[i].addr);
> -		}
> +		if (cur == routes[i].from_comp && next == routes[i].to_comp)
> +			mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask,
> +					      routes[i].val);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>   
> @@ -124,27 +129,14 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>   {
>   	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
>   	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
> -	u32 reg;
>   	int i;
>   
>   	for (i = 0; i < mmsys->data->num_routes; i++)
> -		if (cur == routes[i].from_comp && next == routes[i].to_comp) {
> -			reg = readl_relaxed(mmsys->regs + routes[i].addr);
> -			reg &= ~routes[i].mask;
> -			writel_relaxed(reg, mmsys->regs + routes[i].addr);
> -		}
> +		if (cur == routes[i].from_comp && next == routes[i].to_comp)
> +			mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask, 0);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>   
> -static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
> -{
> -	u32 tmp;
> -
> -	tmp = readl_relaxed(mmsys->regs + offset);
> -	tmp = (tmp & ~mask) | val;
> -	writel_relaxed(tmp, mmsys->regs + offset);
> -}
> -
>   void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val)
>   {
>   	if (val)
> @@ -161,18 +153,13 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
>   {
>   	struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
>   	unsigned long flags;
> -	u32 reg;
>   
>   	spin_lock_irqsave(&mmsys->lock, flags);
>   
> -	reg = readl_relaxed(mmsys->regs + mmsys->data->sw0_rst_offset);
> -
>   	if (assert)
> -		reg &= ~BIT(id);
> +		mtk_mmsys_update_bits(mmsys, mmsys->data->sw0_rst_offset, BIT(id), 0);
>   	else
> -		reg |= BIT(id);
> -
> -	writel_relaxed(reg, mmsys->regs + mmsys->data->sw0_rst_offset);
> +		mtk_mmsys_update_bits(mmsys, mmsys->data->sw0_rst_offset, BIT(id), BIT(id));
>   
>   	spin_unlock_irqrestore(&mmsys->lock, flags);
>   
