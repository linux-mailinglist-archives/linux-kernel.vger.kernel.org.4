Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD340672033
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAROxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAROw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:52:56 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C59D1DB87
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:46:45 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id j130so28782910oif.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2v9rowf1iOtrujUFxIVI27nUO9c6hi0orZbEtBDtO/M=;
        b=RiTvi1RHWMX4c6XlVOeyMO7S6RAS5f2WU6zsA/UGcpaW130MNfsdXcoLlx7onWaUhP
         SRJ1N2i9KpPz1Lp0jgkiD57q7pftHnEEEbgtkBYp1y0gzvuIhgRYby267RrejZFBzmWC
         /UTFHXdiiEFYnE4iWfEAJeyDeA9aNJCUVect/acyDt3LEJMw7CWqavwRSm3lxqVnPcQ5
         v7BzVVZxNVuyoeIg5q22Lj9W4CsiMQ7FdSc6/gxt0h1DxNkrPmP01wOp9+AK8X8VuLOw
         w9UT3U+9fUXr2zIJDDVO5l+MzIlEtcTsuMdDOMyOOOPulJUSn3CkoEtOZqZGFo4a4Vqz
         u+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v9rowf1iOtrujUFxIVI27nUO9c6hi0orZbEtBDtO/M=;
        b=cXrnvhXTF5Gcd70dQmDKObqHIWOzL77WgIIWMoyHCuqHc3cC2Ec84F1JA6O02R4e95
         3p6ZXJGbw1FVPzQF44gu/dFG2CFVT/TDsH6dlwBmHIU45QjYrm3o5BND0/VRlB5WmjUa
         mwOFgLUSFHjtV/PZm1L+7njTguNkQO2IuzzBEHxYxPq/h7CG/wEQSG44cnbqBjh1BRsw
         cd5gk0f5HVdSM5h4iNP2Qs7rPdSxrjQtddf4lxtdmK1q6zJJY97NJj/Ytg/N0jbfTZ9c
         xQDkXY9UeRcujdgdcVoflLUbw+Alq83/CLBmRNnfg2zl7h48ptWxzcbGqoCCDHGT7bn+
         sRmA==
X-Gm-Message-State: AFqh2ko4ybeSxRVew/NQZpKbZYM1BIZ47ebDOgHGHAYXNTxZCOmpgX/t
        hlD1525/Yaz+T+s/eeegeBeJwDZt+VdXHN+ffq4=
X-Google-Smtp-Source: AMrXdXtf0gUATG4daazGEOzCExkSfUC1Svy0l6u6xTtUUGc31RHzPBYgKtydw/UIG2EkUxMh9AU98ll54TZrTKB8tAc=
X-Received: by 2002:a05:6808:4387:b0:35b:d93f:cbc4 with SMTP id
 dz7-20020a056808438700b0035bd93fcbc4mr423280oib.96.1674053204483; Wed, 18 Jan
 2023 06:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20230118101107.10173-1-nicuborta123@gmail.com>
In-Reply-To: <20230118101107.10173-1-nicuborta123@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Jan 2023 09:46:32 -0500
Message-ID: <CADnq5_PuWM2Cz7a8-q8GFVMrXHVOSP-pXSQ1QY1pRQDuU=KwBg@mail.gmail.com>
Subject: Re: [PATCH] amd/dcn20: Fix high mem clock with multiple displays
To:     Nicu Borta <nicuborta123@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 5:43 AM Nicu Borta <nicuborta123@gmail.com> wrote:
>
> On RX5000 series GPUs, using a high refresh rate monitor causes the VRAM to
> always stay at the highest clock (according to AMD, this is done to prevent
> flickering).
>
> However, when using 2 monitors (e.g. one at 165Hz and another at 60Hz), then
> disconnecting the high refresh monitor, before this patch the VRAM clock didn't
> decrease like it should.
>
> This patch fixes that bug, and now, when disconnecting the high refresh rate
> monitor, the VRAM clock jumps to the minimum.
>
> Tested for a few months, I haven't noticed any visual artifacts or other errors
> (RX5700XT).
>

This has been enabled and disabled several times in the past due to
stability issues with multiple monitors reported by a number of users.
Please see commit:

commit bcfab8e35ce81e2fd3230c1575024bfde0d28c8b
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Thu Feb 3 10:04:58 2022 -0500

    drm/amdgpu/display: change pipe policy for DCN 2.0

    Fixes hangs on driver load with multiple displays on
    DCN 2.0 parts.

    Bug: https://bugzilla.kernel.org/show_bug.cgi?id=215511
    Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1877
    Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1886
    Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy
to allow for multi-display pipe split")
    Reviewed-by: Harry Wentland <harry.wentland@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I would suggest following up on those bug reports to see if those
users are still experiencing stability issues when changing this.

Alex

> Signed-off-by: Nicu Borta <nicuborta123@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 8a0dd0d7134b..481a15b02126 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -714,7 +714,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>                 .timing_trace = false,
>                 .clock_trace = true,
>                 .disable_pplib_clock_request = true,
> -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>                 .force_single_disp_pipe_split = false,
>                 .disable_dcc = DCC_ENABLE,
>                 .vsr_support = true,
> --
> 2.38.2
>
