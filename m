Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585B5FBC02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJKU0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJKU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:26:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587FD79A41
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:26:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h18so7795422ilh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=po1IjVvNbfbkNgObAIQZQOCa9GvhgYqjWMEtcnXnmpc=;
        b=d6MtaVm6pP0yHYkMSOsLFHOxH5SVe6fGiLgMrrPMUGQpwYsNyBwYRXGyfmQ7V/MOHU
         josGyFZE7meSowi4YBlN2kf5OMx39SfNGpGa5ATdwq7h7jn8VpDjhlVfxUudxl62Vx33
         dzz0bUXSI3nF4o2FJ3Z1wxWzuUEasjt0+/IcYF6R58BaE/5p5U0JyBiCA73ODjYHi5GG
         vUrDDvSioW6eXlvBK1WGiSqHjeXA31Xxd61QfEF8tjtIkT0NvZbQArsewaW0kkrmYJzT
         spleOTxpeRlgFDIuE/oRQCZumpd0WAcvXD8QecHLaShxRVY0arhBGQyBewnh4HDWh3og
         kBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po1IjVvNbfbkNgObAIQZQOCa9GvhgYqjWMEtcnXnmpc=;
        b=r5xSegSVYGrPBwVc96jmudX+lc1Lmnk7mVS4YDrei9smG3qEa7odI7perYaxc3Lldc
         njCvrvSF7V7sAGV4uECqVKGn4abMbX9AOHf1AWvUm60Cu3zrE1On4la+VAYjfLOr2ajn
         1leVe1G/zFvzUB3/lci7j5KfErWzAY433jWkx3IxgEQm8asp95o9qeO9Nxgo/D0E3fE6
         mH+sXqbaI2gOKie5JdF5aX+edbtKqbw5uWRfy+zElISSJcitMkUhKE2yxtc8fkx/fvJA
         2YbTW7N13QuFO/7jBeA5CsAF+fun9YZnlcPlDgCQgmF7QpNRr6iDu9wrDS0T3VSJ655H
         4voQ==
X-Gm-Message-State: ACrzQf0iDGncPli3Yibt3qmucn5hVJeAD9bBHbU1eiP1s2O9kZUYolAJ
        RDArvlVoh5A7NBs837nx7mdge1t3NUu12nB7xWjXkw==
X-Google-Smtp-Source: AMsMyM415+lMvVbX7yZEq7tZlWUuO3juBcQw6UXdl44PBZ6p/6LEI1BZ/phvFx/2s2QBTyfEqvspvNeGvv9GRetnYqg=
X-Received: by 2002:a92:6506:0:b0:2fc:37fb:60c2 with SMTP id
 z6-20020a926506000000b002fc37fb60c2mr6188696ilb.244.1665519974463; Tue, 11
 Oct 2022 13:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221011200112.731334-1-keescook@chromium.org> <20221011200112.731334-6-keescook@chromium.org>
In-Reply-To: <20221011200112.731334-6-keescook@chromium.org>
From:   Colin Cross <ccross@android.com>
Date:   Tue, 11 Oct 2022 13:26:02 -0700
Message-ID: <CAMbhsRT2KafJ8-mvKbi1MkY8T-0sZFdCg-Rb8FoUGorGH6jipg@mail.gmail.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 1:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> Update pstore to better reflect reality of active contributors:
>
> - Remove Anton and Colin (thank you for your help through the years!)
> - Move Tony to Reviewer
> - Add Guilherme as Reviewer
> - Add mailing list
> - Upgrade to Supported
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..bb18a6c91c4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16458,10 +16458,10 @@ F:    net/psample
>
>  PSTORE FILESYSTEM
>  M:     Kees Cook <keescook@chromium.org>
> -M:     Anton Vorontsov <anton@enomsg.org>
> -M:     Colin Cross <ccross@android.com>
> -M:     Tony Luck <tony.luck@intel.com>
> -S:     Maintained
> +R:     Tony Luck <tony.luck@intel.com>
> +R:     Guilherme G. Piccoli <gpiccoli@igalia.com>
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
>  F:     Documentation/admin-guide/ramoops.rst
>  F:     Documentation/admin-guide/pstore-blk.rst
> --
> 2.34.1
>

Acked-by: Colin Cross <ccross@android.com>
