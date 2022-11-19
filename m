Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9EC630F32
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiKSOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 09:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiKSOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 09:46:07 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC97EBD2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:46:04 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i5so3819127ilc.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6cRmx5xlvWxqI3Q21J9iOtYTxXg+LdFquwejNlafYk=;
        b=OLikv6lMFDLoykxdmEOYh+5Q9/UFy3P4xNjzwC1tRl9G7aTagGt/mrsXRNmPFGTJYo
         Jaevtq0C76mUxopYFtADVpfYgN+kAI1KngLvcaFUSeJwl99u3cNyOhb6cXj7GViSacUS
         pqC2jGVw2aVblCzrBlJiq9XFEzisLQkdwe142mbY7xv+TS+9pNLLYRHNJAAPWoCwV1j8
         GGDA1sJbykKDy5jCwgBTDlUBTja7vrRmkHjYZbQIA+MVvxdqYqv4dqlcbUfIxSMZG02r
         ZJroV7CNHKHL5F4FSP8JTx4js8kIuKWEHdnTMvq0C1ifLfXszcJe1DAHBaPqTeSUz7a8
         D0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6cRmx5xlvWxqI3Q21J9iOtYTxXg+LdFquwejNlafYk=;
        b=GKlLv9n0NSFHIOwybJ66ZLmGIrlWIH26RsgOMEsbXJrpOeE20ehE/MhRgJ6XNHUgqC
         lV27jR9V1xNwErZtJInn6QtGDTx1XQ6WkVHnFEUTCRrTZG43ULaBCP0FID9oY5l+GnNJ
         9ZkhovLYxFgPZouomT8leHbLA9KUl/a939BPprJH+kViixzRLTc27+V5XnRvZWLIqYlD
         Umzm1ra7JIzaQ/Y3MPW4eWKaliwuEXjfOqpB80PxCA258NI2io9fQwBLK86RNJ1Orpwp
         eyQzAj8A43KzToLXy+Q7S8wHe3h0APwBQbVxPEZBYGhOP8S1lXNW01SQvfsqFn4QBnQM
         D0ug==
X-Gm-Message-State: ANoB5pm3bI23DIfwlr+h6l1nUAQ9WtahSDWq+d5+pAAo8mNpETNC2mew
        QmxqcUL2jK0riTY0YAsjBFANoMji5h04s5WtEnOK3w==
X-Google-Smtp-Source: AA0mqf6OijOkswU4IRx2HHvq9+JmXMjNyCUavkLhkflH2sTsVhu3vvkU+yUNZiWMoGEggr5iG3wDjVr/r6RDpocxDr4=
X-Received: by 2002:a92:c501:0:b0:302:9dc6:3939 with SMTP id
 r1-20020a92c501000000b003029dc63939mr4285784ilg.157.1668869163557; Sat, 19
 Nov 2022 06:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20221101032248.819360-1-kernel@hev.cc> <Y2KBovUHODJJ8ZnV@casper.infradead.org>
 <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com>
In-Reply-To: <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com>
From:   hev <r@hev.cc>
Date:   Sat, 19 Nov 2022 22:45:52 +0800
Message-ID: <CAHirt9jh=8tRtGi=f2xhhyDn_Qjb-ofSitvsUyFmVwzCrDLiHg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/shmem: Fix undo range for failed fallocate
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Guoqi <chenguoqic@163.com>, Huacai Chen <chenhuacai@loongson.cn>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Wang <kernel@hev.cc>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

On Thu, Nov 3, 2022 at 3:52 PM hev <r@hev.cc> wrote:
>
> Hi Matthew,
>
> On Wed, Nov 2, 2022 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 01, 2022 at 11:22:48AM +0800, Rui Wang wrote:
> > > This patch fixes data loss caused by the fallocate system
> > > call interrupted by a signal.
> > >
> > > Bug: https://lore.kernel.org/linux-mm/33b85d82.7764.1842e9ab207.Coremail.chenguoqic@163.com/
> > > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> >
> > How does that commit introduce this bug?
>
> In the test case[1], we created a file that contains non-zero data
> from offset 0 to A-1. and a process try to expand this file by
> fallocate(fd, 0, 0, B), B > A.
> Concurrently, another process try to interrupt this fallocate syscall
> by a signal. I think the expected results are:
>
> 1. The file is not expanded and file size is A, and the data from
> offset 0 to A-1 is not changed.
> 2. The file is expanded and the data from offset 0 to A-1 is not
> changed, and from A to B-1 contains zeros.
>
> Now, the unexpected result is that the file is not expanded and the
> data that from offset 0 to A-1 is changed by
> truncate_inode_partial_folio that called
> from shmem_undo_range with unfalloc = true.
>
> This issue is only reproduced when file on tmpfs, and begin from this
> commit: b9a8a4195c7d ("truncate,shmem: Handle truncates that split
> large folios")
>
> >
> > > Reported-by: Guoqi Chen <chenguoqic@163.com>
> > > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Rui Wang <kernel@hev.cc>
> > > ---
> > >  mm/shmem.c | 20 ++++++++++++--------
> > >  1 file changed, 12 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index bc9b84602eec..8c8dce34eafc 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -948,11 +948,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> > >       folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
> > >       if (folio) {
> > >               same_folio = lend < folio_pos(folio) + folio_size(folio);
> > > -             folio_mark_dirty(folio);
> > > -             if (!truncate_inode_partial_folio(folio, lstart, lend)) {
> > > -                     start = folio->index + folio_nr_pages(folio);
> > > -                     if (same_folio)
> > > -                             end = folio->index;
> > > +             if (!unfalloc || !folio_test_uptodate(folio)) {
> > > +                     folio_mark_dirty(folio);
> > > +                     if (!truncate_inode_partial_folio(folio, lstart, lend)) {
> > > +                             start = folio->index + folio_nr_pages(folio);
> > > +                             if (same_folio)
> > > +                                     end = folio->index;
> > > +                     }
> >
> > ... so what you're saying is that if we allocate a page, but zeroing
> > it is interrupted by a signal, we cannot now remove that page from
> > the cache?  That seems wrong.
> >
> > Surely the right solution is to remove this page from the cache if we're
> > interrupted by a signal.
>
> So I think we should not truncate_inode_partial_folio for unfalloc =
> true. Isn't that right?
>
> [1] https://github.com/abner-chenc/abner/blob/master/fallocate.c
>
> Regards,
> Ray
