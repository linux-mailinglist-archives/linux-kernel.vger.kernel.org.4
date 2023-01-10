Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A05664DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAJVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjAJVQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:16:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4A5F491
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:16:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so1621299wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rm3QR70vsvtk0GdrQxO+T3mTyRnc34PXABTeiDAN3aU=;
        b=J6bsJ+qdaNDxxbNulA8aTN9nXH3IutM50tiJ5BjyYjYfGVJb5R+O19fG0rRUReO6GR
         mLjpF2Kf9ICtutODhBvNHZxSrXfjfBtK/OtLFDr4jNkF7Js5VDHb1C0svKOgiTnu5oyL
         1y9qXWMQ1O0C9YmFzGhsloo6j61NYsU9y5h190SIqCK+ULiConv3u4L5NNGZb8BUayPv
         ktWG/fet59yas18GqJET0PmLvOV9Z0sloEiOptIMMjz32S7Fu53+XAgoLDgOlf8hDvoH
         tbGRPUGuW5P3GV7pnnk6jglZI/X4HiE9SW8MbVfQB5z95+UWcGGZ9K2UTVPdyd/jDDhg
         7g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm3QR70vsvtk0GdrQxO+T3mTyRnc34PXABTeiDAN3aU=;
        b=Zx3oq2fCrkSXKSVd+Jvam7/hTjlmzRaRb7KZayUdapNVtHuHmGR588ZrU12fdIAEtC
         4Gu5ipeosUpDJLSrPdVY239v57O6U5vc8jSJRmfVqrAzMwlc991dPjFsbQSox5GNbOLq
         P4tIPb8AUM+2pGuNOX2XyigwZ2k4+oZii+fD1UuvNQ+iqqjo8s6UdtwFMWU3ebVlEQn6
         vr09d0xFbs5c4/SWVFenwgGfJrY24Jj2rC2AbYvT3RTorpidtDmKtAqZ4EsjIw+/WIpy
         96oqWf9aJPFcHarOe8Gm3nABFhdj5YYnZbObqfRCdWbVLuxV9NdImP0ejGqM52Cvkv0y
         0ZRQ==
X-Gm-Message-State: AFqh2ko/jGinWJ6XIAzaJ5Yt9z3aarpsLHIfe6Y/vSLU80udrfjllPWy
        pvvUblW698ltbnFDDqDfhV84XKcg7WyhJ0AP1cchh5XVaaQ=
X-Google-Smtp-Source: AMrXdXuPNpcSOQohf7grr4ojrQziXGy7FM8/oN0RxQE7DoM80GPa1c3u6edBIVq+XJWnAd7jnyKuiaTSWBDRQdd99jQ=
X-Received: by 2002:a05:600c:3d99:b0:3d0:8c4b:b76f with SMTP id
 bi25-20020a05600c3d9900b003d08c4bb76fmr3038411wmb.131.1673385398899; Tue, 10
 Jan 2023 13:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20230104231127.2634648-1-nphamcs@gmail.com> <20230104231127.2634648-3-nphamcs@gmail.com>
 <Y710pFYI8rBX9Eqe@bfoster>
In-Reply-To: <Y710pFYI8rBX9Eqe@bfoster>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 10 Jan 2023 13:16:27 -0800
Message-ID: <CAKEwX=OjhHRrH9uS4d5XWfRU=UEpBVQ9n9+-f4hyvB5Rs+r0Og@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] cachestat: implement cachestat syscall
To:     Brian Foster <bfoster@redhat.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
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

On Tue, Jan 10, 2023 at 6:21 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Wed, Jan 04, 2023 at 03:11:26PM -0800, Nhat Pham wrote:
> > Implement a new syscall that queries cache state of a file and
> > summarizes the number of cached pages, number of dirty pages, number of
> > pages marked for writeback, number of (recently) evicted pages, etc. in
> > a given range.
> >
> > NAME
> >     cachestat - query the page cache statistics of a file.
> >
> > SYNOPSIS
> >     #include <sys/mman.h>
> >
> >     struct cachestat {
> >         __u64 nr_cache;
> >         __u64 nr_dirty;
> >         __u64 nr_writeback;
> >         __u64 nr_evicted;
> >         __u64 nr_recently_evicted;
> >     };
> >
> >     int cachestat(unsigned int fd, off_t off, size_t len,
> >           size_t cstat_size, struct cachestat *cstat,
> >           unsigned int flags);
> >
> > DESCRIPTION
> >     cachestat() queries the number of cached pages, number of dirty
> >     pages, number of pages marked for writeback, number of evicted
> >     pages, number of recently evicted pages, in the bytes range given by
> >     `off` and `len`.
> >
> >     An evicted page is a page that is previously in the page cache but
> >     has been evicted since. A page is recently evicted if its last
> >     eviction was recent enough that its reentry to the cache would
> >     indicate that it is actively being used by the system, and that
> >     there is memory pressure on the system.
> >
> >     These values are returned in a cachestat struct, whose address is
> >     given by the `cstat` argument.
> >
> >     The `off` and `len` arguments must be non-negative integers. If
> >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
> >     0, we will query in the range from `off` to the end of the file.
> >
> >     `cstat_size` allows users to obtain partial results. The syscall
> >     will copy the first `csstat_size` bytes to the specified userspace
> >     memory. `cstat_size` must be a non-negative value that is no larger
> >     than the current size of the cachestat struct.
> >
> >     The `flags` argument is unused for now, but is included for future
> >     extensibility. User should pass 0 (i.e no flag specified).
> >
> > RETURN VALUE
> >     On success, cachestat returns 0. On error, -1 is returned, and errno
> >     is set to indicate the error.
> >
> > ERRORS
> >     EFAULT cstat points to an invalid address.
> >
> >     EINVAL invalid `cstat_size` or `flags`
> >
> >     EBADF  invalid file descriptor.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
> >  arch/arm/tools/syscall.tbl                  |   1 +
> >  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
> >  include/linux/fs.h                          |   3 +
> >  include/linux/syscalls.h                    |   3 +
> >  include/uapi/asm-generic/unistd.h           |   5 +-
> >  include/uapi/linux/mman.h                   |   9 ++
> >  init/Kconfig                                |  10 ++
> >  kernel/sys_ni.c                             |   1 +
> >  mm/filemap.c                                | 143 ++++++++++++++++++++
> >  20 files changed, 186 insertions(+), 1 deletion(-)
> >
> ...
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 08341616ae7a..d70d47b20700 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> ...
> > @@ -3949,3 +3953,142 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
> >       return try_to_free_buffers(folio);
> >  }
> >  EXPORT_SYMBOL(filemap_release_folio);
> ...
> > +#ifdef CONFIG_CACHESTAT_SYSCALL
> > +/*
> > + * The cachestat(5) system call.
> > + *
> > + * cachestat() returns the page cache statistics of a file in the
> > + * bytes range specified by `off` and `len`: number of cached pages,
> > + * number of dirty pages, number of pages marked for writeback,
> > + * number of evicted pages, and number of recently evicted pages.
> > + *
> > + * An evicted page is a page that is previously in the page cache
> > + * but has been evicted since. A page is recently evicted if its last
> > + * eviction was recent enough that its reentry to the cache would
> > + * indicate that it is actively being used by the system, and that
> > + * there is memory pressure on the system.
> > + *
> > + * `off` and `len` must be non-negative integers. If `len` > 0,
> > + * the queried range is [`off`, `off` + `len`]. If `len` == 0,
> > + * we will query in the range from `off` to the end of the file.
> > + *
> > + * `cstat_size` allows users to obtain partial results. The syscall
> > + * will copy the first `csstat_size` bytes to the specified userspace
> > + * memory. It also makes the cachestat struct extensible - new fields
> > + * can be added in the future without breaking existing usage.
> > + * `cstat_size` must be a non-negative value that is no larger than
> > + * the current size of the cachestat struct.
> > + *
> > + * The `flags` argument is unused for now, but is included for future
> > + * extensibility. User should pass 0 (i.e no flag specified).
> > + *
> > + * Because the status of a page can change after cachestat() checks it
> > + * but before it returns to the application, the returned values may
> > + * contain stale information.
> > + *
> > + * return values:
> > + *  zero    - success
> > + *  -EFAULT - cstat points to an illegal address
> > + *  -EINVAL - invalid arguments
> > + *  -EBADF   - invalid file descriptor
> > + */
> > +SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,
> > +             size_t, cstat_size, struct cachestat __user *, cstat,
> > +             unsigned int, flags)
> > +{
> > +     struct fd f = fdget(fd);
> > +     struct address_space *mapping;
> > +     struct cachestat cs;
> > +     pgoff_t first_index = off >> PAGE_SHIFT;
> > +     pgoff_t last_index =
> > +             len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> > +
> > +     if (off < 0 || cstat_size > sizeof(struct cachestat) || flags != 0)
> > +             return -EINVAL;
> > +
> > +     if (!f.file)
> > +             return -EBADF;
> > +
>
> It looks like we miss an fdput() before returning via the above error
> checks.

Ooops yeah I missed that. I'll fix it.

>
> The only other thing that stands out as a bit odd to me is the
> cstat_size check and associated ability to return a partial cachestat
> struct. Do other syscalls do anything like that? I'd think we'd want to
> ensure we always at least return a fully populated cachestat struct,
> even if it happened to be an old/compat version if the size does ever
> increase. Hm?

Not that I know of, but the idea is that the user might expect a smaller
struct cachestat in their code (and allocate memory accordingly).
With this cstat_size, we can make sure that the expansion of cachestat
struct (with new fields) does not break existing user's code - we only
copy part of the struct.

>
> Brian
>
> > +     memset(&cs, 0, sizeof(struct cachestat));
> > +     mapping = f.file->f_mapping;
> > +     filemap_cachestat(mapping, first_index, last_index, &cs);
> > +     fdput(f);
> > +
> > +     if (copy_to_user(cstat, &cs, cstat_size))
> > +             return -EFAULT;
> > +
> > +     return 0;
> > +}
> > +#endif /* CONFIG_CACHESTAT_SYSCALL */
> > --
> > 2.30.2
> >
>
