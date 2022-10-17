Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B769E60172A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJQTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJQTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:16:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683AF72FE3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:16:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y10so9326316wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsSRW+G2rxl1qTZ7eXeAY8au2TKGPXJ9C9uJXfGontk=;
        b=f58qD0Y01+sBzs963EIbITJY88tl2KpclgURVg6w1N/urjJY33b/Oke7Rt+Zw9sZmZ
         1ePeHXmYHS5g/HvxDh3xrgvXl6ASCAkQClaYXnrH+zkpa5LpX7Uy0PEFKF6G9Hvh+bOR
         TmF2Ny01azJchxKXlbCMA30u89Bf0J4P8Oi6awyklYBgissIA3VueOwscksAl9Y6foEd
         M3HoYUt0tDLZ0GCkLB03yyHm8AHIRM4zoGTOF8GvaEMLgps2+xjGbm4ZpmZ5/pKnwCMN
         4bXZqCT5wJOZifO6OukbnvggvsSFpzwuS/eT7gYFGUBg1jFMrtULhPGlwIcN1nLVGDaA
         xSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsSRW+G2rxl1qTZ7eXeAY8au2TKGPXJ9C9uJXfGontk=;
        b=j+3WpHSVf043Z5LGFiqlpU1UZQIlCvcdf4k3ixWnvKDH0MiJCAtRb1SyaIbiM63nYy
         qPPoDf87UXplI4389AnxDvYhLxiWSNhWgEm7in4XoLYK/hU4kLXauZrlDCu2nzPCDssf
         XAlXG0qCBXZDjz6x3JPftEvvIqntwts62t799Vg+pkxqB1ClC74KLTs2C8JJhCs9tOrB
         0jBHVCuKTVZEqDFxnZiFO6rN5EShZglSUE+ke0jsYHX4FDc6ZHHvOn0QFPc5ZwpHDkqO
         lYzdr8WSUEUBNTsosUOJ1RVO8nl7DVf3ffotpFZMYD+RyDF/DWx8wYuE5D4DVBih4RTY
         C+aA==
X-Gm-Message-State: ACrzQf3JTqsHoVBWenlIUj1xl2NLcCSR4A6RmyNqs/hngiOVdHMynuFl
        SNSBodgyYMgv1Pl/zpVg6Qs=
X-Google-Smtp-Source: AMsMyM50ofQo1mrK+27tOaJQEscKROZJs4JZN2aX9HQe33XcbJRJyVdg/gk9ywf+TgT6EZs33L70bg==
X-Received: by 2002:a05:600c:490f:b0:3c6:2c21:97f6 with SMTP id f15-20020a05600c490f00b003c62c2197f6mr20028931wmp.177.1666034164909;
        Mon, 17 Oct 2022 12:16:04 -0700 (PDT)
Received: from [192.168.2.4] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b003c6edc05159sm9177519wms.1.2022.10.17.12.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 12:16:04 -0700 (PDT)
Message-ID: <8d884b80-ea5d-6c91-fef0-a093affb3247@gmail.com>
Date:   Mon, 17 Oct 2022 21:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [BUG] [PATCH] drm/rockchip: use generic fbdev setup
Content-Language: en-US
To:     John Keeping <john@metanate.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20211029115014.264084-1-john@metanate.com>
 <d814394b-86c3-beb1-ddd4-04c65004f138@gmail.com> <Y00o3M7SKAB/w9sW@donbot>
 <2220890.jZfb76A358@phil> <c4bf7723-b3b8-0955-5ba3-e4d05bdc835a@gmail.com>
 <Y02mRUuecw2C1i+h@donbot>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <Y02mRUuecw2C1i+h@donbot>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/22 21:00, John Keeping wrote:
> On Mon, Oct 17, 2022 at 08:30:23PM +0200, Johan Jonker wrote:
>>
>>
>> On 10/17/22 13:29, Heiko Stuebner wrote:
>>> Am Montag, 17. Oktober 2022, 12:05:16 CEST schrieb John Keeping:
>>>> Hi Johan,
>>>>
>>>> On Mon, Oct 17, 2022 at 10:11:32AM +0200, Johan Jonker wrote:
>>>>> Your patch contribution causes a kernel panic on MK808 with Rockchip rk3066a SoC.
>>>>> Would you like to contribute to fix this issue?
>>>>> The assumtion that drm_fbdev_generic_setup() does what rockchip_drm_fbdev_init did is not true!
>>>>> A revert makes it work again.
>>>>
>>
>>>> It looks like there are 3 different ways to end up with -ENOMEM here,
>>>> can you track down whether you're hitting one of the cases in
>>>> rockchip_gem_prime_vmap() or if it's the iosys_map_is_null case in
>>>> drm_gem_vmap()?
>>
>> It looks like it comes from rockchip_gem_prime_vmap() second return (2).
>>
>>
>> 	if (rk_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
>>
>> ////////////////
>>
>> 		printk("FBDEV rockchip_gem_prime_vmap 2");
>>
>> ////////////////
>> 		return -ENOMEM;
>> 	}
> 
> Ah-ha, Heiko was right that this is because the no-iommu path is broken
> as a result of switching to the generic fbdev code.
> 
> This patch should fix it, but I wonder if Thomas has any ideas about a
> better way to handle this since it feels a bit hacky to special-case the
> fb_helper inside the GEM code:

The penguin is back on screen. Thanks!

> 
> -- >8 --
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index 614e97aaac80..da8a69953706 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -364,9 +364,12 @@ rockchip_gem_create_with_handle(struct drm_file *file_priv,
>  {
>  	struct rockchip_gem_object *rk_obj;
>  	struct drm_gem_object *obj;
> +	bool is_framebuffer;
>  	int ret;
>  
> -	rk_obj = rockchip_gem_create_object(drm, size, false);
> +	is_framebuffer = drm->fb_helper && file_priv == drm->fb_helper->client.file;
> +
> +	rk_obj = rockchip_gem_create_object(drm, size, is_framebuffer);
>  	if (IS_ERR(rk_obj))
>  		return ERR_CAST(rk_obj);
> -- 8< -- 
