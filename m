Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3FB672A82
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjARVab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjARVa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:30:27 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202F18ABC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:30:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vm8so659050ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tnJen0JlVnpxANdVlso3lEPtkgjCthVBNQkdDsiq0s=;
        b=UZ3loKrisBOI0oZH2cVvwYh3dZgpesVtDKr/3i7EePdrp0snFtq+hjtmUoeN4Ywoel
         3csgLlw5JK7H+exEFh+Zx6hC4/U+Q49l/8AENG3cnbXOutmDQJmuamRrDDnwkjI0dR2d
         SfMUAs3FEPeo7RTqUQWR6Z4MRVfMWIbIWOS48j8Bna7soCtxfrBz66QFRwAXmy4lzwlq
         lp2MeU574SnFZV7lsfGtO5ZSLeYNXhc3tL4nkKKQciDwgLsNMTGhb/E3GMjpbNE/4DfC
         xbcXXD77PjLkjR+OG4XDZ4ltdBtcqZaLjDwCkXmjLFzHSlh6gGrdmZUChjsZoa13dlc1
         8ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tnJen0JlVnpxANdVlso3lEPtkgjCthVBNQkdDsiq0s=;
        b=rimg7z4A2m2iWuxfg3D0bCcniIERdAHCVidVamZwTurYT/TbYVw/kpphTUn9/iBAk3
         KiJ77RbSatVfKVFaKk0LurNdXm33JdW7+cvwQh/wf1dfZwtDJfTXI4sed3AF2diedpIG
         HT+IPvT4996rOFFOfKRi4m4fSmFc1Z/f6SWkeSvm5t0Qe99AVAN8NUxaNrjBmiWbe+Gi
         ef7L9NxVZQkbxSCf6l9b1zQBflNs2XmsDq8eJ8PWMchgu0yNx+elGYrOL03Vd0sd4lzd
         tXLR+IXANGV5YyJRNumOHQ6Rg8gPKTscGGhVjUqs42dDAn3Hp9ERtV57DejbEXa9jVvv
         LTew==
X-Gm-Message-State: AFqh2kqAIDEM/liPhD10sbo+gFQe280QRrGmv8gNiIalYWL/D0HStbgf
        zeCTo+iXtdXzTy8gGO0u2lg=
X-Google-Smtp-Source: AMrXdXu7VUgBZ4yZa/zcOFsfGWyxAjUiwjXI4jpKXU65LUduQcb7Ik9nWjObrl8U4hztGntKf4UA6Q==
X-Received: by 2002:a17:907:2a8c:b0:870:8e22:1433 with SMTP id fl12-20020a1709072a8c00b008708e221433mr4015668ejc.16.1674077422509;
        Wed, 18 Jan 2023 13:30:22 -0800 (PST)
Received: from andrea (host-95-251-43-234.retail.telecomitalia.it. [95.251.43.234])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b00862497eafb2sm9177503ejj.103.2023.01.18.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:30:21 -0800 (PST)
Date:   Wed, 18 Jan 2023 22:30:16 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y8hk6JrUXei6ZInI@andrea>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
> As stated in the documentation and implied by its name, the ppo
> (preserved program order) relation is intended to link po-earlier
> to po-later instructions under certain conditions.  However, a
> corner case currently allows instructions to be linked by ppo that
> are not executed by the same thread, i.e., instructions are being
> linked that have no po relation.
> 
> This happens due to the mb/strong-fence relations, which (as one
> case) provide order when locks are passed between threads followed
> by an smp_mb__after_unlock_lock() fence.  This is illustrated in
> the following litmus test (as can be seen when using herd7 with
> `doshow ppo`):
> 
> P0(int *x, int *y)

spinlock_t


> {
>     spin_lock(x);
>     spin_unlock(x);
> }
> 
> P1(int *x, int *y)
> {
>     spin_lock(x);
>     smp_mb__after_unlock_lock();
>     *y = 1;
> }
> 
> The ppo relation will link P0's spin_lock(x) and P1's *y=1,
> because P0 passes a lock to P1 which then uses this fence.
> 
> The patch makes ppo a subrelation of po by eliminating this
> possibility from mb and strong-fence, and instead introduces the
> notion of strong ordering operations, which are allowed to link
> events of distinct threads.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---


> +	Whenever any CPU C' executes an unlock operation U such that
> +	CPU C executes a lock operation L followed by a po-later
> +	smp_mb__after_unlock_lock() fence, and L is either a later lock
> +	operation on the lock released by U or is po-after U, then any
> +	store that propagates to C' before U must propagate to all other
> +	CPUs before any instructions po-after the fence are executed on C.

The barrier is never mentioned in this document.  This is a relatively
oddball/rare barrier.  Also, IMO, this description doesn't add much to
the notions of execution and propagation being introduced.  I'd rather
move it (or parts of it) to ODDS AND ENDS where smp_mb__after_spinlock()
and other smp_mb__*() are currently briefly described.


> +While smp_wmb() and release fences only force certain earlier stores
> +to propagate to another CPU C' before certain later stores propagate
> +to the same CPU C',

If "earlier" means po-earlier, this statement is wrong, cf. the comment
about A-cumulativity.  IAC, it should be clarified.


> strong fences and smp_mb__after_unlock_lock()
> +force those stores to propagate to all other CPUs before any later
> +instruction is executed.  We collectively refer to the latter
> +operations as strong ordering operations, as they provide much
> +stronger ordering in two ways:
> +
> +	Firstly, strong ordering operations also create order between
> +	earlier stores and later reads.

Switching back to "execution order" I guess; need clarification.


> +
> +	Secondly, strong ordering operations create a form of global
> +	ordering: When an earlier store W propagates to CPU C and is
> +	ordered by a strong ordering operation with a store W' of C,
> +	and another CPU C' observes W' and in response issues yet
> +	another store W'', then W'' also can not propagate to any CPU
> +	before W.  By contrast, a release fence or smp_wmb() would only
> +	order W and W', but not force any ordering between W and W''.
> +	To summarize, the ordering forced by strong ordering operations
> +	extends to later stores of all CPUs, while other fences only
> +	force ordering with relation to stores on the CPU that executes
> +	the fence.
> +
> +The propagation ordering enforced by release fences and strong ordering
> +operations affects stores from other CPUs that propagate to CPU C before
> +the fence is executed, as well as stores that are executed on C before
> +the fence.  We describe this property by saying that release fences and
> +strong ordering operations are A-cumulative.  By contrast, smp_wmb()
> +fences are not A-cumulative; they only affect the propagation of stores
> +that are executed on C before the fence (i.e., those which precede the
> +fence in program order).

[lots of renaming unless I missed something]


> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 07f884f9b2bf..1d91edbc10fe 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -36,9 +36,7 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> -		fencerel(After-unlock-lock) ; [M])
> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
>  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>  let strong-fence = mb | gp
>  
> @@ -91,8 +89,12 @@ acyclic hb as happens-before
>  (* Write and fence propagation ordering *)
>  (****************************************)
>  
> -(* Propagation: Each non-rf link needs a strong fence. *)
> -let pb = prop ; strong-fence ; hb* ; [Marked]
> +(* Strong ordering operations *)
> +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
> +		[After-unlock-lock] ; po ; [M])
> +
> +(* Propagation: Each non-rf link needs a strong ordering operation. *)
> +let pb = prop ; strong-order ; hb* ; [Marked]
>  acyclic pb as propagation
>  
>  (*******)
> @@ -141,7 +143,7 @@ let rec rcu-order = rcu-gp | srcu-gp |
>  	(rcu-order ; rcu-link ; rcu-order)
>  let rcu-fence = po ; rcu-order ; po?
>  let fence = fence | rcu-fence
> -let strong-fence = strong-fence | rcu-fence
> +let strong-order = strong-order | rcu-fence
>  
>  (* rb orders instructions just as pb does *)
>  let rb = prop ; rcu-fence ; hb* ; pb* ; [Marked]
> @@ -169,7 +171,7 @@ flag ~empty mixed-accesses as mixed-accesses
>  (* Executes-before and visibility *)
>  let xbstar = (hb | pb | rb)*
>  let vis = cumul-fence* ; rfe? ; [Marked] ;
> -	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
> +	((strong-order ; [Marked] ; xbstar) | (xbstar & int))
>  
>  (* Boundaries for lifetimes of plain accesses *)
>  let w-pre-bounded = [Marked] ; (addr | fence)?
> @@ -180,9 +182,9 @@ let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
>  	[Marked]
>  
>  (* Visibility and executes-before for plain accesses *)
> -let ww-vis = fence | (strong-fence ; xbstar ; w-pre-bounded) |
> +let ww-vis = fence | (strong-order ; xbstar ; w-pre-bounded) |
>  	(w-post-bounded ; vis ; w-pre-bounded)
> -let wr-vis = fence | (strong-fence ; xbstar ; r-pre-bounded) |
> +let wr-vis = fence | (strong-order ; xbstar ; r-pre-bounded) |
>  	(w-post-bounded ; vis ; r-pre-bounded)
>  let rw-xbstar = fence | (r-post-bounded ; xbstar ; w-pre-bounded)

If "making ppo a subrelation of po" is the goal, why not something like:

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index d70315fddef6e..6e08e92323b5d 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -36,9 +36,7 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
-		fencerel(After-unlock-lock) ; [M])
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 let strong-fence = mb | gp
 
@@ -90,6 +88,9 @@ acyclic hb as happens-before
 (* Write and fence propagation ordering *)
 (****************************************)
 
+let strong-fence = strong-fence | ([M] ; po-unlock-lock-po ;
+	[After-unlock-lock] ; po ; [M])
+
 (* Propagation: Each non-rf link needs a strong fence. *)
 let pb = prop ; strong-fence ; hb* ; [Marked]
 acyclic pb as propagation

No other changes to the CAT/TXT files (or, if you like, a short addition
to ODDS AND ENDS).

Sorry, this doesn't really seem to be worth the noise/diff...

  Andrea
