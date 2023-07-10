Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956BE74DC90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjGJRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGJRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:35:01 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB9FE9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:35:00 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-563439ea4a2so3328445eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689010499; x=1691602499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lNLHcBXTtApGxZhppUoQis59G42kvHVFKXqqsERN5w=;
        b=Tie9dyVfcJItKBW5qwyLx0wwlrCJW7b1aqOZhRFL+u91onLNcZCco4Sigd/T83inz9
         6b6RviZqnZiD3MFiWPU83Kid6khe0q/gdyWy7bxD7mxX+ErLQCZCn8/DxQOdrkhi3Khq
         aPVuOTcqPKI4+wu53FlVyllNIaZ9FMurrSfy/i+lKX1SVE0F02Xjca4CQEEdW531c5FD
         r1oSLMUD3ut0o+0OEteag1xrwj5ehZHNjaeZZH+MjbPGcE6qnUFzTVLNJ3SWAN8PMMr2
         NHBFd7APIqj81WND+j3/ErI1n/UHgHCtu9VGnwRi2MTEWA0WckFuHBQuDbZii9uzuxsH
         8D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010499; x=1691602499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lNLHcBXTtApGxZhppUoQis59G42kvHVFKXqqsERN5w=;
        b=fjFJDhQ/ZD5kuk8a0daD/FurfzNC3qFnFMFkHLAa44BXY56CxGJzV2Qe81CEzvESw2
         0io4rg8VbYQfGkOQeBb9I4N8/i7Qk86ME9ufuVmUnkMPalrL1pLvJ0gE3c43x7dqFrk4
         AvIwi/cu5nc45YwFD8CaT8WolD4V7pEmapMGSnjoTj8n+rH78iHyk6UeGmAL9GWQCc2p
         NLMoAIeWUe1tjgB3QlZS3fmPmxT6+JjkzZkJzaKXLN8awR/TMe2GexFwlgHUura2YH2w
         3EidHaS5VFtoh7R2BBJkPz4fajtq0w+P3i8cJu0xLXbi5F0YC7zGCPi0flw+IXDqZggq
         CnHA==
X-Gm-Message-State: ABy/qLanl0GZnzYRl5LDpPZpnglxpeOwYH8Httbpt5fePUa/ShMmIb0K
        uzVvUVKj2MmeFJd1P+B7H875zER4fFMc02n+cps=
X-Google-Smtp-Source: APBJJlHnXQlhaJFZ9BvVHmlWPcKunuDRQ7cebzO5QwL/a9uYmG/n3mKcEidNp0WncN8mcAFEKm1oErNLqJieuBbSXEg=
X-Received: by 2002:a05:6808:1a1e:b0:3a3:6283:ce94 with SMTP id
 bk30-20020a0568081a1e00b003a36283ce94mr12747718oib.44.1689010499346; Mon, 10
 Jul 2023 10:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230710091057.64085-1-xujianghui@cdjrlc.com> <3a541f425a1ab6d2664a6d74cc4c3a51@208suo.com>
In-Reply-To: <3a541f425a1ab6d2664a6d74cc4c3a51@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jul 2023 13:34:48 -0400
Message-ID: <CADnq5_NHYsquFpZre8hfsJKibEjyEooTGCigBWsfSA7OCEPc=w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: "(foo*)" should be "(foo *)"
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks.  I've applied all the patches you sent out, but all
of them had whitespace problems.  Please double check your mailer on
any future submissions.

Thanks,

Alex

On Mon, Jul 10, 2023 at 6:03=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix five occurrences of the checkpatch.pl error:
> ERROR: "(foo*)" should be "(foo *)"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/radeon_kms.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c
> b/drivers/gpu/drm/radeon/radeon_kms.c
> index e0214cf1b43b..a16590c6247f 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -444,7 +444,7 @@ int radeon_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>               DRM_DEBUG_KMS("timestamp is r6xx+ only!\n");
>               return -EINVAL;
>           }
> -        value =3D (uint32_t*)&value64;
> +        value =3D (uint32_t *)&value64;
>           value_size =3D sizeof(uint64_t);
>           value64 =3D radeon_get_gpu_clock_counter(rdev);
>           break;
> @@ -543,18 +543,18 @@ int radeon_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>           *value =3D rdev->vce.fb_version;
>           break;
>       case RADEON_INFO_NUM_BYTES_MOVED:
> -        value =3D (uint32_t*)&value64;
> +        value =3D (uint32_t *)&value64;
>           value_size =3D sizeof(uint64_t);
>           value64 =3D atomic64_read(&rdev->num_bytes_moved);
>           break;
>       case RADEON_INFO_VRAM_USAGE:
> -        value =3D (uint32_t*)&value64;
> +        value =3D (uint32_t *)&value64;
>           value_size =3D sizeof(uint64_t);
>           man =3D ttm_manager_type(&rdev->mman.bdev, TTM_PL_VRAM);
>           value64 =3D ttm_resource_manager_usage(man);
>           break;
>       case RADEON_INFO_GTT_USAGE:
> -        value =3D (uint32_t*)&value64;
> +        value =3D (uint32_t *)&value64;
>           value_size =3D sizeof(uint64_t);
>           man =3D ttm_manager_type(&rdev->mman.bdev, TTM_PL_TT);
>           value64 =3D ttm_resource_manager_usage(man);
> @@ -614,7 +614,7 @@ int radeon_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>           DRM_DEBUG_KMS("Invalid request %d\n", info->request);
>           return -EINVAL;
>       }
> -    if (copy_to_user(value_ptr, (char*)value, value_size)) {
> +    if (copy_to_user(value_ptr, (char *)value, value_size)) {
>           DRM_ERROR("copy_to_user %s:%u\n", __func__, __LINE__);
>           return -EFAULT;
>       }
