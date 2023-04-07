Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2506DB2B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDGSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGSVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:21:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4FBC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:21:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ja10so40616406plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680891703; x=1683483703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZdRaKow9MiJw77AIs6HNE5L6Bt+Axun0Z6165dll/w=;
        b=o3WtKycKtV542XSaicFZz0CZ/dev938aAn+qeeNOY8WRyHVIze4YnJcFgiiCsWaJxV
         Ajd71OA0ng3Iisqa/ZJw1jna4z9PJi5fh7kAxvyGHi1kAoeLTxecd7HJsNnkjtM/ct+x
         emcM3MoywW3r3eCx1wcYy4wWI2bv+DS9v1sL47O7H1elmMk597W7oAgHNauc5/iOBFpH
         6Wnov6/4+cfjUr6gNj+wyBLCt4+2Xk9D7yEQQESblpkSTIwBCJElhNz6OS5Rj33wpnKO
         cnOUzmdDfEz++ahqDKTY62TN4cPZL+eaoeUJJFSxTblMU2G2LmxcljBt5McsPw1BoSWu
         m72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891703; x=1683483703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZdRaKow9MiJw77AIs6HNE5L6Bt+Axun0Z6165dll/w=;
        b=s7U1wdip+8YJZG6u/THnoW1PkTA/Wr4qWOyCm4VzruFHN9bUqo6sviMovqe645+scL
         M2N92ZVrB4Ui+ErNSNI1cDlCfTrBxTCslCDhr+Gimu5To8bSBgRdFl1+w3YQ6nTe3RIQ
         Rxa9aZnwOmpo1x+v5rXpnI9GxjZQpY+kOfsFVvdZ9hZsXEWb1xZuJwH3B/t/ScNZBmbZ
         eXS/+8Z9GRtEQrNs9e6k/8Yw8mQBnR/w1YQkFevA84FKvk60GFbj6WYCURrfkL/aI4U9
         ImbKIVLzhLAq3nW0AbggeMFpElrrCpEExADdTjeRZrceOuRDhX1jaS64egeMENZL7E2E
         0RCA==
X-Gm-Message-State: AAQBX9d8N4++KB8CYyO6RvTkO71G3HRd8yYqx2o4C8GzEiDdVo7Tmx9U
        NuqOsVT25uOcUM989UZPutWm7Zn2aBmL/5MoJKHie6DKb7gun3KZQn7Opg==
X-Google-Smtp-Source: AKy350bi6/Eqyz2r683FnPvRwH6NTPyo8wV2nEG2rf8+C/NqkAczhLhuqlNMO7AwVBgrZzZVxiS/kkIt6VR0vqaeXZs=
X-Received: by 2002:a17:902:da85:b0:19f:2aa4:b1e5 with SMTP id
 j5-20020a170902da8500b0019f2aa4b1e5mr1212280plx.2.1680891702918; Fri, 07 Apr
 2023 11:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230331172423.1860083-1-trix@redhat.com>
In-Reply-To: <20230331172423.1860083-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:21:31 -0700
Message-ID: <CAKwvOdkoYTVYeN9G-YB5ADq1Lt35d265pJHCOcy-Ro-22PFM4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: remove unused num_relocs variable
To:     Tom Rix <trix@redhat.com>
Cc:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        fziglio@redhat.com
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

On Fri, Mar 31, 2023 at 10:24=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/qxl/qxl_ioctl.c:149:14: error: variable
>   'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
>         int i, ret, num_relocs;
>                     ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Fixes: 74d9a6335dce ("drm/qxl: Simplify cleaning qxl processing command")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

That commit should also have removed the label out_free_bos IMO since
having two labels for the same statement is a code smell.  Tom, do you
mind sending a v2 with that folded in?

> ---
>  drivers/gpu/drm/qxl/qxl_ioctl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 30f58b21372a..3422206d59d4 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -146,7 +146,7 @@ static int qxl_process_single_command(struct qxl_devi=
ce *qdev,
>         struct qxl_release *release;
>         struct qxl_bo *cmd_bo;
>         void *fb_cmd;
> -       int i, ret, num_relocs;
> +       int i, ret;
>         int unwritten;
>
>         switch (cmd->type) {
> @@ -201,7 +201,6 @@ static int qxl_process_single_command(struct qxl_devi=
ce *qdev,
>         }
>
>         /* fill out reloc info structs */
> -       num_relocs =3D 0;
>         for (i =3D 0; i < cmd->relocs_num; ++i) {
>                 struct drm_qxl_reloc reloc;
>                 struct drm_qxl_reloc __user *u =3D u64_to_user_ptr(cmd->r=
elocs);
> @@ -231,7 +230,6 @@ static int qxl_process_single_command(struct qxl_devi=
ce *qdev,
>                         reloc_info[i].dst_bo =3D cmd_bo;
>                         reloc_info[i].dst_offset =3D reloc.dst_offset + r=
elease->release_offset;
>                 }
> -               num_relocs++;
>
>                 /* reserve and validate the reloc dst bo */
>                 if (reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO || reloc.sr=
c_handle) {
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
