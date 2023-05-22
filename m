Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A870C20A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjEVPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjEVPLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:11:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D38CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:11:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba82956d3e0so5443654276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684768291; x=1687360291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTJnTOSBsJdXxwudOgHDRynaphl008jVXxiS43MOx6A=;
        b=OjzMYV7FB/u87mx5iCndMOolICZ+awcR65uiYxd2r+5DoA8Fzi1mcEn7jmNNRsM5aO
         Hx0dXZ0Rotbhoo77WvEwqMkXG+AxskMEisTrQbPA5SRlHWM6QUDKtfWcaPO8GwQt5zqe
         naNvC5tb5mjCjv0V0GTeKJ9xsiFxYdrFZJV3wIiHI3wJJGUvZIEEyVaJQeqHhssu3lLb
         YRDspCVKo8x8JzSaCLkR1NyMjjE6LCCAQLLI0HDosu+2YYZqY2YuCMg7BqsFCIR4FEwr
         ytqyKHU1opANj1xICHWv+voTqSuBJOn817lek4h9jgHnxaCLLZ6yEPkWaSovAmWfmwZT
         WK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768291; x=1687360291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTJnTOSBsJdXxwudOgHDRynaphl008jVXxiS43MOx6A=;
        b=fr6R6QC6wTCs9CJjlekqnIObuwGCURG+/IikdtrcNSY4ymI+o+qzQp6f7/PBtyiOSz
         TkFKPNs5MW4h0/6vdYPnoxSM3js7hq0gUm1O2VoafjbeFm+bYFtIrtRK3OoZOYqZ+uWI
         TplYmcjPmfRd3No3Zn36XOY9xtWEclZyjJtsuriUh9LUfmeaHG6CLWREb/H2zEtxYFF6
         i8XobXgUyJxVZGlXdPwr2RQufaTW++5wDECmU3ZBGhkk43DxW8tUt7xlSqtNhXfiZRWC
         yMiwsl0nJXGSNrgMv24QpOCsrH7UHsWYfRYBrxAeS/SEe4g42MRH3n/TGIXgwix9dWl+
         KDvA==
X-Gm-Message-State: AC+VfDw1Z9EEU3nbRytX5+JQVtw8/TAbkbLN3Goq9/iO5vcm+fOVwn8n
        SpGg6dXAeAGCddh+FELQJnPUpa2WlecMF8CVgGA0kB1r
X-Google-Smtp-Source: ACHHUZ7a9CC/BJ1/5Uahg1uci41+efd+P2PhLAf72v4ugAcuf/SpYmFxwV9zyHFfsS0YrZ/uT3+SL/iFf3MoM+Qv1yQ=
X-Received: by 2002:aca:d806:0:b0:38e:e5b5:493e with SMTP id
 p6-20020acad806000000b0038ee5b5493emr7140299oig.11.1684768270110; Mon, 22 May
 2023 08:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230522123013.1065975-1-trix@redhat.com>
In-Reply-To: <20230522123013.1065975-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 May 2023 11:10:58 -0400
Message-ID: <CADnq5_Pc+3YNT0Ymf77zPDKt9Nr2mBYgxgcyqT4PZLQhrD+iRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unused variable num_xcc
To:     Tom Rix <trix@redhat.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, le.ma@amd.com, lijo.lazar@amd.com,
        tao.zhou1@amd.com, shiwu.zhang@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Mon, May 22, 2023 at 8:30=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:2138:13: error: variable
>   =E2=80=98num_xcc=E2=80=99 set but not used [-Werror=3Dunused-but-set-va=
riable]
>  2138 |         int num_xcc;
>       |             ^~~~~~~
>
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index e5cfb3adb3b3..63718cf02aa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2135,9 +2135,6 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct =
amdgpu_ring *ring,
>  static int gfx_v9_4_3_early_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       int num_xcc;
> -
> -       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>
>         adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
>                                           AMDGPU_MAX_COMPUTE_RINGS);
> --
> 2.27.0
>
