Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813AB72A2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjFITGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFITGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:06:01 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A53A95;
        Fri,  9 Jun 2023 12:05:59 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-558b6cffe03so1418033eaf.3;
        Fri, 09 Jun 2023 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686337558; x=1688929558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOMvkZnPwmIO9rUDsynYpLezUNy31X65xq+c1pvLo/s=;
        b=qZOElJiJqsKIUEZ/4W0bxkDQ5IRO6XWZ6HMgsZGzbdLDwGFlP8zIRzDsmMxJtJo7Pe
         Y4UETOwCudj6NWjmm7+KDVKQfjAYazbUTknxg0t5NnA507jCMfqAN3BSzj58nh2qc5pd
         iIZh207kPMaMO3BRRGpb112M5J1ecsBzRgTER5+J5ssAK06rgNPIFwHWP4XhcLgOfhUl
         YhaciTgZAMas7YjpyOaloenbzB//wX2oLsEDsbKNcbDvULoWO9ZD0HrI1wI2fvTtAyUD
         kbUUZo/e53fFxOtLofLZ8GfIad4ItQDHVSdX/2SckLjjnRy0ePQwdB1u4XKX56trxTkt
         btOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337558; x=1688929558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOMvkZnPwmIO9rUDsynYpLezUNy31X65xq+c1pvLo/s=;
        b=GVgbVKAsXWnGA8Vo5NvSl2JjERPWrmdk83KjTPNculOFUm5q/lbANUVfjP0hMxJTP6
         atI1d/iNFUO/MIeLk7RC1Nef5AON+5f4mNx0GMoJCKm9UR6+A+qE+NGDGZvbxscvBEp0
         ZHSLoWJB3MqGeoMOX8GsIvyPwOpR/TvPMnLXxW0kvwKTjnrvgMycetIpwLgVRuAEh20p
         EaVkHrEu30shWySJtpYLZsRQHULXKXhbmAr+HNtbRis1OaZZtwvi3lO6gLmagB8B/wqy
         tBCYjBPrg1ZloYLdfkoKT8pe+1Gh91VoX74ljZTJdCOzHf7fIcs+n+7N/cWEvS54zyDp
         j3MA==
X-Gm-Message-State: AC+VfDx0h8+WeEfh+pdwtDjig+xiSCtDtNBx+7MaiWxyIrM+wMEX2vbR
        m8yf5eVCXIkvekhVzFch0NklzZOSOsc2TRPFq21OpY3B
X-Google-Smtp-Source: ACHHUZ7VVOVGPYkQhvxHXzRFN2Pvvtu5u5tXb4+ByJD8vIVQa6VfmTrN8dYJvKeI4gq0hQCaGTm4nZTtEr62J0fBLcY=
X-Received: by 2002:a4a:e708:0:b0:555:9b48:93de with SMTP id
 y8-20020a4ae708000000b005559b4893demr1382251oou.5.1686337558655; Fri, 09 Jun
 2023 12:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-16-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-16-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Jun 2023 15:05:47 -0400
Message-ID: <CADnq5_OVMwV80XbTpdRECa54iDLK8+SGz==KWpWTJN+hs1QAkA@mail.gmail.com>
Subject: Re: [RESEND 15/15] drm/amd/amdgpu/sdma_v6_0: Demote a bunch of
 half-completed function headers
To:     Lee Jones <lee@kernel.org>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org,
        Stanley Yang <Stanley.Yang@amd.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
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

These have already been fixed up.

Thanks!

Alex

On Fri, Jun 9, 2023 at 4:18=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter =
or member 'job' not described in 'sdma_v6_0_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter =
or member 'flags' not described in 'sdma_v6_0_ring_emit_ib'
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:945: warning: Function parameter =
or member 'timeout' not described in 'sdma_v6_0_ring_test_ib'
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1124: warning: Function parameter=
 or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter=
 or member 'vmid' not described in 'sdma_v6_0_ring_emit_vm_flush'
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter=
 or member 'pd_addr' not described in 'sdma_v6_0_ring_emit_vm_flush'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 3b03dda854fdc..8cd7abe74e6c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -233,7 +233,7 @@ static void sdma_v6_0_ring_insert_nop(struct amdgpu_r=
ing *ring, uint32_t count)
>                         amdgpu_ring_write(ring, ring->funcs->nop);
>  }
>
> -/**
> +/*
>   * sdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
>   *
>   * @ring: amdgpu ring pointer
> @@ -936,7 +936,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>         return r;
>  }
>
> -/**
> +/*
>   * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
>   *
>   * @ring: amdgpu_ring structure holding ring information
> @@ -1118,7 +1118,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_=
ib *ib,
>         ib->ptr[ib->length_dw++] =3D count - 1; /* number of entries */
>  }
>
> -/**
> +/*
>   * sdma_v6_0_ring_pad_ib - pad the IB
>   * @ib: indirect buffer to fill with padding
>   * @ring: amdgpu ring pointer
> @@ -1167,7 +1167,7 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struc=
t amdgpu_ring *ring)
>                           SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry=
 count, poll interval */
>  }
>
> -/**
> +/*
>   * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
>   *
>   * @ring: amdgpu_ring pointer
> --
> 2.41.0.162.gfafddb0af9-goog
>
