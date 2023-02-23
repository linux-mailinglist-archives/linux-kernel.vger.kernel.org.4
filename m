Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BC6A0069
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjBWBFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBWBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:05:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D26DB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:05:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id h16so37802571edz.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHogG2LDNYMpKAnj+yA1kU5df/jIvMfB3AX9e8CKk5Q=;
        b=eMEr2KTiTgK78tcAXjNLifRF6IhRudaha/mQV40/EZp98wWqB3C4XPGo8J46TDVQuK
         9Myt9kMvWCrEOe/SaNvOPIMclmFuS8vgmWgA3EZN0lRW3NmVeZNtfvxE+6NNyAltGVH/
         YB1MxF7KzN2WhPp3SZazN8uDBfpRznfZN5azAZl8E0fgnhETkEf4FUuAYJG2PAv3mdOs
         hzBuFXnu7ItacKES8EPoRUmLOwNlaSpVy456ogAk+b3AvJs50CaoJHkq+qNUj/jAN7jE
         nz/ejjux5nP3MClh8TxQkpm3o2EHZgigNxCMOh+n0EV8+CdMxCSQVXStaua0ZgUJCiBt
         Br5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHogG2LDNYMpKAnj+yA1kU5df/jIvMfB3AX9e8CKk5Q=;
        b=KYk9jMri2S3BJvHzx+WK/g5i7j+ABG3Tctw9JY610f1vb7w2y2pCHk/RMVJGY797jJ
         sGrCATrCqI94ymyTKA+LW3sYRRBIbTKwElernRXO1CXwRYCKZ0rrVMYMHfLmZBOFBgAQ
         VZtFv2CDSO5qlG1fFFekOR39w66m+FWVbbYlqDrRz+vcYhUXz0pLQ+LwePWFr76t6DoT
         QoUGX4wmzwIJCOnPBCQ3AJJ9shUkRfs5ZEQnwpt/npWcaEPUl/eJ38UCrmN6tpRGmFjk
         e6HuXqJUHbG9uOKX/Zqa84+OkPNyT5DXcZizPItL717uuCWcDuB+uDZ4EVTio4yBMDLl
         OEJg==
X-Gm-Message-State: AO0yUKWAfwWlNIQDsdVqVko2dlUMxZh/61ESK9fwIDDeXc/Yg4fUgRZR
        +g3VJRNCGfXJW3+0iqPYwBII2GU+HDcr/RvreLWqEQ==
X-Google-Smtp-Source: AK7set8Tlpt0l9zSd2Ls40nRHuuybUPIQY9OPfJ8q+1se4mX40SUAsOH3ldxioQc54rTxF2xHul/dQj3q3UO1rqhHfo=
X-Received: by 2002:a17:907:7b8a:b0:8af:2ad8:3453 with SMTP id
 ne10-20020a1709077b8a00b008af2ad83453mr10329720ejc.6.1677114310566; Wed, 22
 Feb 2023 17:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20230207025259.2522793-1-mcgrof@kernel.org> <20230207025259.2522793-3-mcgrof@kernel.org>
 <Y+HNL9RoP48tquGd@casper.infradead.org> <Y+PHPfiVS6EiTVl1@bombadil.infradead.org>
 <Y+PfqulG2wt0Y+Vr@casper.infradead.org> <CAJD7tkZnaphPCrOTMjb0uM7HHqwJESaauNZ6Q58+QP1290Zd4A@mail.gmail.com>
 <Y/a4/ktpxw/z7/PO@bombadil.infradead.org>
In-Reply-To: <Y/a4/ktpxw/z7/PO@bombadil.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Feb 2023 17:04:32 -0800
Message-ID: <CAJD7tkYHHSaiZwU9Evu-4r5=4FjrmFc-=xMst63io-4AM9N6XA@mail.gmail.com>
Subject: Re: [RFC 2/2] shmem: add support to ignore swap
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
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

On Wed, Feb 22, 2023 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Feb 08, 2023 at 12:33:37PM -0800, Yosry Ahmed wrote:
> > On Wed, Feb 8, 2023 at 9:45 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Feb 08, 2023 at 08:01:01AM -0800, Luis Chamberlain wrote:
> > > > On Tue, Feb 07, 2023 at 04:01:51AM +0000, Matthew Wilcox wrote:
> > > > > On Mon, Feb 06, 2023 at 06:52:59PM -0800, Luis Chamberlain wrote:
> > > > > > @@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> > > > > >   struct shmem_inode_info *info;
> > > > > >   struct address_space *mapping = folio->mapping;
> > > > > >   struct inode *inode = mapping->host;
> > > > > > + struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> > > > > >   swp_entry_t swap;
> > > > > >   pgoff_t index;
> > > > > >
> > > > > >   BUG_ON(!folio_test_locked(folio));
> > > > > >
> > > > > > + if (wbc->for_reclaim && unlikely(sbinfo->noswap))
> > > > > > +         return AOP_WRITEPAGE_ACTIVATE;
> > > > >
> > > > > Not sure this is the best way to handle this.  We'll still incur the
> > > > > oevrhead of tracking shmem pages on the LRU, only to fail to write them
> > > > > out when the VM thinks we should get rid of them.  We'd be better off
> > > > > not putting them on the LRU in the first place.
> > > >
> > > > Ah, makes sense, so in effect then if we do that then on reclaim
> > > > we should be able to even WARN_ON(sbinfo->noswap) assuming we did
> > > > everthing right.
> > > >
> > > > Hrm, we have invalidate_mapping_pages(mapping, 0, -1) but that seems a bit
> > > > too late how about d_mark_dontcache() on shmem_get_inode() instead?
> > >
> > > I was thinking that the two calls to folio_add_lru() in mm/shmem.c
> > > should be conditional on sbinfo->noswap.
> > >
> >
> > Wouldn't this cause the folio to not show up in any lru lists, even
> > the unevictable one, which may be a strange discrepancy?
> >
> > Perhaps we can do something like shmem_lock(), which calls
> > mapping_set_unevictable(), which will make folio_evictable() return
> > true and the LRUs code will take care of the rest?
>
> If shmem_lock() should take care of that is that because writepages()
> should not happen or because we have that info->flags & VM_LOCKED stop
> gap on writepages()? If the earlier then shouldn't we WARN_ON_ONCE()
> if writepages() is called on info->flags & VM_LOCKED?
>
> While I see the value in mapping_set_unevictable() I am not sure I see
> the point in using shmem_lock(). I don't see why we should constrain
> noswap tmpfs option to RLIMIT_MEMLOCK
>
> Please correct me if I'm wrong but the limit seem to be designed for
> files / IPC / unprivileged perf limits. On the contrary, we'd bump the
> count for each new inode. Using shmem_lock() would  also complicate the
> inode allocation on shmem as we'd have to unwind on failure from the
> user_shm_lock(). It would also beg the question of when to capture a
> ucount for an inode, should we just share one for the superblock at
> shmem_fill_super() or do we really need to capture it at every single
> inode creation? In theory we could end up with different limits.
>
> So why not just use mapping_set_unevictable() alone for this use case?

Sorry if I wasn't clear, I did NOT mean that we should use
shmem_lock(), I meant that we do something similar to what
shmem_lock() does and use mapping_set_unevictable() or similar.

I think we just need to make sure that if we use
mapping_set_unevictable() does not imply that shmem_lock() was used
(i.e no code assumes that if the shmem mapping is unevictable then
shmem_lock() was used).

Anyway, I am not very knowledgeable here so take anything I say with a
grain of salt.
Thanks.

>
>   Luis
