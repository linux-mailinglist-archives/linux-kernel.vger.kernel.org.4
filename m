Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1606C3B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCUUGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCUUGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:06:37 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D791BE;
        Tue, 21 Mar 2023 13:06:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g9so10617440qvt.8;
        Tue, 21 Mar 2023 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679429194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+UDFGhD29Q4QGajkdg6XZG5EljYTtzigwRFZgqLDEw=;
        b=NvQRQBFjdDqWOMsPDgwMdxIElTVo/eitAnoLlPKchBb6ZDgaO2l7dUO1STIyAKRISa
         uKbKm7p0TIxXRdnOHNuHG9d2NwUqhjD/ofxbh1hRkYkxfDvKFsa4qqTs798qQFgLrkYA
         w+xkkTP0bXimCajhXKDVAOgA9dLmLUlmUn71MrMZHFfsUpH0pI1opNrDjFDH+k8MYQR8
         LAlaGxzvoNCql0qG7gQY9FW3/pyf5XlOz/tfOio54aoOMdtuJTx8ygMPKFr4/8mZezZV
         unujiS9rEIVIY94RrMzT9N4DAbUQbKq/RmlAXMjf2PKEt9Gtsx2BcuDGmGGPQcbcsQiv
         HThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+UDFGhD29Q4QGajkdg6XZG5EljYTtzigwRFZgqLDEw=;
        b=ENNNY4AoTIz1JuCr8TwN/raq3SboqLWxJvgnEpiAYB31BKR5tzjTECN/qsyP6/jhgD
         GoqBzdv67280N38z61qlHAZctajq8qLsALh3wF/uWkIriDVs7SQPuLHiDkdIfVJ1H1yy
         GOr6b2lNADY4f0MBEodMACRHQ+MqgHkeO70Jo4YW76PId+ejuWXwtRqTREfAalPKvcrQ
         OgerlFb+zOERReIDw4Hc5bus1VkMdcT5XbmSkuh+TBFQ7TuLKc/0wNu12wsWOz8jY3zu
         vNGPxUkAQ3sUBrQNT63hjGwyrE+pOVM7k6i35aZYwg9oNU4cJY1imPbkp4eR7S7WxzQh
         9KqA==
X-Gm-Message-State: AO0yUKXqnoY1uJizN38dXuYwL7xd+KFLoH4ilf3ijJE0Z+xM6OD+U90w
        BNjeoZBgtEGfoX5tCzVQEns=
X-Google-Smtp-Source: AK7set98BOPBmOhKRECVy8ukKPM2PnWRfbBO9l4tLkEW6UHNPe7Fisvr4bfL8+5yyzICmEs8orFiQQ==
X-Received: by 2002:a05:6214:20e9:b0:56e:98a1:fff1 with SMTP id 9-20020a05621420e900b0056e98a1fff1mr1948967qvk.7.1679429194064;
        Tue, 21 Mar 2023 13:06:34 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s80-20020a37a953000000b00741a984943fsm2064570qke.40.2023.03.21.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:06:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 215DB27C005C;
        Tue, 21 Mar 2023 16:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 21 Mar 2023 16:06:33 -0400
X-ME-Sender: <xms:SA4aZL2GQ-ZgWfwYuqq07EJgMYDKtidAQNmVdYnv5HfaKm5Fhq700w>
    <xme:SA4aZKFIABoqr2FKtzDkcAFLHqH9w0AyDzbNu-UPUBPMBj505APD3OkPp0TT-TZR5
    HTKty6z9_3-GCKzcw>
X-ME-Received: <xmr:SA4aZL7qK91sd5NrTRXgRgJ79zOyL0EBLGy6vyS7xqstMe09TqY-NBF-81w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:SA4aZA0TpRBMSDGmMZQDfId7yIoAzGl_L_wf7QL72Ojj4Q37rBtByA>
    <xmx:SA4aZOGOpndl07w8XJL_cUtubgBp8VarLtxFRvOP2skOKfWVF7SV4A>
    <xmx:SA4aZB-Ym-wVZTfLG50NWXKuA9vhQK8GJPlhTo_NNDMDurcTaL7wMg>
    <xmx:SA4aZMb-wlWRoEkIGGBkW8SuSExgygkd6LIsjlfylti6JnvSC90HEA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 16:06:32 -0400 (EDT)
Date:   Tue, 21 Mar 2023 13:06:14 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 4/5] rust: init: add common init-helper functions for
 `Opaque`
Message-ID: <ZBoONi8oMO4X7DWy@boqun-archlinux>
References: <20230321194934.908891-1-y86-dev@protonmail.com>
 <20230321194934.908891-5-y86-dev@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321194934.908891-5-y86-dev@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:50:05PM +0000, Benno Lossin wrote:
> Add helper functions to more easily initialize `Opaque<T>` via FFI.
> These functions take a function pointer to the FFI-initialization
> function and take between 0-4 other arguments. It then returns an
> initializer that uses the FFI function along with the given arguments to
> initialize an `Opaque<T>`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---
>  rust/kernel/init.rs        |  1 +
>  rust/kernel/init/common.rs | 42 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 rust/kernel/init/common.rs
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 895845db6f2b..5b8adb8727b2 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -207,6 +207,7 @@ use core::{
>      ptr,
>  };
> 
> +pub mod common;
>  #[doc(hidden)]
>  pub mod macros;
> 
> diff --git a/rust/kernel/init/common.rs b/rust/kernel/init/common.rs
> new file mode 100644
> index 000000000000..f8c6e9dff786
> --- /dev/null
> +++ b/rust/kernel/init/common.rs
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +//! Module containing common kernel initializer functions.
> +
> +use crate::{
> +    init::{self, PinInit},
> +    types::Opaque,
> +};
> +
> +macro_rules! create_func {
> +    ($name:ident $(, $arg_name:ident: $arg_typ:ident)*) => {
> +        /// Create an initializer using the given initializer function from C.
> +        ///
> +        /// # Safety
> +        ///
> +        /// The given function **must** under all circumstances initialize the memory location to a
> +        /// valid `T`. If it fails to do so it results in UB.
> +        ///
> +        /// If any parameters are given, those need to be valid for the function. Valid means that
> +        /// calling the function with those parameters complies with the above requirement **and**
> +        /// every other requirement on the function itself.
> +        pub unsafe fn $name<T $(, $arg_typ)*>(
> +            init_func: unsafe extern "C" fn(*mut T $(, $arg_name: $arg_typ)*),
> +            $($arg_name: $arg_typ,)*
> +        ) -> impl PinInit<Opaque<T>> {
> +            // SAFETY: The safety contract of this function ensures that `init_func` fully
> +            // initializes `slot`.
> +            unsafe {
> +                init::pin_init_from_closure(move |slot| {
> +                    init_func(Opaque::raw_get(slot) $(, $arg_name)*);
> +                    Ok(())
> +                })
> +            }
> +        }
> +    }
> +}
> +
> +create_func!(ffi_init);
> +create_func!(ffi_init1, arg1: A1);
> +create_func!(ffi_init2, arg1: A1, arg2: A2);
> +create_func!(ffi_init3, arg1: A1, arg2: A2, arg3: A3);
> +create_func!(ffi_init4, arg1: A1, arg2: A2, arg3: A3, arg4: A4);

I wonder whether it's better to make these as methods of Opaque<T>, i.e.
	
	impl<T> Opaque<T> {
	    pub unsafe fn ffi_init(...) -> impl PinInit<Self> {
	    	...
	    }
	    ...
	}

then it's a little more obvious to users that these methods are for
Opaque type pin init.

Thoughts?

Regards,
Boqun

> --
> 2.39.2
> 
> 
