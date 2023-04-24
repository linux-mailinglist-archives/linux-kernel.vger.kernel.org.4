Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000F16ED483
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjDXSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjDXSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07DE8A7F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F9AE61353
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7831C433EF;
        Mon, 24 Apr 2023 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682361303;
        bh=elWSjrPnEy4/ZkSa87Ap3uNz+gGryyRP1CEeaZxvihU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n7prQDYHw4UEl3PVKv2trX1MkkHdTJWItJZAfD1Dpvrpa4y6GNMJKSSOXuLt2RsQs
         ZwJ5wlJOlkQV1NSHQ8nqMCSZA6aHd490VmIttPS4yBv2TCy1mxkeLuYWZzTZzQlH0P
         FvTn1JiFgfHK73mgRW6qmUl8qkSzxGwN+y4xeeeX4aqgpqJYQLVyRgmXziD7Wupu81
         8T5+l7VRlb3fK54uthgds9mMpfBM6JhLf+QtHq+jUcSnklskUF/PLqjhFbpzClzjLV
         L9sDowUufveYWwwbomKHUR8LG4D6afANEQwXBx7X4pnFIiN1eXVtoUUVaZInXbGzEn
         zf7ztc/zmXFcA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4E25915404E7; Mon, 24 Apr 2023 11:35:03 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:35:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/slab: add a missing semicolon on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <4b3342d5-8407-49af-b4c8-b54d350be7a2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230415033159.4249-1-sj@kernel.org>
 <20230415033159.4249-2-sj@kernel.org>
 <21cd0c00-4738-49f7-899f-ec3792520bfb@paulmck-laptop>
 <63f33512-f426-d808-5680-d5dfd8e0c9d2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f33512-f426-d808-5680-d5dfd8e0c9d2@suse.cz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:27:45PM +0200, Vlastimil Babka wrote:
> On 4/24/23 19:43, Paul E. McKenney wrote:
> > On Sat, Apr 15, 2023 at 03:31:58AM +0000, SeongJae Park wrote:
> >> An example code snippet for SLAB_TYPESAFE_BY_RCU is missing a semicolon.
> >> Add it.
> >>
> >> Signed-off-by: SeongJae Park <sj@kernel.org>
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Or please let me know if you would like me to take it.  (Probably better
> > going up through the usual slab route, though.)
> 
> Yeah will take it via slab after merge window, but was hoping you'd ack
> that (mainly 2/2) as indeed the correct example first.

You got it!  ;-)

							Thanx, Paul

> Thanks, Vlastimil
> 
> > 							Thanx, Paul
> > 
> >> ---
> >>  include/linux/slab.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> index f8b1d63c63a3..b18e56c6f06c 100644
> >> --- a/include/linux/slab.h
> >> +++ b/include/linux/slab.h
> >> @@ -53,7 +53,7 @@
> >>   * stays valid, the trick to using this is relying on an independent
> >>   * object validation pass. Something like:
> >>   *
> >> - *  rcu_read_lock()
> >> + *  rcu_read_lock();
> >>   * again:
> >>   *  obj = lockless_lookup(key);
> >>   *  if (obj) {
> >> -- 
> >> 2.25.1
> >>
