Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5D6884D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjBBQwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBBQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:51:59 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8036DFFD;
        Thu,  2 Feb 2023 08:51:58 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h24so2499184qta.12;
        Thu, 02 Feb 2023 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6NUjptHk0fH85aQHPjlgY3CxEXtEbFDu06Q/GWoLvY=;
        b=gm8KEJ8oqSK/U9WtKR1ygOSkG2inMR+ZzHRDvsIRe/xV/uX52TnZG2ywApIxXp3WNU
         xKJKtWNu4kw0UD0wllu2/+ReettyIc1OWIOxR4s75ODZQ471q54gdWfQ8e7FXVaSI3vH
         gGUUErVYZJVZ0amqUuscQ5dm63lrKOGYnONT3QLIZsKfFsEgcjkh/8HGBaKsn10Ba4ut
         mT09FY9Rm1u5K7R7TtGMYH3EljHDNp/QOStU5rGgPqCunGWSCBOJzXNN4bb/VDULlA6T
         BWtpt+LND2p4bM/zdoD6zpeT2CDN/F+cYY/ZSnxID6skIfnax32SGOYfRMkKNRPEeUBJ
         ehSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6NUjptHk0fH85aQHPjlgY3CxEXtEbFDu06Q/GWoLvY=;
        b=tjCD4HMh8bBjveFJthSUh0XGunnKR3jvqH+Zkt5vHrrM6SerOUi7/jDTLqVkACeaUV
         KvwUHfoX6myLpH0hxarpM8jS92WNq0VQXt+usBZcTK9DaucM696HgvUse0r351ofwD20
         UDhMIWLMO60gjOJZkAC/HBISKVL6SlH5wHmPRKFGRGspQyILvfo/QCdhKPqzVcEMT5R9
         J2LMJlJgqDt5cWlsY3KiI2DI59mwrITHHbnMCGmHZKHYnbwaoBVgz6aj1yWCkDSXTul1
         4Z98BqNN4uHcPzINHJKmcaQCVARAN26kQZiLIZDoPN2wRLHdiuds9tAd2vin5pDjH5UT
         OhWQ==
X-Gm-Message-State: AO0yUKUQhmqfKSYETHoLAqM40HeoZpJuDynYY7opXSTgbhUj7TWg7+2N
        uXgrMFx3sJK5rkKqTOHeIMM=
X-Google-Smtp-Source: AK7set870+xc59VzNjqpnfgpqgo1//KsoMpihKZROOK9ktLKkhiWT5O/F+QUwmB7MeKFFPv7oHVNqQ==
X-Received: by 2002:a05:622a:189f:b0:3b8:6ae9:b107 with SMTP id v31-20020a05622a189f00b003b86ae9b107mr13064658qtc.17.1675356717316;
        Thu, 02 Feb 2023 08:51:57 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l11-20020a05620a28cb00b007259807a512sm83143qkp.12.2023.02.02.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:51:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id D38DB27C0054;
        Thu,  2 Feb 2023 11:51:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 Feb 2023 11:51:55 -0500
X-ME-Sender: <xms:K-rbY2U7HbDyqtPmr33SboMYQfcV3N-9lZZIpxaDEA-RmiyV70QkGw>
    <xme:K-rbYykk4d7z3YeFKP7mPYLOuUUwyaeHnDhJKJInFooD_dUrlokPgUH2LxkjOsuJs
    A0_WXc5e-8SHUDcsQ>
X-ME-Received: <xmr:K-rbY6aThQd4Atpsh20GRVYrYzsEBxRNnJRV3oHDwLGAqbXfm4F49jFnhvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:K-rbY9Vtcow9wCprHEiZXbVIbnU7Ln_mSXi55v6a_tfnWykiLhGEBA>
    <xmx:K-rbYwnmBc61Mr48hIa7BcLpCqLu9Z_ReXvgJPvRAWVV2TR1l07l0w>
    <xmx:K-rbYyekYWRob3ZpLTzzLbPoTMHbt8ltLDNTM1bmEmqytR2mc8vdKg>
    <xmx:K-rbY6cOVYAttjiRmpIcFos2tMh6z9xxewLIhim4pBefqv1cwo8DZA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 11:51:54 -0500 (EST)
Date:   Thu, 2 Feb 2023 08:51:51 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gary Guo <gary@garyguo.net>, Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9viM2POUsSnbKUh@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 05:17:55PM +0100, Greg KH wrote:
[...]
> > > > But there are correct ways to use a refcount, e.g. if you own
> > > > `Arc` and `.count()` returns 1, then you know that you are the
> > > > exclusive owner of the `Arc` and nobody else is going to touch it.
> > > 
> > > But you should never know this, as it is not relevant.
> > > 
> > > So no, please don't allow printing out of a reference count, that will
> > > only cause problems and allow people to think it is safe to do so.
> > > 
> > 
> > People already do it, even in *security* code,
> > 
> > security/keys/keyring.c:
> > 
> > 	int key_link(struct key *keyring, struct key *key)
> > 	{
> > 		...
> > 		kenter("{%d,%d}", keyring->serial, refcount_read(&keyring->usage));
> > 		...
> > 	}
> > 
> > Should we fix that?
> 
> Yes.  But really, that's debugging code, it probably should all be
> removed now.
> 

Well, there are also printings in proc_keys_show() and
proc_key_users_show() in security/keys/proc.c, and I think it's hard to
remove these since they are userspace related.

Anyway I realise I could have done a better job explaining what I'm
doing here:

I want to read refcount in a later patch, which make Arc<T> implement
Debug trait/interface, and that allows user to print Arc<T> for debug
purposes, e.g.

	pr_info!("{:#x?}", a); // a is an "Arc<T">

that's the only usage of the reading from refcount. I could open code an
FFI call in that implementation, but I thought maybe I could add a
helper function, hence the "count" function. And since "count" is a
private function, so no one can use it outside this
rust/kernel/sync/arc.rs file, therefore mis-usage by outsiders are
impossible.

Maybe I made things confusing because I just learned the language and
wanted to try out a few things which made things complicated (for
review), hope the above explanation undo some of the confusion I
created.

As I said, I'm open to remove the printing of the refcount, and if you
and Peter think maybe it's OK to do that after the explanation above,
I will improve the patch to make things clear ;-)

Regards,
Boqun

> thanks,
> 
> greg k-h
