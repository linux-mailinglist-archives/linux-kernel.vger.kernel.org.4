Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D06C5FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCWGan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:30:41 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6A1E29D;
        Wed, 22 Mar 2023 23:30:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c10so14298738qtj.10;
        Wed, 22 Mar 2023 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679553039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhAsUoztmuqWCk/RtYU7Y/jxMQ5MJV8LTqU+TgYM9HY=;
        b=hwDGhhlh6syM0F4yaWNb8x1cpO/Jc4yO+gXKVUvY6q3eRVhOeToTLDRFyTxLvYylWE
         6xNKez48OYQ3qfZxVu/hJ0XcPi/OYZNBEnsGUL1C6enfahBISDGHQLY++i5KxWR1/orN
         85e28RzplkD4xs2jZbmeN5M9FcH056ug8Ux6i/eaOkd71Kl/DruZynOoQPoal4QtVhtf
         rIyfhMZwt43j1yK7UyvflW+dm6jN1CCYbKAMeRsvCC8LdZ9ZZ3AUKlbjFpMXCFVnX2a/
         nFBAZHbF49e5M76jyK6R4fpFCSC8Q9puthy9E1jsYgtKB+bev0dxIM3Z9iuAMUO1laYP
         xPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhAsUoztmuqWCk/RtYU7Y/jxMQ5MJV8LTqU+TgYM9HY=;
        b=fYmkuipiEDjuoTGHuqAFBQ0CF/6Mv1Oc0BCibbDrIL6YJgi9MyqLU8dI6h6WUoLnks
         /h41/QlFf2Tbwn9nxyDqy2n6Gf30Ss4+73sI1JXm1KpMTvT+VdunnTCH8xuNUXJKYHzL
         T7FzLhCOX13ddsvPX++roJFfH0SqYyPBm5DTq+ZOHNgfSSGc05jSt2mA40lFD+7AFKJd
         f/W0RmmLIA63y14CPpc8DA7FkB7iBKJlzRskaSTMyB6PmHKfXdy14O4mtTB6mL+XOb5c
         ISLj+6MtCYSyFdZ0zPaVAykpWN+w9tN21A1fw/hH7z/p3TpV3JBjEV9qVEd1Do8Gjsdu
         TdZw==
X-Gm-Message-State: AO0yUKXWJ+VOWSRV35g4Xufle7tZfEHntrGvyvnK5hh7EXeVzdtR7gOl
        8L621OUZEKQ4WiJpvTdI3cY=
X-Google-Smtp-Source: AK7set+0KKR4/NmJEyqFywo22jUgVMyDBi0HZWSJWqGnddEUGYnPWIYZiLAjObxr23aJ7Gi4gO4F8A==
X-Received: by 2002:a05:622a:103:b0:3e1:5060:5c8f with SMTP id u3-20020a05622a010300b003e150605c8fmr10159361qtw.33.1679553039284;
        Wed, 22 Mar 2023 23:30:39 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b0074583bda590sm12668492qkh.10.2023.03.22.23.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 23:30:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1F28A27C0054;
        Thu, 23 Mar 2023 02:30:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Mar 2023 02:30:38 -0400
X-ME-Sender: <xms:DfIbZC9lYqPVL80QXhH3ktDG-LsjzmRrvw1AefDd-LGAl9F864bk2Q>
    <xme:DfIbZCtrF0nvn7Ongo8hKSvsLO-Mb9su-RoLEERyuF5WzooTpo9fbyKUOPnQuYvOx
    OTxsUm4x9zr93mc4A>
X-ME-Received: <xmr:DfIbZICbRTbmpjRkBsbGdpknEeB0G1djOTm76p9OmuprhsEzdnvfx4NYqWaOSwo6ucti6tjifyzakLzo9oMuOBipcVtFs9xnY2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DfIbZKehO0R-rQVDEW-n6rz0ktcrf2wWHI9ifT4SIV5cKMATyfhPSg>
    <xmx:DfIbZHOi17Q9_FlgceWWbdG_BQTZwaOA7weaaMbuNoYw__i2VU7Owg>
    <xmx:DfIbZEkZrrj2REwG5vTHYiXoa_oLrbw2hqTT7dSjy2mg77N89MHFSA>
    <xmx:DfIbZAhkkgDT5lI95X66r3BKKE415vZ6mr-ejrkoH8csde3oO2gOrA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 02:30:37 -0400 (EDT)
Date:   Wed, 22 Mar 2023 23:30:35 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 3/5] rust: add pin-init API
Message-ID: <ZBvyCwPcpTnk2R7h@Boquns-Mac-mini.local>
References: <20230321194934.908891-1-y86-dev@protonmail.com>
 <20230321194934.908891-4-y86-dev@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321194934.908891-4-y86-dev@protonmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:50:00PM +0000, Benno Lossin wrote:
[...]
> +/// # Syntax
> +///
> +/// As already mentioned in the examples above, inside of `pin_init!` a `struct` initializer with
> +/// the following modifications is expected:
> +/// - Fields that you want to initialize in-place have to use `<-` instead of `:`.
> +/// - In front of the initializer you can write `&this in` to have access to a [`NonNull<Self>`]
> +///   pointer named `this` inside of the initializer.
> +///
> +/// For instance:
> +///
> +/// ```rust
> +/// # use kernel::pin_init;
> +/// # use macros::pin_data;
> +/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
> +/// #[pin_data]
> +/// struct Buf {
> +///     ptr: *mut u8,
> +///     buf: [u8; 64],

Say we have an extra field,

           a: u8,

> +///     #[pin]
> +///     pin: PhantomPinned,
> +/// }
> +/// pin_init!(&this in Buf {
> +///     buf: [0; 64],
> +///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },

And I think we want to disallow:

           a: unsafe { (*addr_of!(*this.as_ptr().buf))[0] }

, right? Because we don't want `pin_init!` to provide any initialization
order guarantee? If so, maybe add one or two sentences to call it out.

If not sure, I think we can leave it as it is, until someone really uses
this pattern ;-)

Regards,
Boqun

> +///     pin: PhantomPinned,
> +/// });
> +/// ```
> +///
> +/// [`try_pin_init!`]: kernel::try_pin_init
> +/// [`NonNull<Self>`]: core::ptr::NonNull
> +#[macro_export]
> +macro_rules! pin_init {
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @type_name($t),
> +            @typ($t $(<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error(::core::convert::Infallible),
> +        )
> +    };
> +}
> +
[...]
