Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C25B4F77
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIKOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIKOpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:45:11 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D2524087
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:45:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id a1-20020a4ab101000000b0044acf001f83so1038467ooo.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0vIafAUmfHKEkRBn1BJs65Ura+eUXhwSJOGqHqTk/x4=;
        b=NJS4McPgY7YVVhIfIV57csmvoqjvrU55j9D6Wc9iSqTEgRFy8j3qEAE1UjmXRz1U79
         4Htu424fqVQ7e9nJFgPrjdvwIRvzDt18q56G+QHX3nOlCO8JvI/Od8GOYQOIslX4yv5B
         A78rCHbCUulyAHTjhUZE1pqtbLRoxRdAeL26HmfT1WPX7bzaHTMqCNlLBsIOtfPP15hC
         uakI/GSkfR32eNOJOdjotsE2h3knKfnewnV6Yae/BSug5LUVoHMWkEpR0LCCBCVbnxk+
         NCX6uUAlnYzvhpOoOdp3HuPBUZY1DS22UOUG+J+oka0wiwItja82WIKmvLUZt96wRNY/
         3j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0vIafAUmfHKEkRBn1BJs65Ura+eUXhwSJOGqHqTk/x4=;
        b=bHAQLKpD/eirZ5re5lXyQFvyZmfhU2mzlw4aOTXDBNSSLTyKqMGgJiLLcGetzklw8v
         kp4Nv6FY4WeNMg/UD0jzxc+qvNQz7yhuiCzhwz/TpvJ8+M03g/zvBskLM/FMZQKl64Fn
         zNA/Ggnuby1ZjHaAdqGQliR4mG2JsUftPSvUJ13gPMDVhMfoA2kPFnwGTZ0hEV7rHB99
         HX8tFEWn6gp/08JlJxmBgBuLQ/HEt4C8hibXcsjq/QyrbRfpcBSROXbPppN2Uq46YJDG
         9DrZqI5/yTjHWsroOvHpePm3sXuVpI1pWsaYbiGMPnT/PT0XgajD5duQZTQnJR/4kL9F
         nn3w==
X-Gm-Message-State: ACgBeo10AriPwagK1hpfwKjU7WOwiBymSKkQdfieLcYthPjfI2FQzhQr
        t5y2sBE8GVrdMTOuJYnjXng=
X-Google-Smtp-Source: AA6agR5eNz/JoNngMq46UrG0IzKQVetXwwpQIejkcORgK5yAtkWs02KET+QkcF3ofAoLDN9tHD6+zQ==
X-Received: by 2002:a05:6820:1a0d:b0:44b:f59:8354 with SMTP id bq13-20020a0568201a0d00b0044b0f598354mr7856325oob.92.1662907508924;
        Sun, 11 Sep 2022 07:45:08 -0700 (PDT)
Received: from ?IPV6:2804:431:c7f5:f684:ee06:25a5:3122:5cd3? ([2804:431:c7f5:f684:ee06:25a5:3122:5cd3])
        by smtp.gmail.com with ESMTPSA id t6-20020a4a8246000000b0044b491ccf97sm2750663oog.25.2022.09.11.07.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 07:45:08 -0700 (PDT)
Message-ID: <5f6089e5-146a-78c7-6590-4ef0ec1ea043@gmail.com>
Date:   Sun, 11 Sep 2022 11:45:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] drm/vkms: fix 32bit compilation error by replacing
 macros
Content-Language: en-US
To:     Melissa Wen <mwen@igalia.com>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel test robot <lkp@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220910190303.682897-1-mwen@igalia.com>
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
In-Reply-To: <20220910190303.682897-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Igor Torrente <igormtorrente@gmail.com>

On 9/10/22 16:03, Melissa Wen wrote:
> Replace vkms_formats macro for fixed-point operations with functions
> from drm/drm_fixed.h to do the same job and fix 32-bit compilation
> errors.
> 
> v2:
> - don't cast results to s32 (Igor)
> - add missing drm_fixp2int conversion (Igor)
> 
> Fixes: a19c2ac9858 ("drm: vkms: Add support to the RGB565 format")
> Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com> (v1)
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com> (v1)
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 53 +++++++++++------------------
>   1 file changed, 19 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 300abb4d1dfe..d4950688b3f1 100644
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
> +	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> +	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
>   
>   	for (size_t x = 0; x < x_limit; x++, src_pixels++) {
>   		u16 rgb_565 = le16_to_cpu(*src_pixels);
> -		s32 fp_r = INT_TO_FIXED((rgb_565 >> 11) & 0x1f);
> -		s32 fp_g = INT_TO_FIXED((rgb_565 >> 5) & 0x3f);
> -		s32 fp_b = INT_TO_FIXED(rgb_565 & 0x1f);
> +		s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
> +		s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
> +		s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
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
> +	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
> +	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
>   
>   	for (size_t x = 0; x < x_limit; x++, dst_pixels++) {
> -		s32 fp_r = INT_TO_FIXED(in_pixels[x].r);
> -		s32 fp_g = INT_TO_FIXED(in_pixels[x].g);
> -		s32 fp_b = INT_TO_FIXED(in_pixels[x].b);
> +		s64 fp_r = drm_int2fixp(in_pixels[x].r);
> +		s64 fp_g = drm_int2fixp(in_pixels[x].g);
> +		s64 fp_b = drm_int2fixp(in_pixels[x].b);
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

