Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A96DB2C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDGSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:25:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B44227
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:25:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id kq3so40590943plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680891902; x=1683483902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqDA4WRbqZ8pZx3U3y6YYJyg8kkdxxYYCziSSoMs6f4=;
        b=IxJT4QMtg5r1G4F+GoM/q1tJVSZvAIzcvgcNYRgfVw3xxAXMfzR1j8kFIJQ5+3LOP1
         3YHWb+PmbJpffDwUvHHaOXgcH2jW/vRq4CF9OWiUG3Yw3QmAQYL8j8U1clL3OB9jmSOy
         OyqeP0yvsylVpyedaCAmYyRhVhsHlrqYdOQkm6zEPNpcuTzw6LZR0eNjDkzB3H5FNkR2
         wu7pPND7ZoQbJtAPGlxSLa4vkDjlLenKV/r5RHZaltDRU/HzSi58qR/dbY+sR1VRcn3Y
         RBguN4BK97kV/rDwV1gdLloP/3QNpzjoWbdXoWTvO7wu3ee35i1j5aMXZ8rUuik0aKWR
         rCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891902; x=1683483902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqDA4WRbqZ8pZx3U3y6YYJyg8kkdxxYYCziSSoMs6f4=;
        b=mhpZbcx2IDHMfcObFYiWi3zP2yivJG95Md4zG4a8JjHB5V0lyckrqvQC5TfoAEVPZC
         PW+EPyQDbW1ndcVNgOEt1LwgaaMND710B95YrtJ9eyQsXmHIDiJs6y7w/8e7sII1VTV4
         AbmwVddBD4Wy6HCKKVQm7Bi0wp8KKuPV8fkBs2kUu8qs/BBsj9hw2xLaVjGi2FDs4JCZ
         hNz07Mlr7tkokXeJNSSQOwoNx4JZ6yATQ7akMM1tHreWOwBpBPvnLpLR1zdSLFj78GS4
         grMA774BmLJ5gxaM5w07iZUCLyFLFStmWUFW+ul9Pg/XWO+ckVEbZI9qWIMuB2IiU6WJ
         4pDQ==
X-Gm-Message-State: AAQBX9dcgkq0iqtulmqCRrXKc+KDALIHccdNF+c399nUVvaqTgMszmam
        X3ExZcCLgYThrrOpDLH4r8GTRczvzL68SbEI6qvb8w==
X-Google-Smtp-Source: AKy350bXQUYcPYmDw9ucdCsVzHEhLhSxuODvj2EavnS9lslRG5I8VtiLzyQAXkkbbqqxnfc/IY218hVz5XmMfH2ovNY=
X-Received: by 2002:a17:902:e54d:b0:19e:f660:81ee with SMTP id
 n13-20020a170902e54d00b0019ef66081eemr1104963plf.2.1680891902021; Fri, 07 Apr
 2023 11:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230331204209.1863060-1-trix@redhat.com>
In-Reply-To: <20230331204209.1863060-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:24:50 -0700
Message-ID: <CAKwvOdmkyXgii52gyD5uO7=BwYu0iJ9QZtbOcusE2PeH24f6uw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr: remove unused loc variable
To:     Tom Rix <trix@redhat.com>
Cc:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        gsamaiya@nvidia.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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

On Fri, Mar 31, 2023 at 1:42=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:7: error: variable
>   'loc' set but not used [-Werror,-Wunused-but-set-variable]
>                 u32 loc, sig, cnt, *meta;
>                     ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Ben, any idea if this was supposed to be used somewhere? If not:

Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/acr/lsfw.c
> index f36a359d4531..bd104a030243 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> @@ -218,7 +218,7 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subd=
ev *subdev,
>                 const struct firmware *hsbl;
>                 const struct nvfw_ls_hsbl_bin_hdr *hdr;
>                 const struct nvfw_ls_hsbl_hdr *hshdr;
> -               u32 loc, sig, cnt, *meta;
> +               u32 sig, cnt, *meta;
>
>                 ret =3D nvkm_firmware_load_name(subdev, path, "hs_bl_sig"=
, ver, &hsbl);
>                 if (ret)
> @@ -227,7 +227,6 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subd=
ev *subdev,
>                 hdr =3D nvfw_ls_hsbl_bin_hdr(subdev, hsbl->data);
>                 hshdr =3D nvfw_ls_hsbl_hdr(subdev, hsbl->data + hdr->head=
er_offset);
>                 meta =3D (u32 *)(hsbl->data + hshdr->meta_data_offset);
> -               loc =3D *(u32 *)(hsbl->data + hshdr->patch_loc);
>                 sig =3D *(u32 *)(hsbl->data + hshdr->patch_sig);
>                 cnt =3D *(u32 *)(hsbl->data + hshdr->num_sig);
>
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
