Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CB722AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjFEPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjFEPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:20:17 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32E94;
        Mon,  5 Jun 2023 08:20:16 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6261d4ea5f0so36176156d6.0;
        Mon, 05 Jun 2023 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685978415; x=1688570415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUZHRO1zeZz3BCQ/8pluOf6wT+DjiPFE0AyXF7Sk8QI=;
        b=bagez7OVbO4l3te/JVNs9gXj7XHGwru/0VpjsvlPOr1cqcleiKVW00LwqWbHRZuwUX
         /iD5F4TNRVKOOvV2cC3cpKoo0b8JF+Jxn0yc5uPYUe44uHFlXGvulTvSIge3G2mPwz+W
         p1rCkxDI5BVP1+Ay45gBjmAJRPinvgQFRUu44w0dQAZwg7855GEVPsfYsczmeO+5j3uB
         TKlt2jgmrkgozDdPUInuyMcT9CnEJ1btdIBbhN2Sg5VK9GPzWsRl0VLP3x2KkVzYSWv5
         OukdL/HpvOG5RNL/YdVMzfWio4YkFQlkvn7cgC6kbjjDui3c5cjVoDVmprMYnBSF0Z0t
         jPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685978415; x=1688570415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUZHRO1zeZz3BCQ/8pluOf6wT+DjiPFE0AyXF7Sk8QI=;
        b=hcjytGxvT38fXfFET8Sa7aCe52xf+5MsgjH6MTHdnozDdvCjKDFy+H81HW4kdExo7b
         CQIytTfShGU09leJkhR6c+scUuTWbeTqfgttyJve5dwb05ExLDdjZjL9CeW5Lt9cYa8o
         j+prU5MIUBth+/rsmAnHWmm07mdqGApKFPXawC8b4HiJOOnUU2kxPa3EwfqsIilZdaW3
         KZTUsXMtc2LQjQ6rpFtSMGcpQGST9uQedzw4nkpZtPkxkaGItAanITUSTlhRK4pdzya1
         9fSw/Xe5iZDC9CGc7jWaujgOYaS8fkdBtcNMB8bzQDPs+zsrZTxgs9p75p11PrjrNU2p
         2dig==
X-Gm-Message-State: AC+VfDzXx5KFILz4yjiouRN0Ub/6JQbw+XWEfV971IjS+B3unJ54zc5E
        LxmjM9SL3KnlAZrumv2XYzk=
X-Google-Smtp-Source: ACHHUZ7heOWr7/SHZmlRVT4As7YBmKH1/ZkzVV/FdHng7+Z5epyUsK2MTqJm3M6drW1uqq8ZaVHSww==
X-Received: by 2002:a05:6214:528b:b0:623:8bb3:ad5c with SMTP id kj11-20020a056214528b00b006238bb3ad5cmr7944061qvb.1.1685978415308;
        Mon, 05 Jun 2023 08:20:15 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id jy12-20020a0562142b4c00b0062629cbff10sm4632866qvb.114.2023.06.05.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:20:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3CACE27C0054;
        Mon,  5 Jun 2023 11:20:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Jun 2023 11:20:14 -0400
X-ME-Sender: <xms:Lf19ZPfA0XHNL2Ri7Vrk0V1QboshWTx2KrQgHE4hcv4HnmPSn6agCw>
    <xme:Lf19ZFMvV0dj76gLeQAv-IQJjtZ3VLslNINTyg_Wrsc6baVDunOin0KjSCqsVAphr
    pJwYKjHiRYYuXVlvg>
X-ME-Received: <xmr:Lf19ZIgQiEavrF2l8ab1-_C8YwlYO7-hiEJz0XQ1vzpWh6FlnFB463L-CVB5eW8onQ50cddRLZTkN0coK7l5rClM2MyiMh39szA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtlefgveduteeuveekhfejffeutdffleegleeugffgueevhffhfffgtdeh
    fefhfeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhpthhrrdgrshdprhhushhtqd
    hlrghnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Lf19ZA-mDLntwYs4beyzCmfP8uiqR9jH0puGQUh-J3mQR1WpLWTRag>
    <xmx:Lf19ZLvyq3vKqH3tHrgvPdwjxQStXWqfZx-X-CNRrJ1TtkTRhGj2tQ>
    <xmx:Lf19ZPH3lJNKb72LTjLt_FOVZN_j8xTSTJ39TpeZSpEKx6xZu7i_rQ>
    <xmx:Lf19ZLGAey0n6dxvBSOn75cNBLtZ2Iv8SGs69ATiWTPE94rM8EOiyw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 11:20:13 -0400 (EDT)
Date:   Mon, 5 Jun 2023 08:20:11 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 3/8] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <ZH39K83kU2YeCQv1@Boquns-Mac-mini.local>
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-4-aliceryhl@google.com>
 <87v8g61119.fsf@metaspace.dk>
 <20230605153142.28a4093c.gary@garyguo.net>
 <ZH34psABEaq1bHtg@Boquns-Mac-mini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH34psABEaq1bHtg@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:00:57AM -0700, Boqun Feng wrote:
> On Mon, Jun 05, 2023 at 03:31:42PM +0100, Gary Guo wrote:
> > On Fri, 02 Jun 2023 12:51:08 +0200
> > "Andreas Hindborg (Samsung)" <nmi@metaspace.dk> wrote:
> > 
> > > Alice Ryhl <aliceryhl@google.com> writes:
> > > 
> > > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > >
> > > > These methods can be used to turn an `Arc` into a raw pointer and back,
> > > > in a way that preserves the metadata for fat pointers.
> > > >
> > > > This is done using the unstable ptr_metadata feature [1]. However, it
> > > > could also be done using the unstable pointer_byte_offsets feature [2],
> > > > which is likely to have a shorter path to stabilization than
> > > > ptr_metadata.
> > > >
> > > > Link: https://github.com/rust-lang/rust/issues/81513 [1]
> > > > Link: https://github.com/rust-lang/rust/issues/96283 [2]
> > > > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > > > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > > > ---
> > > >  rust/kernel/lib.rs      |  1 +
> > > >  rust/kernel/sync/arc.rs | 42 ++++++++++++++++++++++++++++++++++++++++-
> > > >  2 files changed, 42 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > > index 7ea777b731e6..ad9142928fb1 100644
> > > > --- a/rust/kernel/lib.rs
> > > > +++ b/rust/kernel/lib.rs
> > > > @@ -17,6 +17,7 @@
> > > >  #![feature(const_refs_to_cell)]
> > > >  #![feature(dispatch_from_dyn)]
> > > >  #![feature(new_uninit)]
> > > > +#![feature(ptr_metadata)]
> > > >  #![feature(receiver_trait)]
> > > >  #![feature(unsize)]
> > > >  
> > > > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > > > index a89843cacaad..684be9f73aca 100644
> > > > --- a/rust/kernel/sync/arc.rs
> > > > +++ b/rust/kernel/sync/arc.rs
> > > > @@ -24,7 +24,7 @@
> > > >  };
> > > >  use alloc::boxed::Box;
> > > >  use core::{
> > > > -    alloc::AllocError,
> > > > +    alloc::{AllocError, Layout},
> > > >      fmt,
> > > >      marker::{PhantomData, Unsize},
> > > >      mem::{ManuallyDrop, MaybeUninit},
> > > > @@ -212,6 +212,46 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
> > > >          }
> > > >      }
> > > >  
> > > > +    /// Convert the [`Arc`] into a raw pointer.
> > > > +    ///
> > > > +    /// The raw pointer has ownership of the refcount that this Arc object owned.
> > > > +    pub fn into_raw(self) -> *const T {
> > > > +        let ptr = self.ptr.as_ptr();
> > > > +        core::mem::forget(self);
> > > > +        // SAFETY: The pointer is valid.
> > > > +        unsafe { core::ptr::addr_of!((*ptr).data) }
> > > > +    }
> > > > +
> > > > +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
> > > > +    ///
> > > > +    /// This code relies on the `repr(C)` layout of structs as described in
> > > > +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
> > > > +    /// can only be called once for each previous call to [`Arc::into_raw`].
> > > > +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> > > > +        let refcount_layout = Layout::new::<bindings::refcount_t>();
> > > > +        // SAFETY: The caller guarantees that the pointer is valid.
> > > > +        let val_layout = unsafe { Layout::for_value(&*ptr) };
> > > > +        // SAFETY: We're computing the layout of a real struct that existed when compiling this
> > > > +        // binary, so its layout is not so large that it can trigger arithmetic overflow.
> > > > +        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
> > > > +
> > > > +        // This preserves the metadata in the pointer, if any.
> > > > +        //
> > > > +        // Note that `*const T` and `*const ArcInner<T>` have the same metadata as documented at
> > > > +        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> > > > +        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);  
> > > 
> > > Thanks for updating the comment with the link. I looked into this and I
> > > find that what we are doing here, even though it works, does not feel
> > > right at all. We should be able to do this:
> > > 
> > >         let metadata = core::ptr::metadata(ptr);
> > >         let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
> > >         let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> > > 
> > > but the way `Pointee::Metadata` is defined will not allow this, even
> > > though we know it is valid. I would suggest the following instead:
> > > 
> > >         let metadata = core::ptr::metadata(ptr);
> > >         // Convert <T as Pointee>::Metadata to <ArcInner<T> as
> > >         // Pointee>::Metadata. We know they have identical representation and thus this is OK.
> > >         let metadata: <ArcInner<T> as Pointee>::Metadata = *unsafe {
> > >             &*((&metadata as *const <T as Pointee>::Metadata as *const ())
> > >                 as *const <ArcInner<T> as Pointee>::Metadata)
> > >         };
> > 
> > This could just be a `transmute_copy`.
> > 
> 
> Or just `transmute`:
> 
> 	let metadata = unsafe {
> 		core::mem::transmute<_, <ArcInner<T> as
> 		Pointee>>::Metadata>(metadata)
> 	};
> 
> ? Since `Pointee::Metadata` is `Copy`.
> 
> Regards,
> Boqun
> 
> > >         let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
> > >         let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> > > 
> > > Even though it is a bit more complex, it captures what we are trying to
> > > do better.
> > 
> > I agree this captures the semantics better.
> > 
> 
> I actually wish that we could use `wrapping_byte_offset`[1], and just
> 
> 	// `*const T` and `*const ArcInner<T>` should have the same
> 	// metdata, so convert the pointer type first.
> 	let ptr = ptr as *const ArcInner<T>;
> 
> 	// .. and then adjust the byte offset.
> 	let ptr = ptr.wrapping_byte_offset(-val_offset);
> 
> This may be the opposite direction as Andreas proposed ;-), but the
> result is less code.
> 

(Forget the link to the function)
[1]: https://doc.rust-lang.org/std/primitive.pointer.html#method.wrapping_byte_offset

> Regards,
> Boqun
> 
> > Best,
> > Gary
