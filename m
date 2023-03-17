Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0B6BF2CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCQUjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCQUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:39:28 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DAC1F900
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:39:21 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y184so4703532oiy.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2ceKigtwCgXknXQIGjyiY2sXOg78OguiBhLG+H+iU0=;
        b=F7NTXlDuv7+z1BobleOBc0RzjNkRncybXR/Z40pNG/5NJ00vWglvmdZcLWvQSAu8o9
         0vM/eWWYUP/2F/sNosphE2DlJnnWrAKAyy0vUfp+q9pWka7l+v0dBJ0JTDFdwr14dwV4
         qpbQN5es849DbZbRstsHGVEQEKDoy0P2oeumDIR7sPrWsviRTQCMoPUown0o9FXfMMzj
         IGyIMPZzJL7fZuA69a/x0CuYlKgDoM34lBsqu6tTFCYYd/ODOZbSIg9aupD44K674Mdw
         QDqrb2MMUjaD/n+dSrVXs90YvQpONuYZQY/7ixBluCMoZ72av/q1J1MYHSZEYDUjHlp9
         CNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2ceKigtwCgXknXQIGjyiY2sXOg78OguiBhLG+H+iU0=;
        b=mn9TRw33Q1AifmF31YCdnJh/gIv8ZJ3DRjk02OBZWOxRxCET8jio2LmPbtIpAp/FJ4
         OZSqYTLnhIjuebPV92MM6m94Tzaaov8O1jwTovW9G+0ssmd5gEKyI1S/09z/gfqQH93a
         XndrxN2UU21FvvK9nnUMS4zC63m9juobVOC+9yBAIvlcOJdK74HTXVh8RpdkEiiyeJPu
         791jKAcGj+mxGv9Y/jqp1t8c/wM+MSCIJKZ+c0uCCwQIPPlirorB8ebZSVDUObhtmkRo
         06ZoBFe2nA4y79Y9fNidcRgEuUDPZnZU197Ei+x8SuimZRu7UIRRXOD9DEK/NV0qS/Nw
         ZzMA==
X-Gm-Message-State: AO0yUKW1GpDh+PUebcPBuNvBskZEpGNqeoecVA9KGd/Y/xB+RC/Q2i4B
        Y9TZUp+6ioGLUD0hfgIfT4gjC1gwnUr27O2Pr4g=
X-Google-Smtp-Source: AK7set+b+3oyu0svFygRamnRBQc9qzNVoS/CNFRldG8LQY67XtnAE+vykp7jKoBeOi7sUvON7HXb4M7gFbjdNQ7cXLQ=
X-Received: by 2002:a54:449a:0:b0:384:692c:56c9 with SMTP id
 v26-20020a54449a000000b00384692c56c9mr3625036oiv.3.1679085558766; Fri, 17 Mar
 2023 13:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-31-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-31-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:39:07 -0400
Message-ID: <CADnq5_M4Zq4AQJVVw8f1k_M4xTygzPzbYoNdHQV27T76uk=2tw@mail.gmail.com>
Subject: Re: [PATCH 30/37] drm/amd/display/dc/link/protocols/link_dp_training:
 Remove set but unused variable 'result'
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Wenjing Liu <wenjing.liu@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training=
.c: In function =E2=80=98perform_link_training_with_retries=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training=
.c:1586:38: warning: variable =E2=80=98result=E2=80=99 set but not used [-W=
unused-but-set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c   | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_traini=
ng.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index a9025671ee4a8..10261764a0cea 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -1580,8 +1580,7 @@ bool perform_link_training_with_retries(
>                                  * Report and continue with eDP panel mod=
e to
>                                  * perform eDP link training with right s=
ettings
>                                  */
> -                               bool result;
> -                               result =3D cp_psp->funcs.enable_assr(cp_p=
sp->handle, link);
> +                               cp_psp->funcs.enable_assr(cp_psp->handle,=
 link);
>                         }
>                 }
>
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
