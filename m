Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD06801C8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjA2Voy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA2Vov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:44:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B91420D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:44:50 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s4so8546535qtx.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccXGm88Lr7OU3cqWAubaK46qqzKiZyBK/VzlJfykCB8=;
        b=oojcySu1JmpbzjjuinnoQkYrnDml2eNyFWcnHu5Jhy8Pi7r1c+plQSE+W+/S/PMIUX
         MYPNsHFt5BOnBTZYudm8sgDQeOf8LWRffcYnB9pQt8SItCaGKviZhopR1IwjVyluGuBL
         179ELrK8/wxr5AiXosARB2NZwxDJTAi44BkS+31POdjzPowulSDvTNvoFtfeSXbvySx6
         104ffvxKCb63ChneedFg9TaBvaekEBA0H+rdCCi6LRn9jUOR8vncpuZtJtMIu7MqH7oU
         siRkaN3Lr4rXhi/lE0mPIohFCm9h1hR1yN93h61k0OQx5BuVT7WA99krp9C40Sat24JJ
         pOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccXGm88Lr7OU3cqWAubaK46qqzKiZyBK/VzlJfykCB8=;
        b=ex82LninwKetbyVkMORG7/Dw+10mkLQDOBcXpNwyjL04PQ8aerpmUlrb0K5ERZVZAV
         eJmcPKh0PMDlvIKNsZHUXmZeda7cXvJ+o9za6vihhds3KVNgfP7U0ndIuKNCHDkg84Ls
         79sxSP/vz3kaI6n8AtTGboNRrRDNTJJrc0MLsr0wmKVRg+RfojPs4O3nSNdEGAmgO0Ue
         o540w+b4ir8mIU7Es15vT4flnsu2OENbaVEzNcrmzHlLFd7plAnmVv63eGn3Renqj4Ws
         baa+af4Jby/xIIP67b99x/i9F8/xN21VHTaZaoVC2mPz1956sgZnlG5pHkAnNhRR1s7C
         7iTg==
X-Gm-Message-State: AFqh2krQGQzEwYzPGqlLJJeeWR5xiovIS21UXP46aj/fo5A3ODc6biat
        sMUflEEkJ0sor7AEWOtxMUQ=
X-Google-Smtp-Source: AMrXdXvcF80klqEio3hBF0RD+PYhOuNR5QYFl7CKeh7J9oMPeOcVF6H0uT7XfEcvky7zcpOL4qgHNA==
X-Received: by 2002:ac8:48d9:0:b0:3b6:2f49:1acc with SMTP id l25-20020ac848d9000000b003b62f491accmr63132600qtr.16.1675028689070;
        Sun, 29 Jan 2023 13:44:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h189-20020a3753c6000000b006fbb4b98a25sm6961205qkb.109.2023.01.29.13.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:44:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4C8727C0054;
        Sun, 29 Jan 2023 16:44:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 29 Jan 2023 16:44:47 -0500
X-ME-Sender: <xms:zujWYwXt37PjcqqN-AQWxnc8wETxMVoxTY_bfJotg6O9ulm8qJVjuQ>
    <xme:zujWY0mF3OP5XVxuLQDbRP3LsJGAzPxS1z-MDIfICeQnACL4SOk6S-cLk_PHUtp7x
    elwJQBnTJcLNp2Y5A>
X-ME-Received: <xmr:zujWY0auUEnc6a5P5XsijP0XjiTDc43UpJMVEeJW6hFDw4nthLpSge6asCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeftddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:zujWY_WDWFX-15k7gr30eQtaIPJuX_A5poDGUyylscKx2eAIqkqOww>
    <xmx:zujWY6kRXjXyO-1mwXPx3t6mPz9IAeXtqL5T4EQiFw0eRtJlEfAMHQ>
    <xmx:zujWY0f3nZPsnSaIomkCZO5V0TxzUfdVCQ6vNFQ82JDyRqPE3NSbDA>
    <xmx:z-jWY00aH-rUhG9WABOx1LdX87l48wvHLJmCOJzvD_IqTNDtfX6i5Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jan 2023 16:44:46 -0500 (EST)
Date:   Sun, 29 Jan 2023 13:43:53 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9bomciHJ/6WGYM0@boqun-archlinux>
References: <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9asu0CswZZ3yyls@andrea>
 <20230129184403.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129184403.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 10:44:03AM -0800, Paul E. McKenney wrote:
> On Sun, Jan 29, 2023 at 06:28:27PM +0100, Andrea Parri wrote:
> > > Why can't P3's spin_lock() read from that initial write?
> > 
> > Mmh, sounds like you want to play with something like below?
> > 
> >   Andrea
> > 
> > diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> > index 6b52f365d73ac..20c3af4511255 100644
> > --- a/tools/memory-model/lock.cat
> > +++ b/tools/memory-model/lock.cat
> > @@ -74,7 +74,6 @@ flag ~empty UL \ range(critical) as unmatched-unlock
> >  
> >  (* Allow up to one unmatched LKW per location; more must deadlock *)
> >  let UNMATCHED-LKW = LKW \ domain(critical)
> > -empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
> >  
> >  (* rfi for LF events: link each LKW to the LF events in its critical section *)
> >  let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
> > @@ -120,8 +119,7 @@ let rf-ru = rfe-ru | rfi-ru
> >  let rf = rf | rf-lf | rf-ru
> >  
> >  (* Generate all co relations, including LKW events but not UL *)
> > -let co0 = co0 | ([IW] ; loc ; [LKW]) |
> > -	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])
> > +let co0 = co0 | ([IW] ; loc ; [LKW])
> >  include "cos-opt.cat"
> >  let W = W | UL
> >  let M = R | W
> 
> No idea.  But the following litmus test gets no executions whatsoever,
> so point taken about my missing at least one corner case.  ;-)
> 
> Adding a spin_unlock() to the end of either process allows both to
> run.
> 
> One could argue that this is a bug, but one could equally well argue
> that if you have a deadlock, you have a deadlock.
> 

in lock.cat: 

	(* Allow up to one unmatched LKW per location; more must deadlock *)
	let UNMATCHED-LKW = LKW \ domain(critical)
	empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks

we rule out deadlocks from the execution candidates we care about.

Regards,
Boqun

> Thoughts?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> C lock
> 
> {
> }
> 
> 
> P0(int *a, int *b, spinlock_t *l)
> {
> 	spin_lock(l);
> 	WRITE_ONCE(*a, 1);
> }
> 
> P1(int *a, int *b, spinlock_t *l)
> {
> 	spin_lock(l);
> 	WRITE_ONCE(*b, 1);
> }
> 
> exists (a=1 /\ b=1)
