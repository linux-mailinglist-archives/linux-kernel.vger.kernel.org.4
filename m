Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E06119E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJ1SJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJ1SJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:09:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5F22BD5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:09:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o28so1304136qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1IYYsyytsU85jHej1IH0APedSXjD7s2oSDBJqGWIlQ=;
        b=PgK+L46fDru3JnOz0FlKXHvqy4h+P91Bp8lFs50uA1AFO7FYdA1s2Okt1he9JSkTPz
         AhT4iclNNva9e+IlnrAAW5A2SlVycY5QJG4e7kXLX6JlG2TJXaQ8eEXnXCD16MPrI1Xd
         Kfw7uqaoiMna9ZpgdQkK0YcPiWHsdPEBpL0kaMYbzxJR3/xGGF0ebS8XvrU+bUnjc02R
         p9PZ5UVHCYJkVJwRFhJawmkd1HbgT2Eoav/tnissbMETSuuic+JqNyp5LkRLYWQ1sgbu
         6xyKEkGIxnS7E0HnpDHQ3KWvszQ/wjKmu4XjCYeNju2pohwLg+ju/cYdMRlId5yGQzy7
         EjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1IYYsyytsU85jHej1IH0APedSXjD7s2oSDBJqGWIlQ=;
        b=XR/NTTZ3RfwKtdfp0g/WZZ64sWWhX3maRDd8EF3/Oc7Ht1xxBO7CskBLE392aUZkwR
         NzMpGL2/dNvw5gkGCorBP4cxYLsPZvMt6jlpfZEkNYQWibTgV235sLWBfvfXBOJkCo4p
         n8//201KnGFc1bvVeOH9DbCxPinWkjpE+nHigDEA8TtEgNDo/6zAehA51yBieD3XHLh6
         UOeo11S8h0oov+IULh6FtsS/nC0sFab/1HYg/JYSK4CjCviNYARFj3kZkfiK/CNi/b3G
         L1XxKQMoUsWoyAuext/iRiy07/r1mJ/gJU8W9cWom/YzSVSuRTaBsjOn2/NnHrMwWk3y
         4lLQ==
X-Gm-Message-State: ACrzQf0VRWGAQQQ+diCAn9HhRLd04Pd8wJYXcoJpgIderm7jN8c2tpXq
        vo7uhDuQ0j1YDwCh9G6VLJs=
X-Google-Smtp-Source: AMsMyM7gMaBAhl/fP2Oijgw2eVNLpqiDR0fUeo1fyL3nx9iRiNXkoiO/IxAbJ5g1uMZOEvJHo/XJyQ==
X-Received: by 2002:a05:620a:79a:b0:6fa:1c1:26dc with SMTP id 26-20020a05620a079a00b006fa01c126dcmr377512qka.449.1666980579863;
        Fri, 28 Oct 2022 11:09:39 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a244b00b006bbf85cad0fsm3513902qkn.20.2022.10.28.11.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:09:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2268A27C0054;
        Fri, 28 Oct 2022 14:09:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 28 Oct 2022 14:09:38 -0400
X-ME-Sender: <xms:4RpcY7-1qcZF-7ghjbYt3JKJYTpHMFKOLHceZcGkijQu55WmTUR91g>
    <xme:4RpcY3sYloXZIy6-mOHeZjmKz_iAJYrm0DwyQmtADD8iihm4fnWSN9tKhP7HmyGq_
    4lNsZi1aHyBzUuJYA>
X-ME-Received: <xmr:4RpcY5BGq-3sNdcg-r8EWmtrxkw-21SieZSi4gfazdxQ28HTocSleoQAAhNV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4RpcY3fX9US38ibkHY-ZNcno_unMOPr7zPjHHCq4HWEcKxiKJyud6A>
    <xmx:4RpcYwNsOUwpMidAlXpWqo2N3_Dp4IYMiz6doDYvaCbyZqkUZgJsig>
    <xmx:4RpcY5lLKLntvHSDpuNh0ZQDIZy8jvaHrvceZga2-CxMubNOOYgSUA>
    <xmx:4RpcY3e3ckF3kt7W2V6_WbHQ-TFiceJJsRz9yDE6UZLhhTsLlWCDOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Oct 2022 14:09:36 -0400 (EDT)
Date:   Fri, 28 Oct 2022 11:09:35 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 33/38] printk: introduce console_list_lock
Message-ID: <Y1wZrIfi8UoaKcBF@Boquns-Mac-mini.local>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-34-john.ogness@linutronix.de>
 <Y1pY3I1ufABvroYj@alley>
 <20221027185007.GG5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027185007.GG5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:50:07AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 27, 2022 at 12:09:32PM +0200, Petr Mladek wrote:
> > Adding Paul into Cc so that he is aware of using a custom SRCU lockdep
> > check in console_list_lock().
> 
> [ . . . ]
> 
> > > +/**
> > > + * console_list_lock - Lock the console list
> > > + *
> > > + * For console list or console->flags updates
> > > + */
> > > +void console_list_lock(void)
> > > +{
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +	/*
> > > +	 * In unregister_console(), synchronize_srcu() is called with the
> > > +	 * console_list_lock held. Therefore it is not allowed that the
> > > +	 * console_list_lock is taken with the srcu_lock held.
> > > +	 *
> > > +	 * Whether or not this context is in the read-side critical section
> > > +	 * can only be detected if the appropriate debug options are enabled.
> > > +	 */
> > > +	WARN_ON_ONCE(debug_lockdep_rcu_enabled() &&
> > > +		     srcu_read_lock_held(&console_srcu));
> 
> Yes, this is an interesting case.
> 
> The problem that John is facing is that srcu_read_lock_held() believes
> that it is safer to err on the side of there being an SRCU reader.
> This is because the standard use is to complain if there is -not-
> an SRCU reader.  So as soon as there is a lockdep issue anywhere,
> srcu_read_lock_held() switches to unconditionally returning true.
> 
> Which is exactly what John does not want in this case.
> 
> So he excludes the CONFIG_DEBUG_LOCK_ALLOC=n case and the
> !debug_lockdep_rcu_enabled() case, both of which cause
> srcu_read_lock_held() to unconditionally return true.
> 
> This can result in false-positive splats if some other CPU issues a
> lockdep warning after debug_lockdep_rcu_enabled() is invoked but before
> srcu_read_lock_held() is invoked.  But similar vulnerabilities are
> present in RCU_LOCKDEP_WARN(), so unless and until there is a problem,
> this code should suffice.
> 
> One way to save a line is as follows:
> 
> 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
> 		     debug_lockdep_rcu_enabled() &&
> 		     srcu_read_lock_held(&console_srcu));
> 
> Longer term, it might be possible to teach lockdep about this sort of
> SRCU deadlock.  This is not an issue for vanilla RCU because the RCU
> reader context prohibits such deadlocks.  This isn't exactly the same
> as reader-writer locking because this is perfectly OK with SRCU:
> 
> 	CPU 0:
> 		spin_lock(&mylock);
> 		idx = srcu_read_lock(&mysrcu);
> 		do_something();
> 		srcu_read_unlock(&mysrcu, idx);
> 		spin_unlock(&mylock);
> 
> 	CPU 1:
> 		idx = srcu_read_lock(&mysrcu);
> 		spin_lock(&mylock);
> 		do_something();
> 		spin_unlock(&mylock);
> 		srcu_read_unlock(&mysrcu, idx);
> 
> Adding Boqun on CC in case it is easier than I think.  ;-)
> 

First I think reader-writer deadlock detection won't treat this as a
deadlock, because srcu_read_lock() is a recursive read lock ;-) in other
words, lockdep knows they don't block each other.

I was actually considering to equip SRCU with reader-writer deadlock
detection when:

	https://lore.kernel.org/lkml/20180412021233.ewncg5jjuzjw3x62@tardis/

The problem (for SRCU to use reader-writer deadlock detection) is
letting lockdep know synchronize_srcu() doesn't block srcu_read_lock(), 
so looks like I owe you a new lockdep annotation primitive ;-)

Regards,
Boqun

> 							Thanx, Paul
