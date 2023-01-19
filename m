Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83057672F82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjASDky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASDja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:39:30 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A04DE32
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:39:12 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-15ebfdf69adso1309150fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2aM8iDrd+dulL6aZ193yV7HSVHkd3onqhyS0eiH7EX0=;
        b=K3bnMRBl9Y5G7sg8Q20fp9EUqQJEM9w2rAGCeEJ58/yVxvNV8lUnk2IDjoLVfPT+ys
         x64Y20nIFx1l5qAWb7zxuFNapkKW7Hxn2ELf1m4OONKh+ztXgIxaTRyeZztDWf9xkaHk
         0rHHhCaQ6AI6KmOHN1mV5sZVBwrUOA18PRAcI3g2hMs3ZnCooY9Mfgz65YsYKjpXw3JL
         u69FS4H4PNBqTvOo/RDAU26z3ufRx6ASdWfO5Pqxbwxk6YfI4uSGDt9qjTkG9M5tEL6r
         tFuq7q8U5jCf6PUs0/lotWNoaWWuHCnNe/JXMDdKB2vAfVVyLF65DZ4iZyibQLDvzeXc
         BlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aM8iDrd+dulL6aZ193yV7HSVHkd3onqhyS0eiH7EX0=;
        b=DbDjaeZ0hoyEbIuyQk2B5dI5tgvp/ZNjhkaKJr8doRMToW0c97jce5nnZaaLieEeuc
         FWuLqwPEZfRDy40jy1FIIMmdLvv1igB07/dW7JlI3dF2OnFC5K5R4XvpQ6FQv+zkclhE
         +BSEftne3re6OtGV1Cj+uR6NBBpDEZxS6ceAEntKapUQzcANsbfT2Ey0ZXPp8hBbbX8w
         WqwO+8WeDLdJ4TqVKIYSs33BYi3kearnhNUHZTGhQewNgahg0RrtY3RGHXvq9Nh+BENt
         4MXNaHgZNgYHQk5YxiHoIs+N/3oHEhWIrAocs+e0XuvrUOn1ntNaGl9I/xYtvP+OSl5G
         RosA==
X-Gm-Message-State: AFqh2ko0C5vjPtUpYD1qB6teY8p96udcIDALJ5HcQgWnE6sr2ticxz3X
        qqn2ywTfjUvcSc8VBpPUrA4DNYSQ1YCNmAM+j2VIr2z3
X-Google-Smtp-Source: AMrXdXuhtNH+PLsKPrU5l4hivxjoTe0rrDnG6rW/fskBNkyXJF2zC/DPYgTMixpy74dNpdLMr6ffM0kYKE6NWxm0UO0=
X-Received: by 2002:a05:6808:4387:b0:35b:d93f:cbc4 with SMTP id
 dz7-20020a056808438700b0035bd93fcbc4mr541759oib.96.1674098945563; Wed, 18 Jan
 2023 19:29:05 -0800 (PST)
MIME-Version: 1.0
References: <202301181539003991927@zte.com.cn>
In-Reply-To: <202301181539003991927@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Jan 2023 22:28:54 -0500
Message-ID: <CADnq5_Nb-UQheq7rV5x6taOjj+tQT4sGB_0unj3scWBO_EGDHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate included header files
To:     ye.xingchen@zte.com.cn
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com, xinhui.pan@amd.com,
        rodrigo.siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, wenjing.liu@amd.com,
        michael.strauss@amd.com, dri-devel@lists.freedesktop.org,
        george.shen@amd.com, jun.lei@amd.com, christian.koenig@amd.com,
        jimmy.kizito@amd.com
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

On Wed, Jan 18, 2023 at 2:49 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> resource.h is included more than once.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 1e60827911c6..6747e4b199de 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -47,7 +47,6 @@
>  #include "link/link_dp_training_auxless.h"
>  #include "link/link_dp_phy.h"
>  #include "link/link_dp_capability.h"
> -#include "resource.h"
>  #define DC_LOGGER \
>         link->ctx->logger
>
> --
> 2.25.1
