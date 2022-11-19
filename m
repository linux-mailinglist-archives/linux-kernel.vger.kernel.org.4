Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E998630D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiKSHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:51:58 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44ABA317D;
        Fri, 18 Nov 2022 23:51:56 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a6so6820812vsc.5;
        Fri, 18 Nov 2022 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6vdOEVAcD2AZ27aVOd1nSfHkg1RH4opt/DvlE3Mfq4=;
        b=iIZHwweMUcLVO5AndwXT/ROt80RSWCgUcj9w2CjXhnIRwMf5Gt8QtzbQ1aJnBxqlUG
         Zz+7gUq5XYUJIjHwyy5ebQ98mtlQr2p7zacU85h8TQwMLx+ZYL/BZirh9s8+S3L/kZlr
         v6qNE6tKQnmUwCDv+SNkUCRfaAAHLcY7gHPr4HaLUJP6mDGDxz4sNg4or18wR0kbBf9E
         Nz6zRDYUZ0EG7uv69sWchDASNClFrxShEi1ockIArfAyvMxk/O6qIPgpuZWF+ROZEnRU
         rSUVa+6Td2b/UpxqKQwWuwrJ5sdBCRZabWqRl222Bj1bSQUtmCgYKG3fIbrCXm7MGKfA
         Qxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6vdOEVAcD2AZ27aVOd1nSfHkg1RH4opt/DvlE3Mfq4=;
        b=1PWBIQUU/E+P+AZWh+YrRQxJYG6RZeNpZ0PAftKkJ9qSIPuwUvBra1E9BGiqr76W8Y
         OtZAM64/Rr8ZEwG3UQwW2+2JyFkgclHi7pI039VRb9g0TEaquii3RAXxQDrooGPrWbBp
         Se2TH79jIJD0hR5OlfXS/b3tf65brLbDqs/vpn2O+XdjNRoUf9MOyFzQJ4g02+N7FzMp
         th7AFgstqtOT3f0MMg27fC5m2t6FIjBcR2iNsi9/Sd4QwePS7BOo0bOZHwf27s/TyELI
         WWtVV/3OQsuB84UxHsFGH2eWObcg0vmwKF5/mMTX4cuE6GT3xSbfjo9tAy0AOQxWreVQ
         yIRg==
X-Gm-Message-State: ANoB5pmsFScjhDhg5RzISntwuQgja//D5++gUbCS4eDEbWwqeXooIywx
        w3yzdUmG6chWtjatTyU793kyTcroslqDt3g01BzgmyXNyqE=
X-Google-Smtp-Source: AA0mqf4ypRAYhlRK0VTmnA2RAqqAbSSKp7OsH7IVigNzZZ+x/TEOxnB1+59/XS7DEXU6JiKMw4xI+qzrF4fDEd5/T3c=
X-Received: by 2002:a67:1006:0:b0:3aa:5e8:3a19 with SMTP id
 6-20020a671006000000b003aa05e83a19mr5351809vsq.37.1668844315837; Fri, 18 Nov
 2022 23:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20221118063304.140187-1-chenzhongjin@huawei.com>
 <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
 <0e693d41-0bb5-b4a9-19b7-1c71e90e06bf@huawei.com> <55553de4-04c3-09f3-b075-f0112d2298cb@huawei.com>
 <CAKFNMom=vjGrXJoc02ut8GocQ6hMmHrkcdReEvk-ykcE4p0b-w@mail.gmail.com>
In-Reply-To: <CAKFNMom=vjGrXJoc02ut8GocQ6hMmHrkcdReEvk-ykcE4p0b-w@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 19 Nov 2022 16:51:39 +0900
Message-ID: <CAKFNMon7TSEgTBHJ9YA26X2eqf39qG9h_ANYjyQ6s1EQs8B76Q@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix nilfs_sufile_mark_dirty() not set segment
 usage as dirty
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Nov 19, 2022 at 4:17 PM Ryusuke Konishi wrote:
>
> Hi Chen Zhongjin,
>
> On Sat, Nov 19, 2022 at 2:29 PM Chen Zhongjin wrote:
> >
> >
> > On 2022/11/19 13:24, Chen Zhongjin wrote:
> > > On 2022/11/19 6:11, Andrew Morton wrote:
> > >> On Fri, 18 Nov 2022 14:33:04 +0800 Chen Zhongjin
> > >> <chenzhongjin@huawei.com> wrote:
> > >>
> > >>> In nilfs_sufile_mark_dirty(), the buffer and inode are set dirty, but
> > >>> nilfs_segment_usage is not set dirty, which makes it can be found by
> > >>> nilfs_sufile_alloc() because it checks nilfs_segment_usage_clean(su).
> > >>>
> > >>> This will cause the problem reported by syzkaller:
> > >>> https://syzkaller.appspot.com/bug?id=c7c4748e11ffcc367cef04f76e02e931833cbd24
> > >>>
> > >>>
> > >>> It's because the case starts with segbuf1.segnum = 3, nextnum = 4, and
> > >>> nilfs_sufile_alloc() not called to allocate a new segment.
> > >>>
> > >>> The first time nilfs_segctor_extend_segments() allocated segment
> > >>> segbuf2.segnum = segbuf1.nextnum = 4, then nilfs_sufile_alloc() found
> > >>> nextnextnum = 4 segment because its su is not set dirty.
> > >>> So segbuf2.nextnum = 4, which causes next segbuf3.segnum = 4.
> > >>>
> > >>> sb_getblk() will get same bh for segbuf2 and segbuf3, and this bh is
> > >>> added to both buffer lists of two segbuf.
> > >>> It makes the list head of second list linked to the first one. When
> > >>> iterating the first one, it will access and deref the head of second,
> > >>> which causes NULL pointer dereference.
> > >>>
> > >>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> > >> Merged in 2009!
> > >
> > > Yes, seems it is introduced at the beginning of this file and the
> > > function called nilfs_touch_segusage().
> > >
>
> Could you please resubmit the patch reflecting the following comments ?
>
> After I replied to Andrew, I noticed them.
> Also, When reposting, it would be helpful if you could add all the
> tags I asked for Andrew in advance.
>
> Comments:
> 1) Please change nilfs_sufile_mark_dirty() so that it protects the
> segusage modification
> with &NILFS_MDT(sufile)->mi_sem:
>
> > --- a/fs/nilfs2/sufile.c
> > +++ b/fs/nilfs2/sufile.c
> > @@ -495,12 +495,18 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
> >  int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
> >  {
> >       struct buffer_head *bh;
> > +     void *kaddr;
> > +     struct nilfs_segment_usage *su;
> >       int ret;
> >

> >       ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
>
> +       down_write(&NILFS_MDT(sufile)->mi_sem);

Sorry, the location of this down_write() was wrong in this email.
In my tested change, I put it before
nilfs_sufile_get_segment_usage_block() like others.

> +       down_write(&NILFS_MDT(sufile)->mi_sem);
> >       ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
> >       if (!ret) {
> >               mark_buffer_dirty(bh);
> >               nilfs_mdt_mark_dirty(sufile);
> > +             kaddr = kmap_atomic(bh->b_page);
> > +             su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
> > +             nilfs_segment_usage_set_dirty(su);
> > +             kunmap_atomic(kaddr);
> >               brelse(bh);
> >       }
> +       up_write(&NILFS_MDT(sufile)->mi_sem);
> >       return ret;
>
> All functions that modify metadata on the sufile need protection with
> this R/W semaphore.
> You may not see this protection for some sufile functions as is, but
> in that case, the wrapper function that uses them acquires this R/W
> semaphore instead.


Regards,
Ryusuke Konishi


>
> Since I retested for this change as well, you don't have to drop my
> "Tested-by" tag.
>
> 2) Please use the following complete email address for the
> "Reported-by" tag of syzbot.
>
> Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
>
> Your tag is partially abbreviated.  I don't know that abbreviation is
> valid, but there are very few examples of such.
> And even if it's valid for syzbot, I don't think that omission is
> desirable as some tools may not support it.
>
> Thanks,
> Ryusuke Konishi
