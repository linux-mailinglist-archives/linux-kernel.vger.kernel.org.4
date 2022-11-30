Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ABC63DAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiK3Qml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiK3Qmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:42:39 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590A6BFD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:42:36 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3b48b139b46so176718917b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjDPR5yR6DIywWszOgQ0UDhPZ4vEbh5Pko8PrUKf3pI=;
        b=K86j6VMRXYIQSYFV+KA78qEDNE9v5WU4bWnu4FRw2pC332BzaqIyvlaShvQZTviLZD
         COiqs6oMwW2dklkvQs/yh280WV+N5Q24S0VgBHZCrlfJLl/ncK8ChCEoWqv/eJYepItk
         w3TFu1AzI/YXHE0e0rGAG38/r1K85Vt9QOPLE9sGdYGtas73TUgIfS1+ZrPxAmTPeBDV
         avwm8hAtetBSQ0iCfIXlWtRuBAPQGxskP22jpMWnlLE6CT/Oc8cXnN+ArYwiZhRjHECL
         lvTKpFg9DZpUKswVxXm+tma4r66CsXSqKTzYnah7h3nBdLDzGmYTnDQ1ARpHDJe6op4r
         O+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjDPR5yR6DIywWszOgQ0UDhPZ4vEbh5Pko8PrUKf3pI=;
        b=nvQt0JHm/uzaetxADLcZ+nlvadi26aOWNuJ++k5EiODmdp4iecAxNuvOKntL/wQVP3
         OG+05Opxq9kCk3rGs5IQEneqKnonW9su+fzJCHsIjZhRYLASSD0yDlvoRojjvxnsCRa7
         UfONhuivsKftWSi5Mbgu6vPWWpRYXyBplY4K0qzsBvHAeHjpG5sQ3oRpT1zF/y1kETHx
         3wcPyPS4oVVh8yo+Ur+2Cn5g28t8p6/71HQ9mwpF8Q6AzUmyMDyDAwQdWh0YbuX9h+tx
         MLGyiYw7X6t1barfuXZa2ZI28ZSuRoSZ+AH0g0mnLN6QTsIY80Nl5DLYKEsaEnSjcqsF
         qkgQ==
X-Gm-Message-State: ANoB5pljUogXEeqe3yGu7fXLd2veS1JF8M5aU6rJSgEGLUiUh3U5somh
        v6kn0v+vb/0pY7/NYLzYSkrKR4JllMMgesW7UG7sEA==
X-Google-Smtp-Source: AA0mqf4XJlQocRvwHgq5x6G+DiS5HWePV/wtvsYDvhb/t958IEY8PeYMJEWY84wIyKWoBw2EWDiCO1pk1A/sEmqKBdo=
X-Received: by 2002:a0d:d80c:0:b0:3ca:b34:9ce1 with SMTP id
 a12-20020a0dd80c000000b003ca0b349ce1mr13279423ywe.466.1669826555061; Wed, 30
 Nov 2022 08:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org> <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com>
In-Reply-To: <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Nov 2022 08:42:24 -0800
Message-ID: <CALvZod7_FjO-CjzHUpQTsCTm4-68a1eKi_qY=4XdF+g7yMLd4Q@mail.gmail.com>
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
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

On Tue, Nov 29, 2022 at 11:33 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 29 Nov 2022, Johannes Weiner wrote:
> > On Mon, Nov 28, 2022 at 11:59:53AM -0500, Johannes Weiner wrote:
> > > On Wed, Nov 23, 2022 at 10:03:00PM -0800, Hugh Dickins wrote:
> > > The swapcache/pagecache bit was a brainfart. We acquire the folio lock
> > > in move_account(), which would lock out concurrent faults. If it's not
> > > mapped, I don't see how it could become mapped behind our backs. But
> > > we do need to be prepared for it to be unmapped.
> >
> > Welp, that doesn't protect us from the inverse, where the page is
> > mapped elsewhere and the other ptes are going away. So this won't be
> > enough, unfortunately.
> >
> > > > Does that mean that we just have to reinstate the folio_mapped() checks
> > > > in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
> > > > commit?  Or does it invalidate the whole project to remove
> > > > lock_page_memcg() from mm/rmap.c?
> >
> > Short of further restricting the pages that can be moved, I don't see
> > how we can get rid of the cgroup locks in rmap after all. :(
> >
> > We can try limiting move candidates to present ptes. But maybe it's
> > indeed time to deprecate the legacy charge moving altogether, and get
> > rid of the entire complication.
> >
> > Hugh, Shakeel, Michal, what do you think?
>
> I'm certainly not against deprecating it - it's a largish body of odd
> code, which poses signficant problems, yet is very seldom used; but I
> feel that we'd all like to see it gone from rmap quicker that it can
> be fully deprecated out of existence.
>
> I do wonder if any user would notice, if we quietly removed its
> operation on non-present ptes; certainly there *might* be users
> relying on that behaviour, but I doubt that many would.
>
> Alternatively (although I think Linus's objection to it in rmap is on
> both aesthetic and performance grounds, and retaining any trace of it
> in rmap.c still fails the aesthetic), can there be some static-keying
> done, to eliminate (un)lock_page_memcg() overhead for all but those few
> who actually indulge in moving memcg charge at immigrate?  (But I think
> you would have already done that if it were possible.)
>

My preference would be going with the removal of non-present ptes over
static-key in [un]lock_page_memcg().

How about the following steps:

1. Add warning in memory.move_charge_at_immigrate now (6.1/6.2) that
this is going away and also backport it to the stable kernels.

2. For 6.2 (or 6.3), remove the non-present pte migration with some
additional text in the warning and do the rmap cleanup.

3. After 3 or 4 releases (and hopefully finding no real users), we
deprecate this completely.

Step 3 can be delayed if there are some users depending on it. However
we need to be firm that this is going away irrespective.

Shakeel
