Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9560AE06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiJXOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiJXOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:45:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3230FE902
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:22:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o2so5982293qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3txhj9ruJJM9AXKbEF9KilhIBuojvzSzGeKITvXuzxc=;
        b=Eed5kNNahpu3t3tRM9gcdCp1a3yHYKXjKMf6lxt920bqzQGVjK11zLBWeQBd7Kx3kl
         G+X0ORbi9jkD4MwiMudW1QTPzAvjUCGyPnDyy5Jtqjh8RU6g9jLtoo38QdlG3N1Ne0hE
         c5tUM/SaWag6bfZC1kDlovWqzYp46JXi9ZNWuV5nuPXOo7/JB8IYBX2KY57jN+jzZN+m
         nFpugPGmSCtusuJxhw+L+ZnPh4sa3UwzORPNboN1HSkNBU4UhJsNGyX+RWUHvMf1By/f
         HG6MiQdgmTtsf9BKvThw6SNtY+DHqMSz5NE714fT3yanXHuy/ULiT1EXnqvBNkdryd0j
         UZ2g==
X-Gm-Message-State: ACrzQf2eKDkT2OxmzqCpStAFUS9F44P4sS8MuwQjdYHfxIJrkr5qyMsS
        Q4YgFb+MHQlxpFCslCnntlx2m2Hua4g1tEE8aoQxB9HGxvE=
X-Google-Smtp-Source: AMsMyM7iaQNp3f7FapFnm0Yoj7RcyPLjcsanArfKJ/K+M9JX8k2MmSjS/sHMiI8XwqFhti5tC8tTSJ410QQBxMx82jw=
X-Received: by 2002:a05:620a:1102:b0:6ee:6fb:4af2 with SMTP id
 o2-20020a05620a110200b006ee06fb4af2mr23191085qkk.501.1666617290077; Mon, 24
 Oct 2022 06:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
In-Reply-To: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Oct 2022 15:14:35 +0200
Message-ID: <CAJZ5v0izrhdD9ecWgZf4LPc7d2pYQt02XDsjOG9cye1v_qxX=A@mail.gmail.com>
Subject: Re: [PATCH] container_of: remove container_of_safe()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 2:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It came in from a staging driver that has been long removed from the
> tree, and there are no in-kernel users of the macro, and it's very
> dubious if anyone should ever use this thing, so just remove it
> entirely.
>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/container_of.h | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 2f4944b791b8..a6f242137b11 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -21,20 +21,4 @@
>                       "pointer type mismatch in container_of()");       \
>         ((type *)(__mptr - offsetof(type, member))); })
>
> -/**
> - * container_of_safe - cast a member of a structure out to the containing structure
> - * @ptr:       the pointer to the member.
> - * @type:      the type of the container struct this is embedded in.
> - * @member:    the name of the member within the struct.
> - *
> - * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
> - */
> -#define container_of_safe(ptr, type, member) ({                                \
> -       void *__mptr = (void *)(ptr);                                   \
> -       static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> -                     __same_type(*(ptr), void),                        \
> -                     "pointer type mismatch in container_of_safe()");  \
> -       IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :                     \
> -               ((type *)(__mptr - offsetof(type, member))); })
> -
>  #endif /* _LINUX_CONTAINER_OF_H */
> --
> 2.38.1
>
