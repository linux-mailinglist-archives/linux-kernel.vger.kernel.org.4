Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6455ECEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiI0U4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiI0U4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:56:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687E10D643
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:56:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so2235315pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JhFaXT/LTm6dJIMFtmVs4nNn7X53gVvoLeA/cKj/Kok=;
        b=WbxQz3//FCAeiZv7aNflDd8o/IexLIOZYI6UqFZ46vdzRXqmqckoy5VF84QOTdmG6W
         Amaf6YGuhyuPAUHuzFXEAC1iCjeP9Gy7Hf6ackzi88O/pYboc6aZvxP+/0HYZPnSrGb2
         BiAXB8EFN9XDhDYpOPiwwqBdZO8gyja5ReQFjim8JO2Dz/YZK2jkxK0qfQ9M3BDm+dFp
         cBUzmBuNJxE91ZcD7w5r1d3+11RpJx3m/YT8R9yTahMG9yP1kvDxVaqN8+Je02Ren2Qw
         xSqh1qggygHKpMUBVOAN29FtO0nSTnyc2scJkPNIBaktSPDMNPW/5HSh+zf3NIVMw3yd
         Cx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JhFaXT/LTm6dJIMFtmVs4nNn7X53gVvoLeA/cKj/Kok=;
        b=vI6AwWI/JGiqZMkMNO6Fub/1b+Vn9X/G2ulRhNMhWkmKbR26BkovUhkgIukK2bmsY2
         rDFimdkFhHi2LDYyaRwqw49I5IvVM99aDQ07i0CyqOhyqdeNd3Ob1i7OsjbWPPdHYhiH
         J3qw3jEFW5oFe9fmJ1nfLIMdzsThlaoj6KYtve6l/XymrHBWfVHixfrz28MvoghF2T+m
         j+bvHNE0YFvgDerP8xA7b8eIGjy4XkHzkksIup9mlCtsj5gAsbefkavMTAp2Va/OvKck
         bP2EsNdSPYZTSijjzzvfSn0l6MPtF2aXpEK2puGFdorqsvZkpguIdo2qAat+sAoXNo/j
         iyXQ==
X-Gm-Message-State: ACrzQf14bozvIvj1f0wn1jC5DKPiNgIe0uWRfbc1NNmDJQi64Bj5UfUU
        bo/iVrbUAvJzVgIMhgbpHnNUQesAkQMc7x+2Le4=
X-Google-Smtp-Source: AMsMyM7L7/T/vdACPxgn3SYNaVAu/FkJBFcghXQ0Ys4A8wPHzFUnym2G0TWCyawtGwaTnon5uLhyK39Mo4r8Efnr4U8=
X-Received: by 2002:a17:903:41c8:b0:177:e7e1:4f4f with SMTP id
 u8-20020a17090341c800b00177e7e14f4fmr28230270ple.61.1664312177758; Tue, 27
 Sep 2022 13:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220921060616.73086-1-ying.huang@intel.com> <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal> <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal> <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Sep 2022 13:56:05 -0700
Message-ID: <CAHbLzkqw3G5oN8YsPYPzRjYa3WMfSoaOL9Pp54GhOKsGGcXWeg@mail.gmail.com>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 6:52 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Alistair Popple <apopple@nvidia.com> writes:
>
> > Yang Shi <shy828301@gmail.com> writes:
> >
> >> On Mon, Sep 26, 2022 at 2:37 AM Alistair Popple <apopple@nvidia.com> wrote:
> >>>
> >>>
> >>> Huang Ying <ying.huang@intel.com> writes:
> >>>
> >>> > This is a preparation patch to batch the page unmapping and moving
> >>> > for the normal pages and THP.
> >>> >
> >>> > In this patch, unmap_and_move() is split to migrate_page_unmap() and
> >>> > migrate_page_move().  So, we can batch _unmap() and _move() in
> >>> > different loops later.  To pass some information between unmap and
> >>> > move, the original unused newpage->mapping and newpage->private are
> >>> > used.
> >>>
> >>> This looks like it could cause a deadlock between two threads migrating
> >>> the same pages if force == true && mode != MIGRATE_ASYNC as
> >>> migrate_page_unmap() will call lock_page() while holding the lock on
> >>> other pages in the list. Therefore the two threads could deadlock if the
> >>> pages are in a different order.
> >>
> >> It seems unlikely to me since the page has to be isolated from lru
> >> before migration. The isolating from lru is atomic, so the two threads
> >> unlikely see the same pages on both lists.
> >
> > Oh thanks! That is a good point and I agree since lru isolation is
> > atomic the two threads won't see the same pages. migrate_vma_setup()
> > does LRU isolation after locking the page which is why the potential
> > exists there. We could potentially switch that around but given
> > ZONE_DEVICE pages aren't on an lru it wouldn't help much.
> >
> >> But there might be other cases which may incur deadlock, for example,
> >> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
> >> then write them back in a batch. The same pages may be on the
> >> migration list and they are also dirty and seen by writeback. I'm not
> >> sure whether I miss something that could prevent such a deadlock from
> >> happening.
> >
> > I'm not overly familiar with that area but I would assume any filesystem
> > code doing this would already have to deal with deadlock potential.
>
> Thank you very much for pointing this out.  I think the deadlock is a
> real issue.  Anyway, we shouldn't forbid other places in kernel to lock
> 2 pages at the same time.
>
> The simplest solution is to batch page migration only if mode ==
> MIGRATE_ASYNC.  Then we may consider to fall back to non-batch mode if
> mode != MIGRATE_ASYNC and trylock page fails.

Seems like so...

>
> Best Regards,
> Huang, Ying
>
> [snip]
