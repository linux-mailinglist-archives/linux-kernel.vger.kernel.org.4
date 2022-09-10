Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB15B43B6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 04:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIJCIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 22:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJCIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 22:08:53 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA1ED3A4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 19:08:52 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1225219ee46so8614967fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 19:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=r2jR76pxcnzfEkuXxQEgboRlqq/3zLn/QAJVxQMJjhw=;
        b=XgFkpvaLUEplPZYAaADayPuYDtyHmcZNFIrrliJwgJjpYycsb3HsMZ2tt+jEXpCVC2
         zJEQc8bEDtlgRLK6HCAseM2mEOOmgQUmRt1xc/St8Xbs/UPeAEJt7spqK0b/hgZ/a1P0
         QIfo+Vn80askIpx9cZ265WytlfL0QTgVOiizKvobZBEYWZ7WaYGjZZoazVeqSdAd31cG
         dUQCygWXyeLuMe/Sy2sOhG9ke2h1l4ZMYBw+uZPottyfNJmYpA6pWE0JRNGKb94y9BwN
         Nad7N51kf4tqvFARhw01HpEpmU+AmKkd/kpe05AG3OYemHrnilJZC4lGtb5xJ2qW1Q0h
         Chqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=r2jR76pxcnzfEkuXxQEgboRlqq/3zLn/QAJVxQMJjhw=;
        b=H0OkBKG2CPsf4XXwNptAxNE7futWbwhINmI89SneXCQdNpInJWs4aOwo+jgAUJ/O9F
         j3kTqNbc9jOK6Og7pyg8t5V6oadveuEShpMHZ3J3uQzFaYtxNhbGChqXHe9c6qVCY1Jz
         p0HuHgIuwL/z/OOfG6MLXoxEOsol7dQUXb1pkZF1/IdPddXx1UtFrzvtp8EFqIS9Go9X
         3VbFXQM8wO1rn8b3axM0XU9bOzu5lfCG1aEFSovld0agCVPTL8NKFV4+Z4IhEzRHgbrX
         XUx3w+JwELgj/XkGfxV916Ivdj0MU/MmMBRRMxI4fzm8Lq6WWVIa5sV0XCSqP6M374JB
         rAjg==
X-Gm-Message-State: ACgBeo15ggwfBpvq8M1O0ui0oF9ybWNE+jtZxg4wFREtX4gOmf8NLDtk
        oj8fcz14HHCF66cOBpw3mn8=
X-Google-Smtp-Source: AA6agR7w+5cbzIwBNJSi6sudshLuVwEPEb4r7H6NpxVljo9MuYqnhjbdXtjNN0hwEnw1Fnfd3iZtJw==
X-Received: by 2002:a05:6870:41d0:b0:126:5d06:28a5 with SMTP id z16-20020a05687041d000b001265d0628a5mr6570419oac.181.1662775731403;
        Fri, 09 Sep 2022 19:08:51 -0700 (PDT)
Received: from ?IPV6:2804:431:c7f5:f684:ee06:25a5:3122:5cd3? ([2804:431:c7f5:f684:ee06:25a5:3122:5cd3])
        by smtp.gmail.com with ESMTPSA id f3-20020a4ac483000000b0047271772dd0sm584296ooq.19.2022.09.09.19.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 19:08:51 -0700 (PDT)
Message-ID: <29f87796-b288-7cdc-86dd-050cf7f0b5dd@gmail.com>
Date:   Fri, 9 Sep 2022 23:08:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] drm/vkms: fix 32bit compilation error by replacing macros
Content-Language: en-US
To:     Melissa Wen <mwen@igalia.com>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220909114133.267689-1-mwen@igalia.com>
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
In-Reply-To: <20220909114133.267689-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mellisa,

Thanks for the patch fixing my mistakes.

On 9/9/22 08:41, Melissa Wen wrote:
> Replace vkms_formats macros for fixed-point operations with functions
> from drm/drm_fixed.h to do the same job and fix 32-bit compilation
> errors.
> 
> Fixes: a19c2ac9858 ("drm: vkms: Add support to the RGB565 format")
> Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 53 +++++++++++------------------
>   1 file changed, 19 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 300abb4d1dfe..ddcd3cfeeaac 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -1,27 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -#include <drm/drm_rect.h>
> +#include <linux/kernel.h>
>   #include <linux/minmax.h>
> +#include <drm/drm_rect.h>
> +#include <drm/drm_fixed.h>
>   
>   #include "vkms_formats.h"
>   
> -/* The following macros help doing fixed point arithmetic. */
> -/*
> - * With Fixed-Point scale 15 we have 17 and 15 bits of integer and fractional
> - * parts respectively.
> - *  | 0000 0000 0000 0000 0.000 0000 0000 0000 |
> - * 31                                          0
> - */
> -#define SHIFT 15
> -
> -#define INT_TO_FIXED(a) ((a) << SHIFT)
> -#define FIXED_MUL(a, b) ((s32)(((s64)(a) * (b)) >> SHIFT))
> -#define FIXED_DIV(a, b) ((s32)(((s64)(a) << SHIFT) / (b)))
> -/* This macro converts a fixed point number to int, and round half up it */
> -#define FIXED_TO_INT_ROUND(a) (((a) + (1 << (SHIFT - 1))) >> SHIFT)
> -#define INT_TO_FIXED_DIV(a, b) (FIXED_DIV(INT_TO_FIXED(a), INT_TO_FIXED(b)))
> -#define INT_TO_FIXED_DIV(a, b) (FIXED_DIV(INT_TO_FIXED(a), INT_TO_FIXED(b)))
> -
>   static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
>   {
>   	return frame_info->offset + (y * frame_info->pitch)
> @@ -137,19 +122,19 @@ static void RGB565_to_argb_u16(struct line_buffer *stage_buffer,
>   	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
>   			       stage_buffer->n_pixels);
>   
> -	s32 fp_rb_ratio = INT_TO_FIXED_DIV(65535, 31);
> -	s32 fp_g_ratio = INT_TO_FIXED_DIV(65535, 63);
> +	s32 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), 31);
> +	s32 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), 63);

I think you need to add `drm_int2fixp` to 31 and 63.

>   
>   	for (size_t x = 0; x < x_limit; x++, src_pixels++) {
>   		u16 rgb_565 = le16_to_cpu(*src_pixels);
> -		s32 fp_r = INT_TO_FIXED((rgb_565 >> 11) & 0x1f);
> -		s32 fp_g = INT_TO_FIXED((rgb_565 >> 5) & 0x3f);
> -		s32 fp_b = INT_TO_FIXED(rgb_565 & 0x1f);
> +		s32 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
> +		s32 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
> +		s32 fp_b = drm_int2fixp(rgb_565 & 0x1f);

And we are cast implicitly from 64 bits int to 32 bits which is 
implementation-defined AFAIK. So, probably we should be using `s64` for 
all of these variables.

I tested the patch. And I'm seeing some differences in the intermediate 
results. From my testing, these changes solve those differences.

Another thing that may have an impact on the final output is the lack of 
rounding in drm_fixed.h. This can potentially produce the wrong result.

Thanks,
---
Igor Torrente

>   
>   		out_pixels[x].a = (u16)0xffff;
> -		out_pixels[x].r = FIXED_TO_INT_ROUND(FIXED_MUL(fp_r, fp_rb_ratio));
> -		out_pixels[x].g = FIXED_TO_INT_ROUND(FIXED_MUL(fp_g, fp_g_ratio));
> -		out_pixels[x].b = FIXED_TO_INT_ROUND(FIXED_MUL(fp_b, fp_rb_ratio));
> +		out_pixels[x].r = drm_fixp2int(drm_fixp_mul(fp_r, fp_rb_ratio));
> +		out_pixels[x].g = drm_fixp2int(drm_fixp_mul(fp_g, fp_g_ratio));
> +		out_pixels[x].b = drm_fixp2int(drm_fixp_mul(fp_b, fp_rb_ratio));
>   	}
>   }
>   
> @@ -248,17 +233,17 @@ static void argb_u16_to_RGB565(struct vkms_frame_info *frame_info,
>   	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
>   			    src_buffer->n_pixels);
>   
> -	s32 fp_rb_ratio = INT_TO_FIXED_DIV(65535, 31);
> -	s32 fp_g_ratio = INT_TO_FIXED_DIV(65535, 63);
> +	s32 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), 31);
> +	s32 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), 63);
>   
>   	for (size_t x = 0; x < x_limit; x++, dst_pixels++) {
> -		s32 fp_r = INT_TO_FIXED(in_pixels[x].r);
> -		s32 fp_g = INT_TO_FIXED(in_pixels[x].g);
> -		s32 fp_b = INT_TO_FIXED(in_pixels[x].b);
> +		s32 fp_r = drm_int2fixp(in_pixels[x].r);
> +		s32 fp_g = drm_int2fixp(in_pixels[x].g);
> +		s32 fp_b = drm_int2fixp(in_pixels[x].b);
>   
> -		u16 r = FIXED_TO_INT_ROUND(FIXED_DIV(fp_r, fp_rb_ratio));
> -		u16 g = FIXED_TO_INT_ROUND(FIXED_DIV(fp_g, fp_g_ratio));
> -		u16 b = FIXED_TO_INT_ROUND(FIXED_DIV(fp_b, fp_rb_ratio));
> +		u16 r = drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
> +		u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
> +		u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
>   
>   		*dst_pixels = cpu_to_le16(r << 11 | g << 5 | b);
>   	}

