Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085AA6D0E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjC3SsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjC3SsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:48:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C119BB98;
        Thu, 30 Mar 2023 11:47:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h16so12657378qtn.7;
        Thu, 30 Mar 2023 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvdpDaUCX6HrbPh4opBGTooMsJIvWBbLgc7Xy6twBlk=;
        b=FhRla7cGwH9sWjbWyjL6OU0CcYD1tOT2N+dqdJq0ul9s1kkgJaVgeMFTrj6NJM9RMG
         0S8R/IKr3rkT2m/MZSUWa/ZVObCW1KXGx+YoBWX34oIZ7pktBy+MUcyJ4+doEvwPcTPt
         bzemRLPxeTw819NhO+bwdQcmLloT1dIIvntQxIco85Qh53qY6oBThQWu7fEdm2YWWOTW
         Z+HQxAYk1gc/9JObvwIoH5EqX+NX0TjIXtlo5Fri9yWI3pdHRTzZua8qm2StdtXmgb6n
         rpaSxoB0Y5B2c2GJMPVYutQGClWX/7+E59MxRKvdpuVsDzNiRe+CyUpodILmyUk1bARa
         B4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvdpDaUCX6HrbPh4opBGTooMsJIvWBbLgc7Xy6twBlk=;
        b=AOazmfpMNXRU8VOeT7WiAN2wJd+ffbSmJYB3m42neTNNSPJTeiCZw+43o4Xh7I5XPk
         A3xTw1/+jeAX2NuvIrtLcTQDIBpSI5ggEJ2/E9qK7JKaO/+V9v617TXn+I0ZCAwXav6g
         a1nN9EihDqraOeNpeSIr3ND5l8VS+QkUK8BdzPZilTcq/ZPDOI3lqn2k0aRqIx5vjP/r
         3ICzFbwiJw6JlRQaZMSJi9TvF83d5XDLPCiAdxo2p//ds0TJ2Re7u90ou4hvwJ9M7JBS
         8hhTV97e4unhyJsgeL9doGQ94j2WwjmyR0BCpioJhLYOQLFIoHZURIlgPBAX/ACFCnPq
         iJ4w==
X-Gm-Message-State: AAQBX9dc562aEct+pw7byEJR8xOizdmNavUc2zir7w5ID9xT7vE4iLwU
        UNJdgSc/xbOPHH8quM0D3nU=
X-Google-Smtp-Source: AKy350bQ9vde2Z7NmcVtWDGCP5NK1Yk7B1di4IkDu5TuKqLnvPIEtKlm+gJOhiOgn7Ji8T8agH+gdA==
X-Received: by 2002:ac8:5a43:0:b0:3e4:f002:2b6e with SMTP id o3-20020ac85a43000000b003e4f0022b6emr21541492qta.32.1680202078314;
        Thu, 30 Mar 2023 11:47:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j185-20020a37b9c2000000b007469cfebee2sm70350qkf.49.2023.03.30.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:47:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id E17D427C0054;
        Thu, 30 Mar 2023 14:47:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 30 Mar 2023 14:47:56 -0400
X-ME-Sender: <xms:XNklZEobTKc9C6LF70_vM8-Yqa6rayqYB7IVn_71B2PYhz3WL-IA6w>
    <xme:XNklZKo2Gji5TuATAzt7gmgZLm07lc6C2OnSYweqSR6r6ItA3awl06kPiE3HCYDfH
    VgVWD3m75zjLMd9tQ>
X-ME-Received: <xmr:XNklZJNaXjg4-dp3B-6xbGz-tCy-0lc8pddSrtmkOgDrUzDtxpGBNTRQvUPyIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XNklZL4O9AN6YUdmyIDa6Xc0DHASussjKkbQWFgGvs2BtWy-IytBBQ>
    <xmx:XNklZD6_lIsCYK3Pjsj688Nkxi5uAhQSm8BKC1D7Rq5DmPfixhys9g>
    <xmx:XNklZLi9NaRJexGcA0RStybs1gDFJMMWS-P3-hG8bBUPAXRmWXksmQ>
    <xmx:XNklZHiuFlPxQ_-8laJRHfBpUXoos2SSNNTtlN0X3_zjMJiKPKWmyQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 14:47:56 -0400 (EDT)
Date:   Thu, 30 Mar 2023 11:47:12 -0700
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
Message-ID: <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
 <20230330130108.GE124812@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330130108.GE124812@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > This is the `struct mutex` lock backend and allows Rust code to use the
> > kernel mutex idiomatically.
> 
> What, if anything, are the plans to support the various lockdep
> annotations? Idem for the spinlock thing in the other patch I suppose.

FWIW:

*	At the init stage, SpinLock and Mutex in Rust use initializers
	that are aware of the lockdep, so everything (lockdep_map and
	lock_class) is all set up.

*	At acquire or release time, Rust locks just use ffi to call C
	functions that have lockdep annotations in them, so lockdep
	should just work.

In fact, I shared some same worry as you, so I already work on adding
lockdep selftests for Rust lock APIs, will send them shortly, although
they are just draft.

Regards,
Boqun
