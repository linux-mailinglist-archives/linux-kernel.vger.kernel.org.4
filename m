Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD326509C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLSKHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:07:42 -0500
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C8C26FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:07:41 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id 16A23CCD39
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:07:39 +0000 (GMT)
Received: (qmail 2594 invoked from network); 19 Dec 2022 10:07:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Dec 2022 10:07:38 -0000
Date:   Mon, 19 Dec 2022 10:07:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <20221219100734.jag6zejp4tug77yq@techsingularity.net>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y51/Mt70d++6Zzzq@lucifer>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> + Mel
> 
> On Sat, Dec 17, 2022 at 04:56:03AM +0000, Matthew Wilcox wrote:
> > I think we're waiting to see if any users show up.  It's only been 18
> > months or so, so perhaps wait a little longer?
> 
> Apologies, I should have researched the background of this further. I see it was
> added speculatively in 0f87d9d30f.
> 
> > Also, if we do get rid of this, then __alloc_pages_bulk() can lose
> > the "list" argument.
> 
> Ack. Will do a v2 if Mel feels it's appropriate to remove at this stage,
> otherwise we can drop the idea and wait for users to emerge.

I reckon we should give it another few months until May. There has been
one user recently that tried to use list but it turned out arrays were
more appropriate.

-- 
Mel Gorman
SUSE Labs
