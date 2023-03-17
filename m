Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513FA6BF28C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCQU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCQU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:29:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA211E83
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:28:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w22-20020a9d77d6000000b0069d2032f98aso3432368otl.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6aACPxqUIkT43mYqyKmb1AfW+xFiyWxFJZz7u1wr14=;
        b=BK2YPfUrlvlvCpE5wWvAfGtxE42u5BfYuYZKVaciH8+4uYZX7GpPrMm5mb3PdJLbUz
         0774aS4o9dju6/pZU36KHlOLsF5K4eToLOJiVXf5BA0PMHLjv1wT0O2pUsLEBscc4g0Y
         AfsQq2/KaseSDEszHEAAENK8J/FWWaCXSU0P1pz8ufCWcBVmO+aZqsF95D1alcQCdKrg
         W5GYP8U7J2OSnnqpGNbIcQGFfdFsjNbptLkaw59Dk1TehddL+K66J6YaXh0BeqewrWa3
         7S2ssuFwzZ7L1p0lvjeuqdAtQAw81dy9M1IUhQyMV0j+55Y7WT9Lx1Oc+EhkeVMyDbBK
         9bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6aACPxqUIkT43mYqyKmb1AfW+xFiyWxFJZz7u1wr14=;
        b=O8PPZY+/kxwVkRG8Qap7f5fysRN3+ufBfk8/09AwurtHZJ7Sr1SKnamM3TF+0YOoas
         kK0dKLJ01COfE8HCJ4slxzoBexacRCLYiDYCfKvaFg0e2eKy+j+XxrlOiLGH27jzfZtW
         nA/qU0nlCgB0oPcE+iHows1+TshMv9XbnrIXs8Wl/fjm2W9ED6L2Ek/lVnLzVV/AtnIE
         v5TRSy4g8TwidzvPei0feKJCHPi3y0pjsQY31IprEnPkrqLnMmX3Ns3Hrg6mlvylje4B
         Winb806SMI1ceFCLWp9dPRJjn6DYWrXzULkYs6otdVALi23K27iavrgHfEP+v57wff2B
         NM/g==
X-Gm-Message-State: AO0yUKVCown0mgRUI0XMzdzhTgK+aFXIyAeGa4qm+kltYw1YEX/J+wna
        3XO2QEQfjbIstsiqQw3LTKN3mpmFAIWsD6NnEVeAD9u/
X-Google-Smtp-Source: AK7set89ivnYrpU/9WVegkro6qNkp52C0d5j3e3YbnZDjwyaG5GuwZIaR6q+pX0wiaVxWqyxhvnZYJZ/su7IHQ8TtIs=
X-Received: by 2002:a05:6830:1e38:b0:69b:af37:6f9a with SMTP id
 t24-20020a0568301e3800b0069baf376f9amr315445otr.3.1679084926751; Fri, 17 Mar
 2023 13:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-20-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-20-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:28:35 -0400
Message-ID: <CADnq5_NhOpGd0rG_TVFFfZsk9aFy6Lu+nJ87TdTKAubkXpomXw@mail.gmail.com>
Subject: Re: [PATCH 19/37] drm/amd/pm/swsmu/smu11/vangogh_ppt: Provide a
 couple of missing parameter descriptions
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Li Ma <li.ma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
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

Alex

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:2381: warning=
: Function parameter or member 'residency' not described in 'vangogh_get_gf=
xoff_residency'
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:2399: warning=
: Function parameter or member 'entrycount' not described in 'vangogh_get_g=
fxoff_entrycount'
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Li Ma <li.ma@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 4590374251f3b..7433dcaa16e04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2389,6 +2389,7 @@ static u32 vangogh_set_gfxoff_residency(struct smu_=
context *smu, bool start)
>   * vangogh_get_gfxoff_residency
>   *
>   * @smu: amdgpu_device pointer
> + * @residency: placeholder for return value
>   *
>   * This function will be used to get gfxoff residency.
>   *
> @@ -2407,6 +2408,7 @@ static u32 vangogh_get_gfxoff_residency(struct smu_=
context *smu, uint32_t *resid
>   * vangogh_get_gfxoff_entrycount - get gfxoff entry count
>   *
>   * @smu: amdgpu_device pointer
> + * @entrycount: placeholder for return value
>   *
>   * This function will be used to get gfxoff entry count
>   *
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
