Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A235B89AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiINOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiINOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:00:48 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE879A4D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:00:17 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-127dca21a7dso41143885fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Nhf4NUE5pNrO2iPn+duWxF+/BKciVlA3AuEHtMu2CkM=;
        b=aLjXaqxm731w8pTsLIJqD/I2r3nY06kTldoBkhB+GTNaSahVvmr04XDUCNS2awKrsP
         0sOo3DaKjjQXVYof4nLSJeFVwkH+VfffbTEjdfVu/wXmzrV9ILvlkVVe1s0QZC1QYHoT
         rPA4VzvgvpygZ9DEZiyMu7kayNhTLP9MI4j1Wv95mqAxL7OxrgJa0zaBrM+dbHIG0UCc
         dvsNAqvrRL8z++KlsXFsStXKaon9pqNvXrerCldvBwpOUKRXKKiore6NH93N6bRQHYiX
         dpqqPZwiI7zZs0dJ6/NGm7q5XJrHuqyiYsbNc/CHDsIP0XhnBA6xbEWLVF57nwToWoHV
         Nvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Nhf4NUE5pNrO2iPn+duWxF+/BKciVlA3AuEHtMu2CkM=;
        b=7wF+ZjDViRKm0HKOgQqoLBepBnFYtbRjiaQkX/s5GfFlV01zBnzIHyNGio/D4B1nfT
         e5+CCy5faDgiRvVS0YS6yQQ29P+cgssix7DE0/qbbpjBaKr1OslhFS9YEPpkIDoCGPYd
         U6wGYS6/S4jE+mWZO/pdOznrJ+TQ6wsVB87SX4y/T+YEu48q2VyRvc5Z0oCit8XvsM5K
         7hks2GsPwOTrZtO/BEhJOcomnyN68CF2l54cndnryqupUDlZeIfQEoM2ILUKqSsXO/db
         26hqi1eNeeRIkO1en2/t6xnIocEpFzcJZIQmKP4JjpAhVVlbv/25eyhk93QG+/jOr5r7
         jFbw==
X-Gm-Message-State: ACgBeo0oSTkuiK0Ko8X12sgmjoSqeeMZqBYRgLbWKYhF4A2uiYvsGyml
        aOGlXmwZuixV0wfKCVBgYuTJaujh7GnuJusgbD4=
X-Google-Smtp-Source: AA6agR4+0HrSlOBJVxUZRMY+wQKkAqM7Lq8kfvW+Hf/8efKDYKhqKL0TNMJEugeMxOFKaXEotpqoHFiDtk0gYbgOf+U=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr2643357oae.46.1663164016167; Wed, 14 Sep
 2022 07:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com> <20220914052742.116297-8-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220914052742.116297-8-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 14 Sep 2022 10:00:04 -0400
Message-ID: <CADnq5_NmWKF+7UQov2oQ2JH5UW0Pzjw0bCUzhZWZQ=xH2mu17g@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amd/display: make optc32_phantom_crtc_post_enable,
 optc32_setup_manual_trigger and optc32_set_drr static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, airlied@linux.ie, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

Applied the series.  Thanks!

Alex

On Wed, Sep 14, 2022 at 1:29 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> These three functions are not used outside the function
> dcn32_optc.c, so the modification is defined as static.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:159:6: warnin=
g: no previous prototype for function 'optc32_phantom_crtc_post_enable'.
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:218:6: warnin=
g: no previous prototype for =E2=80=98optc32_set_drr=E2=80=99.
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:193:6: warnin=
g: no previous prototype for =E2=80=98optc32_setup_manual_trigger=E2=80=99.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2140
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/=
gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 1fad7b48bd5b..ec3989d37086 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -156,7 +156,7 @@ static bool optc32_disable_crtc(struct timing_generat=
or *optc)
>         return true;
>  }
>
> -void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
> +static void optc32_phantom_crtc_post_enable(struct timing_generator *opt=
c)
>  {
>         struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
>
> @@ -190,7 +190,7 @@ static void optc32_set_odm_bypass(struct timing_gener=
ator *optc,
>         optc1->opp_count =3D 1;
>  }
>
> -void optc32_setup_manual_trigger(struct timing_generator *optc)
> +static void optc32_setup_manual_trigger(struct timing_generator *optc)
>  {
>         struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
>         struct dc *dc =3D optc->ctx->dc;
> @@ -215,7 +215,7 @@ void optc32_setup_manual_trigger(struct timing_genera=
tor *optc)
>         }
>  }
>
> -void optc32_set_drr(
> +static void optc32_set_drr(
>         struct timing_generator *optc,
>         const struct drr_params *params)
>  {
> --
> 2.20.1.7.g153144c
>
