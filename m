Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B193D6D4C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDCPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDCPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:44:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5392D49;
        Mon,  3 Apr 2023 08:44:41 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t19so28697797qta.12;
        Mon, 03 Apr 2023 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680536680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kclZcPGzLT8qD+FxOEEZz3AYIvik9LusU8EytUnJ65w=;
        b=R3kQPYI0RGcmUaPVY9ZIhhTYXdPCCoxzw+W2mUQdu4i9JRrSWH9k3cWB0QhAmHHnmt
         dZJr7j+pVgxWHkz3ontXO/DVjylkzGjkqDdOpxYt14UN1QZbp6u43IfLuWq5rf2vHBSP
         K1guvuQ9Lpwt1dlMFR+VVWxzIA7aJxey5FOwniB6pbhnLOrDA4e4KCZ7i4mMfmXDvRI1
         jb/yxiRZrYggjckx+1v+ddNbcOFwQr69aSqeWv4OuV1PpcL/SeSHY+6bALXy82daUU63
         FpuP257J5GtF8JuD2oFDKtNk2HwS617p8B9KHsU5aeIIfe36FY/DG25tABwDF9aDPlnZ
         uvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kclZcPGzLT8qD+FxOEEZz3AYIvik9LusU8EytUnJ65w=;
        b=jK8PvoNJTUq3UIDKq27NK2niwWbQmHO+SyyCTONMG0yeFPEJ+p5LFPUrOj/Z5nwFo8
         eSEA1E9ySEFQpB9OKXsaPFjQgqvRAkHNsJ+DlXGmrZGjfEmiuJZBqZ/W0g8R7PDJ42SZ
         DCw0eeScykL1VF9Uqyvbs42I+7/sZPsJ9b/eFDZN3Eo5VaIgLlR30ehE826DHHVuAwD6
         Qg5nezGajB97RdLHMB0lZSzQh5U3R5kj4lNgszjLIgyKjQzYJMDVB+TMRFmrtPMbC7Jw
         yBSAL3WM1DU65OeltAAz8ROQAgmo/B+49cDTGYe2CZkyfRcMQYR9EArSnIeljJuOMXBw
         iXlg==
X-Gm-Message-State: AAQBX9c+bLbrLubGFHc19PGdlPPzeq0ugJxgEediYHowxQC9byiAaNJJ
        0YdCBD8k5BMzjdw5bcgX8QQ=
X-Google-Smtp-Source: AKy350a4pXXSBX2zmejuRMoR7fs0yhKdvJH71TAvkzpfOEYoHftV3Ksp0JQJM2xQSG89xm/ZkC6hkg==
X-Received: by 2002:a05:622a:1ba7:b0:3e6:38b6:88f5 with SMTP id bp39-20020a05622a1ba700b003e638b688f5mr22401490qtb.25.1680536680239;
        Mon, 03 Apr 2023 08:44:40 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bn29-20020a05620a2add00b00743592b4745sm2840494qkb.109.2023.04.03.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:44:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 25D4A27C0054;
        Mon,  3 Apr 2023 11:44:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 11:44:39 -0400
X-ME-Sender: <xms:ZvQqZLU-6mPuai5kHi2iQpimfzNuUYUsjb54TU608RjXadqy_3UIsA>
    <xme:ZvQqZDlt5Qs8AIx2qIoT7pKYaxjUIrgRbzW-mrt1MR1mb3A7b2O8oiyA1qL1CTqZQ
    _FGNXgzaSnQzS-1Gw>
X-ME-Received: <xmr:ZvQqZHYPvUaH0ISFUpcOAck-EVHDlBt6vZl1WgIlX_1DAmrYJO_VoCblINisFZ9X9qL8Zit7hI0XMOKWKuJi4lgz8ONKDEKDEnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZvQqZGUFD9Q1XbmHX3eLnB1qVQwZGqsuOTZLlPdeY-iqzhQsVdbDBA>
    <xmx:ZvQqZFnOnZRu2tQGAMr9s8C4UNNo7PlET6bn0i2Py8AYcrkmhx7IrQ>
    <xmx:ZvQqZDduh_eDtCU45ZyQxbi5f9G1UAmbWUWuksUTyqTMYFPwbOX5JA>
    <xmx:Z_QqZLd8wbdnu9R8XA-RTyUlrl00oEReIS1NPmzHU428KkUMAOJDcA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 11:44:38 -0400 (EDT)
Date:   Mon, 3 Apr 2023 08:44:36 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/13] rust: lock: introduce `Mutex`
Message-ID: <ZCr0ZDlvlFHFIRbh@Boquns-Mac-mini.local>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
 <20230330130108.GE124812@hirez.programming.kicks-ass.net>
 <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
 <20230403082052.GR4253@hirez.programming.kicks-ass.net>
 <ZCrZkUaoslXHpige@wedsonaf-dev>
 <20230403162529.7bef76e6.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403162529.7bef76e6.gary@garyguo.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 04:25:29PM +0100, Gary Guo wrote:
> On Mon, 3 Apr 2023 10:50:09 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> 
> > On Mon, Apr 03, 2023 at 10:20:52AM +0200, Peter Zijlstra wrote:
> > > On Thu, Mar 30, 2023 at 11:47:12AM -0700, Boqun Feng wrote:  
> > > > On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:  
> > > > > On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:  
> > > > > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > > > > 
> > > > > > This is the `struct mutex` lock backend and allows Rust code to use the
> > > > > > kernel mutex idiomatically.  
> > > > > 
> > > > > What, if anything, are the plans to support the various lockdep
> > > > > annotations? Idem for the spinlock thing in the other patch I suppose.  
> > > > 
> > > > FWIW:
> > > > 
> > > > *	At the init stage, SpinLock and Mutex in Rust use initializers
> > > > 	that are aware of the lockdep, so everything (lockdep_map and
> > > > 	lock_class) is all set up.
> > > > 
> > > > *	At acquire or release time, Rust locks just use ffi to call C
> > > > 	functions that have lockdep annotations in them, so lockdep
> > > > 	should just work.
> > > >   
> > > 
> > > ffi is what the C++ world calls RAII ?  
> > 
> > No, ffi is 'foreign function interface', it just means that the caller will use
> > the same ABI as the callee.
> > 
> > > But yes, I got that far, but I wondered about things like
> > > spin_lock_nested(&foo, SINGLE_DEPTH_NESTING) and other such 'advanced'
> > > annotations.
> > > 
> > > Surely we're going to be needing them at some point. I suppose you can
> > > do the single depth nesting one with a special guard type (or whatever
> > > you call that in the rust world) ?  
> > 
> > I haven't looked at all the advanced annotations, but something like
> > spin_lock_nested/mutex_lock_nested can be exposed as a lock_nested() associated
> > function of the `Lock` type, so one would do:
> > 
> >   let guard = my_mutex.lock_nested(SINGLE_DEPTH_NESTING);
> >   // Do something with data protected by my_mutex.
> 
> I don't think an additional function would work. It's not okay to
> perform both nested locking and non-nested locking on the same lock

Note that lock_nested() here is simply a lockdep concept, it means
locking nested under the same lock class (key), not lock instance, for
example:

	spinlock_t X1;
	spinlock_t X2;

	// X1 and X2 are of the same lock class X
	spin_lock(&X1);
	spin_lock(&X2); // lockdep will report a deadlock.

	// However, if we know that X1 and X2 has some ordering to lock,
	// e.g. X1 is the lock for a directory and X2 is the lock for
	// the file in the directory, we can
	spin_lock(&X1);
	spin_lock_nested(&X2, SINGLE_DEPTH_NESTING);

	// and lockdep won't complain.

There is some design space here for Rust, since we may be able to put
the nested information in the type.

Regards,
Boqun

> because non-nested locking will give you a mutable reference, and
> getting another reference from nested lock guard would violate aliasing
> rules.
> 
> A new lock type would be needed for nested locking, and guard of it can
> only hand out immutable reference.
> 
> Best,
> Gary
