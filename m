Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF96DB2B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjDGSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDGSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:17:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445B8BBA3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:17:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-62815785926so1034500b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680891435; x=1683483435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuwimqlPO9HpY2//fLh7FzFmSEeSG4CgWKNzgwGf5e0=;
        b=Pxebkcm9CczGaHvPx5PvvvRnR6vaeDp6HKms/KgNAqJQXvWemgVDWj5OCZHUEsr5j3
         G9LMgv/KajspUvAGyGLQ7Iszic6kbG9P2k5NSjI2veF2IMW/awCFrSItQeZmJWK2XLZ8
         i6eaSk3xj2bQYr9/oCtHhhg4bWIW25XK+DRij7sRFBY0PrKPBfd43oe3kVErQiVRHnnP
         rBC1NfOjx2peA67xPLFCrmXLrsiOeHJW2kZXiKf92yzvKxgztNNJ4tJanifs/JMLrTin
         Iun3CcwO27658Fb0advMSuPzDrAVtKjlY5wElw8gSey5BR3sb1CzIGcoUtpUEIO4NNiT
         hDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891435; x=1683483435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuwimqlPO9HpY2//fLh7FzFmSEeSG4CgWKNzgwGf5e0=;
        b=mMGrVq9BmdyguIzNM4SsUWcusYPoph8pVcMGFwoGUV/Ijm+t9y8rmRoOyBcZFNdYYV
         TlO/u6BWTSy+zPTnqWsT1wsJBgmvKLajV58NsG+ybwZ304w8EBktUGvSNPwivJ6+oZQA
         7F/CZaUX98tOUi+vVt87knMif9UCtqlbq61nyx4yTiSmfTSy2mPLBSO45/rcbKNkK/a9
         g5KRWjq7pgU4w8u7TldtGzkglt2PNGq9rh4j+gvtyiJ/02UIJQlzvikYrr7VlDo+5Y2v
         FMSBPYciEAZCJZT07TizsFD+z6Hn8+YAjySaKC8eYh+lDjjD3PT2OV2UTHLac6MWMjwI
         HtLQ==
X-Gm-Message-State: AAQBX9f/ZTd6Drbie4HImhWbTSI1kcY6Vvl1fQgkSjH4SFEFch3BGFHD
        3UYDIxkPoZmpeVlQNTlKY5wcg0LGHxJ3GNJp0RYwww==
X-Google-Smtp-Source: AKy350Y6wWEggvCrlIf1bje2atujKhf9qMM/qxlunzgcridw/Fvst4ed6hVP1rP9DeneT/1K3zn48LLIF486O17fgc0=
X-Received: by 2002:a05:6a00:2ea8:b0:61c:67d2:a332 with SMTP id
 fd40-20020a056a002ea800b0061c67d2a332mr1427088pfb.3.1680891434554; Fri, 07
 Apr 2023 11:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230331164041.1859088-1-trix@redhat.com>
In-Reply-To: <20230331164041.1859088-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:17:03 -0700
Message-ID: <CAKwvOd=5Uw=6_8erAq0gt_-URUqXgK2ZvtCv5Ch_VZdk01sayQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: remove unused num_of_active_display variable
To:     Tom Rix <trix@redhat.com>
Cc:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, Hawking.Zhang@amd.com,
        kenneth.feng@amd.com, lijo.lazar@amd.com, KevinYang.Wang@amd.com,
        tim.huang@amd.com, andrealmeid@igalia.com, Kun.Liu2@amd.com,
        mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 9:40=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1700:6: error: variab=
le
>   'num_of_active_display' set but not used [-Werror,-Wunused-but-set-vari=
able]
>         int num_of_active_display =3D 0;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Fixes: commit 75145aab7a0d ("drm/amdgpu/swsmu: clean up a bunch of
stale interfaces")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..f93f7a9ed631 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1696,8 +1696,6 @@ static int smu_display_configuration_change(void *h=
andle,
>                                             const struct amd_pp_display_c=
onfiguration *display_config)
>  {
>         struct smu_context *smu =3D handle;
> -       int index =3D 0;
> -       int num_of_active_display =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
> @@ -1708,11 +1706,6 @@ static int smu_display_configuration_change(void *=
handle,
>         smu_set_min_dcef_deep_sleep(smu,
>                                     display_config->min_dcef_deep_sleep_s=
et_clk / 100);
>
> -       for (index =3D 0; index < display_config->num_path_including_non_=
display; index++) {
> -               if (display_config->displays[index].controller_id !=3D 0)
> -                       num_of_active_display++;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
