Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAEE60391F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJSFR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJSFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:17:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE86C107
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:17:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z20so15860529plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEYY08IO1GQda3Oo29H9CB5vCsxgZYI+Mu2YJ6LIwxs=;
        b=Buq0KVAaGIJ4On1IZVmUbUwVBFh9UF7PA19sOAMdSpJUeBurtc+39fam2Z0jTfwMqj
         EixqoPDSPhGjFO/yN4nM9NZ4buEmMun/Q9yBeZR7n4DzJybNz0/RF/5GbtDs/lWTxdFe
         tioGvtf12HQz+YGq8l7ktVM5cPIxYpPUeZQbBZ6zgMF/FYwxEky1ig6ReSlgzLHJ0jYw
         S3PGImlYC1WzJXKFUaHvhsrIaCpB0mPPLQI5LoIpgCUo4zJZKVC/vUdU9KmDGKLO+JRO
         XGCMSrliJ6tKSto7jqtSzDg+h5SuYWr5HLaffE8xEv5VJ30R3DTfL/PYePvyOS4i3Lq5
         Zuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEYY08IO1GQda3Oo29H9CB5vCsxgZYI+Mu2YJ6LIwxs=;
        b=70AGOr01JGTQZmdWtRYY1NDUebgt6G6B2YNn31CDE+lC4Naf9eIZGe/FEBUT3Dyh0L
         BIA+6ioeAJhv/KnfsTbfr9R6BCh/LfhwcQ4sa7TOS1vs56F3D0BhEiUzWWHUBI1nwROb
         03IwLYNIE6FihVGNK7bTtTfBOwHpy9clmOFMIX867V17cwuZU0lM2U3UZUKNYf+W4mw5
         wPaDGumPXNEmnzfjfEMSiKyAMR0MyX001YV/rKhMCMOe6quJpwWFtf2jDJyYDvwKgkG/
         Rp4Dki/FOhXLxmTL0xNxTqe/8ipGDlj5yfCLuI+qLQ9gKXt4GKGEigeTy9JnslVIXb4n
         PzgA==
X-Gm-Message-State: ACrzQf09Kbk+SdG8/rzPj+hIdEMVzSJrYuABR4omS9L67/Gxuz4OdGge
        BbFgWIaEKqP9RF2h03p5/hrubvIEpilLUKcOA8I8Uw==
X-Google-Smtp-Source: AMsMyM6y7mvbMqGuqPmpTfLvf44iKqjD6K5p+5a3bqhBADKg8teZE3IgeJo9zljz0xvgnhQzrE1wMQmhb2Y6gzGPcSk=
X-Received: by 2002:a17:902:8ec7:b0:182:dcf0:4a22 with SMTP id
 x7-20020a1709028ec700b00182dcf04a22mr6843610plo.61.1666156639652; Tue, 18 Oct
 2022 22:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk> <20221018174157.1897-1-phillip@squashfs.org.uk>
In-Reply-To: <20221018174157.1897-1-phillip@squashfs.org.uk>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Wed, 19 Oct 2022 01:17:08 -0400
Message-ID: <CA+pv=HNWZHrDBO9pp-3HoJ1qwRGaJMoZXt=iXRMUPz=-t7v8Qw@mail.gmail.com>
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        nicememory@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On Tue, Oct 18, 2022 at 1:42 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> This diff has fixed the problem with my repoducer.
> Please test and report your results.
>
> Phillip

Tested-by me just a few moments ago and can report this fixed the
problem. (I believe Mirsad also reported that this fixed it.)

Yours,
-srw

>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..e526eb7a1658 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -557,6 +557,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
>                 int res, bsize;
>                 u64 block = 0;
>                 unsigned int expected;
> +               struct page *last_page;
>
>                 nr_pages = __readahead_batch(ractl, pages, max_pages);
>                 if (!nr_pages)
> @@ -593,15 +594,15 @@ static void squashfs_readahead(struct readahead_control *ractl)
>
>                 res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>
> -               squashfs_page_actor_free(actor);
> +               last_page = squashfs_page_actor_free(actor);
>
>                 if (res == expected) {
>                         int bytes;
>
>                         /* Last page (if present) may have trailing bytes not filled */
>                         bytes = res % PAGE_SIZE;
> -                       if (pages[nr_pages - 1]->index == file_end && bytes)
> -                               memzero_page(pages[nr_pages - 1], bytes,
> +                       if (index == file_end && bytes && last_page)
> +                               memzero_page(last_page, bytes,
>                                              PAGE_SIZE - bytes);
>
>                         for (i = 0; i < nr_pages; i++) {
> diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
> index 54b93bf4a25c..6aa38f88e31c 100644
> --- a/fs/squashfs/page_actor.c
> +++ b/fs/squashfs/page_actor.c
> @@ -53,6 +53,7 @@ struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>         actor->pages = pages;
>         actor->next_page = 0;
>         actor->tmp_buffer = NULL;
> +       actor->last_page = NULL;
>         actor->squashfs_first_page = cache_first_page;
>         actor->squashfs_next_page = cache_next_page;
>         actor->squashfs_finish_page = cache_finish_page;
> @@ -71,11 +72,13 @@ static void *handle_next_page(struct squashfs_page_actor *actor)
>                         (actor->next_index != actor->page[actor->next_page]->index)) {
>                 actor->next_index++;
>                 actor->returned_pages++;
> +               actor->last_page = NULL;
>                 return actor->alloc_buffer ? actor->tmp_buffer : ERR_PTR(-ENOMEM);
>         }
>
>         actor->next_index++;
>         actor->returned_pages++;
> +       actor->last_page = actor->page[actor->next_page];
>         return actor->pageaddr = kmap_local_page(actor->page[actor->next_page++]);
>  }
>
> diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
> index 95ffbb543d91..97d4983559b1 100644
> --- a/fs/squashfs/page_actor.h
> +++ b/fs/squashfs/page_actor.h
> @@ -16,6 +16,7 @@ struct squashfs_page_actor {
>         void    *(*squashfs_first_page)(struct squashfs_page_actor *);
>         void    *(*squashfs_next_page)(struct squashfs_page_actor *);
>         void    (*squashfs_finish_page)(struct squashfs_page_actor *);
> +       struct page *last_page;
>         int     pages;
>         int     length;
>         int     next_page;
> @@ -29,10 +30,13 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>  extern struct squashfs_page_actor *squashfs_page_actor_init_special(
>                                 struct squashfs_sb_info *msblk,
>                                 struct page **page, int pages, int length);
> -static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
> +static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *actor)
>  {
> +       struct page *last_page = actor->last_page;
> +
>         kfree(actor->tmp_buffer);
>         kfree(actor);
> +       return last_page;
>  }
>  static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
>  {
