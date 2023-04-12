Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C426DF2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjDLLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDLLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:17:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AD4231
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:16:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso11010203wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681298140; x=1683890140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPng0uX84C5bAhSzcWmSxhhcnDr0cY7vCS4LxH5PTLI=;
        b=XMKWPnTXpH9z4caj9fCy5PB0e1zEhMyySW6oD0xZZetZbZnufST4PS5xRV2jfQqUSg
         p3yd0lIwS1EfGyta0ASTxPiy4tU4+WFux713j02I4h2hOrysY+HhyHBzOIwr6bI8fO1z
         69Yc88c/Q27Jw+E5429lWcfLo/G51E7s3XvV6EwyWJwk11NUPxc2u9Nh9uCzswbmcwNy
         Zqu+D5SG01MDbSKNCLapa0tp2VE1x5aLJGoUWzKBoO0F6LUUZXyVfb/fDwVlAGbk0VYP
         6Gn4w0xlNyyYXMVH9UbSFns4TSPlDS25AoA6aVkahjCtf35r07PmWj5UGWXHtFOI9UdY
         FX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298140; x=1683890140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPng0uX84C5bAhSzcWmSxhhcnDr0cY7vCS4LxH5PTLI=;
        b=Dz1dTTcP5CvAopfnwHncnL5P2ZU1W3wwT0v+oYVXUv3Z7pvOWWcfqkTeQps2qY8yts
         QGSvsFyMAGQ00T0qFO3TI010e2+JMwn+P5WK0y6fDY4mHSZjIzyWyxN5Fqni2C7AJ/Pu
         gBrfyJ0ouhwAb+JseAAplHtrq+cVVwq9XHOJqrGpcFpla+cAqlgVuxX6pF1n5LKqsRuU
         /6zJrMpIkg/d3YdRzDMQRFh6VU5n/PFcykPdP+z+ku4XmhAJAhNsLYibFQ6W/VA1C0je
         S/vyVB2TiwgqhoDt3nY8SzFej6VWncI54WxOZzeXHNRf4A3A7amWL3pT5YeTSnW/Oq/y
         JahA==
X-Gm-Message-State: AAQBX9cxFB0q0ghl7v8PBY7Uep8UECBOKnTYqsin+MPSxzYABwzHCD/Y
        Sr7l1k5wEEllBTfoLWfJBqs=
X-Google-Smtp-Source: AKy350ZjmuWZhJ+YDUrMDgqUmQgVF1CFmTs2u1hfTFBUXLq1SFrDwQBWBq4Fho3ErVSJ7XpQ1mNbpw==
X-Received: by 2002:a05:600c:3791:b0:3f0:7f07:e617 with SMTP id o17-20020a05600c379100b003f07f07e617mr1727822wmr.8.1681298139560;
        Wed, 12 Apr 2023 04:15:39 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b002c71b4d476asm16866714wrt.106.2023.04.12.04.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:15:38 -0700 (PDT)
Message-ID: <f3080105-bb30-3d59-c337-3a4afc6f3518@gmail.com>
Date:   Wed, 12 Apr 2023 13:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next 1/3] drm/mediatek: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
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
>   drivers/gpu/drm/mediatek/mtk_cec.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
> index b640bc0559e7..03aae9f95606 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -185,7 +185,6 @@ static int mtk_cec_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct mtk_cec *cec;
> -	struct resource *res;
>   	int ret;
>   
>   	cec = devm_kzalloc(dev, sizeof(*cec), GFP_KERNEL);
> @@ -195,8 +194,7 @@ static int mtk_cec_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, cec);
>   	spin_lock_init(&cec->lock);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	cec->regs = devm_ioremap_resource(dev, res);
> +	cec->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(cec->regs)) {
>   		ret = PTR_ERR(cec->regs);
>   		dev_err(dev, "Failed to ioremap cec: %d\n", ret);
