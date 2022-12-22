Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F17654138
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiLVMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiLVMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:44:18 -0500
Received: from outbound-smtp15.blacknight.com (outbound-smtp15.blacknight.com [46.22.139.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77423E9F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:44:16 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id BD89C1C36CD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:44:14 +0000 (GMT)
Received: (qmail 19094 invoked from network); 22 Dec 2022 12:44:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Dec 2022 12:44:14 -0000
Date:   Thu, 22 Dec 2022 12:44:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <20221222124412.rpnl2vojnx7izoow@techsingularity.net>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer>
 <20221219100734.jag6zejp4tug77yq@techsingularity.net>
 <CAHbLzkp58y=d70j7eE9KkhK0HOorjD4=vxpuTk-9jLwGH5yarw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkp58y=d70j7eE9KkhK0HOorjD4=vxpuTk-9jLwGH5yarw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:56:19AM -0800, Yang Shi wrote:
> On Mon, Dec 19, 2022 at 2:07 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> > > + Mel
> > >
> > > On Sat, Dec 17, 2022 at 04:56:03AM +0000, Matthew Wilcox wrote:
> > > > I think we're waiting to see if any users show up.  It's only been 18
> > > > months or so, so perhaps wait a little longer?
> > >
> > > Apologies, I should have researched the background of this further. I see it was
> > > added speculatively in 0f87d9d30f.
> > >
> > > > Also, if we do get rid of this, then __alloc_pages_bulk() can lose
> > > > the "list" argument.
> > >
> > > Ack. Will do a v2 if Mel feels it's appropriate to remove at this stage,
> > > otherwise we can drop the idea and wait for users to emerge.
> >
> > I reckon we should give it another few months until May. There has been
> > one user recently that tried to use list but it turned out arrays were
> > more appropriate.
> 
> Another recent try was the patches for dm-crypt. However Mel suggested
> adding a callback interface instead of using list since list is not
> necessary for that usecase. Or are we talking about the same one?
> 

That was the one I was thinking of but forgot the specifics so the array
comment was wrong. I only remembered that there was an attempted list user
but it wasn't the best solution.

> I didn't get time to implement Mel's suggestion yet due to my
> employment change. Hopefully I can find some time after the new year.
> 

No rush.

-- 
Mel Gorman
SUSE Labs
