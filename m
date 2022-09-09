Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888A5B4111
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIIUxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiIIUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:53:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF70E582A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:53:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso1851058otv.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Tv3Et/tqY6Zk/pnAAyJuFDBD309Fy7UgcvolVBKAIt0=;
        b=XDqQfKosBFzUJL2xT8WnuKul95HYglkg8NPZTdD8yer3mkW0yRnXch4X7L024AWOpG
         lHhrc0bFdyTds58pYk8wgR+4CCChs02NqRg70znBM6Aq/MFeaft1dGIE2EnIDuXc4Pvh
         WPohlQkvZXJQed98j2WW2vYLuHj5mi1PpppqVit2JpE1KWLFaeVev2MZCX2xYDFePU42
         2lO1uClPEbP6gGdVFuoKyHDJ7DccqBAJmkDVinAjyh+pbyEj+NdiwNZl7CxJw0Zv++k9
         RjOD8wMR/g8OyqZusKMmA0yY6OU3FRaQ6RISA2FEEJveonpA0094igOC5Cm4+vYxIVSp
         tVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Tv3Et/tqY6Zk/pnAAyJuFDBD309Fy7UgcvolVBKAIt0=;
        b=euh2BB06eO2/thQigZNz2726cjONtmqXMKkr6ZBEY/+MMiGsIRl7D+hAQdnL7/5ZX0
         AUJmiLcEmL9u9Q/6uqG9ZYdozrpjseAzQ1wEOrj4ZhjEp4u9+/jtMEz+Q67cb/hF8akn
         +FfNV9KJPIxcQB7lvxYtEVKCN7J8bE+SABGdJHgadOzNAwk2vrUmyNri0p6pAgGwj+rL
         0HJSqLzaU5CZ1hme/IJr5b+muIxwdt+vAvDNGGRIom2TbLQdzYiiaAMnWySwMjzYnzB1
         mt68C1p8iSGlaXqapBuL1YTYswgnBUECrojHAOTxubaqqzHvDfYnsdNgmwHlVe4j5EoM
         F/BA==
X-Gm-Message-State: ACgBeo18fBsD/BUNUnnclgjRwvsLqdmP8HlIL9vdJsoep/h0J7YPBzfD
        NZ+u9PEykpW7h3VQw7aQAmv6DmW2qJxPyjveegw=
X-Google-Smtp-Source: AA6agR6OyPFZC2Rer+UUiW1qXoiXPjbx2R+7p2UUCURa7R4KDh0CNuFWNY3EZu5Y9xqXHY5l76BxtbO4Zjwk8hSy4PQ=
X-Received: by 2002:a9d:12ce:0:b0:654:9bf:94ee with SMTP id
 g72-20020a9d12ce000000b0065409bf94eemr3411691otg.123.1662756810347; Fri, 09
 Sep 2022 13:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220905075624.22979-1-jingyuwang_vip@163.com>
In-Reply-To: <20220905075624.22979-1-jingyuwang_vip@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:53:19 -0400
Message-ID: <CADnq5_NbUSWstURQQ8NKXehByBZY-2-gimwvA9kUyoGvaqKtKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_amdkfd.c
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     Felix.Kuehling@amd.com, lexander.deucher@amd.com,
        hristian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Sep 5, 2022 at 3:57 AM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Fix everything checkpatch.pl complained about in amdgpu_amdkfd.c
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 091415a4abf0..4f5bd96000ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  /*
>   * Copyright 2014 Advanced Micro Devices, Inc.
>   *
> @@ -130,6 +131,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>                                                   kfd.reset_work);
>
>         struct amdgpu_reset_context reset_context;
> +
>         memset(&reset_context, 0, sizeof(reset_context));
>
>         reset_context.method = AMD_RESET_METHOD_NONE;
>
> base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
> --
> 2.34.1
>
