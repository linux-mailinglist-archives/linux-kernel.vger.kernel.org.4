Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D78B5F0DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiI3OuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiI3Otb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:49:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F517B514
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:48:42 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t62so4937498oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IrD2HiOAvlqhSlCj89Kg6AmBSA4GqWLvYu4q+ahkxqw=;
        b=FTvf7jWuva7dVerCSj72BQDqO1vmZDve/XbFr29Mq3HYSofxF+vBpy5/iZIer9Og4Y
         9h9F3CcvgYFpfZv/yejrKiCERLYeqz2LvHnqwyadSVZvy1nEtIRl4rT3HlqWRWLdN9Fl
         6z0FgRXM7sbCz6Z/CQe/zjsqbO0WbtHUvFQJuxhfcMd++iUyY6+M4itfmhGQZbhoBV+/
         z/5sGbycYevtssfYgpjygcJfdUu/LmcZ9NcHFq80jtTHXwXBv/Qdeq1Le8d1AVN+kh6m
         a/h4uMAu3+3AcZPIHZjPsE86B4QD+PgbXUNdsEbbs59ljH5g3agTf5/GQHtlACPfj0hV
         k7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IrD2HiOAvlqhSlCj89Kg6AmBSA4GqWLvYu4q+ahkxqw=;
        b=NA22a0hQ75COGPnUrkdzD/aJCVqupBI7Ap31edFgn2i3HH6kxIvijBfhLCFKO80yNa
         9BofWtaiXwyuOFGA2w1W1qhRa5u93j8mYeEVorANHRuX/Bog+Wj0X+FbsjX0SZkTqTbg
         tR1+wY867vhoqGhK72Q1TyOU5DBE+qJkokYA0ve2sugPf3vIb2BZHXMIeFULmcAUbJFe
         9/JjqW3MwwmTZsvB+nLgxwykxXpE3/btNdgG605z+zda+FvwuVdJRKd0P/3YICyvkLpO
         x9B4Lua5yBKtXNMQD5sMMB45pclanOnZdNstXxEpMmA5j8rRD0sFdkD/WsRiCpXQqSUm
         mN1w==
X-Gm-Message-State: ACrzQf0CordREQMEV4EYQaf43pbQzsgeBwqZaintYZkls+c+kNsnmBhD
        J58BfD6JKu9/BMym3Ovv/vADJ1lzwPKBXrfbcFlvg9nb
X-Google-Smtp-Source: AMsMyM6sqVe8c4bTD9YFY2G/C+1svDf3GvVoxIluh8OGYmkdHCKavHRdrDmDo8TK3DWsOb6b2Gm9Uq4Bb3RTeg+9OAc=
X-Received: by 2002:a05:6808:2194:b0:350:cb3d:ecd2 with SMTP id
 be20-20020a056808219400b00350cb3decd2mr9930656oib.46.1664549321709; Fri, 30
 Sep 2022 07:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220930053859.100235-1-yang.lee@linux.alibaba.com> <20220930053859.100235-2-yang.lee@linux.alibaba.com>
In-Reply-To: <20220930053859.100235-2-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 30 Sep 2022 10:48:30 -0400
Message-ID: <CADnq5_O24ZXhE3qfKajjtP1gj8Pd8DO7ZVrQE6QN5cY_vf4Gvw@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] drm/amd/display: clean up one inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

Applied the series.  Thanks!

On Fri, Sep 30, 2022 at 1:39 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> clean up one inconsistent indenting
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2321
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 559e563d5bc1..f04595b750ab 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -852,7 +852,7 @@ static struct hubbub *dcn301_hubbub_create(struct dc_context *ctx)
>                 vmid->masks = &vmid_masks;
>         }
>
> -        hubbub3->num_vmid = res_cap_dcn301.num_vmid;
> +       hubbub3->num_vmid = res_cap_dcn301.num_vmid;
>
>         return &hubbub3->base;
>  }
> --
> 2.20.1.7.g153144c
>
