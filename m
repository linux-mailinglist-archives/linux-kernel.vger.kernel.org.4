Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3117202F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjFBNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjFBNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:16:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D98E40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:16:37 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-19674cab442so1749345fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711797; x=1688303797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYau0cpbmF2229LuNjRzjCtrizI+QeTZguYhYONJy44=;
        b=LuzsAfDBmOXD0EjIKMI778fOAdZKeFBo41VobCgstmoY1/9Sb5y/hJtf8J/htg1KEK
         CXovctuAqQkHDS2ta0Q6S4lVE7x19yWwFK1tm8bgXOPChuX2XncVYGdiQ+Enh62ibdMq
         lc7JcbzaURSNxlebc9q5PUeYyWd4xzNUM3d70ID/4osQaCkhCDD/YnZyNr00P5L7udNp
         OH426YdJir+Yv64VqpxKg96iTXxY9uId9gcCWpkU6kYVT1zExCUeD3m1cpnXPf+CkZgq
         n+dVEfuX6RgD3nRO7E5lCTGLxJhJKos3g+/rCujzArni+nPzSzxxozANwFJo2F4bSuBc
         xisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711797; x=1688303797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYau0cpbmF2229LuNjRzjCtrizI+QeTZguYhYONJy44=;
        b=RToNGOIlqcIQYkUIzWqqbPS+953ssx58jhCbfkXS3sGVxfc1fln4+BRoJvdwicJXN5
         fM1We/eh9CF0lXgpze/LMa1QuSCc2Aq92NR++Ayb1cYXkS0j+fXdSEll13WbcBkDvtcj
         +h/s06/KsyNU8+7LhQkAiUKWOLJNW2aNDAAaM0mLNzFadpsO8x7hlTbNrht/Y/MrFodf
         OHxN37bjeaRzBz4IY/LejTIUq3vUjFvYn1/psjpmyoHlvDzY/+cyjKlNkErfKRXO0coR
         YC6jpTlaqJqW6qhaqfS+aSwDCjPp2lyxa4yqSvGWkImFFUD4ktc6l+cYw2LwKYjygOh7
         My7A==
X-Gm-Message-State: AC+VfDwTI7YTil4rzJQ4Bdhcnj6nOrKt4H3yPVUFHseYwBAaQ2k4AdPl
        8OUhhDprbRH4HlEDpme9zQnhgGkZQdKmpf0EkmE=
X-Google-Smtp-Source: ACHHUZ4d+mPkSE0hu7HbOz7ZkhsDyhfO7It5De8ZVs8k1eJrsdMkPa7OxS3RePrIKnDAMZGlNipapCXHq7t4gt5/JvM=
X-Received: by 2002:a05:6870:709:b0:19f:ce38:f01 with SMTP id
 ea9-20020a056870070900b0019fce380f01mr1358399oab.30.1685711797050; Fri, 02
 Jun 2023 06:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230602061650.115385-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230602061650.115385-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 2 Jun 2023 09:16:26 -0400
Message-ID: <CADnq5_NzXJezQNVSUY4D9cWg1TuBu3AS_HEmQFaoQHuczQeVbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jun 2, 2023 at 2:17=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:614 amdgpu_gfx_enable_kcq() warn:=
 inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5377
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a33d4bc34cee..37a8f43cf281 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -611,8 +611,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
>         kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 j =3D i + xcc_id * adev->gfx.num_compute_rings;
> -                       kiq->pmf->kiq_map_queues(kiq_ring,
> -                                                &adev->gfx.compute_ring[=
j]);
> +               kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_rin=
g[j]);
>         }
>
>         r =3D amdgpu_ring_test_helper(kiq_ring);
> --
> 2.20.1.7.g153144c
>
