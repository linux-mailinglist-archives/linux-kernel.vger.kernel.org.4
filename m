Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC8690BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBIOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjBIOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:36:00 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964EC5FE4B;
        Thu,  9 Feb 2023 06:35:53 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t5so1808076oiw.1;
        Thu, 09 Feb 2023 06:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sp03I73N+r+twL5ugYnXLYJHbMgUcy+BtwmbrfyskRA=;
        b=pk2zh5SKB0jC3nyw5hEQMgnCtR1FzWaM40IWi6fTOOzWWWDF1KEMm8BKLaF++pBFNP
         LISFddbkBGt9pkiEX0zlHCkysLhP+vszdT3pE68qkI/nihnVTWYwwJpKaxdjhRp2CLoV
         hmRmhAc0oWHyLq4KSG2cYKAsxoZ0DGLJe5wVv8celkMvhfKOpkP1PfJW7PPfB9+9+uP4
         ycFwzTH3d6vQVrraGr7hcY4+ddve3ztW8K/x+lLZoH7QegRjFncz6U8ug2RBt6NR7pOO
         LW8z8m6jay2uXfa1lIrvzXJAaqska39DGFurLQA2fTzT0vtpW77xAXGfdjRQ5yEMVsVK
         udAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp03I73N+r+twL5ugYnXLYJHbMgUcy+BtwmbrfyskRA=;
        b=lCLjrTOFccTKxdrgginidX9YMHoAIH/nb4AENGn/IoeKInftYNqQTdrDyHwsfloRRH
         LpsD9nlYUgPrgtUzxJnrsJa/9ynMfiwhaGIUjGKx74aUp0mIAODMN9oBcN4Q8/v3lB67
         OjtAFIWv96QSDAW2CeXJPwFmrKss/ULip4DMSWv5Rpa+SsrQx1GRf/7/IKjCv/vTwsEw
         4PGTe2Nr2fX7aJs6UwcWV3AisQSzcttAlHGjLIr4iMTch5Z2d2WR3mBQlj+t8L+Eo73x
         MkcdFXLPNukAEJZ9BSnCqIWkhUjlQ7EQf/w19eyJDoGpIvSSkWiSqW++8NAW033Htqwa
         IGtQ==
X-Gm-Message-State: AO0yUKVuXgSo38p8lBP21ro+EHZns2rYxQC75JoHXUCc4fZMzbQg9kTc
        a6I7Oc41nA9BDuHtObk9f2Bt4SBDNXAyh6LaDyauzjlM
X-Google-Smtp-Source: AK7set8WUzFR+9A6rkN9lf35+zMlZ5Ra7EmUoSFmZH1NreHw2xOKi29aBn57YpXN8BAKmHuLuXls8iBeXTO3FjkqpBs=
X-Received: by 2002:aca:c108:0:b0:35b:d93f:cbc4 with SMTP id
 r8-20020acac108000000b0035bd93fcbc4mr575101oif.96.1675953352898; Thu, 09 Feb
 2023 06:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20230209125330.1433481-1-colin.i.king@gmail.com>
In-Reply-To: <20230209125330.1433481-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Feb 2023 09:35:41 -0500
Message-ID: <CADnq5_Pju2QxoR2QEhWf_p9EcKnuF+SkqaKJ7i7adxBktJBBAw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistakes of function
 name in error message
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
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

Applied.  Thanks!

Alex

On Thu, Feb 9, 2023 at 7:53 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The function name is being reported as dc_link_contruct when it is
> actually dc_link_construct_phy. Fix this by using %s and the __func__
> for the function name.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_factory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> index 13a766273755..3fc93fc593fb 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> @@ -452,7 +452,7 @@ static bool dc_link_construct_phy(struct dc_link *link,
>         link->psr_settings.psr_vtotal_control_support = false;
>         link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
>
> -       DC_LOG_DC("BIOS object table - dc_link_contruct finished successfully.\n");
> +       DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
>         return true;
>  device_tag_fail:
>         link->link_enc->funcs->destroy(&link->link_enc);
> @@ -469,7 +469,7 @@ static bool dc_link_construct_phy(struct dc_link *link,
>                 link->hpd_gpio = NULL;
>         }
>
> -       DC_LOG_DC("BIOS object table - dc_link_contruct failed.\n");
> +       DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
>         return false;
>  }
>
> --
> 2.30.2
>
