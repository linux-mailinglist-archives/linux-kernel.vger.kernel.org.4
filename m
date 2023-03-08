Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CAB6B0D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjCHPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjCHPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:17 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3905DEE9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:39:59 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t22so12440066oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678289999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaAUtb/N9UL1YS9AZl0SE37nPbeXIoJeDvkrLAar53k=;
        b=kpbqi66Gx1HUmzbNTjMnEaY0fUaP1rVbAomOrfPAi6GcirN4TmHcJZpl5yUCh4UNdS
         U4IDL+DM0ggo2lH3wHX/dnuTn/mpin2tE/Gj8L7gY5gv/NyN2Gge346/MazBZ4W2N2fg
         jgao/+S/aHEmZbK3Jk6+1IjLZmTiWLxYTTdgbUBb76oHb/wY08vCu88wfQf6y+IOZvao
         H3AML1UGkdJgfPY1UtiJhSHPjt7nNXel5yiWfJ1V8y9HF1dzPGsQ6WMzcHUEekR09tGC
         dcX/F9eBZF3eUUSdNU1G+3HRSSW45zh/JrcRmFjnnocojr2YSAQjfE2mZimv+iTK0ykr
         Nlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678289999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaAUtb/N9UL1YS9AZl0SE37nPbeXIoJeDvkrLAar53k=;
        b=14R1F1/QTcXaRSoseu+X+tozRLR14gL2vHCY/Gw8UfYbTX4FjxLngd7IJgsa7w8lIh
         T5sMhQDaF8mCiNR77Jgm/g4nCTu4xotzgFJJuo4JEzLgcN/e1uHU68gVOf3VWVj/M61c
         vRRpW3mkH0oLCGi3cCA5CdWLNw/bczSj+qje6r5YIMh8zZwxn77jltA5/G+HEMdxhzPH
         DFo3ExntzwaYCz4MZSV//Yvq+Kbwh09inphhMFuw1990xnCbuY+ON8kneEcFebhnsS7H
         ScEfa613GPHY126ZNPXq1l12HuMV6B56FZqQbb2SRmdiFE1/Sn73J3CpqtKZ2iahvRPp
         NdDw==
X-Gm-Message-State: AO0yUKXhSH6VOrBGGJ1bzGJpoDO3CrLVdG47P1Si6CUxj7JHgK2j63OY
        RTf6VB73Y5D4l1BHpkISd/3Hs2GZLaGYXWDkImY=
X-Google-Smtp-Source: AK7set/l1y6f5wm26prcQWrhc6hlrODYBjN/jrOtHMUH61GhN/Z+0wVcB3PTAdG/g3xV47wB9O//ChhmmBH37L39xEw=
X-Received: by 2002:a05:6808:8f7:b0:36e:f6f5:5cf0 with SMTP id
 d23-20020a05680808f700b0036ef6f55cf0mr5499115oic.3.1678289999154; Wed, 08 Mar
 2023 07:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20230308140943.2009970-1-trix@redhat.com>
In-Reply-To: <20230308140943.2009970-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 10:39:47 -0500
Message-ID: <CADnq5_PdEGjvc59HjaYdffrNmAfFWuVe5M23wenHZMyF9LdCOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused variable res_pool
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, lyude@redhat.com, Wayne.Lin@amd.com,
        hersenxs.wu@amd.com, hamza.mahfooz@amd.com, Jerry.Zuo@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 8, 2023 at 9:10 AM Tom Rix <trix@redhat.com> wrote:
>
> With gcc and W=3D1, there is this error
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:121=
4:31:
>   error: variable =E2=80=98res_pool=E2=80=99 set but not used [-Werror=3D=
unused-but-set-variable]
>  1214 |         struct resource_pool *res_pool;
>       |                               ^~~~~~~~
>
> Since res_pool is unused, remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 2739bef9b90c..4b9b5e4050fc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1211,7 +1211,6 @@ static int pre_compute_mst_dsc_configs_for_state(st=
ruct drm_atomic_state *state,
>         bool computed_streams[MAX_PIPES];
>         struct amdgpu_dm_connector *aconnector;
>         struct drm_dp_mst_topology_mgr *mst_mgr;
> -       struct resource_pool *res_pool;
>         int link_vars_start_index =3D 0;
>         int ret =3D 0;
>
> @@ -1220,7 +1219,6 @@ static int pre_compute_mst_dsc_configs_for_state(st=
ruct drm_atomic_state *state,
>
>         for (i =3D 0; i < dc_state->stream_count; i++) {
>                 stream =3D dc_state->streams[i];
> -               res_pool =3D stream->ctx->dc->res_pool;
>
>                 if (stream->signal !=3D SIGNAL_TYPE_DISPLAY_PORT_MST)
>                         continue;
> --
> 2.27.0
>
