Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24AB6A3365
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBZSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBZSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:17:09 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80158FF10;
        Sun, 26 Feb 2023 10:17:06 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c3so248846qtc.8;
        Sun, 26 Feb 2023 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxTc3RYjx8Z6j1Ud65V9EMwg2hzF0dyvk+bnE0WctnY=;
        b=gkRVFmZKo/2uiw/LHVqI6QfMX2/cL6pXmY/lyDjRopJFWwBdDsEiLzqNEbrfUPedCG
         4znjI+8JDm/Usjlb/kDjE8KBKYuP819aBn1TxzhrLSah9LBAmGYZVkyWy8kYF/wacZlA
         uA8XTCJ1RARBREkcp9Q+YDjppLRTrWBKIWCaaqzw0L4JHj0rARe40Ww9OAaxmMcadQIA
         vE/YpwzThwjYzQ7NXBsGkE5Py7uAbsalo4CSkSX2iHAgWFfcYE9qAq+NUTI51RtVvKkc
         LYN2pbY92DqlCQcFKyRo2y3FXKmdAhlee79K6a9N2bnr4IOEGS0TEr9uNlVSLw0NYzqx
         om+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxTc3RYjx8Z6j1Ud65V9EMwg2hzF0dyvk+bnE0WctnY=;
        b=y3mEMhFi6Z+tLeuYbj/CZR6yzWbmkqnTeDQE3dRo7mKE7QUyOuR/9Lq+bpFQOb81vr
         fVU2v+4bOGDh9CSU/HwOuepajeR0B36ty13mQps/uujLgQ9gYF8jCg1v0zUkUJgctVrH
         HlRyZBP0m3iTezmAYR3DVAPEmm6QKAEW6gON4ynAzocapql66g2eYD9x4mpoqsj08NvA
         41ZhQHRVe80cCM+pId/8IoTnvEx7JzwjBqpPVfdlCitIzE2wf8WUEaWHgOpgfVVui7ax
         CYJjTNfyMaPO/UmqitHQdlQ8LOmBxpuBSxwDKUu5BhlqcmJ5e8SeCJGKJIfQ019T2UZD
         6dLQ==
X-Gm-Message-State: AO0yUKVqTE3kOvgdP7FNjFZCcVZhgg74wpASOO49cfkJl5py5lfTnWvT
        LrjsyI5u1cSZEVKFgdCLFXo=
X-Google-Smtp-Source: AK7set+alyjI6amc+2ubZu1BL2Rz4veyv2vVY8UnIxbvFjxrTEy7GQ3JlpfQv/b3GOWhtOKFcsZySg==
X-Received: by 2002:ac8:5cc6:0:b0:3b9:bc8c:c1f6 with SMTP id s6-20020ac85cc6000000b003b9bc8cc1f6mr12043316qta.1.1677435425574;
        Sun, 26 Feb 2023 10:17:05 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a15d600b0074235386738sm3404007qkm.37.2023.02.26.10.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 10:17:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id A01FE27C0054;
        Sun, 26 Feb 2023 13:17:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 26 Feb 2023 13:17:04 -0500
X-ME-Sender: <xms:H6L7Y5bSq1DkIEcnWZbfRQUbn37G1Rx4eANoTiKaAiOkl_ryI5NdyA>
    <xme:H6L7YwaKmTa7oKdKVxjHgjvg_rSDozSezAG5MXfz8FwK1RQ5dIVKvWKkqWRu7NW4P
    KGdeW9JWXwXSLqRcg>
X-ME-Received: <xmr:H6L7Y7-ASZoOBlyvPGQ7rOmgHFmdYotn-Kx5Hn1L0jlrsvB60ge7PAg9-WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:H6L7Y3rX7lFA087B6SffnCDnHhXfe7d2L1ldVg2a7-p9jkVfWQCz5A>
    <xmx:H6L7Y0ofBSVAOmY5ejvO8wBvl_eV2G0wlk1hu_euCbpzezCZiLqe2Q>
    <xmx:H6L7Y9RqaeJMVH09fZKijateLwZrdJpByon1nUznxjC1rItOtYAS5w>
    <xmx:IKL7YxgYeu7He99Dm3w80G7vsHjTnDgNllxRMCzqQn7B7Ms6tpIseQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 13:17:03 -0500 (EST)
Date:   Sun, 26 Feb 2023 10:16:33 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
Message-ID: <Y/uiAfZnfbbMrQuD@boqun-archlinux>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
 <Y/lOlcSpc+d9ytq/@boqun-archlinux>
 <20230225222340.34d749ee.gary@garyguo.net>
 <Y/rCU1S+GDgIojNf@boqun-archlinux>
 <20230226133606.583cd1d8.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226133606.583cd1d8.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 01:36:06PM +0000, Gary Guo wrote:
> On Sat, 25 Feb 2023 18:22:11 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Sat, Feb 25, 2023 at 10:23:40PM +0000, Gary Guo wrote:
> > > On Fri, 24 Feb 2023 15:56:05 -0800
> > > Boqun Feng <boqun.feng@gmail.com> wrote:
> > >   
> > > > On Fri, Feb 24, 2023 at 05:50:23PM +0900, Asahi Lina wrote:  
> > > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > 
> > > > > Add a helper macro to easily return C result codes from a Rust function
> > > > > that calls functions which return a Result<T>.
> > > > > 
> > > > > Lina: Imported from rust-for-linux/rust, originally developed by Wedson
> > > > > as part of file_operations.rs. Added the allow() flags since there is no
> > > > > user in the kernel crate yet and fixed a typo in a comment.
> > > > > 
> > > > > Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> > > > > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > > > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > > > ---
> > > > >  rust/kernel/error.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 52 insertions(+)
> > > > > 
> > > > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > > > index cf3d089477d2..8a9222595cd1 100644
> > > > > --- a/rust/kernel/error.rs
> > > > > +++ b/rust/kernel/error.rs
> > > > > @@ -226,3 +226,55 @@ pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> > > > >      }
> > > > >      Ok(ptr)
> > > > >  }
> > > > > +
> > > > > +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> > > > > +#[allow(dead_code)]
> > > > > +pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
> > > > > +where
> > > > > +    T: From<i16>,
> > > > > +{
> > > > > +    match r {
> > > > > +        Ok(v) => v,
> > > > > +        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
> > > > > +        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
> > > > > +        // therefore a negative `errno` always fits in an `i16` and will not overflow.
> > > > > +        Err(e) => T::from(e.to_kernel_errno() as i16),
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
> > > > > +///
> > > > > +/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
> > > > > +/// from inside `extern "C"` functions that need to return an integer
> > > > > +/// error result.
> > > > > +///
> > > > > +/// `T` should be convertible from an `i16` via `From<i16>`.
> > > > > +///
> > > > > +/// # Examples
> > > > > +///
> > > > > +/// ```ignore
> > > > > +/// # use kernel::from_kernel_result;
> > > > > +/// # use kernel::bindings;
> > > > > +/// unsafe extern "C" fn probe_callback(
> > > > > +///     pdev: *mut bindings::platform_device,
> > > > > +/// ) -> core::ffi::c_int {
> > > > > +///     from_kernel_result! {
> > > > > +///         let ptr = devm_alloc(pdev)?;
> > > > > +///         bindings::platform_set_drvdata(pdev, ptr);
> > > > > +///         Ok(0)
> > > > > +///     }
> > > > > +/// }
> > > > > +/// ```
> > > > > +// TODO: Remove `unused_macros` marker once an in-kernel client is available.
> > > > > +#[allow(unused_macros)]
> > > > > +macro_rules! from_kernel_result {    
> > > > 
> > > > This actually doesn't need to be a macro, right? The following function
> > > > version:
> > > > 
> > > > 	pub fn from_kernel_result<T, F>(f: F) -> T
> > > > 	where
> > > > 	    T: From<i16>,
> > > > 	    F: FnOnce() -> Result<T>;
> > > > 
> > > > is not bad, the above case then can be written as:
> > > > 
> > > > 	unsafe extern "C" fn probe_callback(
> > > > 	    pdev: *mut bindings::platform_device,
> > > > 	) -> core::ffi::c_int {
> > > > 	    from_kernel_result(|| {
> > > > 		let ptr = devm_alloc(pdev)?;
> > > > 		bindings::platform_set_drvdata(pdev, ptr);
> > > > 		Ok(0)
> > > > 	    })
> > > > 	}
> > > > 
> > > > less magical, but the control flow is more clear.
> > > > 
> > > > Thoughts?  
> > > 
> > > I don't think even the closure is necessary? Why not just
> > > 
> > >  	pub fn from_kernel_result<T: From<i16>>(r: Result<T>) -> T
> > > 
> > > and
> > > 
> > >  	unsafe extern "C" fn probe_callback(
> > >  	    pdev: *mut bindings::platform_device,
> > >  	) -> core::ffi::c_int {
> > >  	    from_kernel_result({
> > >  		let ptr = devm_alloc(pdev)?;  
> > 
> > Hmm.. looks like the `?` only "propagating them (the errors) to the
> > calling *function*":
> > 
> > 	https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator
> > 
> > , so this doesn't work as we expect:
> > 
> > 	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=64c9039e1da2c436f9f4f5ea46e97e90
> 
> Oh, you're absolutely right, I guess I shouldn't be doing code review
> in the middle of the night...
> 

;-)

> However, if we have the try blocks then we should be able to just
> rewrite it as
> 
> 	from_kernel_result(try {
> 	    ...
> 	})
> 

Thank you and Miguel for the references on try blocks, I vaguely
remember I heard of them, but never take a close look.

> I guess in this sense it might worth keeping this as a macro so we can
> tweak the implementation from closure to try blocks without having to
> edit all use sites?
> 

My preference to function instead of macro here is because I want to
avoid the extra level of abstraction and make things explict, so that
users and reviewers can understand the API behavior solely based on
Rust's types, functions and closures: they are simpler than macros, at
least to me ;-)

Speak of future changes in the implementation:

First, I think the macro version here is just a poor-man's try block, in
other words, I'd expect explicit use of try blocks intead of
`from_kernel_result` when the feature is ready. If that's the case, we
need to change the use sites anyway.

Second, I think the semantics is a little different between try block
implementation and closure implemention? Consider the following case:

	// the outer function return a Result<i32>

	let a = from_kernel_result!({
		...
		return Some(0); // x is i32
		..
	});

	return Some(a + 1);

Do both implementation share the same behavior?

No one can predict the future, but being simple at the beginning sounds
a good strategy to me.

Regards,
Boqun

> Best,
> Gary
