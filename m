Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50486DB219
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDGRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDGRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:53:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD725597
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:53:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y2so26947949pfw.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889980; x=1683481980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYBbdfYMz/vjcXkNGYT26LJaYJDJYJgOQo589rbtS2s=;
        b=DqKYdsHfDx8zdLJVjdTiTFTABvHWdnCrcEmv1w5HVb7vZJgYb9t4uDuX/Cr9FthsY+
         sNlQf5412FR4vITwMaeTaoKN8vXOBxK5I09sKXDtFLOCDcucYYJqntHqjO3K/idXejnx
         mpjwZtwsKYITG3OUusv3MCa9zgiWgd4qcE93WnOc5b19hJYSRsJv9ND+hyeP42g88eNa
         4M5aWWIG7t2lc67vCrkzFbzHfaMpEH2orbYitLkGcLjlPGiRbePJKxB3XQzuoavzhYGq
         dWt2ylU++nmF7XJzcfQQHXSf1nOsa4/z1PObYwy+i3A5Vf3jwiWGU3HMphpiMtUKlzUK
         V5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889980; x=1683481980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYBbdfYMz/vjcXkNGYT26LJaYJDJYJgOQo589rbtS2s=;
        b=OcgXBvVe7Kd/gv6bT1mpUFMYgwXoZKEeH2BadAqnPGUX6lttzh2D74ayeUEG/ZPaCO
         kWHMzj667ZiAWm6me+HmbsmiFv8Rr2qleuLlKla6aMMD5ghd+TqHCpNHZviDDOjYSQYQ
         3SYayPoNaD/t7pDzvBNKQ7MxJFLxZVR2yPC5ULpiWt83XvrKQYGNjJdJagGb2cPPJdyK
         ttGsD0DWpHRlR/xMeDC4OmNPA8by95HkryVMtQatCqY1IDTAS2bR5gCB284JGVUNCunE
         pOPKqIwR/PhAXf4RKEWHBmxtV9iV5O0k+XC3HFyvSLlqk7MwQvgBhDMAAqNuFGlJTwA4
         N8/A==
X-Gm-Message-State: AAQBX9cZAGnZLp2hdzM14n3/qn86KHF9XU21r88SIDY4mCLjt+7PoAPo
        k3O7rfzrwjgBUfNiDCC663e7cyeRh1Dbjm6tVD01/g==
X-Google-Smtp-Source: AKy350a+v8VTeVHFSzQqt9MX7OgojFeGTP3VMzP+2ISQI5Bm8J3rb6li0V3ygg9UHvL/3/kvKvVCidFCyNNRg0JU/is=
X-Received: by 2002:a65:5b43:0:b0:50f:5f89:2a9d with SMTP id
 y3-20020a655b43000000b0050f5f892a9dmr671939pgr.1.1680889980187; Fri, 07 Apr
 2023 10:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230325134503.1335510-1-trix@redhat.com>
In-Reply-To: <20230325134503.1335510-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:52:49 -0700
Message-ID: <CAKwvOdng_wH8qKnnGN=VpUhLK9q6wyc7sZKO7ORt-3QOKVP_nw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused matching_stream_ptrs variable
To:     Jimmy.Kizito@amd.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, Jun.Lei@amd.com,
        wenjing.liu@amd.com, Cruise.Hung@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jimmy, can you review?

The change LGTM; but I'm not sure if there was something else intended here=
.

On Sat, Mar 25, 2023 at 6:45=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c:625:6: er=
ror:
>   variable 'matching_stream_ptrs' set but not used [-Werror,-Wunused-but-=
set-variable]
>         int matching_stream_ptrs =3D 0;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/driv=
ers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> index 41198c729d90..30c0644d4418 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> @@ -622,7 +622,6 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_s=
tate *state)
>         int i, j;
>         uint8_t valid_count =3D 0;
>         uint8_t dig_stream_count =3D 0;
> -       int matching_stream_ptrs =3D 0;
>         int eng_ids_per_ep_id[MAX_PIPES] =3D {0};
>         int ep_ids_per_eng_id[MAX_PIPES] =3D {0};
>         int valid_bitmap =3D 0;
> @@ -645,9 +644,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_s=
tate *state)
>                 struct link_enc_assignment assignment =3D state->res_ctx.=
link_enc_cfg_ctx.link_enc_assignments[i];
>
>                 if (assignment.valid) {
> -                       if (assignment.stream =3D=3D state->streams[i])
> -                               matching_stream_ptrs++;
> -                       else
> +                       if (assignment.stream !=3D state->streams[i])
>                                 valid_stream_ptrs =3D false;
>                 }
>         }
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
