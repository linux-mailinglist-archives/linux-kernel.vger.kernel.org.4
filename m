Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6B686CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjBARVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjBARVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:21:46 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F8A66ED4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:21:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w20so4151075pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 09:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QEUPSJlkUP9dP+KzLmG+nyeDxD6BwlDPsnj8Snmv2ws=;
        b=Ex03OYIcKcLRt/ukAP8p9G4Pv5YM9g6dThlCpBKf09d0qZNK6RXJXyypR0RTSMhPH7
         WxJk/TGr7cHUKLiGJCLM3Q/mgiZbx7tJ28cPI7/G+qZdTwZW5MTwEZ7MIl6GTbDuL8k1
         GYQOwnhwbVHTe04xNjwUOEVDM/quba8VfyqUFDTuHeG2nnp0gS1Q42BdMVQ6eI1pN2sA
         Nto596Cd3lqTjCdoq4BoYTKJuLV8lYGBDWeM/3cN4B5mQTBlWTWJuFFt4GL4YZGTxf6Q
         jx2juFHTxdHPAYyVL4/bKf/G1263qkIeeC4ZUXsfn2yrXL3MwRLWX/aOiTlvNj3aaEn3
         IylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEUPSJlkUP9dP+KzLmG+nyeDxD6BwlDPsnj8Snmv2ws=;
        b=18QVpniNOzeoc4W+yd+V4jfJ4e/d2CgNRKZ5k4dLLwaHKeBXKN0aa/mrm9NmhXtDwS
         9xlI9Dxq+c/FpqWGUyyHcVPrH6mOEiyc6OtSSKpxxQh3vaZ+bObfCz6QYRj/Bvum3uF2
         94pUfkBrNIgkvk83bHHJymYlStwsegQ/VcYjf0FHhjEU+LAhWAUyPLgz77iu2Gk8+Zac
         kcwYMOP0kRxTSC10f+7hD7CgwqKpfl6KJ7gEx3SFN0f7RWoxDEK9ITFqXAZTd9zk9xRr
         zP/DfXNtDlItJXGz8R5gl4e8AqHcjJdMthjCZy/TV+VRPw+MISFTAXpHcP5okJJHJbPq
         aL5w==
X-Gm-Message-State: AO0yUKUCo7hL7EoWB4bFaP2UvMHu28o8ViZqperIASjB189+5dsAO0mv
        naXFREEqi2WHeXQq/+ZfWZXgPqnL83/9WpTKCEI=
X-Google-Smtp-Source: AK7set9TYOV9y/Db1jjJk3sL/H6qBCOPgxHDegUIq93V7cq6hcS822WZObGfwWSwZTk9VVvc8YK/MCEzKqrCqrX44jM=
X-Received: by 2002:a05:6a00:1589:b0:592:7c9a:1236 with SMTP id
 u9-20020a056a00158900b005927c9a1236mr670346pfk.26.1675272099190; Wed, 01 Feb
 2023 09:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
 <20230129134815.21083b65ef3ae4c3e7fae8eb@linux-foundation.org>
 <568c10e8-c225-b3c4-483a-5bb3329de4c5@huawei.com> <Y9eEbTXNm0x0IZem@dhcp22.suse.cz>
 <13e4e6ee-414e-7e36-5ac1-fa0fa555ba41@huawei.com> <CAHbLzkp=NFHHa88jaTqVBeUsdPbHrRFBitcnO0HJiZ-1T+Arhg@mail.gmail.com>
 <Y9odzlOwzCeErKKH@dhcp22.suse.cz>
In-Reply-To: <Y9odzlOwzCeErKKH@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 1 Feb 2023 09:21:27 -0800
Message-ID: <CAHbLzkqeU0eufPEw-dHJ6vGPWncHffa6NuxeihWOjWknDryD4g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ma Wupeng <mawupeng1@huawei.com>
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

On Wed, Feb 1, 2023 at 12:07 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 30-01-23 11:30:47, Yang Shi wrote:
> > On Mon, Jan 30, 2023 at 4:20 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > >
> > >
> > >
> > > On 2023/1/30 16:48, Michal Hocko wrote:
> > > > On Mon 30-01-23 09:16:13, Kefeng Wang wrote:
> > > >>
> > > >>
> > > >> On 2023/1/30 5:48, Andrew Morton wrote:
> > > >>> On Sun, 29 Jan 2023 10:44:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > >>>
> > > >>>> As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),
> > > >>>
> > > >>> Merged in 2017.
> > > >>>
> > > >>>> hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
> > > >>>> could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
> > > >>>> occurs a NULL pointer dereference, let's do not record the foreign
> > > >>>> writebacks for folio memcg is null in mem_cgroup_track_foreign() to
> > > >>>> fix it.
> > > >>>>
> > > >>>> Reported-by: Ma Wupeng <mawupeng1@huawei.com>
> > > >>>> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> > > >>>
> > > >>> Merged in 2019.
> > > >>>
> > > ...
> > > >
> > > > Just to make sure I understand. The page has been hwpoisoned, uncharged
> > > > but stayed in the page cache so a next page fault on the address has blowned
> > > > up?
> > > >
> > > > Say we address the NULL memcg case. What is the resulting behavior?
> > > > Doesn't userspace access a poisoned page and get a silend memory
> > > > corruption?
> > >
> > > + Yang Shi
> > >
> > > Check previous link[1], seems that it is a known issue, and there is a
> > > TODO list for storage backed filesystems from Yang.
> >
> > For tmpfs and hugetlbfs, the page cache still stay in page cache, the
> > later page fault will handle the case gracefully. Other real storage
> > backed filesystem will have page cache truncated.
> >
> > The page cache will be uncharged before truncate. If the truncate
> > fails, we may end up in this case.
>
> This would be a good addendum to the changelog. What would be a typical
> failure in the truncation path?

For memory failure path, there may be a couple of cases, for example,
page is not for a regular file (maybe directory), fail to release
buffers, etc.

>
> > >
> > >
> > > [1]
> > > https://lore.kernel.org/all/20211020210755.23964-6-shy828301@gmail.com/T/#m1d40559ca2dcf94396df5369214288f69dec379b
>
> --
> Michal Hocko
> SUSE Labs
