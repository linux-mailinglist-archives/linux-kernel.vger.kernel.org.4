Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B62263418E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiKVQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKVQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:30:57 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756932BB09
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:30:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 11-20020a63000b000000b004776fe2eebfso3489056pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+tKnyn/Cyv5SBwG1da8cKfhKhoYcRDt75vGeaxs9fk=;
        b=MC7t/RjNxF4M05cdJCqZ+z9kLUErLG05/Djm9rojrB4WW9Xkf692T2wUv8dGxivXXK
         f7lr2XG4p5fgwMoQuxeXhTTF+2JZv/6Cyoc0QvXtBf93MJ2LWULf42migXRaFcNniedh
         FDceLzA9AXfL2F7RaJAEZJdmFSMPtExdpmAKEI94/qNrfcr4yJ5J3ddqsFEyijARrAmS
         vEbQdBSiCB1ojNp1hgLKm0BYtCjRNun9LWEXlVfX2JoqPmT6ZOT33oa46K+keLIt9ZL3
         hJPtQQdNUqc8gGZ5bkn3HkK0RBb5NeI3pCM710eufIFflGILZhd8KgqEL/H0lAFRA0fi
         /Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+tKnyn/Cyv5SBwG1da8cKfhKhoYcRDt75vGeaxs9fk=;
        b=zys5yjD8blrV89p70wdINEB09+yVKYnO4qtPbebGKMD/G8Vbzccb9tjVavZWcxNktF
         leq+TETh4CeMGVhf8RAiE/SaW9HvFkBVzAw2Lu3v7nkB8KHn6lJOOoR3F3IaOknA25My
         NT0FblaADCMDkbwf+pp4MoEBwQlbhVqpjr5CZWjPy+mbKzBM09P4RhVpOqT9ni1ySFoU
         pdPsEiC0njC10fuxHUfBpy68KR0ODfDftdGcaJdJ+nh55haOOIdxKdTlax4q4MbKlwza
         fjQX95VvDwlfa9/rejTaXkJ74rMKasS93MW2NOncNvU4uTd/Nh2Nn8xRpWBBDa/apuJN
         GdYA==
X-Gm-Message-State: ANoB5pmAjn4MXS68HP/xgPHY0YM9o3vuYAj9M1zXYAx5UN3cGibLvroo
        jZKlxO1nGtvkrjjuGHFH+IOsucEz+IVp7A==
X-Google-Smtp-Source: AA0mqf6psx92ZT/st1c7JFGzjLbYxXaAUphXGERJq21OYZf+61cRy9bY1cYqYRj1EfZdazcQiZXiMalJgigTvA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:df8c:b0:20a:fee1:8f69 with SMTP
 id p12-20020a17090adf8c00b0020afee18f69mr2340761pjv.0.1669134655640; Tue, 22
 Nov 2022 08:30:55 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:30:53 +0000
In-Reply-To: <Y3xya5802BhoFin0@cmpxchg.org>
Mime-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <20221121165938.oid3pemsfkaeq3ws@google.com>
 <Y3vI58VtjiAkorUX@cmpxchg.org> <Y3xk1hX5QrCZMT4q@casper.infradead.org> <Y3xya5802BhoFin0@cmpxchg.org>
Message-ID: <20221122163053.gngosdbd3stksk6c@google.com>
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 01:55:39AM -0500, Johannes Weiner wrote:
> On Tue, Nov 22, 2022 at 05:57:42AM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 21, 2022 at 01:52:23PM -0500, Johannes Weiner wrote:
> > > That leaves clearing writeback. This can't hold the page lock due to
> > > the atomic context, so currently we need to take lock_page_memcg() as
> > > the lock of last resort.
> > > 
> > > I wonder if we can have cgroup take the xalock instead: writeback
> > > ending on file pages always acquires the xarray lock. Swap writeback
> > > currently doesn't, but we could make it so (swap_address_space).
> > > 
> > > The only thing that gives me pause is the !mapping check in
> > > __folio_end_writeback. File and swapcache pages usually have mappings,
> > > and truncation waits for writeback to finish before axing
> > > page->mapping. So AFAICS this can only happen if we call end_writeback
> > > on something that isn't under writeback - in which case the test_clear
> > > will fail and we don't update the stats anyway. But I want to be sure.
> > > 
> > > Does anybody know from the top of their heads if a page under
> > > writeback could be without a mapping in some weird cornercase?
> > 
> > I can't think of such a corner case.  We should always wait for
> > writeback to finish before removing the page from the page cache;
> > the writeback bit used to be (and kind of still is) an implicit
> > reference to the page, which means that we can't remove the page
> > cache's reference to the page without waiting for writeback.
> 
> Great, thanks!
> 
> > > If we could ensure that the NR_WRITEBACK decs are always protected by
> > > the xalock, we could grab it from mem_cgroup_move_account(), and then
> > > kill lock_page_memcg() altogether.
> > 
> > I'm not thrilled by this idea, but I'm not going to veto it.
> 
> Ok, I'm also happy to drop this one.
> 
> Certainly, the rmap one is the lowest-hanging fruit. I have the patch
> rebased against Hugh's series in mm-unstable; I'll wait for that to
> settle down, and then send an updated version to Andrew.

I am planning to initiate the deprecation of the move charge
functionality of v1. So I would say let's go with low hanging fruit for
now and let slow process of deprecation remove the remaining cases.
