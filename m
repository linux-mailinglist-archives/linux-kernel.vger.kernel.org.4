Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D9722A19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjFEPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFEPBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:01:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0209A7;
        Mon,  5 Jun 2023 08:00:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f6c0d651adso54364971cf.2;
        Mon, 05 Jun 2023 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685977259; x=1688569259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6J/yjWn5Jx7TWYuGywXaTRRE0NrX4LCzm3f27TL3Zk=;
        b=k9LRbkp6+BF+kTf2BYBGdaGjvnI0KFHGdoKBkA4b6tU4VkdpdcyvO+R93ysEEZbqPo
         +WlVRkqjW9/xo4cX2nh7pQgy+A1B7wNOZhxVCE2UeNg2HkFolFUKRZtdLTKa/kE8pidO
         +BCHx9nhHkL2sRoLy68U/60+S9DhGxIH0cCl94WNEkJxgLko3n+gp6EQcQ9kCTGQKBU2
         RY2Y3oPht0CwQkm/gqa3hN+3HO+6pWjfZR8wLdEGKv2GK7vhPPux2v/5cV5cEW2efHwY
         YyE7oNWc+AEbaMxF/hE8yK7LBTCw+KLmcFc3DH969L6zOG6C6Vx4nGEKjqVLJUoIC+5A
         0NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685977259; x=1688569259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6J/yjWn5Jx7TWYuGywXaTRRE0NrX4LCzm3f27TL3Zk=;
        b=Ypzx5r3OLcB2ZzH9+X+Ndr5p44OqcCs5WkS9AdGOWu8y5JBzvThcUiRI49HlkZTHGJ
         F4PeZOyWsn425SOebueWPY4mQl0S/qGJL3ki/9b62eF7sXy/YRTMqAzWwJ22MBDCybAA
         K2lCwnQqqKXcXpwHq4XqFT+4llKUYNkNmDjiC+8PT0L5xJUQUUq121+GtnwjSiiU/iZR
         SjXbzxSXHks/6SPzA1Og4ux5KlrKIrsZ6npkpkm1H1mwcS8hMa90GFy8D7jrBhqdxut8
         U1Ltmhn01dDpcA5jqJBs2yrbqII8WNxB5itGivwsTV37vlI4P80EaeIMPL6q1EDJkYLS
         E7QA==
X-Gm-Message-State: AC+VfDxGfayrKlucl2TVQiONK6uXhmw99GNtG2luLS3lv2kp3ssBL3g7
        K0eurLgMxkUBrBvrTZVK3fM=
X-Google-Smtp-Source: ACHHUZ5UEPAT+5gQuE+gaNtKOYBAdlulwwrIwlKs7O8jKJwH7qhfcwgiBgRNKivV4l8NZEDRMdjWaw==
X-Received: by 2002:ac8:584d:0:b0:3ef:2649:44ae with SMTP id h13-20020ac8584d000000b003ef264944aemr8384459qth.13.1685977258711;
        Mon, 05 Jun 2023 08:00:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id gd9-20020a05622a5c0900b003f9aacedb6csm373210qtb.76.2023.06.05.08.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:00:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 86AB827C005A;
        Mon,  5 Jun 2023 11:00:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Jun 2023 11:00:57 -0400
X-ME-Sender: <xms:qPh9ZPKEa7U9LoGlLrYUF5PI1sgM_BbDaDJb3XJ8wMFxw0bys0T6xQ>
    <xme:qPh9ZDIjR4sVh4kj_RB3GZ2DXWbr1fb3p7MkX3_LkdR2Ayhdna24Tkc5o5Sk7764E
    RkXBenovEi1zoM25g>
X-ME-Received: <xmr:qPh9ZHtAYfx9ZMbb6FPqRTPVJPHM9zXb80WyyhHL5MA_o5iTDhdjr14Csm7S6hrACoW22sQAMhyYWQG2xOfV0ObcE6amUEggMDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgkeegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:qPh9ZIZinjVPx3w-4U38Opq-uLaz74KMkk-oP0J4BqwJ8GZ-fNEpYw>
    <xmx:qPh9ZGYbwGTDfR3HnqVcQsj17pQHFqK5vtGJR0c5KLpODEYRJu9wlw>
    <xmx:qPh9ZMDqV7Vt_qQpx44_JXZNyfkKfVzihq_dgw1JvCos_vVvA5X72Q>
    <xmx:qfh9ZMx1ZJ-3vlcStN8yy2SEh8W41IrlNotYe36WmafBpMSuzhRKlw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 11:00:56 -0400 (EDT)
Date:   Mon, 5 Jun 2023 08:00:54 -0700
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
Message-ID: <ZH34psABEaq1bHtg@Boquns-Mac-mini.local>
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-4-aliceryhl@google.com>
 <87v8g61119.fsf@metaspace.dk>
 <20230605153142.28a4093c.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605153142.28a4093c.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:31:42PM +0100, Gary Guo wrote:
> On Fri, 02 Jun 2023 12:51:08 +0200
> "Andreas Hindborg (Samsung)" <nmi@metaspace.dk> wrote:
> 
> > Alice Ryhl <aliceryhl@google.com> writes:
> > 
> > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > >
> > > These methods can be used to turn an `Arc` into a raw pointer and back,
> > > in a way that preserves the metadata for fat pointers.
> > >
> > > This is done using the unstable ptr_metadata feature [1]. However, it
> > > could also be done using the unstable pointer_byte_offsets feature [2],
> > > which is likely to have a shorter path to stabilization than
> > > ptr_metadata.
> > >
> > > Link: https://github.com/rust-lang/rust/issues/81513 [1]
> > > Link: https://github.com/rust-lang/rust/issues/96283 [2]
> > > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > > ---
> > >  rust/kernel/lib.rs      |  1 +
> > >  rust/kernel/sync/arc.rs | 42 ++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 42 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index 7ea777b731e6..ad9142928fb1 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -17,6 +17,7 @@
> > >  #![feature(const_refs_to_cell)]
> > >  #![feature(dispatch_from_dyn)]
> > >  #![feature(new_uninit)]
> > > +#![feature(ptr_metadata)]
> > >  #![feature(receiver_trait)]
> > >  #![feature(unsize)]
> > >  
> > > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > > index a89843cacaad..684be9f73aca 100644
> > > --- a/rust/kernel/sync/arc.rs
> > > +++ b/rust/kernel/sync/arc.rs
> > > @@ -24,7 +24,7 @@
> > >  };
> > >  use alloc::boxed::Box;
> > >  use core::{
> > > -    alloc::AllocError,
> > > +    alloc::{AllocError, Layout},
> > >      fmt,
> > >      marker::{PhantomData, Unsize},
> > >      mem::{ManuallyDrop, MaybeUninit},
> > > @@ -212,6 +212,46 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
> > >          }
> > >      }
> > >  
> > > +    /// Convert the [`Arc`] into a raw pointer.
> > > +    ///
> > > +    /// The raw pointer has ownership of the refcount that this Arc object owned.
> > > +    pub fn into_raw(self) -> *const T {
> > > +        let ptr = self.ptr.as_ptr();
> > > +        core::mem::forget(self);
> > > +        // SAFETY: The pointer is valid.
> > > +        unsafe { core::ptr::addr_of!((*ptr).data) }
> > > +    }
> > > +
> > > +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
> > > +    ///
> > > +    /// This code relies on the `repr(C)` layout of structs as described in
> > > +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
> > > +    /// can only be called once for each previous call to [`Arc::into_raw`].
> > > +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> > > +        let refcount_layout = Layout::new::<bindings::refcount_t>();
> > > +        // SAFETY: The caller guarantees that the pointer is valid.
> > > +        let val_layout = unsafe { Layout::for_value(&*ptr) };
> > > +        // SAFETY: We're computing the layout of a real struct that existed when compiling this
> > > +        // binary, so its layout is not so large that it can trigger arithmetic overflow.
> > > +        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
> > > +
> > > +        // This preserves the metadata in the pointer, if any.
> > > +        //
> > > +        // Note that `*const T` and `*const ArcInner<T>` have the same metadata as documented at
> > > +        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> > > +        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);  
> > 
> > Thanks for updating the comment with the link. I looked into this and I
> > find that what we are doing here, even though it works, does not feel
> > right at all. We should be able to do this:
> > 
> >         let metadata = core::ptr::metadata(ptr);
> >         let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
> >         let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> > 
> > but the way `Pointee::Metadata` is defined will not allow this, even
> > though we know it is valid. I would suggest the following instead:
> > 
> >         let metadata = core::ptr::metadata(ptr);
> >         // Convert <T as Pointee>::Metadata to <ArcInner<T> as
> >         // Pointee>::Metadata. We know they have identical representation and thus this is OK.
> >         let metadata: <ArcInner<T> as Pointee>::Metadata = *unsafe {
> >             &*((&metadata as *const <T as Pointee>::Metadata as *const ())
> >                 as *const <ArcInner<T> as Pointee>::Metadata)
> >         };
> 
> This could just be a `transmute_copy`.
> 

Or just `transmute`:

	let metadata = unsafe {
		core::mem::transmute<_, <ArcInner<T> as
		Pointee>>::Metadata>(metadata)
	};

? Since `Pointee::Metadata` is `Copy`.

Regards,
Boqun

> >         let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
> >         let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> > 
> > Even though it is a bit more complex, it captures what we are trying to
> > do better.
> 
> I agree this captures the semantics better.
> 

I actually wish that we could use `wrapping_byte_offset`[1], and just

	// `*const T` and `*const ArcInner<T>` should have the same
	// metdata, so convert the pointer type first.
	let ptr = ptr as *const ArcInner<T>;

	// .. and then adjust the byte offset.
	let ptr = ptr.wrapping_byte_offset(-val_offset);

This may be the opposite direction as Andreas proposed ;-), but the
result is less code.

Regards,
Boqun

> Best,
> Gary
