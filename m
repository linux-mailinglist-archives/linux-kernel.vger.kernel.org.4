Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F33749AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGFLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGFLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:39:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF8F199C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:39:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31454996e06so282524f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688643544; x=1691235544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiX0kM9yAvsqqQQcFgblcf3ys13s7viaphie1EL1uOE=;
        b=pQtrCkQbZkFdoLEQ2lrwbmLRAQXkBikr+SYkCsnZJKTiV+WdTB7d/O51bih6j1gf3f
         mWBOTXXGqgnrKps5pCYHLrjeQ5cPvMIJmZSm+59Jogg1DmZcCC5r+fODIxpxR41ms2au
         qMkKw3uslXLBvg7xgPA1JQTNiZSH5MLLSHcnU1ay9HrPEf2Xdx0E1hgVadWmBCralmz7
         t2u512+TSnaDVeqLvSbJbO5llzNQttgG2HawIy0ON0MF1He+76+m1EhGq9g4q6XlOZx9
         mzBHhBdcJ38Q4OtIA7TzfFoFgOf31oVPurR4LQp0lkYxrspDM16cNMnYEV4NIentXAjs
         n/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643544; x=1691235544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiX0kM9yAvsqqQQcFgblcf3ys13s7viaphie1EL1uOE=;
        b=QPGU0ZfoIJW+KiqbCrrXSR0+6kkgqG33KuJXN5HkjQ0eq9ILNtsRRR0dAsqcB+zgiJ
         X96PPpCthPFpKZYttd77THRdhqHmD38c+jPkUGthALB05MEBTEks+IC7FMGyMvKxg20h
         1UJGX8SFFsowWoxswqaJZDWwps4ITtgDTNfnUxD8t3execdWTmqVnSlOERHNc3G6HLVo
         4C64hbKpgcdisBtZfDwuKvRc+lao0/awPGqUVy4rimHTmFtKpzMGh7h7BqBPRIcsmGe5
         Wcwly450h1CZBV5p++rL3f+v++egBn19L6+TVRZTnESivhki28CsRHTIOaFcpppHBx46
         gHvg==
X-Gm-Message-State: ABy/qLbYrGso+uMX/hOV9ZcwHnGV/Hzgcw+KmovOLIt6Gg2aRBvuvS5F
        Q8ZpdHO6tUEpzM7TKPIn1bJB/9vVCnUqpg==
X-Google-Smtp-Source: APBJJlGVQmlrHpXi8l/4jbLYNHmIbdD92pYW9Owm3df69yA1z94eteFsOfVszAadDxRftyQAm4MNDA==
X-Received: by 2002:a05:6000:136f:b0:30e:3f54:f8c9 with SMTP id q15-20020a056000136f00b0030e3f54f8c9mr1158666wrz.10.1688643543915;
        Thu, 06 Jul 2023 04:39:03 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6792000000b003063a92bbf5sm1651041wru.70.2023.07.06.04.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:39:02 -0700 (PDT)
Message-ID: <78b023a0-ce6d-80e2-c8d0-d3d6fde1c928@gmail.com>
Date:   Thu, 6 Jul 2023 13:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/mediatek: Fix potential memory leak if vmap() fail
Content-Language: en-US, ca-ES, es-ES
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230626185801.684451-1-suijingfeng@loongson.cn>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230626185801.684451-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/06/2023 20:58, Sui Jingfeng wrote:
> Also return -ENOMEM if such a failure happens, the implement should take
> responsibility for the error handling.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index a25b28d3ee90..9f364df52478 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -247,7 +247,11 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>   
>   	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
>   			       pgprot_writecombine(PAGE_KERNEL));
> -
> +	if (!mtk_gem->kvaddr) {
> +		kfree(sgt);
> +		kfree(mtk_gem->pages);
> +		return -ENOMEM;
> +	}

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   out:
>   	kfree(sgt);
>   	iosys_map_set_vaddr(map, mtk_gem->kvaddr);
