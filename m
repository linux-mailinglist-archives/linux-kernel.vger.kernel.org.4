Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FD75B390A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIINcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIINct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:32:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53371138654
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:32:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w22-20020a056830061600b006546deda3f9so1062536oti.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fAZyWvk9aIg6HNZZ2qBZvOJO5tyWSXJY6s5pUv95Q0o=;
        b=ftxAh0gsbgkhrMX8rdkibCcKLrQX3RBh0B+cT1gdD3220HnP0VETXI7zIF5k5CN5Vj
         IjxTa8QuYmbtyaLxc6q76DDucWSA0RYEbncJESudDEV1D/HtcEmIhSvxJ4kze5Ws8zk7
         3sne/+dhsQxi54RnakQe3QCflN4019s/aq5PxxRjmQrQA88BX7/3rIjgw4XFeIma/oK1
         xrVObDYyvf4LoOKTTXDOu4yAM9nnGwGDiZ1f81ocOV3LMAhD/pz+v26g6RnC7UG/b0dF
         SSgbXJnSq3OUGqmwQVvapztkJ8m4C38Z/7wBXbwkb+d70vh6NY0ZI6Z3gcxx3d+Ol3u8
         NR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fAZyWvk9aIg6HNZZ2qBZvOJO5tyWSXJY6s5pUv95Q0o=;
        b=1RXuk5fxfTh+DrUTZbp6O2E+h9og0+64LlnGSjAhlplhF7FYj3fT3gzniDswPmd2ny
         GbYMMZ/aU2sYPzui/PXk817cwIJDRTexPfCZg/KRtCvhypK8AnOBStmCiTBCF62yOpsU
         b83Txnpo1V2m/AlRau+36U1nzGbzNJ5+EtQIXtvFrlfTzpWDl2HPP02pXLDbZs/XxbUl
         z7eLHl5pAY9vD5NhuTw61mCUii/CpP2zNFfOTBcYO27VyGvV44u4V2GFWXTGV94d4xA2
         9Gu4SkT+VrlyyV2rDz+tFh/bGuxVsj6qPnBOIe/Z+9L6RXgsDtBMP+sZi4l9iJ5ea7z0
         8b2w==
X-Gm-Message-State: ACgBeo0FBtKoynvM3808V6COymli3yXaEingkNzM5K9DyZAmTnjobAJG
        hjb8oJHd2NiO0CkqZcBVoF9buiCq2WYEM+8cSb8=
X-Google-Smtp-Source: AA6agR60is4ZKlehqzgH5AzaBmaZWtiJzhV8cR+SiPOLEK6lelCHPk7QCiFG75dGkQ36jQBbu7pD5ykSdsyyBvkF/wE=
X-Received: by 2002:a9d:12ce:0:b0:654:9bf:94ee with SMTP id
 g72-20020a9d12ce000000b0065409bf94eemr2655489otg.123.1662730367545; Fri, 09
 Sep 2022 06:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220909114133.267689-1-mwen@igalia.com>
In-Reply-To: <20220909114133.267689-1-mwen@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 09:32:36 -0400
Message-ID: <CADnq5_O8uJT7_LBCEQTVX=p_3Eo1yVQFDSei_rumSbSn7_gGew@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: fix 32bit compilation error by replacing macros
To:     Melissa Wen <mwen@igalia.com>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, igormtorrente@gmail.com,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 7:42 AM Melissa Wen <mwen@igalia.com> wrote:
>
> Replace vkms_formats macros for fixed-point operations with functions
> from drm/drm_fixed.h to do the same job and fix 32-bit compilation
> errors.
>
> Fixes: a19c2ac9858 ("drm: vkms: Add support to the RGB565 format")
> Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/vkms/vkms_formats.c | 53 +++++++++++------------------
>  1 file changed, 19 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 300abb4d1dfe..ddcd3cfeeaac 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -1,27 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
> -#include <drm/drm_rect.h>
> +#include <linux/kernel.h>
>  #include <linux/minmax.h>
> +#include <drm/drm_rect.h>
> +#include <drm/drm_fixed.h>
>
>  #include "vkms_formats.h"
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
>  static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
>  {
>         return frame_info->offset + (y * frame_info->pitch)
> @@ -137,19 +122,19 @@ static void RGB565_to_argb_u16(struct line_buffer *stage_buffer,
>         int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
>                                stage_buffer->n_pixels);
>
> -       s32 fp_rb_ratio = INT_TO_FIXED_DIV(65535, 31);
> -       s32 fp_g_ratio = INT_TO_FIXED_DIV(65535, 63);
> +       s32 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), 31);
> +       s32 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), 63);
>
>         for (size_t x = 0; x < x_limit; x++, src_pixels++) {
>                 u16 rgb_565 = le16_to_cpu(*src_pixels);
> -               s32 fp_r = INT_TO_FIXED((rgb_565 >> 11) & 0x1f);
> -               s32 fp_g = INT_TO_FIXED((rgb_565 >> 5) & 0x3f);
> -               s32 fp_b = INT_TO_FIXED(rgb_565 & 0x1f);
> +               s32 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
> +               s32 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
> +               s32 fp_b = drm_int2fixp(rgb_565 & 0x1f);
>
>                 out_pixels[x].a = (u16)0xffff;
> -               out_pixels[x].r = FIXED_TO_INT_ROUND(FIXED_MUL(fp_r, fp_rb_ratio));
> -               out_pixels[x].g = FIXED_TO_INT_ROUND(FIXED_MUL(fp_g, fp_g_ratio));
> -               out_pixels[x].b = FIXED_TO_INT_ROUND(FIXED_MUL(fp_b, fp_rb_ratio));
> +               out_pixels[x].r = drm_fixp2int(drm_fixp_mul(fp_r, fp_rb_ratio));
> +               out_pixels[x].g = drm_fixp2int(drm_fixp_mul(fp_g, fp_g_ratio));
> +               out_pixels[x].b = drm_fixp2int(drm_fixp_mul(fp_b, fp_rb_ratio));
>         }
>  }
>
> @@ -248,17 +233,17 @@ static void argb_u16_to_RGB565(struct vkms_frame_info *frame_info,
>         int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
>                             src_buffer->n_pixels);
>
> -       s32 fp_rb_ratio = INT_TO_FIXED_DIV(65535, 31);
> -       s32 fp_g_ratio = INT_TO_FIXED_DIV(65535, 63);
> +       s32 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), 31);
> +       s32 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), 63);
>
>         for (size_t x = 0; x < x_limit; x++, dst_pixels++) {
> -               s32 fp_r = INT_TO_FIXED(in_pixels[x].r);
> -               s32 fp_g = INT_TO_FIXED(in_pixels[x].g);
> -               s32 fp_b = INT_TO_FIXED(in_pixels[x].b);
> +               s32 fp_r = drm_int2fixp(in_pixels[x].r);
> +               s32 fp_g = drm_int2fixp(in_pixels[x].g);
> +               s32 fp_b = drm_int2fixp(in_pixels[x].b);
>
> -               u16 r = FIXED_TO_INT_ROUND(FIXED_DIV(fp_r, fp_rb_ratio));
> -               u16 g = FIXED_TO_INT_ROUND(FIXED_DIV(fp_g, fp_g_ratio));
> -               u16 b = FIXED_TO_INT_ROUND(FIXED_DIV(fp_b, fp_rb_ratio));
> +               u16 r = drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
> +               u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
> +               u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
>
>                 *dst_pixels = cpu_to_le16(r << 11 | g << 5 | b);
>         }
> --
> 2.35.1
>
