Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA67666E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbjALJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjALJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:40:53 -0500
Received: from outbound-smtp36.blacknight.com (outbound-smtp36.blacknight.com [46.22.139.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F512A1A3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:38:16 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id D9FE71F58
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:38:14 +0000 (GMT)
Received: (qmail 25808 invoked from network); 12 Jan 2023 09:38:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2023 09:38:14 -0000
Date:   Thu, 12 Jan 2023 09:38:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] mm/page_alloc: Explicitly record high-order atomic
 allocations in alloc_flags
Message-ID: <20230112093812.x7kgdgvyd2fzrwex@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-4-mgorman@techsingularity.net>
 <Y77XYW/81sfSXCj9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y77XYW/81sfSXCj9@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:36:01PM +0100, Michal Hocko wrote:
> On Mon 09-01-23 15:16:27, Mel Gorman wrote:
> > A high-order ALLOC_HARDER allocation is assumed to be atomic. While that
> > is accurate, it changes later in the series. In preparation, explicitly
> > record high-order atomic allocations in gfp_to_alloc_flags(). There is
> > a slight functional change in that OOM handling avoids using high-order
> > reserve until it has to.
> 
> I do not follow the oom handling part. IIRC we are dropping highatomic
> reserves before triggering oom. Something might have changed down the
> path but I can still see unreserve_highatomic_pageblock in
> should_reclaim_retry.
> 

That comment is now stale and should be removed because I fixed up the
OOM oddities. At this point, a series resubmission is needed because a
few changelogs have to be updated.

-- 
Mel Gorman
SUSE Labs
