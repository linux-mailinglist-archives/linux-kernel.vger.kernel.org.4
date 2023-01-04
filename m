Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B9165D756
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbjADPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjADPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:37:23 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED3183AF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:37:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id x22so83449672ejs.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elkCLDa7j/BppptywJb/EVnoK0MGW4NNJ4a9WbezZeg=;
        b=UAFY4Uxmd52ZaZdUOrZTlmpR5F20CKLkxLj7zC/1rubIzTCCH9Qxwg+csOI3ooxlvT
         PNCy5ELz7ogKGwjVFerA9ZrJgJKN/UQ1nVh16nMk3xLL3Xm7oPOwYdNgZzW+yV/yXgJ1
         K4kch3s7bbj1hUojX3uMfMelOkHFh0dJ4+vQI7wi0casW9Rajlh3NV6MbvQeCq9oxUC6
         G6DC52+ZZ2yxP7jNU0qWY6SISEi7LowiQ1ofJPKRoxZREiJkbPEnxceZNoG5Y3jjeQxF
         DfsCzWoUBv8rQRpqCjuack7Vw+lYsC9/am8fULhe9brLssKCnOGhUV9pMFVoVMQEnHjK
         qKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elkCLDa7j/BppptywJb/EVnoK0MGW4NNJ4a9WbezZeg=;
        b=dc2/6qT5KVbfiykAE1yWpUkyE+mx5d3N8c6cRSFbWc10f8YKHFciOPBl5tHiOrveNM
         +gYuO7r0KcIlgsqFw6k+87uXe/cFQBGwFy83KLbroWwjCLjL8dP/bWBJ/AnaRBxFdKkQ
         oXeomeOHfzpqD6B6Mto8J8SwWzoFbvLKI1gS2d6FgcuGLqT3uqf2hgnSJHeUwUfVSAfk
         bnnSnw0slPDRi78QdrI5Ur4XfdnjEs23/e6SDVYMyAtM9AI3VjttjKgY9rx3LAMw4F8u
         0snRiLv+4NKyD91AVPhPZWrdi5v9eUfZbtfE4jTVbMI7jQj6qhPhKO3ty6hNPsYvDQO/
         vqUw==
X-Gm-Message-State: AFqh2kqO/Cn0sqS56VMnX1iU0wjMcklPqsU95TxJsQFt3T2ugtWY2Fym
        dsCG7VYD1d9diL+DYFnGOAg=
X-Google-Smtp-Source: AMrXdXs6IEh5K+UqlDWpobHfXQCOHIihf+zYPknSY+YeBvghOTMtnwa88a3I8v9ptHa0ry7M/Ac9Ow==
X-Received: by 2002:a17:906:99d1:b0:7c1:12ef:bf52 with SMTP id s17-20020a17090699d100b007c112efbf52mr38176240ejn.3.1672846641042;
        Wed, 04 Jan 2023 07:37:21 -0800 (PST)
Received: from andrea (host-79-30-37-87.retail.telecomitalia.it. [79.30.37.87])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906368f00b007a9c3831409sm15371409ejc.137.2023.01.04.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:37:19 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:37:14 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y7WdKog5K/UV4JhZ@andrea>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <YzSAnclenTz7KQyt@rowland.harvard.edu>
 <f763bd5ff835458d8750b61da47fe316@huawei.com>
 <Y7R6SPHGS9U/T6IC@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7R6SPHGS9U/T6IC@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 01:56:08PM -0500, Alan Stern wrote:
> [Added LKML to the CC: list so there will be a permanent record of this 
> part of the discussion, and changed the Subject: to something more 
> descriptive of the topic at hand.]
> 
> On Tue, Jan 03, 2023 at 04:57:56PM +0000, Jonas Oberhauser wrote:
> > Happy new year everyone!
> > 
> > I'd like to circle back to the brief discussion we had about ppo \subseteq po.
> > 
> > Here's some context:
> > 
> > > > > > the preserved program order not always being a 
> > > > > > program order, lack of
> > > > 
> > > > > Where does the LKMM allow a ppo relation not to be in program order?
> > > >
> > > > When one thread releases a lock and another one takes the lock, you 
> > > > can get an mb relation between the two threads
> > > >
> > > > https://github.com/torvalds/linux/blob/master/tools/memory-model/linux
> > > > -kernel.cat#L40
> > > > 
> > > > this then turns into a ppo edge.
> > 
> > > Ah.  I suppose we should have been a little more careful about internal vs. external full barriers.  RCU barriers are also external, but the model didn't try to include them in the definition of mb; we should have done the same with unlock-lock.
> > 
> > To be more explicit, in the current LKMM, mb includes some cases of po;[UL];co;[LKW];po which also relates events between threads, and this trickles up to the ppo:
> > 
> >   let mb = ([M] ; fencerel(Mb) ; [M]) |
> > 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> > 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> > 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > 		fencerel(After-unlock-lock) ; [M])
> >   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> >   let strong-fence = mb | gp
> >   ...
> >   let ppo = to-r | to-w | (... | strong-fence | ...) | (po-unlock-lock-po & int) // expanded for readability
> > 
> > Because of this, not every preserved program order edge is actually a program order edge that is being preserved.
> 
> Indeed, one can argue that neither the fence nor the (po-unlock-lock-po 
> & int) sub-relations should be included in ppo, since they don't reflect 
> dataflow constraints.  They could instead be added separately to the 
> definition of hb, which is the only place that uses ppo.
> 
> > My suggestion for a fix would be to move this part out of mb and strong-fence, and instead introduce a new relation strong-sync that covers synchronization also between threads.
> > 
> >   let mb = ([M] ; fencerel(Mb) ; [M]) |
> > 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> > 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> > 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > - 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > -		fencerel(After-unlock-lock) ; [M])
> >   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> >   let strong-fence = mb | gp
> > +  let strong-sync = strong-fence | ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > +		fencerel(After-unlock-lock) ; [M])
> > ...
> >   let ppo = to-r | to-w | (... | strong-fence | ...) | (po-unlock-lock-po & int)
> > 
> > and then use strong-sync instead of strong-fence everywhere else, e.g.
> > - let pb = prop ; strong-fence ; hb* ; [Marked]
> > + let pb = prop ; strong-sync ; hb* ; [Marked]
> > and similarly where strong-fence is being redefined and used in various later lines.
> > (In general I would prefer renaming also other *-fence relations into *-sync when they include edges between threads).
> > 
> > 
> > Note that no ordering is changed by this move.
> > Firstly, the case [M];po;[UL];po;[LKW]; fencerel(After-unlock-lock) ; [M] which is also eliminated from mb by this change  is still present in ppo through the definition ppo = ... | (po-unlock-lock-po & int).
> > Secondly, for the ordering of [M];po;[UL];co;[LKW]; fencerel(After-unlock-lock) ; [M] we can focus on the case [M];po;[UL];coe;[LKW]; fencerel(After-unlock-lock) ; [M] because the other case (coi) is covered by the previous case.
> > Ordering imposed by this case is also not lost, since every [M];po;[UL];coe;[LKW]; fencerel(After-unlock-lock) ; [M] edge also imposes a
> >     [M];po;[UL];rfe;[LKR]; fencerel(After-unlock-lock) ; [M]
> > edge which is a po-rel ; [Marked] ; rfe ; [Marked] ; acq-po edge and hence hb;hb;hb.
> > Thirdly, no new ordering is imposed by this change since every place we now order by strong-sync was previously ordered by the old strong-fence which is identical to the new strong-sync, and in all other places we changed we just (potentially) removed ordering.
> > 
> > The definition of strong-sync could also be slightly simplified to 
> >   let strong-sync = strong-fence | ([M]; po-unlock-lock-po ; [After-unlock-lock] ; po ; [M])
> > which is kind of pretty because the after-unlock-lock is now after po-unlock-lock-po.
> > 
> > What do you think?
> 
> That all sounds good to me.  However, I wonder if it might be better to 
> use "strong-order" (and similar) for the new relation name instead of 
> "strong-sync".  The idea being that fences are about ordering, not (or 
> not directly) about synchronization.

Sounds good to me too.  I'm trying to remember why we went for the LKW
event to model smp_mb__after_unlock_lock() (as opposed to the LKR event,
as suggested above/in po-unlock-lock-po).  Anyway, I currently see no 
issue with the above (we know that LKW and LKR come paired), and I think
it's good to merge the two notions of "unlock-lock pair" if possible.

  Andrea
