Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0A6DF2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDLLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDLLR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:17:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472658A57
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:17:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so13882188wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681298169; x=1683890169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oYUJMojD0ryoRHItO91lvPbTnTt0bQOfwf2G2otABA=;
        b=UnMwH+JjCQ8EQWQ9vLoNqgyX+7QvrHcuazJ4jFKYqPcDCdxeNDp+x9SPiRVbE70Vre
         9gx+uV/w0WEcVmrtFYxLaxPFlM3lIO7OzjXijSkfmmgoS00nWPPXm7tsNxSzfpnTt8e8
         xfixhDnKWplpU11hkit9j/B5cKVDVE0MIkifuytYOy3jtopZkV6qK3KzEwRn3Mo0qsB5
         u4U/B7/V4kUdX0s7exfVXuW/VaZtM0scyVFrLyyl+9TEDgeKU8uwRLuZ49NDS3rQPpqJ
         TWE4me1IIa3pUaEV31yVYbdz2C2W+/QL7T30NmjtPygbK6JDnbAiezzdZdF6R+RbJPZ2
         +j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298169; x=1683890169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oYUJMojD0ryoRHItO91lvPbTnTt0bQOfwf2G2otABA=;
        b=RgXrvxw4EUB+7K6p4054PTGBzEhDHTUA3hpVdob/NnUewJ997MGQ22CmaTOoTjZgvl
         rOWEZ6zvB131meQNBZ/stW7ATTJ/8PWnVs1b2DO5Q8w03Qc2z86kl1B4Ray7mVkI4AGF
         x7AaRitbimygJQw6v/I+h9BqGCMxsv8t2N1J9/1UpFPjIaZG1gOAUGkrITQVgnocNQVG
         n5ogNPi4LjQ1y6hKFAg5sa5EPCbuEWM7HEbSX5gdMAFAA3LkRedC9IlvEA+x51uVk7Jt
         Eb0k6KzvLd6nvFq4Ks1n27ic6mOMnM74To1rXpRHLa9PhR+XGbt1DZYVETgYx8PDGZ+R
         fjew==
X-Gm-Message-State: AAQBX9dk9x1Dd9eO5gAm2P57yydlfyXD5VpS3/vU86Y6SBUeGgQJQ2Db
        GMxLdxm499TojgqPgHafv2A=
X-Google-Smtp-Source: AKy350Ytb3nPP2kCpTxqr/Xs1qPJNN6qUvMq7Y9nRQ5UQ+DeYLvOYyNhKVCasxGI+ZcqtJSr3tcJjQ==
X-Received: by 2002:a1c:cc17:0:b0:3eb:9822:f0 with SMTP id h23-20020a1ccc17000000b003eb982200f0mr4214599wmb.30.1681298168974;
        Wed, 12 Apr 2023 04:16:08 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003edc11c2ecbsm2055322wmc.4.2023.04.12.04.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:16:07 -0700 (PDT)
Message-ID: <9f42d92c-c111-1ad7-ea5b-c52efb71d15d@gmail.com>
Date:   Wed, 12 Apr 2023 13:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next 3/3] drm/mediatek: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
 <20230412064635.41315-3-yang.lee@linux.alibaba.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412064635.41315-3-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 08:46, Yang Li wrote:
> Remove variable 'res' and convert platform_get_resource(),
> devm_ioremap_resource() to a single call to
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> index 1773379b2439..5cee84cce0be 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -159,7 +159,6 @@ static int mtk_disp_ccorr_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct mtk_disp_ccorr *priv;
> -	struct resource *res;
>   	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -172,8 +171,7 @@ static int mtk_disp_ccorr_probe(struct platform_device *pdev)
>   		return PTR_ERR(priv->clk);
>   	}
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->regs = devm_ioremap_resource(dev, res);
> +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->regs)) {
>   		dev_err(dev, "failed to ioremap ccorr\n");
>   		return PTR_ERR(priv->regs);
