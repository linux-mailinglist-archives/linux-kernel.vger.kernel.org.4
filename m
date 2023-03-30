Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A886D0E30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjC3S45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3S4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:56:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B97DE;
        Thu, 30 Mar 2023 11:56:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g19so19464095qts.9;
        Thu, 30 Mar 2023 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zikl0+WJQyfKb/6s3F2mXqcF7vsu9H00XXtQyNQeZY=;
        b=BCeJlB/WCdMVcQoouTNUiVPfEN4YQdGq9/QIK8d637YJvH2O75zO5nU5wtf6FSEVOd
         WcStVyVDR+ssG1lXHg3JaX3hqYm2019ZqSsMcpybMLueu0hmIUeuBMlQqRWWiszrUjRn
         NFXGift3YBxrZMaQxaLaFcY+jO/qXe1iCgD6lhLMUNn/uWptmC0SJu88oWhJtM0NWDa/
         i5uZF5Ml/7PEu7iuRb6F6rFqvgPvKeSTL2R/QkWXSWusF45Z7ase7dCCTuM63Fhj6eao
         OnytynZ9xj4P14Q9hGskhF23/UO12BMBO2fgzxZkfrNlHoeVOWosykW8WM4Af4Eq2XKu
         r5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zikl0+WJQyfKb/6s3F2mXqcF7vsu9H00XXtQyNQeZY=;
        b=h/ebU4JnMRBA9ZZ4Sa7XFS9PZKzdpVfdIBcgqhB7h+0w8nz4Z9D3kgLonCdIqiO1ho
         x5vQQJVSfofGy9/hZtycD4b01OxO9OXwhWbzRLXjkDqltpk+Q/ylJtvmeneIkQACfKCi
         t0j4ba1SLt8UdNyD+EOl69QUAHaHJ+eM7mrt4WNvYtbEoZHja6MTScjoKSxvBBAPzMxx
         CJvPN42bCJkYtkrisJ9JGB8n/aJXDRKbdxhU1BzVi0udZlUZT4/BRjLL4oYkimhT7SzX
         F+QkHoAewkNEIcg74y3zh4GmCfMIR0Dnm/WAnflhRn3Il7sclIXkZDgXyJPeh90Kd/8q
         h90A==
X-Gm-Message-State: AO0yUKW5ffwBBIvAI7cqByypUBypuDpjDgsKThg+1ymx88d1ZBqMB84V
        gF3mlZEGxDgJ760v8gm0Kw8=
X-Google-Smtp-Source: AK7set/3WMVb9vsAmARpC95V/lR3kXuS87LcY7A3jLWIpRagLQ/bzrQsQQ0EitiZlAxm9lGbxYnTmA==
X-Received: by 2002:ac8:588c:0:b0:3bf:cff2:2c2f with SMTP id t12-20020ac8588c000000b003bfcff22c2fmr39724358qta.44.1680202613609;
        Thu, 30 Mar 2023 11:56:53 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a041200b00746059d9c3fsm80346qkp.35.2023.03.30.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:56:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8E42727C0054;
        Thu, 30 Mar 2023 14:56:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Mar 2023 14:56:52 -0400
X-ME-Sender: <xms:dNslZJy4Yg0KxBAWiVD1zyhH0fwCbTG1z8PTip2AT0vZzr7x6xNLpg>
    <xme:dNslZJTeqiQaHkF8A31SdGBQagWdqvWLny8HztNWbPtTQLHRTTxm0JM3rn_zblDhd
    ZO72xz2s9vtH76hZQ>
X-ME-Received: <xmr:dNslZDUViqCA2miPefZMbz0NqalmJ8jg8Ovx0iruoWM1KLWS4l6LpnWzzA2myA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:dNslZLgRmDHi7er86a7MbP6LlcF4vd-epg4KVaDa-J0OLSbhWaA0fg>
    <xmx:dNslZLCfjt9y_A_oA_wU_rLfl_X1ExzJea78BBXbQ-t8pHvIbKdXDQ>
    <xmx:dNslZEK6WKqFMcJ1oWRWr8_1nULp_K4Mv7QwbysO6r1WIRwv_FXThQ>
    <xmx:dNslZILheVYjgtGe6J6kBn70si5Mm6J86icPY3cb8qBVmjPCVYVnAA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 14:56:51 -0400 (EDT)
Date:   Thu, 30 Mar 2023 11:56:07 -0700
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
Message-ID: <ZCXbR+Pnff6jrstu@boqun-archlinux>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
 <20230330130108.GE124812@hirez.programming.kicks-ass.net>
 <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:47:12AM -0700, Boqun Feng wrote:
> On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:
> > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > 
> > > This is the `struct mutex` lock backend and allows Rust code to use the
> > > kernel mutex idiomatically.
> > 
> > What, if anything, are the plans to support the various lockdep
> > annotations? Idem for the spinlock thing in the other patch I suppose.
> 
> FWIW:
> 
> *	At the init stage, SpinLock and Mutex in Rust use initializers
> 	that are aware of the lockdep, so everything (lockdep_map and
> 	lock_class) is all set up.
> 
> *	At acquire or release time, Rust locks just use ffi to call C
> 	functions that have lockdep annotations in them, so lockdep
> 	should just work.
> 
> In fact, I shared some same worry as you, so I already work on adding
> lockdep selftests for Rust lock APIs, will send them shortly, although
> they are just draft.
> 

Needless to say, the test shows that lockdep works for deadlock
detection (although currently they are only simple cases):

	[...] locking selftest: Selftests for Rust locking APIs
	[...] rust_locking_selftest::SpinLockAATest: 
	[...] 
	[...] ============================================
	[...] WARNING: possible recursive locking detected
	[...] 6.3.0-rc1-00049-gee35790bd43e-dirty #99 Not tainted
	[...] --------------------------------------------
	[...] swapper/0/0 is trying to acquire lock:
	[...] ffffffff8c603e30 (A1){+.+.}-{2:2}, at: _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...] 
	[...] but task is already holding lock:
	[...] ffffffff8c603de0 (A1){+.+.}-{2:2}, at: _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...] 
	[...] other info that might help us debug this:
	[...]  Possible unsafe locking scenario:
	[...] 
	[...]        CPU0
	[...]        ----
	[...]   lock(A1);
	[...]   lock(A1);
	[...] 
	[...]  *** DEADLOCK ***
	[...] 
	[...]  May be due to missing lock nesting notation
	[...] 
	[...] 1 lock held by swapper/0/0:
	[...]  #0: ffffffff8c603de0 (A1){+.+.}-{2:2}, at: _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...] 
	[...] stack backtrace:
	[...] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc1-00049-gee35790bd43e-dirty #99
	[...] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.1-1-1 04/01/2014
	[...] Call Trace:
	[...]  <TASK>
	[...]  dump_stack_lvl+0x6d/0xa0
	[...]  __lock_acquire+0x825/0x2e20
	[...]  ? __lock_acquire+0x626/0x2e20
	[...]  ? prb_read_valid+0x24/0x50
	[...]  ? printk_get_next_message+0xf6/0x380
	[...]  ? _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...]  lock_acquire+0x109/0x2c0
	[...]  ? _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...]  _raw_spin_lock+0x2e/0x40
	[...]  ? _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...]  _RNvXNtNtNtCs1t6xtuX2C8s_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend4lock+0x6/0x10
	[...]  _RNvXCsaDWbe1gW6fC_21rust_locking_selftestNtB2_14SpinLockAATestNtB2_8LockTest4test+0xa5/0xe0
	[...]  ? prb_read_valid+0x24/0x50
	[...]  dotest+0x5a/0x8d0
	[...]  rust_locking_test+0xf8/0x210
	[...]  ? _printk+0x58/0x80
	[...]  ? local_lock_release+0x60/0x60
	[...]  locking_selftest+0x328f/0x32b0
	[...]  start_kernel+0x285/0x420
	[...]  secondary_startup_64_no_verify+0xe1/0xeb
	[...]  </TASK>
	[...]   ok  | lockclass mask: 100, debug_locks: 0, expected: 0

Regards,
Boqun

> Regards,
> Boqun
