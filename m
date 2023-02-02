Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F76883CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBBQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBBQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:10:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97122112;
        Thu,  2 Feb 2023 08:10:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z5so2348623qtn.8;
        Thu, 02 Feb 2023 08:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UgN8itriCu5k21j1t8HLwNK2BsKs2JF2gFNgZHnX4k=;
        b=B/kOSS+2gaeNzEjq5Xs91kwvAsa3sb9lotmMVoHiUPlrr2mA/NUXV28isrxJlVXA1J
         XmsxKubisR2K5JJ8g/bJ6RCJzXTmEcAAYGXz84F39T8NW3KgywQUQumHQeLgra36qZSU
         KhHcXnD8kFzzRBcUum0LOa/YDVZeBDWeGI4HnzIxIlLQQrnDzV0WlNUk3QCdJY0i6i0u
         eJhSeW4egLc9XBFC06L90GpP/oi/dJ6qxZhLsxHTn/xqSwzK/YgqadUQLdHrttAYP2B0
         2/R7NRcrfXiV9Tfi2x606/jE2MrlXg/b9n0F07WVO5oEyNa4aTY2ZguS7wozVSiQDcRp
         T60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UgN8itriCu5k21j1t8HLwNK2BsKs2JF2gFNgZHnX4k=;
        b=Dsta/zu91ndsbcBcrICm4OGu+LlBdHVVGcEVkW72dv37tq+eYo4Ghr512tlSs3QCOh
         4N3kbXhD0fUAiM+TIEkZNF1AghCGFpkaebDAHVs6b+pJtshXjRmywKa3mm/SVv+phibF
         Ej9jxQjUts+e05fUNDiByscZe2/lc3rGwYF9fIPwHYCI7AWDYM578obwCbGbt812n8vv
         Ro131fDdlbwzjHhD1XcsdKOIDLblBnDzHeE2yJfkjHRfEGLMyHILrR0ircVd9g4HoHB1
         ou1xuhbvZ623pf1/wte7dl8P5vAUUR+pljf0mG3FSPXC5lY/KIYbcD4aeJ/pVfpZZ0r7
         xPew==
X-Gm-Message-State: AO0yUKVrt4/odls35v6tD5/IMEeePooBL12OqbR/0eNq09Qng9Zf84+w
        3abf9OiFW9alBvkSc5PKlyM=
X-Google-Smtp-Source: AK7set9y+6A8orJtX6tMwdAiseAV29K4ZIHGmEwmFqF5mM69HnWKogs6gqjAB2RuzAiN6vj9dID39Q==
X-Received: by 2002:ac8:5ac2:0:b0:3b8:4e37:50ea with SMTP id d2-20020ac85ac2000000b003b84e3750eamr12697897qtd.58.1675354224733;
        Thu, 02 Feb 2023 08:10:24 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b4-20020a378004000000b0070736988c10sm14485459qkd.110.2023.02.02.08.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:10:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4EAF727C005B;
        Thu,  2 Feb 2023 11:10:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 Feb 2023 11:10:23 -0500
X-ME-Sender: <xms:buDbYzDUzyKO_ynT2BM18e0MXgHsIY-gFHWCBb7fzvLNi1vw8jpqoQ>
    <xme:buDbY5iUVg_nqiByHnCCMawpcSdoUnv5NOMHzF8ivV-vgctKTzF64Cc29ulbFs0G2
    ezScJGsHFZ354m3zg>
X-ME-Received: <xmr:buDbY-ks3hRnEBndqqtm-g2KYfCU6RshfrOzaiUWibmYg2Fxa7Oqj6JCU2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:buDbY1zhoThO6r1UvGGJXsc9dSvTkpKrJvEotV1nf6GHT50Efke-qg>
    <xmx:buDbY4RgeVJL9IVVxbxwHwfgb3FHseE1yXuN9C41NKGLcJXrtMoY9g>
    <xmx:buDbY4ZM-xxXRAmmness5k94mzTPBRk9k1d_0Em2DID6p_2GfhV2Ng>
    <xmx:b-DbY8aMtX1pXu3iditc_OysRtBGfKfnZtQNMC6dTYigzVdeKeBM0Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 11:10:22 -0500 (EST)
Date:   Thu, 2 Feb 2023 08:10:19 -0800
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
Message-ID: <Y9vga90K0aVfGUwW@boqun-archlinux>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vZu08L2WaLNJIc@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:41:47PM +0100, Greg KH wrote:
> On Thu, Feb 02, 2023 at 02:21:53PM +0000, Gary Guo wrote:
> > On Thu, 2 Feb 2023 10:14:06 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Feb 01, 2023 at 03:22:41PM -0800, Boqun Feng wrote:
> > > > This allows reading the current count of a refcount in an `ArcInner`.
> > > > 
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > >  rust/helpers.c          | 6 ++++++
> > > >  rust/kernel/sync/arc.rs | 9 +++++++++
> > > >  2 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > > index 09a4d93f9d62..afc5f1a39fef 100644
> > > > --- a/rust/helpers.c
> > > > +++ b/rust/helpers.c
> > > > @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> > > >  
> > > > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > > > +{
> > > > +	return refcount_read(r);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> > > > +
> > > >  /*
> > > >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> > > >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > > > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > > > index fc680a4a795c..fbfceaa3096e 100644
> > > > --- a/rust/kernel/sync/arc.rs
> > > > +++ b/rust/kernel/sync/arc.rs
> > > > @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
> > > >      data: T,
> > > >  }
> > > >  
> > > > +impl<T: ?Sized> ArcInner<T> {
> > > > +    /// Returns the current reference count of [`ArcInner`].
> > > > +    fn count(&self) -> u32 {
> > > > +        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
> > > > +        // normal atomic read (i.e. no data race) only requiring on the address is valid.
> > > > +        unsafe { bindings::refcount_read(self.refcount.get()) }
> > > > +    }
> > > > +}  
> > > 
> > > This is completely unsafe vs concurrency. In order to enable correct
> > > tracing of refcount manipulations we have the __refcount_*(.oldp) API.
> > 
> > Retrieving the reference count is safe. It's just that in many
> > scenarios it's very hard to use the retrieved reference count
> > correctly, because it might be concurrently changed.
> 
> Yes, so you really should never ever ever care about the value, and that
> includes printing it out as it will be wrong the instant you read it.
> 

Agreed.

> > But there are correct ways to use a refcount, e.g. if you own
> > `Arc` and `.count()` returns 1, then you know that you are the
> > exclusive owner of the `Arc` and nobody else is going to touch it.
> 
> But you should never know this, as it is not relevant.
> 
> So no, please don't allow printing out of a reference count, that will
> only cause problems and allow people to think it is safe to do so.
> 

People already do it, even in *security* code,

security/keys/keyring.c:

	int key_link(struct key *keyring, struct key *key)
	{
		...
		kenter("{%d,%d}", keyring->serial, refcount_read(&keyring->usage));
		...
	}

Should we fix that?

Actually It is *safe* to do it, the existence of `ArcInner` proves the
object can not be freed while reading the refcount. This is somewhat
similar to the data_race() macro, we know there is a data race, but we
don't care because of the way that we are going to use the value won't
cause a problem.

What I propose is to print it in debug fmt only, anyway I'm OK to remove
it, but I'm really confused about the reasoning here.

Regards,
Boqun

> Peter is right, please don't do this.
> 
> thanks,
> 
> greg k-h
