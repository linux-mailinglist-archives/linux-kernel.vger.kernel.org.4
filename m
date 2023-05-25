Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB1711851
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEYUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjEYUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:42:36 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E912F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:42:21 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-557c9d7011aso130046eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685047341; x=1687639341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVYcgjfes3J6HZEQtVdQbHlu24tneGcQpq06nRhrvlw=;
        b=PSyP6IvpP8iGD8Tj+Tfz/Bm9wDNlPGgoMn+qDn/5dJgLWzYjTEtz2bsuJTLE0F+vV/
         asWjzVh87EH3fm+DKWt9HY7TCXX8tz+ka615/7caIfTzb/+1hE+2mbvj+P7Mlt7N3/KH
         Rw2SLDn+MIy1CbWtK+NyVlEuxezzlAgZr3w7nGZTQ3WjxStTix4aVbMMcytId7CPOblr
         fTMl2UJiRh6jRIw9/BM7uKUU4ufMfx+TXz3dqsNdBQpk5nLbnkHJJxT9y5Z70c+0nmjM
         Y8aVyyNragyAAcOSEu0SUTkdFJaLgOSETEVwam60wyhb5yxy4hQz2PZnmiiF3hPa2WNI
         Rzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047341; x=1687639341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVYcgjfes3J6HZEQtVdQbHlu24tneGcQpq06nRhrvlw=;
        b=gPObh/Wsmv2Kf41Mro1Ye4At39mXiKkKk9GypQvAqYJhQekZtVeYZSdbGajLU3Ib1O
         KZxbR6D8wGZWYuxhaONTzaGwSyCT/2xfVJDXRADRGqm1uz/AI7Zo6We374eIOSHn75S5
         7vt//NJO/M/NuICXpMX5PMEecwuDtIyhHT1GrASzyiLcONROgFI6JXMKeQ35CY1oe+v2
         46/LCwATgF8L3cRymqPLyS0Bbn62tMyrvoKWzH3t/ylErAgF9S/Lq4cgomkTy/i4hvU7
         i4LOuoY4NwPTGcnKeehlqgW84Avp7BXs5RaJP0iPKUqX9F8VAQrIfmVghNnlkdJgQMzR
         qXkw==
X-Gm-Message-State: AC+VfDx0IY6GFekp1BQbOoOIjeZsxTxgVRfazs1csXdsCmSZrtnPYCfs
        I1Rl+GNyS1LjFyAMJFgqoABlPcPtNHXiWpCaWaY=
X-Google-Smtp-Source: ACHHUZ4YPET8OizIKc5koGJ9RzLrN2jN14bPaH5Iiua0eEhpZi+Z6cy0ZV3Yt5kZm+d3Z0y9u8p+McJ38Y5NHtBpWhU=
X-Received: by 2002:a4a:9bcd:0:b0:546:dd51:f74f with SMTP id
 b13-20020a4a9bcd000000b00546dd51f74fmr1965310ook.4.1685047340843; Thu, 25 May
 2023 13:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230525203531.3233040-1-trix@redhat.com>
In-Reply-To: <20230525203531.3233040-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 May 2023 16:42:09 -0400
Message-ID: <CADnq5_MNr3RsXi65AdYxkZc8EUYpJBNm-oLhenzcLzRKmN+gLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move gfx9_cs_data definition
To:     Tom Rix <trix@redhat.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, le.ma@amd.com, jesse.zhang@amd.com,
        Jiadong.Zhu@amd.com, mario.limonciello@amd.com, Likun.Gao@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 4:35=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> In file included from drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:32:
> drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h:939:36: error:
>   =E2=80=98gfx9_cs_data=E2=80=99 defined but not used [-Werror=3Dunused-c=
onst-variable=3D]
>   939 | static const struct cs_section_def gfx9_cs_data[] =3D {
>       |                                    ^~~~~~~~~~~~
>
> gfx9_cs_data is only used in gfx_v9_0.c, so move its definition there.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Already fixed with:
https://patchwork.freedesktop.org/patch/539234/
which will show up in my tree momentarily.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 5 +++++
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h b/drivers/gpu/d=
rm/amd/amdgpu/clearstate_gfx9.h
> index 567a904804bc..6de4778789ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
> @@ -936,7 +936,3 @@ static const struct cs_extent_def gfx9_SECT_CONTEXT_d=
efs[] =3D
>      {gfx9_SECT_CONTEXT_def_8, 0x0000a2f5, 155 },
>      { 0, 0, 0 }
>  };
> -static const struct cs_section_def gfx9_cs_data[] =3D {
> -    { gfx9_SECT_CONTEXT_defs, SECT_CONTEXT },
> -    { 0, SECT_NONE }
> -};
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 8bf95a6b0767..c97a68a39d93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -56,6 +56,11 @@
>  #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
>  #include "asic_reg/gc/gc_9_0_default.h"
>
> +static const struct cs_section_def gfx9_cs_data[] =3D {
> +    { gfx9_SECT_CONTEXT_defs, SECT_CONTEXT },
> +    { 0, SECT_NONE }
> +};
> +
>  #define GFX9_NUM_GFX_RINGS     1
>  #define GFX9_NUM_SW_GFX_RINGS  2
>  #define GFX9_MEC_HPD_SIZE 4096
> --
> 2.27.0
>
