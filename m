Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBED6236E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiKIW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKIW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:58:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228411451
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:58:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so35721pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 14:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vDNaO5GVqWCFNqmsXm32rt4v9sxjyK3oGfqu/+wwt6c=;
        b=pk/WOT2/oE/kdnN1HZZJjYFxrzFI47NqpiPgMp/AXm7p5iuk/wKp0P3kEiyPaz8vIn
         cvUr5FM3hFIOu18uuUie8pLmULDvWLoKDolxiA5flfdgk6OqHPquAaFu/KDswiiqJrQj
         75t8VpRVFztfzv7geZRLW2abdGPYy8va1txjpSQAcR2te70tSl2Yle8bR7K3rql56dg1
         wgIQ/PoVG/PEjBXcJLSYoc9YLsQau4msuXMCNA2NWNLJ7k5isx5m38t/mE9CqkvKTtS0
         g8vMldUVSfzX5pJv803/2hJv5nWBFeno8l7F+q+tOq4KiYYp/wKo9TeANWzYQj3qpAbM
         EfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDNaO5GVqWCFNqmsXm32rt4v9sxjyK3oGfqu/+wwt6c=;
        b=m/i+v5dXYZplVVzZ1alUJJq5Se3dXpqzHmMemvVye49Df0e//pB7FLanxfjGKUyio8
         dTuaZOLlk3O1kbZS4pMmBYjRuCnZq+cVavy6Bat/1eIjNad5EVujOiKnV5NdEUyedDmT
         y8+vqgr3WMPjTsW+D3l9xA9ekAojopjGNmZNSe/gXkBYV6ozefhqXttBhuBdSHbyFRm0
         3nQyXx4zZUXl+yiIyXB/cF+IFqbAdzLK3FmbYfkUB5nwW8lo89FQVkLtg+GQiVWJVeJU
         ZEDdV3jWftLR63dqfJLavd7Hex1G79Pq3oWyGiKmFuBXgdi8ZLzbpLCfTKOygjIQi1h7
         hcSg==
X-Gm-Message-State: ACrzQf2nSH4GtG5Sj4EmfE5ksIT98meEmq5nkM08oHbLrxpNLY3z2moG
        rkWOErMb09FEKxJv8fr3S3tefntZLlJpEIND/C74xCF0pIA=
X-Google-Smtp-Source: AMsMyM5u+ntcxBzLGuXwikCeQmoqmVxy58cxGcaiR3M8TfoH3UF/t5qebt7H8vYH/iUWCQNNP04bziH8lsIWtiVnoQw=
X-Received: by 2002:a65:4c8e:0:b0:46f:75bb:905a with SMTP id
 m14-20020a654c8e000000b0046f75bb905amr52541069pgt.495.1668034731985; Wed, 09
 Nov 2022 14:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20221109170341.36785-1-steffen.kothe@skothe.de>
In-Reply-To: <20221109170341.36785-1-steffen.kothe@skothe.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 9 Nov 2022 14:58:15 -0800
Message-ID: <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com>
Subject: Re: [PATCH] scripts: dev-needs.sh: Enforce bash usage
To:     Steffen Kothe <steffen.kothe@skothe.de>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 9:04 AM Steffen Kothe <steffen.kothe@skothe.de> wrote:
>
> Calling the script from a system which does not invoke bash
> by default causes a return with a syntax error like:
>
>         ./dev-needs.sh: 6: Syntax error: "(" unexpected
>
> /bin/sh invokes on most distributions a symbolic link to a
> default shell like dash (Debian) or bash (Ubuntu).
>
> Since the script depends on bash syntax, enforce the same by
> default to prevent syntax errors caused by wrong shell type usage.

I wrote this so that it can run on an Android target that runs toybox.
Sadly toybox doesn't like have /bin/bash. This will break my use case.
So I'll have to Nak this.

I'm open to other ideas though as I'd like to this to work in as many
cases as possible. Should we just add a wrapper that has /bin/bash and
then sources this file?

Also looks like multiple #! lines aren't supported by bash, so we
can't add multiple lines either.

-Saravana

>
> Signed-off-by: Steffen Kothe <steffen.kothe@skothe.de>
> ---
>  scripts/dev-needs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
> index 454cc304fb448..46537859727bc 100755
> --- a/scripts/dev-needs.sh
> +++ b/scripts/dev-needs.sh
> @@ -1,4 +1,4 @@
> -#! /bin/sh
> +#! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2020, Google LLC. All rights reserved.
>  # Author: Saravana Kannan <saravanak@google.com>
> --
> 2.30.2
>
>
