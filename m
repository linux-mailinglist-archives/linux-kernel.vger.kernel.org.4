Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DDC6A2D25
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBZCWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZCWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:22:45 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A812873;
        Sat, 25 Feb 2023 18:22:42 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id cf14so3375417qtb.10;
        Sat, 25 Feb 2023 18:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQrE3Rb5HqekvcLNvZWizi/c1lsF9sXCQR/gIeGmvaQ=;
        b=dG5RuXfj9bZXM22IpDE9seEcoVjgsZ9QVn+Xkl09ikKwruihev0S76jx2VV6kg0z3G
         VLkIdIJSR7Boews8WOE6PMHhjRm8lXj5V6fPrcmS9SgVt0sK5qOFjOol/PUfYl6DMRcH
         eeeXN5rmMRIF2S4woGrPbu8Iqb/NSKv8XUgWmhWRCGn9wWeGDdxspjnCjHQP6CXwnEcM
         kXiN7BJdUOR5sfHl5lNRSMMmRVhzanFBmlrhRfvhmOx5F7oroY91CT0F8fW838qeyFnZ
         iutknp8v39xnpX5T4uUaFLtqh1XUVTaeEBUnLCBFXanIHnSaR20z1B3EBk8eAhZH0yGe
         qpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQrE3Rb5HqekvcLNvZWizi/c1lsF9sXCQR/gIeGmvaQ=;
        b=VVXCTyFPRBalMMEIQ5ZEVatAkSmzMkCCR1BwhiQwm9hAIleH7z+Y0T4gUPDcR/30g2
         1/UPGg4q5134oAP2tUNGXwTasVs+fp3I2eqol2ml4+Sz7q5Ru1AWAz1Y7qJQHrnXIDBW
         pS7n4l6os8X3H+W/LRCdipi7V5tYpCgdVGW1VYyshOTXzcL+7YWBihvOVZLW/S49Lk6P
         KyXxQIg1UNLtesfhdFeQY6QnDylIrrQ8tEcN8+Kzzu1BQuIoWhHyiY7NLOG7wgnKT2Tp
         wuszMCjYUQSjbzalV7V/8Qgc991NADZkeCerXmRkmriW4IH7iDAlTNDLfEcY90qspAO0
         keWg==
X-Gm-Message-State: AO0yUKVZbIEmc0z6/KLvP91YzLj0YaGom3GkOffHOxYGQn2P9QM/oK5w
        ANXFUULMRnOqvTnO0GKj/vs=
X-Google-Smtp-Source: AK7set9awm+us7IJy7Mt4BX72jK7dpXdkjsvY+lDa/mCNYU2UjWAl7z2bfn9EvWsWnmS2RAKCFx4Vg==
X-Received: by 2002:ac8:5c92:0:b0:3bf:cfa6:8851 with SMTP id r18-20020ac85c92000000b003bfcfa68851mr3900927qta.20.1677378161763;
        Sat, 25 Feb 2023 18:22:41 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i13-20020ac813cd000000b003bfb5fd72a7sm2193055qtj.86.2023.02.25.18.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 18:22:41 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 890F627C005B;
        Sat, 25 Feb 2023 21:22:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Feb 2023 21:22:40 -0500
X-ME-Sender: <xms:b8L6Y2SvdaKp7GJQ0i4G7xCBHDO-kdfyuYhxR0IixjybXbl9dlaxGQ>
    <xme:b8L6Y7yh1ZcbFxEYd2BkZAv44o2yqPN7rh5AjQRUNLt0Kq0Beo0ZQguwfp4rji8Aj
    UwdlvLlOfs_859N0A>
X-ME-Received: <xmr:b8L6Yz0d9a2rJRC2YIzQehDtJssOfUorIFEP_0fJ_bTVJqjpjqvks-1OXx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:b8L6YyCtwWhSpTlO-NvbHGEXsxCqvcLRYi2qBOzYr1sskkChpWIKOQ>
    <xmx:b8L6Y_g6xTH-Plp7Emsgjr7MkIL2dfYf_jEUD_B2rjoHKMzUM1Rd_w>
    <xmx:b8L6Y-qHe1GW4zOhe0A-ROxl3ln_gKfUkeXOgAR6aXwH4ts148rI-A>
    <xmx:cML6Y0Z7UHYyTxhGAhPd3mlOS4GVRIWxF9B9oMcfCkk4Z4_KIwyROQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 21:22:39 -0500 (EST)
Date:   Sat, 25 Feb 2023 18:22:11 -0800
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
Message-ID: <Y/rCU1S+GDgIojNf@boqun-archlinux>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
 <Y/lOlcSpc+d9ytq/@boqun-archlinux>
 <20230225222340.34d749ee.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225222340.34d749ee.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 10:23:40PM +0000, Gary Guo wrote:
> On Fri, 24 Feb 2023 15:56:05 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Fri, Feb 24, 2023 at 05:50:23PM +0900, Asahi Lina wrote:
> > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > 
> > > Add a helper macro to easily return C result codes from a Rust function
> > > that calls functions which return a Result<T>.
> > > 
> > > Lina: Imported from rust-for-linux/rust, originally developed by Wedson
> > > as part of file_operations.rs. Added the allow() flags since there is no
> > > user in the kernel crate yet and fixed a typo in a comment.
> > > 
> > > Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> > > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > ---
> > >  rust/kernel/error.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > > 
> > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > index cf3d089477d2..8a9222595cd1 100644
> > > --- a/rust/kernel/error.rs
> > > +++ b/rust/kernel/error.rs
> > > @@ -226,3 +226,55 @@ pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> > >      }
> > >      Ok(ptr)
> > >  }
> > > +
> > > +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> > > +#[allow(dead_code)]
> > > +pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
> > > +where
> > > +    T: From<i16>,
> > > +{
> > > +    match r {
> > > +        Ok(v) => v,
> > > +        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
> > > +        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
> > > +        // therefore a negative `errno` always fits in an `i16` and will not overflow.
> > > +        Err(e) => T::from(e.to_kernel_errno() as i16),
> > > +    }
> > > +}
> > > +
> > > +/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
> > > +///
> > > +/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
> > > +/// from inside `extern "C"` functions that need to return an integer
> > > +/// error result.
> > > +///
> > > +/// `T` should be convertible from an `i16` via `From<i16>`.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```ignore
> > > +/// # use kernel::from_kernel_result;
> > > +/// # use kernel::bindings;
> > > +/// unsafe extern "C" fn probe_callback(
> > > +///     pdev: *mut bindings::platform_device,
> > > +/// ) -> core::ffi::c_int {
> > > +///     from_kernel_result! {
> > > +///         let ptr = devm_alloc(pdev)?;
> > > +///         bindings::platform_set_drvdata(pdev, ptr);
> > > +///         Ok(0)
> > > +///     }
> > > +/// }
> > > +/// ```
> > > +// TODO: Remove `unused_macros` marker once an in-kernel client is available.
> > > +#[allow(unused_macros)]
> > > +macro_rules! from_kernel_result {  
> > 
> > This actually doesn't need to be a macro, right? The following function
> > version:
> > 
> > 	pub fn from_kernel_result<T, F>(f: F) -> T
> > 	where
> > 	    T: From<i16>,
> > 	    F: FnOnce() -> Result<T>;
> > 
> > is not bad, the above case then can be written as:
> > 
> > 	unsafe extern "C" fn probe_callback(
> > 	    pdev: *mut bindings::platform_device,
> > 	) -> core::ffi::c_int {
> > 	    from_kernel_result(|| {
> > 		let ptr = devm_alloc(pdev)?;
> > 		bindings::platform_set_drvdata(pdev, ptr);
> > 		Ok(0)
> > 	    })
> > 	}
> > 
> > less magical, but the control flow is more clear.
> > 
> > Thoughts?
> 
> I don't think even the closure is necessary? Why not just
> 
>  	pub fn from_kernel_result<T: From<i16>>(r: Result<T>) -> T
> 
> and
> 
>  	unsafe extern "C" fn probe_callback(
>  	    pdev: *mut bindings::platform_device,
>  	) -> core::ffi::c_int {
>  	    from_kernel_result({
>  		let ptr = devm_alloc(pdev)?;

Hmm.. looks like the `?` only "propagating them (the errors) to the
calling *function*":

	https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator

, so this doesn't work as we expect:

	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=64c9039e1da2c436f9f4f5ea46e97e90

Hope I didn't miss something subtle here..

Regards,
Boqun

>  		bindings::platform_set_drvdata(pdev, ptr);
>  		Ok(0)
>  	    })
>  	}
> 
> ?
> 
> Best,
> Gary
