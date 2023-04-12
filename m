Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1B6DF2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDLLRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDLLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:17:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D8F8692
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:16:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l16so5820411wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681298145; x=1683890145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rRQAYMFQzZ3Z7KU85vDtMZHZSEIGe7IfC6ZvEKTDDQ=;
        b=EQHdnlfwi6nu6QIdLm9Of177q7xeJMgzzi2XQTTToYNjRE61oBqIsDDc0f6ua4qPQ9
         d2gfkkj5fpvOCltBjgHMZzUqRzZJaisNpPyhrHizb7babWJ4LjkuDupe9ckgBaU1Lx1I
         viwMZlC4sTLSSspiNlV/9UiUEwR8lIrvk1YPGWC4XfHWFJXnAR+p4fvt4L8KdC61S3PQ
         CBtF8d8k9drEMxrupXil3qiRyBXXoeq7LJd3B9pXAz8rlxlryF/MNHcSmQyYVRXTYYkD
         0b64WM7qR5s5NleSvhi82dwa34INs+ZfUYsbMBdVGMnXW/LDEAEOiF7oHErYgTjOjnc8
         BXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298145; x=1683890145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rRQAYMFQzZ3Z7KU85vDtMZHZSEIGe7IfC6ZvEKTDDQ=;
        b=ChSVvydyDRsKnBcPtk2NRbsKlw28xbeIfkf5q8PF01ZLXLnNpjXvKLJxlmdbGlp53u
         ATasQE+LHPdKFUY8t8fp4Z/lCbRTvj9lIRrjB2iYiomZZHBQFG6LPc+H2FIu/NDEltSJ
         QWG7i9DK5ez2bpnm9NEQLp4HpwbxDPucy6PHlHTQ3MxESrFYCeIOjnehCgfGj4yAYA7m
         jlzOhW42GP9LnoedSkhN0ZL0Q74JOUyLOPnmJWKoHgS1+RdiwtDLGxkelMO3DnfcupYi
         tTSVKg2Zbzch1kfyjS8CCmGIf6pvwnBI6X13bCpc/a0BHl3r3BXBuLC9iUQbNicHlNdY
         iUPw==
X-Gm-Message-State: AAQBX9fjdhTpOtGDC7TWmcSb35zkLvXectpzAy7BIBA0y4UcsTlgZiS+
        VZuKv1/fnzPXWGjoRpdrVE4=
X-Google-Smtp-Source: AKy350Zm+JQ20RDs5iEIf8/taJMLA27MPvWDySrC8rMlHOZefSmm0Xk3pKeERGIKs4WI+rc0K+uqoA==
X-Received: by 2002:a1c:f716:0:b0:3ef:4138:9eef with SMTP id v22-20020a1cf716000000b003ef41389eefmr12903970wmh.36.1681298144771;
        Wed, 12 Apr 2023 04:15:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm2046961wms.35.2023.04.12.04.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:15:43 -0700 (PDT)
Message-ID: <8d369520-bc2c-e269-aef8-61896adfcd4c@gmail.com>
Date:   Wed, 12 Apr 2023 13:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next 2/3] drm/mediatek: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
 <20230412064635.41315-2-yang.lee@linux.alibaba.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412064635.41315-2-yang.lee@linux.alibaba.com>
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
>   drivers/gpu/drm/mediatek/mtk_disp_aal.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> index 434e8a9ce8ab..391fa0ece22c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> @@ -104,7 +104,6 @@ static int mtk_disp_aal_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct mtk_disp_aal *priv;
> -	struct resource *res;
>   	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -117,8 +116,7 @@ static int mtk_disp_aal_probe(struct platform_device *pdev)
>   		return PTR_ERR(priv->clk);
>   	}
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->regs = devm_ioremap_resource(dev, res);
> +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->regs)) {
>   		dev_err(dev, "failed to ioremap aal\n");
>   		return PTR_ERR(priv->regs);
