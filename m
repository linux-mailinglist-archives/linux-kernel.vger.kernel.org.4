Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A495711820
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbjEYU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:28:40 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9643B119
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:28:39 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-55586f22ab7so40354eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685046519; x=1687638519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKNlFiicj++lChdv/3D3sNNYrSPfiz6K08kKs405o0I=;
        b=pu21L3a6VrMy6kXBYonuVWC1FyydgEt+EcNYGJOQqHpygK8IclVh3wxrF+V/DzntBb
         IhJn3BewNOONlcqN3gIPbAkFp6xBwD4XJ33Ze27lHaizzCa0OaC6s3W1RPYFtcSMag2b
         PHVMf98o1rhFeidOuDcmvq6PAqEs3eh8iZtt/aDqSQg1QHLFLBmcoZzXVOJ/UN3ebVws
         O6VIrJ9JWVdfcdPuamqrsfEwnIejmnpJ1o/hekPBJX5pGcz1P1vFEFVisCVUwY+/LTU+
         YbIzXvZI7IiF7/bFs21IpP0CDvKAqWY+7OVDpLaL84kLkKD/B2WcepBPmnRHtsgAn5U4
         7qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685046519; x=1687638519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKNlFiicj++lChdv/3D3sNNYrSPfiz6K08kKs405o0I=;
        b=MZevyuscYBFjlHgbBMGrw4W23kiWAzbqGfxyeCyz1fcDrhsnc0uHvPQIvZBdMxQXk5
         rPCp2/Px0m+Y6WncLor69zAMW+avVjcKEGnws0JA6zOa8llQ5gTU/6E4rRNiH/AMZJXj
         Yp5oASy/B3EFgwBcvTIo7hKKwa881NP4kGDfd/pRKlWVx976rC8U4L4wC3DdAkIVrzCH
         W3JP+5wLmN5UA9c1Ki/U19fxt33I2zf+BgULbNhVGF5ELTUBKHrDr4LVVVmNFcbaDczD
         W65B1csYkfqcMnRy8RNYLYQc6xvX+74y6w4SI/Zs3I7ntQU4CntBROj7KEylE0iihcTc
         +AeA==
X-Gm-Message-State: AC+VfDwntev0uy102KQw72A9k+BzwU0Al1nM4kWszWrki7pDkvBZQI/R
        bofficCu3jHepys0YJaAjkHqQxX5+s48TysPhwOeXm5/
X-Google-Smtp-Source: ACHHUZ7YPCy5VU7PLAKnwUVDAqKrgz79mw3IyRfKgUgb2Plnl2/z8CLwxHuomouqCjF7tNL7qLg7sGRYWKR8ZMnbFKE=
X-Received: by 2002:a4a:2451:0:b0:555:3212:6e51 with SMTP id
 v17-20020a4a2451000000b0055532126e51mr7234561oov.0.1685046518811; Thu, 25 May
 2023 13:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230525155227.560094-1-robdclark@gmail.com> <20230525155227.560094-2-robdclark@gmail.com>
In-Reply-To: <20230525155227.560094-2-robdclark@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 May 2023 16:28:27 -0400
Message-ID: <CADnq5_Mh-owF5Q9iSOzJDab2i8s=vbupFrO5YKcivse-V5FKsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Remove duplicate fdinfo fields
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Shashank Sharma <shashank.sharma@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:52=E2=80=AFAM Rob Clark <robdclark@gmail.com> wr=
ote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Some of the fields that are handled by drm_show_fdinfo() crept back in
> when rebasing the patch.  Remove them again.
>
> Fixes: 376c25f8ca47 ("drm/amdgpu: Switch to fdinfo helper")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Series is:
Reviewed-by: <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_fdinfo.c
> index 13d7413d4ca3..a93e5627901a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -80,23 +80,20 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct=
 drm_file *file)
>
>         amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
>
>         /*
>          * **************************************************************=
****
>          * For text output format description please see drm-usage-stats.=
rst!
>          * **************************************************************=
****
>          */
>
>         drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> -       drm_printf(p, "drm-driver:\t%s\n", file->minor->dev->driver->name=
);
> -       drm_printf(p, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev,=
 fn);
> -       drm_printf(p, "drm-client-id:\t%Lu\n", vm->immediate.fence_contex=
t);
>         drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>         drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>         drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
>         drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
>                    stats.visible_vram/1024UL);
>         drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>                    stats.evicted_vram/1024UL);
>         drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
>                    stats.evicted_visible_vram/1024UL);
>         drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> --
> 2.40.1
>
