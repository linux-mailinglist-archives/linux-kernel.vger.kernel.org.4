Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15654687F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjBBNrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBBNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:47:00 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7258CA8D;
        Thu,  2 Feb 2023 05:46:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s4so1809567qtx.6;
        Thu, 02 Feb 2023 05:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo+SEOezsbE8/zRzmM/AGT3mfXlrDoWt6YuGQwoJR3M=;
        b=XqKkdJHlHGLfyg9SnNj2JFbMHu7vrI/I49ind7XZA4hfOY0CqirSgDjEo5czcAIOB/
         zU5XC0P/VJzc4+8Dmywg8DaLgoz0tyjtOSaaP8crOb7gLikuCS6/0kquLC4ITMA9wEV/
         PU5Nxkb2U/Vq1qcWWhyFtJ0sa8wvxqz8qEeT08gMXgT6C1XNprb/1XabNdPUKb09P+2+
         RcTch8gpCsc2W8DYb4OrdX6EGxDDD5v94CU7PuRtI/vtB1lYLRsQEVmIUGaqzM13YjK3
         agJgpcqbF+sUt9TjR8jWJ1JoRZQEamsoNtJXNFSjrS4hJ0ViMf1aqM3Y8TFkJlkWa2c+
         iUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mo+SEOezsbE8/zRzmM/AGT3mfXlrDoWt6YuGQwoJR3M=;
        b=MVpbUcnaZBKTCyy0KusSEZalzJS4AYi6UHZ1qOWRFUumd3EN06kHpwf/xM3bX7cs3Q
         K4RgYCiv8ZGnqx3kEQ8IWziZ1LwtRW7kf3VkQZZNkxk300rwUm/SnExVaVzIoCj976e+
         HSWUY05y66ct59Bl06jffIrCy+sWhEI6bm8DeMqUTeiidY9IhBPffMrP5VKlhkm3EsBz
         dPkK7bAO7eVXPs67TtysPO1TOXsHBhzxG4p4PBk4tulw7uSU9KmuLEom8dJF/3SAmDnc
         OU+t6gH6yhPEZw251dHinuU29OyCS++nycpKUJTwDCowZdA8m5wj1gtFaGHWhb8AsL0Q
         PT8w==
X-Gm-Message-State: AO0yUKWFsghT0yokWPZhjiamYRw3bsP+mPUJV8uEHcZIE+CY8iN3Dd8z
        kHi7/J3T3Yyt1bBpcMOz+UlC4tHcX9w=
X-Google-Smtp-Source: AK7set8bCDl1Lc9j2OYYsK0ZMgOMt4ECR64zRzNZqXOvN9enP6yDY70UN6A3NP9uXen54Cn1ciwiUw==
X-Received: by 2002:ac8:5990:0:b0:3b8:ea9b:cbc6 with SMTP id e16-20020ac85990000000b003b8ea9bcbc6mr11562756qte.56.1675345618354;
        Thu, 02 Feb 2023 05:46:58 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b6-20020a37b206000000b00718e853f83csm12521424qkf.106.2023.02.02.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:46:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1567F27C0054;
        Thu,  2 Feb 2023 08:46:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Feb 2023 08:46:57 -0500
X-ME-Sender: <xms:0L7bY_0HR80RaC1z1-fABJoCy4sgCGlAzffuD55QaJdkBSb7QJRszQ>
    <xme:0L7bY-HQnUPPPxYiWHQuJ5ObT7KrAKoTQQm9ViIk4xaplDBSD8YhcntCGull_8Ue_
    qKd5PDkWey9-e2a8Q>
X-ME-Received: <xmr:0L7bY_5tqDiibT87ZyeQhyBliKv0QwQglxQFyLeTsxwdNrrvi11VTYRO5gmXHdOMlpUTjlzDXKBinHUkwzR1dWT8eUo_-vTvX-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0L7bY011lGHLmkv8OdiLSeyDTA3QHDUgVPYdNz0W818TvLJ0dfQdZA>
    <xmx:0L7bYyHk2BKxc2_o21UFdeZpJZe0ahA4AEfDd01jMmNhSyCNAO3JEQ>
    <xmx:0L7bY19koVAFAEzxhm2BQWt3DQq6IgbKJGEbizV4NLBGVZsRCBaXvw>
    <xmx:0L7bY6_ANMp8HOSwvcHxTkDfdi9Km5A8Hg3Jt7HWQOQLVaslvG_Opg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 08:46:55 -0500 (EST)
Date:   Thu, 2 Feb 2023 05:46:53 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9u+zbyD8xvphNzb@Boquns-Mac-mini.local>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:14:06AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 01, 2023 at 03:22:41PM -0800, Boqun Feng wrote:
> > This allows reading the current count of a refcount in an `ArcInner`.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/helpers.c          | 6 ++++++
> >  rust/kernel/sync/arc.rs | 9 +++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 09a4d93f9d62..afc5f1a39fef 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> >  
> > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > +{
> > +	return refcount_read(r);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> > +
> >  /*
> >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index fc680a4a795c..fbfceaa3096e 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
> >      data: T,
> >  }
> >  
> > +impl<T: ?Sized> ArcInner<T> {
> > +    /// Returns the current reference count of [`ArcInner`].
> > +    fn count(&self) -> u32 {
> > +        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
> > +        // normal atomic read (i.e. no data race) only requiring on the address is valid.
> > +        unsafe { bindings::refcount_read(self.refcount.get()) }
> > +    }
> > +}
> 
> This is completely unsafe vs concurrency. In order to enable correct
> tracing of refcount manipulations we have the __refcount_*(.oldp) API.
> 

Interesting.

> Admittedly, I have no idea how to sanely wire that up in this thing, but
> it seems odd to me to have this 'safe' language display fundamentally
> unsafe data like this.

Right now the only use of this "data" is for debugging display, the
"count" function is private, so no one outside Arc can mis-use it, in
that sense, I think it's still safe?

Regards,
Boqun
