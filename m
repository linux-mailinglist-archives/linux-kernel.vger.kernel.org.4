Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47596DCA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDJRsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDJRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:47:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A1171C;
        Mon, 10 Apr 2023 10:47:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id ly9so7081644qvb.5;
        Mon, 10 Apr 2023 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681148855; x=1683740855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ikKE6m67IVKFNKGFB9m6CHWYn/7a3mME8vsRoaNSVU=;
        b=G1/8BltfY1JYBrgojCKl6vcW5e+DHQyGCUvX9LxJNGL5dUB8ycwV7hkndnZDctkv1a
         dg4Tw/+O/5Ctn0hrMEcJuri9a9z/ipdMCkhgU8Jkb//+rXbsovsXlxNh4dp04punRYe8
         D7c+LIMWWl1BsrZ71ehuW6Mbc77RBLuFWyM9eSEB+MsTZGfeD5dw2naHSZaIqX1EYaBw
         6J7S4MI8QJeOE0tW9WNHp3Vp03L7daEygQpsIDvGytbYwHrSrFBIwUF7uK5z1vsWU3d9
         ZS5eEs37e+rVe84nvPLbeIm/mk2HZmArC8D3VkuLV0K/52UxI6TtyX5qNdSTA8UjGOP1
         6vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148855; x=1683740855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ikKE6m67IVKFNKGFB9m6CHWYn/7a3mME8vsRoaNSVU=;
        b=kwugBIblBjzoEYlRIcCxaqPjKk/yKua9x+m9fdxW123gGRXBlbh/1t16MT5nJTJVJD
         hNl0YGxnLTDWcgEzSO6iTHj5c5afeqIAhl+j17cE0j4od6wW9KY+RKQIFs0nwmC6ACvB
         Vnro6eydJPWsOrAjq2AraZEi52izMJF3dIZc6P/Df4re30QnHSD9YUcYFfs+qCZdGiTD
         FfGUe/Kqi86CrhXTFXUQZcblj0lvwsSGUD7XpPIfwedSGA/qIQFuskdGb148ckAdoFtl
         2+KBtX4aq/XNCQwFsgjPAHbaVr3Q9DntPsI6hSfFZAopwKEazLJnMgNbGoPaZNbV82WI
         Oe0w==
X-Gm-Message-State: AAQBX9eXOigj4X8I6LHyyOPRlRwlCRXI0Gid7ASCycY4ik3A/jxRkSt7
        XB9lBwEK2JDL7Xg3isZeWy8=
X-Google-Smtp-Source: AKy350butPB0CJ4unQYaszODP+pboCNACJvptDyFC04Q5cYZQENl2MZPs27pB+ENHJUX/We3yS0D4w==
X-Received: by 2002:a05:6214:f67:b0:5e0:30cc:8305 with SMTP id iy7-20020a0562140f6700b005e030cc8305mr71072qvb.3.1681148854761;
        Mon, 10 Apr 2023 10:47:34 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t3-20020ac86a03000000b003e63324e123sm3093156qtr.61.2023.04.10.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:47:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 601E327C0054;
        Mon, 10 Apr 2023 13:47:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 10 Apr 2023 13:47:33 -0400
X-ME-Sender: <xms:tUs0ZE16g9pk_AKUCAdGNQIXiZrx-GjA5Roks-K9zDupj4Lt2VkQbQ>
    <xme:tUs0ZPFczvb5pxF0QiIp56yc7O6cU39Wv7efBzC9b-xP82l5t8jEzYXZp8gE_NPA9
    DRjrkVVu-gdGRHsag>
X-ME-Received: <xmr:tUs0ZM5w6iAD9w3GVaq3jBbXy6i5kh2fcn_kCdkLwnu5vaVwvmw8kX5E83wsLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:tUs0ZN2H9otqdejpQyqVtYCfxBGLDlPXDAxWiBnom3YRFnJI_LcszA>
    <xmx:tUs0ZHErCDhG0o-XZFPEbQdhkJ-sRSs0CfqDvdfeCrSQcQHDIMAmXQ>
    <xmx:tUs0ZG-hlL3SFCrQtn2Rfg0jfXtxmpz2Z-Vys8DARZu1SlLfQ3cD8A>
    <xmx:tUs0ZG0FvbYCFvr6SdUtaK4-X0kYYpohnZV-_9DZoV2P7ouGQBa9jA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 13:47:32 -0400 (EDT)
Date:   Mon, 10 Apr 2023 10:46:16 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 13/13] rust: sync: introduce `LockedBy`
Message-ID: <ZDRLaDEnrLhQmW+F@boqun-archlinux>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-13-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408075340.25237-13-wedsonaf@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 04:53:40AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This allows us to have data protected by a lock despite not being
> wrapped by it. Access is granted by providing evidence that the lock is
> held by the caller.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Added build_assert to rule out zero-sized types
> v2 -> v3: Improve comments around panics and support for ZSTs
> 
>  rust/kernel/sync.rs           |   2 +
>  rust/kernel/sync/lock.rs      |   2 +-
>  rust/kernel/sync/locked_by.rs | 147 ++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/locked_by.rs
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 431402180aa8..d219ee518eff 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -10,10 +10,12 @@ use crate::types::Opaque;
>  mod arc;
>  mod condvar;
>  pub mod lock;
> +mod locked_by;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::CondVar;
>  pub use lock::{mutex::Mutex, spinlock::SpinLock};
> +pub use locked_by::LockedBy;
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>  #[repr(transparent)]
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index c365bc909dff..84d8d7d01aaa 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -111,7 +111,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
>      _pin: PhantomPinned,
>  
>      /// The data protected by the lock.
> -    data: UnsafeCell<T>,
> +    pub(crate) data: UnsafeCell<T>,
>  }
>  
>  // SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> new file mode 100644
> index 000000000000..ab0ecb013f54
> --- /dev/null
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A wrapper for data protected by a lock that does not wrap it.
> +
> +use super::{lock::Backend, lock::Lock};
> +use core::{cell::UnsafeCell, ptr};
> +
> +/// Allows access to some data to be serialised by a lock that does not wrap it.
> +///
> +/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
> +/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
> +/// possible. For example, if a container has a lock and some data in the contained elements needs
> +/// to be protected by the same lock.
> +///
> +/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
> +/// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
> +/// refers to the wrong instance of the lock.
> +///
> +/// # Examples
> +///
> +/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
> +/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
> +/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
> +/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
> +/// locked; we enforce at run time that the right `InnerDirectory` is locked.
> +///
> +/// ```
> +/// use kernel::sync::{LockedBy, Mutex};
> +///
> +/// struct InnerFile {
> +///     bytes_used: u64,
> +/// }
> +///
> +/// struct File {
> +///     _ino: u32,
> +///     inner: LockedBy<InnerFile, InnerDirectory>,
> +/// }
> +///
> +/// struct InnerDirectory {
> +///     /// The sum of the bytes used by all files.
> +///     bytes_used: u64,
> +///     _files: Vec<File>,
> +/// }
> +///
> +/// struct Directory {
> +///     _ino: u32,
> +///     inner: Mutex<InnerDirectory>,
> +/// }
> +///
> +/// /// Prints `bytes_used` from both the directory and file.
> +/// fn print_bytes_used(dir: &Directory, file: &File) {
> +///     let guard = dir.inner.lock();
> +///     let inner_file = file.inner.access(&guard);
> +///     pr_info!("{} {}", guard.bytes_used, inner_file.bytes_used);
> +/// }
> +///
> +/// /// Increments `bytes_used` for both the directory and file.
> +/// fn inc_bytes_used(dir: &Directory, file: &File) {
> +///     let mut guard = dir.inner.lock();
> +///     guard.bytes_used += 10;
> +///
> +///     let file_inner = file.inner.access_mut(&mut guard);
> +///     file_inner.bytes_used += 10;
> +/// }
> +///
> +/// /// Creates a new file.
> +/// fn new_file(ino: u32, dir: &Directory) -> File {
> +///     File {
> +///         _ino: ino,
> +///         inner: LockedBy::new(&dir.inner, InnerFile { bytes_used: 0 }),
> +///     }
> +/// }
> +/// ```
> +pub struct LockedBy<T: ?Sized, U: ?Sized> {
> +    owner: *const U,
> +    data: UnsafeCell<T>,
> +}
> +
> +// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
> +unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
> +
> +// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> +// data it protects is `Send`.
> +unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> +
> +impl<T, U: ?Sized> LockedBy<T, U> {
> +    /// Constructs a new instance of [`LockedBy`].
> +    ///
> +    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
> +    /// that the right owner is being used to access the protected data. If the owner is freed, the
> +    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
> +    /// memory location*, the data becomes accessible again: none of this affects memory safety
> +    /// because in any case at most one thread (or CPU) can access the protected data at a time.
> +    pub fn new(owner: &Lock<U, impl Backend>, data: T) -> Self {
> +        Self {
> +            owner: owner.data.get(),

Given we use the address of the `data` as a key to verify holding a
lock, I think we should use `Pin<_>` in the function signature, i.e.

	pub fn new(owner: Pin<&Lock<U, impl Backend>, data: T) -> Self {
	    Self {
	        owner: owner.get_ref().data.get()
		data: UnsafeCell::new(data),
	    }
	}

Thoughts?

Regards,
Boqun

> +            data: UnsafeCell::new(data),
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized, U> LockedBy<T, U> {
> +    /// Returns a reference to the protected data when the caller provides evidence (via a
> +    /// reference) that the owner is locked.
> +    ///
> +    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&U` that matches
> +    /// the data protected by the lock without actually holding it.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `owner` is different from the data protected by the lock used in
> +    /// [`new`](LockedBy::new).
> +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> +        // Detect the usage of SZTs, which are supported, at compile time.
> +        crate::build_assert!(core::mem::size_of::<U>() > 0);
> +        if !ptr::eq(owner, self.owner) {
> +            panic!("mismatched owners");
> +        }
> +
> +        // SAFETY: `owner` is evidence that the owner is locked.
> +        unsafe { &*self.data.get() }
> +    }
> +
> +    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
> +    /// mutable owner) that the owner is locked mutably.
> +    ///
> +    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&mut U` that
> +    /// matches the data protected by the lock without actually holding it.
> +    ///
> +    /// Showing a mutable reference to the owner is sufficient because we know no other references
> +    /// can exist to it.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `owner` is different from the data protected by the lock used in
> +    /// [`new`](LockedBy::new).
> +    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
> +        // Detect the usage of SZTs, which are supported, at compile time.
> +        crate::build_assert!(core::mem::size_of::<U>() > 0);
> +        if !ptr::eq(owner, self.owner) {
> +            panic!("mismatched owners");
> +        }
> +
> +        // SAFETY: `owner` is evidence that there is only one reference to the owner.
> +        unsafe { &mut *self.data.get() }
> +    }
> +}
> -- 
> 2.34.1
> 
