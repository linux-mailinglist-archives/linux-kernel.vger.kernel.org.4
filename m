Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F044267BF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjAYWBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:01:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097872AD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:01:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA9B616C2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 22:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E129FC4339B;
        Wed, 25 Jan 2023 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674684106;
        bh=IXFQJl7A4PF5uET/wH1wuo5DdyrH9Lxigzp74ibnL38=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o9ksD5LDWnaJpzDDwpDz7Azt37dg3Z3u0FDp6yFST4zhBllr6hEQlYv6iTe8AGYyD
         NIBGC/z4lO2CwLX6Y+9JEGvaxUB921OV8Vpr2cjdh+8ItHcfwN6Zyzce/ac4wlaO0S
         HhckCHqn+/2/GP7q9FvP5LF9L/T8L2MgggOG1+CONYnp/4ayvkP94vuTNoFwFyth81
         2HuPNhPhi+61UIHgdr4m7nYY6To5GdbUjeAoKRTvdKVEg3fxjavCQ/ctwkOclwdC4V
         9gteS44PrXDEHePQUXCHUdMZhetCf8z9F+QXt5mDWxNNgvBMh8osn3iD3Gq7wzWlyl
         dJuNRVNPX8BUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 818C65C0865; Wed, 25 Jan 2023 14:01:45 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:01:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/2] tools/memory-model: Update some warning labels
Message-ID: <20230125220145.GS2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
 <16ca40c7-ba9d-6741-e7fc-fd553c80a757@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ca40c7-ba9d-6741-e7fc-fd553c80a757@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 09:35:44PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 9:20 PM, Alan Stern wrote:
> > Some of the warning labels used in the LKMM are unfortunately
> > ambiguous.  In particular, the same warning is used for both an
> > unmatched rcu_read_lock() call and for an unmatched rcu_read_unlock()
> > call.  Likewise for the srcu_* equivalents.  Also, the warning about
> > passing a wrong value to srcu_read_unlock() -- i.e., a value different
> > from the one returned by the matching srcu_read_lock() -- talks about
> > bad nesting rather than non-matching values.
> > 
> > Let's update the warning labels to make their meanings more clear.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

Applied for further review and testing.  I am thinking in terms of v6.4,
that is, the merge window after the upcoming one.  Or does someone need
it earlier?

							Thanx, Paul

> > ---
> > 
> >   tools/memory-model/linux-kernel.bell |   10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > Index: usb-devel/tools/memory-model/linux-kernel.bell
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> > +++ usb-devel/tools/memory-model/linux-kernel.bell
> > @@ -53,8 +53,8 @@ let rcu-rscs = let rec
> >   	in matched
> >   (* Validate nesting *)
> > -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> > -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> > +flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
> > +flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
> >   (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> >   let srcu-rscs = let rec
> > @@ -69,14 +69,14 @@ let srcu-rscs = let rec
> >   	in matched
> >   (* Validate nesting *)
> > -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > +flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
> > +flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
> >   (* Check for use of synchronize_srcu() inside an RCU critical section *)
> >   flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> >   (* Validate SRCU dynamic match *)
> > -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > +flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
> >   (* Compute marked and plain memory accesses *)
> >   let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> 
