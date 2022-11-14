Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7766628AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiKNU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiKNUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:55:57 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430D1409B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:55:55 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x15so8575233qvp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31Cd8CNSJO066AAH4b1lETh7z3NAZdgamshDV93laRI=;
        b=JMCpFT1mJ/ySvpQrc53ejKyoP7v/JallecUYCOwLJUNhlbvrr3WNWevZ1wT25tpPJG
         O33ISWQCO+dakh74+hH1fK4nyLT18uJWzF7fQ4/BBMWwz7pxRymByp8R0pBKx7pBDGLi
         5RNfj7ZN93Cl3CgdsNL2nAaRhF+qmz31J+rTEbJnnolJi6BSl/bCryy7XgI3O4iHoOw1
         Is74okh6YJQJmUiZepsZ1vZzVUcWI93LXAQ4hF1T0cJvT1Sqqh6QucoVBzH2epEJIXuL
         8xiqQX8d1tcR/kDbR8W4H5v70QLgTYfDJMxCtJ2MnvEkQSPlaNr1hylfZJBpigL2iEZl
         Rhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31Cd8CNSJO066AAH4b1lETh7z3NAZdgamshDV93laRI=;
        b=KnjoktaeEaPtsbVBlMDMv72nWtuR3DMzrDNIpOWFSLr3qAQItgjlGcIQr83A+FC0dK
         6M2UIp9EVuwjhk+4cSCeI1dpEP5eekMCjB/debKRIcv+a4EHvvXo6wScI1caghDuktGl
         4m8wqugD+PisDSFJN1uQWMHhNhH6QU/bISQbBw1zzFCePFIm9dtsJXFHZzfQ91anJDCT
         ZZo2HZ14MvMkF5PblzrVOYs4bLSGIkTAG2VCvRvdFaiGzVcZRM23zeRcnkfZ22G5V8Vg
         Clvm4AwveWvU2DLakzm2kwdmRVMGF2sxa8QTEKViCSD1qANaMKxWvmR/QHZrBXwrO7Ke
         QGlA==
X-Gm-Message-State: ANoB5pmO4okkJbJRw47ExHVwB3cLb0SAbNstRtcJjPf5EWSRb3lZNcfZ
        Wwddy1pnKEkpdxV6Sj6C4GA=
X-Google-Smtp-Source: AA0mqf58JK4kaOVfwrJ5ABMgpQzefkeYSgSrqzurMJ26BBry4bKgBBkEhaxnXww4Onln9Ef3SJHRTg==
X-Received: by 2002:a05:6214:8d4:b0:4b1:9f77:26a2 with SMTP id da20-20020a05621408d400b004b19f7726a2mr13893804qvb.123.1668459354684;
        Mon, 14 Nov 2022 12:55:54 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ed61f18651sm6973068qkj.16.2022.11.14.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:55:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5887627C0054;
        Mon, 14 Nov 2022 15:55:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 14 Nov 2022 15:55:53 -0500
X-ME-Sender: <xms:V6tyYz9WYNr_IUphA8vn2NoG49RIjQXhzJFA_QHlB9BLtnvTGLf_Gg>
    <xme:V6tyY_tui_RNGtoJbIBLrEAn0rSMQwo1o14zpTnWLeuSU7LV1VeXg2_mrfDq-Rcg8
    aBH3IBdR-g9RCOYDQ>
X-ME-Received: <xmr:V6tyYxAb2FWymlZIfKs7koN2axJqUHM9epCMikwJIbhSGhWAvkWlceMFfXZC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:V6tyY_dR98zQB4Ki7V6Ufy64smO_wFDDiPWB9Idd2NNjnNGWurIglQ>
    <xmx:V6tyY4OU6XaVeJWUZvJ0KyVvXmXDxb8WD1xvVEZLvH6TdqC3zrvJ-Q>
    <xmx:V6tyYxmKjIDDLs4LIhUlPGWlP33s-sKgqvdlaDu0wMop-2GP3EAeDw>
    <xmx:WatyY9es9obpJzc8wdf7F4ZX2aDwJi_RjkXJN7vQowom3-hmzK5Cpg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 15:55:51 -0500 (EST)
Date:   Mon, 14 Nov 2022 12:55:50 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        jonas.oberhauser@huawei.com,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Message-ID: <Y3KrVsDH2ewv0/Ff@Boquns-Mac-mini.local>
References: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:26:23PM -0500, Alan Stern wrote:
> Jonas has pointed out a weakness in the Linux Kernel Memory Model.
> Namely, the memory ordering properties of atomic operations are not
> monotonic: An atomic op with full-barrier semantics does not always
> provide ordering as strong as one with release-barrier semantics.
> 
> The following litmus test illustrates the problem:
> 
> --------------------------------------------------
> C atomics-not-monotonic
> 
> {}
> 
> P0(int *x, atomic_t *y)
> {
> 	WRITE_ONCE(*x, 1);
> 	smp_wmb();
> 	atomic_set(y, 1);
> }
> 
> P1(atomic_t *y)
> {
> 	int r1;
> 
> 	r1 = atomic_inc_return(y);
> }
> 
> P2(int *x, atomic_t *y)
> {
> 	int r2;
> 	int r3;
> 
> 	r2 = atomic_read(y);
> 	smp_rmb();
> 	r3 = READ_ONCE(*x);
> }
> 
> exists (2:r2=2 /\ 2:r3=0)
> --------------------------------------------------
> 
> The litmus test is allowed as shown with atomic_inc_return(), which
> has full-barrier semantics.  But if the operation is changed to
> atomic_inc_return_release(), which only has release-barrier semantics,
> the litmus test is forbidden.  Clearly this violates monotonicity.
> 
> The reason is because the LKMM treats full-barrier atomic ops as if
> they were written:
> 
> 	mb();
> 	load();
> 	store();
> 	mb();
> 
> (where the load() and store() are the two parts of an atomic RMW op),
> whereas it treats release-barrier atomic ops as if they were written:
> 
> 	load();
> 	release_barrier();
> 	store();
> 
> The difference is that here the release barrier orders the load part
> of the atomic op before the store part with A-cumulativity, whereas
> the mb()'s above do not.  This means that release-barrier atomics can
> effectively extend the cumul-fence relation but full-barrier atomics
> cannot.
> 
> To resolve this problem we introduce the rmw-sequence relation,
> representing an arbitrarily long sequence of atomic RMW operations in
> which each operation reads from the previous one, and explicitly allow
> it to extend cumul-fence.  This modification of the memory model is
> sound; it holds for PPC because of B-cumulativity, it holds for TSO
> and ARM64 because of other-multicopy atomicity, and we can assume that
> atomic ops on all other architectures will be implemented so as to
> make it hold for them.
> 
> For similar reasons we also allow rmw-sequence to extend the
> w-post-bounded relation, which is analogous to cumul-fence in some
> ways.
> 
> Suggested-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Regards,
Boqun

> ---
> 
>  tools/memory-model/Documentation/explanation.txt |   28 +++++++++++++++++++++++
>  tools/memory-model/linux-kernel.cat              |    5 ++--
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> Index: usb-devel/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.cat
> +++ usb-devel/tools/memory-model/linux-kernel.cat
> @@ -74,8 +74,9 @@ let ppo = to-r | to-w | fence | (po-unlo
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = (rfe ; [Marked])? ; r
> +let rmw-sequence = (rf ; rmw)*
>  let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> -	po-unlock-lock-po) ; [Marked]
> +	po-unlock-lock-po) ; [Marked] ; rmw-sequence
>  let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
>  	[Marked] ; rfe? ; [Marked]
>  
> @@ -174,7 +175,7 @@ let vis = cumul-fence* ; rfe? ; [Marked]
>  let w-pre-bounded = [Marked] ; (addr | fence)?
>  let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
>  	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
> -let w-post-bounded = fence? ; [Marked]
> +let w-post-bounded = fence? ; [Marked] ; rmw-sequence
>  let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
>  	[Marked]
>  
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -1006,6 +1006,34 @@ order.  Equivalently,
>  where the rmw relation links the read and write events making up each
>  atomic update.  This is what the LKMM's "atomic" axiom says.
>  
> +Atomic rmw updates play one more role in the LKMM: They can form "rmw
> +sequences".  An rmw sequence is simply a bunch of atomic updates where
> +each update reads from the previous one.  Written using events, it
> +looks like this:
> +
> +	Z0 ->rf Y1 ->rmw Z1 ->rf ... ->rf Yn ->rmw Zn,
> +
> +where Z0 is some store event and n can be any number (even 0, in the
> +degenerate case).  We write this relation as: Z0 ->rmw-sequence Zn.
> +Note that this implies Z0 and Zn are stores to the same variable.
> +
> +Rmw sequences have a special property in the LKMM: They can extend the
> +cumul-fence relation.  That is, if we have:
> +
> +	U ->cumul-fence X -> rmw-sequence Y
> +
> +then also U ->cumul-fence Y.  Thinking about this in terms of the
> +operational model, U ->cumul-fence X says that the store U propagates
> +to each CPU before the store X does.  Then the fact that X and Y are
> +linked by an rmw sequence means that U also propagates to each CPU
> +before Y does.
> +
> +(The notion of rmw sequences in the LKMM is similar to, but not quite
> +the same as, that of release sequences in the C11 memory model.  They
> +were added to the LKMM to fix an obscure bug; without them, atomic
> +updates with full-barrier semantics did not always guarantee ordering
> +at least as strong as atomic updates with release-barrier semantics.)
> +
>  
>  THE PRESERVED PROGRAM ORDER RELATION: ppo
>  -----------------------------------------
> 
