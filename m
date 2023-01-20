Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DA675E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjATUAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjATUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:00:01 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85449011;
        Fri, 20 Jan 2023 12:00:00 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j9so4558741qvt.0;
        Fri, 20 Jan 2023 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6X2PZO3BXz50N4+OfonCuuRwxC2bd4Zsuq3HhVpT0A=;
        b=NV9ik0ZnFWwxUVMVEHnCt9jJKCqKIgVvgoY7iwrzIjskVGmx9ZfKLm4JmBgjGYTDcn
         eexiz0aDCIePrAObe19riFUTg6KyNt2umKsyUE7JiJZhAB8hjRNrep1fmEPgNfmGU1R/
         /ySZ//3wQcaCFWvIa6Vc2zxKppqMN4a7B2qxqnhofIDEkfLduvZ3QKqap0j9WK3/EtQI
         gj6Vr96oDTAkYjPwpgXY0NFCntyM1jJIPmqEn0gR4rU+8pIqs5riewfL7RtGm4QUsgEa
         uPZiwLcrEraFVHL9xZMd+FwKM1xfnWQEmyKC+cVkSCIWuSjDT8rqYWl3y2HpB1169pf5
         jZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6X2PZO3BXz50N4+OfonCuuRwxC2bd4Zsuq3HhVpT0A=;
        b=kM8U3TA2RobXecrP/MS6uI358z3ApVB4fYwW/2npM514RY55RR81ocqAQw5TXulZHb
         2gqESD7Xmt3iSYTLLA4Qe3cd7nwyWDzsMurKLtj2Grot/v3AFmO3B8FXnpVcDmJdRTaC
         5o4f60BIJnPvr2BhviG3NtF15eZ3bEQmRd+60X7181kUWR3LDtIOjiornpulTbCDOhwx
         2cQ78FKEgfmU4AoxUxqmrmI3locLimmrumVFYBjBXow5vzdh4n0s1Eed2lHcHL4O4CyA
         IsXWnm+KzBz6REkeMXyp+dXIrnv5YTr4TIGYhhNWSIKI6b0/Pc3EN3YE+lfUCWoV/ysG
         YDTw==
X-Gm-Message-State: AFqh2kq+nBW2wNdFpwUg2yTEx+MoONuBIVUt7j75+f4bXAwlk0mfylwl
        UxHFDTbJPHsqhLaHlci7Nzg=
X-Google-Smtp-Source: AMrXdXsU9J/nLi6df0tnyxZo3wJQ9fcZts+aoyRgmedaJ24/6eRHdv1HNRQTAdOAlGfi5QRgQiId4A==
X-Received: by 2002:a05:6214:4381:b0:535:26a9:782 with SMTP id oh1-20020a056214438100b0053526a90782mr22660905qvb.37.1674244799365;
        Fri, 20 Jan 2023 11:59:59 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b00706bc44fda8sm5236836qkb.79.2023.01.20.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:59:58 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 454DD27C005B;
        Fri, 20 Jan 2023 14:59:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Jan 2023 14:59:58 -0500
X-ME-Sender: <xms:vfLKY3cKS1oAq-m7Ey3EblQAZd1xFFbYle5EnE1PJ4X0lRItmkbjyw>
    <xme:vfLKY9N6BP2mUwH4muGvN_JuvIluMrCgPTh3lc5Lxqr4IEZkJDh6EA2ObkRMKF9Sp
    oLCtyCgLXeqLwhe_Q>
X-ME-Received: <xmr:vfLKYwg2Ju01ew1CJc8NwEnvVsNvxnp7NbywUvd6tPSAswQQlY9mAa6bO7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vfLKY4-dE1L6z9y853Xew7cJ31maAX-thLNMFXLD2IbbojNRPq4snw>
    <xmx:vfLKYztUABBiMV9BQhzSxU7W2GGTt9mfTV9rAZvsCzB3lcxofFktwA>
    <xmx:vfLKY3F7G21Ev1iUX95RJvXrOEjMGfD6vZ_wtYVxAwfxv2a9LXhQGQ>
    <xmx:vfLKY3j7e4xd-vzZCRRUtxhM9UWLqovBYkDmeGv_TwRMSQKD3Td23w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 14:59:56 -0500 (EST)
Date:   Fri, 20 Jan 2023 11:59:29 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Message-ID: <Y8ryoTYIKpYtuqow@boqun-archlinux>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
 <20230119174036.64046-2-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119174036.64046-2-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:40:33PM -0300, Wedson Almeida Filho wrote:
> It was originally called `PointerWrapper`. It is used to convert
> a Rust object to a pointer representation (void *) that can be
> stored on the C side, used, and eventually returned to Rust.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e0b0e953907d..223564f9f0cc 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -16,6 +16,7 @@
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
> +#![feature(generic_associated_types)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>  
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index f0ad4472292d..5475f6163002 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -9,6 +9,60 @@ use core::{
>      ops::{Deref, DerefMut},
>  };
>  
> +/// Used to transfer ownership to and from foreign (non-Rust) languages.
> +///
> +/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
> +/// later may be transferred back to Rust by calling [`Self::from_foreign`].
> +///
> +/// This trait is meant to be used in cases when Rust objects are stored in C objects and
> +/// eventually "freed" back to Rust.
> +pub trait ForeignOwnable {
> +    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
> +    /// [`ForeignOwnable::from_foreign`].
> +    type Borrowed<'a>;
> +
> +    /// Converts a Rust-owned object to a foreign-owned one.
> +    ///
> +    /// The foreign representation is a pointer to void.
> +    fn into_foreign(self) -> *const core::ffi::c_void;
> +
> +    /// Borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> +    /// for this object must have been dropped.
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> +
> +    /// Mutably borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> +        // `into_foreign`.
> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
> +            d.into_foreign();
> +        })

I kinda want to suggest borrow_mut() to be implemented as:

    pub trait ForeignOwnable {
        ...
        unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
            // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
            // `into_foreign`.
            ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
                d.into_foreign();
            })
    }

to avoid funny code as follow:

	let a = Box::new(0).into_foreign();
	// Using an irrelevant `impl ForeignOwnable` to `borrow_mut`
	let borrowed_a: ScopeGuard<Box<i32>, ...> = unsafe { Arc::<u64>::borrow_mut(a) };

but that requires `Self: Sized`. Is it too restrictive?

Regards,
Boqun

> +    }
> +
> +    /// Converts a foreign-owned object back to a Rust-owned one.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> -- 
> 2.34.1
> 
