Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276D667C96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjALRe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjALRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:34:28 -0500
Received: from outbound-smtp48.blacknight.com (outbound-smtp48.blacknight.com [46.22.136.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033984F96
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:57:19 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id E0B85FABFF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:42:23 +0000 (GMT)
Received: (qmail 26989 invoked from network); 12 Jan 2023 16:42:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2023 16:42:23 -0000
Date:   Thu, 12 Jan 2023 16:42:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Message-ID: <20230112164222.7cfygytun7gj4u7v@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-3-mgorman@techsingularity.net>
 <Y77VYdboKBUsILhD@dhcp22.suse.cz>
 <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
 <Y7/XLPfpZqtsRRMg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y7/XLPfpZqtsRRMg@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:47:24AM +0100, Michal Hocko wrote:
> On Thu 12-01-23 09:36:23, Mel Gorman wrote:
> [...]
> > I agree with you but given the risk of bisections hitting this series,
> > would you be opposed to delaying the removal by 1 kernel release? That
> > way bisections for failures will hit 6.3 and a single commit or at least
> > just a report against 6.3. That would mitigate the risk of a full revert
> > of the series. I can add a note to the changelog mentioning the expected
> > removal so git blame will also highlight it.
> 
> Sure. I will post the removal on top of your series and put myself into
> the "wait for regression chair".
> 

I'm happy to sit in the same chair and send the patch. If there is an
example of an RT task actually caring about memory reserves, I'd like to
determine if it's a real problem or a badly designed RT application.

-- 
Mel Gorman
SUSE Labs
