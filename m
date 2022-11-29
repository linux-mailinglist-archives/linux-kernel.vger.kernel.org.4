Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D6E63C8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiK2Trg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiK2Tqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:46:47 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6177205
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:43:06 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y83so18837267yby.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rGTIG8x4KsRIPh4QmKAiIuwOVCN06VOhOfE/clNYHVU=;
        b=iCbO4c3ISsWAsryVLUOqcvzYLYwMoYxQScIi5QhG+vvlujDo7VmIfHe0IA52ZQutMK
         amwKaZjJTL6PsYXcJVsqFVkIuQuyfovT0EWhapOAzn55PBiHbsC7HdJwIyN7CT9cHI8x
         VVZ7qVmQsKNXg3E+ebb0Guqg0H9F0i7pEexuw4OPdde3Ed8SN8zyNmPjSnSHOukHyEji
         kacPnsnMaugQ7P40hIuhkUOARS0JEquiN/xd2Hs8T1HKzZZSa7CNXyUSZaMrgWMBJVZL
         w7tgyMF7w6NMxVOxYy7wSc/DUJxU6gOhmqnNLv9/F87H2osfOzzasLTlcfRsHXVbcWTx
         9MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGTIG8x4KsRIPh4QmKAiIuwOVCN06VOhOfE/clNYHVU=;
        b=UHp1yBopCWBssfH2IgVe2iemAGnC1HIkFd6PoeQko7KbR8/RjmUmtfC5QVgzXqrSGf
         1rQE0i8tDnbW7s0Xa78FBU20tfDkYF0G78maDSsBoQEJ09j1Egk6kuza9E2azQXlZTUf
         2HqTgVQslQZ3Qx3Auk4CYTb/SnTQWF/9h7hhZY7einqz71pXVGtJZXXv4iMe+T9Y07nN
         5a3Fy/QlG+QWWom+7BRpUFvVoquzXH6+nYDQmHvpXMACkNvOefRNwVeVZRht8vXwufcF
         ikU5wR+Fg9kTAVQuNYWHg1J7DQssVhIoyDOZ41olCvuiALCU7D1CWXsos54QZv8vLOYc
         ACSw==
X-Gm-Message-State: ANoB5pmPDEGH5dIokEkeQyZa6QakYKd5jyPyK9rLgUYAHbZrA9FiiNOr
        rtbyPseA0j4Ekw6NG/QeMocq7IuTEhG5uj/DRoYPsg==
X-Google-Smtp-Source: AA0mqf4iDf8S7ORhxxAnl4qKRbvnYF7NYF/WG8Q+uwr3FmLDMgQ2VEFjlHXPYDd+yFVJQeFNluEJWbqsm9x72Ne9QT8=
X-Received: by 2002:a25:909:0:b0:6f6:e111:a9ec with SMTP id
 9-20020a250909000000b006f6e111a9ecmr10937713ybj.259.1669750986030; Tue, 29
 Nov 2022 11:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
In-Reply-To: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 29 Nov 2022 11:42:54 -0800
Message-ID: <CALvZod6PCmbA1cNVueuJL=njL+ZMez_rFK74GEmRZpNy_k=AUA@mail.gmail.com>
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 29, 2022 at 11:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Nov 28, 2022 at 11:59:53AM -0500, Johannes Weiner wrote:
> > On Wed, Nov 23, 2022 at 10:03:00PM -0800, Hugh Dickins wrote:
> > The swapcache/pagecache bit was a brainfart. We acquire the folio lock
> > in move_account(), which would lock out concurrent faults. If it's not
> > mapped, I don't see how it could become mapped behind our backs. But
> > we do need to be prepared for it to be unmapped.
>
> Welp, that doesn't protect us from the inverse, where the page is
> mapped elsewhere and the other ptes are going away. So this won't be
> enough, unfortunately.
>
> > > Does that mean that we just have to reinstate the folio_mapped() checks
> > > in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
> > > commit?  Or does it invalidate the whole project to remove
> > > lock_page_memcg() from mm/rmap.c?
>
> Short of further restricting the pages that can be moved, I don't see
> how we can get rid of the cgroup locks in rmap after all. :(
>
> We can try limiting move candidates to present ptes. But maybe it's
> indeed time to deprecate the legacy charge moving altogether, and get
> rid of the entire complication.
>
> Hugh, Shakeel, Michal, what do you think?

I am on-board.
