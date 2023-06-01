Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7871966C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjFAJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjFAJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:10:08 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C4119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:10:06 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id DE0E41C3795
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:10:04 +0100 (IST)
Received: (qmail 22423 invoked from network); 1 Jun 2023 09:10:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Jun 2023 09:10:04 -0000
Date:   Thu, 1 Jun 2023 10:10:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <20230601091002.zl3udcqxmb3tjtri@techsingularity.net>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer>
 <20221219100734.jag6zejp4tug77yq@techsingularity.net>
 <CAA5enKbsmy99-GCNuVcDRbjESZaLuE4=s8+6PzWP8J-wmOZwEg@mail.gmail.com>
 <CAHbLzkoSC7Q+xAMaSoNihn2eww-+5RZADxe5h7_FidGHELE3BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkoSC7Q+xAMaSoNihn2eww-+5RZADxe5h7_FidGHELE3BQ@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 02:29:01PM -0700, Yang Shi wrote:
> On Wed, May 31, 2023 at 8:24???AM Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> >
> > On Mon, 19 Dec 2022 at 10:07, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> > > I reckon we should give it another few months until May. There has been
> > > one user recently that tried to use list but it turned out arrays were
> > > more appropriate.
> > >
> >
> > It being May 31st, it feels appropriate to chase this up :)
> >
> > David's series at [0] did initially use this function, before
> > switching to the _array() variant. Other than that it seems that it
> > remains unused.
> 
> Thanks for following this up. My patchset (use bulk allocator for
> dm-crypt) also switched from list API to a new callback API suggested
> by Mel. But I haven't heard anything back from Mel about it yet. I
> forgot to follow up due to too many distractions.
> 

It needs a follow-up. My various inboxes that I get cc'd on currently exceed
1000 mails due to being offline a lot during the last few months so there
could be a lot hiding in there. Conceptually at least I don't recall having
any problem with the callback patches as long as the dm-crypt people are
happy. I vaguely recall a review disappeared off into the weeds talking
about maybe using physically contiguous pages (missing the point of using
the bulk allocator at all and ignoring fragmentation concerns affecting
allocation success rates) but I'm not certain.

-- 
Mel Gorman
SUSE Labs
