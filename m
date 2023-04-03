Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEA6D466D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjDCOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjDCOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:04:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35626256;
        Mon,  3 Apr 2023 07:04:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t13so21181463qvn.2;
        Mon, 03 Apr 2023 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW/bOD1HON6noswE8BaYkjAqkjl3OaERY6frVvhB+38=;
        b=LCQ6bs8Gfin2bwNb4d1tNEVZAVH/EyB38lXDsyXGLre7GgP4o2jXDCjLEKpumBD2ig
         el+D5GcKJ9v/LbOtn4evnAgGvkvAoWjZPaKC7b0zLd7zOTvwjNFVp5jaXYfK32pKLEw6
         mAiLJtAAYkdvl9FoLTl6+x4X/l3tBvXq3p+/5cuPJ4SwQ3QLEun/80cMEejqaIR8YRPA
         R1X3nMXbhkU8FOSUbSYwGWE5AZw456NCmgqT+4r9v5yKTMXidkqB6QvyzGmFmY77XySF
         k0HZWmYHKpw/Vl6b5bOVaOZH6px71T7ca5Bm/CroxmhQGdR+TuWhTwlebYj/vhlP0daJ
         9LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IW/bOD1HON6noswE8BaYkjAqkjl3OaERY6frVvhB+38=;
        b=g17CYP+zhpS8xC2b0erPvkOQ8Yn1/lsgvDal2cmGIAUEmQ4/e1+qzWMtgAYQVQiOMT
         0RKMuNINAotECsRHEjl8zHsOYyx66m42SSjb6qUAJGkMtX8Mp2gr13UZxR+j8X0p/CbR
         ONDxfQHewCiCR3UyZsYlFOpGleWoJ0SWJ0TFLBZ2AUZDaj5mA2sHp4J5XioAu/V/khZS
         fR0WDLXfaPea4VQVZ2IBIVvlaK+xMldPP8Xr7wzgzbEJ6cE9aCW7zQOPj2sEpngr46Jr
         a4JPKX8Pg/qk96NKmc3nFNy0F+xY+14VIMilVGPDqSAhK+AOromtGb6dQEhg1hQxossW
         yLQQ==
X-Gm-Message-State: AAQBX9cpTFZyTXt1kiU/qF345Q+gejLBPzGqXt2I8gqAEaUKKG5zv1Y2
        d9h/Lymf+UVrbRF9pEFYgz0=
X-Google-Smtp-Source: AKy350ZDzpP75p8Igfl3itcmCsQAp/xqznxr+zste2QmpAjnoDCuVmXnWiPeTZLxvSoPOJVNY08/VQ==
X-Received: by 2002:a05:6214:2aad:b0:56e:9317:eb9a with SMTP id js13-20020a0562142aad00b0056e9317eb9amr64055030qvb.29.1680530689400;
        Mon, 03 Apr 2023 07:04:49 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id lw6-20020a05621457c600b005dd8b934595sm2660000qvb.45.2023.04.03.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:04:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 54ABA27C005B;
        Mon,  3 Apr 2023 10:04:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 10:04:48 -0400
X-ME-Sender: <xms:_twqZHVU5kZ2Uw8hM-xQNFwU3OaVyXzoqUg9dK3uTE6P9lcY7HVVwA>
    <xme:_twqZPkvxbkEnbkP92xdtUiIQM-T0IMsBIdXCS0CpTJsHhy1F2eQzCgoKRAR6QMLE
    Il9Ac6AsGoboCHfig>
X-ME-Received: <xmr:_twqZDZ7-2AUbLkYyI5H8FqmGdQFzEVCf9wy0vRE4lWhQIB0hM3a41erB3xvtbvUtFeVKyOjfRb7O9PkYzmKwP0FVx31rU3_8KE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_twqZCVmcerRNHKREL3vequB-KHfBJVJCaHPnu-3AoAtIDGIVLv9CA>
    <xmx:_twqZBmAbTBr7rx7sfhAVExceJaoeurPT-7YQqXUVCMtvzhaKpntYQ>
    <xmx:_twqZPecqEWPpwHkpToq1PFDQH3aR-fykgMX87TqoSXFVUbi4Whpgw>
    <xmx:_9wqZHfbi_-Lsuq6codE32HlvTysBdqI5h65qY0pfFeAE9y5FaYCZw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 10:04:45 -0400 (EDT)
Date:   Mon, 3 Apr 2023 07:04:43 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/13] rust: lock: introduce `Mutex`
Message-ID: <ZCrc+5q2Kp63gfPu@Boquns-Mac-mini.local>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
 <20230330130108.GE124812@hirez.programming.kicks-ass.net>
 <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
 <20230403082052.GR4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403082052.GR4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:20:52AM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 11:47:12AM -0700, Boqun Feng wrote:
> > On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:
> > > On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:
> > > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > > 
> > > > This is the `struct mutex` lock backend and allows Rust code to use the
> > > > kernel mutex idiomatically.
> > > 
> > > What, if anything, are the plans to support the various lockdep
> > > annotations? Idem for the spinlock thing in the other patch I suppose.
> > 
> > FWIW:
> > 
> > *	At the init stage, SpinLock and Mutex in Rust use initializers
> > 	that are aware of the lockdep, so everything (lockdep_map and
> > 	lock_class) is all set up.
> > 
> > *	At acquire or release time, Rust locks just use ffi to call C
> > 	functions that have lockdep annotations in them, so lockdep
> > 	should just work.
> > 
> 
> ffi is what the C++ world calls RAII ?
> 

ffi is foreign function interface, it means calling a C function from
Rust. Sorry if I make things confusing ;-)

> But yes, I got that far, but I wondered about things like
> spin_lock_nested(&foo, SINGLE_DEPTH_NESTING) and other such 'advanced'
> annotations.
> 

Right, I haven't really thought through them, but I think it's easy to
add them later (famous later words).

> Surely we're going to be needing them at some point. I suppose you can
> do the single depth nesting one with a special guard type (or whatever
> you call that in the rust world) ?

or a different method for Lock:

	impl Lock { // implementation block for type `Lock`
	//                 v function is called via a.lock_nested(SINGLE_DEPTH_NESTING), a is a Lock
	    fn lock_nested(&self, level: i32) -> Guard<..> {
	//  ^ defines a function           ^ returns a guard

	        ..  
	    }
	}

since Rust side just uses the same function to unlock as C side, so a
normal Guard type suffices, because we don't treat nested lock
differently at unlock time. But if we were to add some more checking at
compile time, we could have a slight different Guard or something.

Regards,
Boqun
