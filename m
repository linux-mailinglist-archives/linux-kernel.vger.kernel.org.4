Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D76DCFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDKC5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDKC5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:57:22 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B92717;
        Mon, 10 Apr 2023 19:57:21 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1845f865452so2999133fac.12;
        Mon, 10 Apr 2023 19:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681181841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd9SeLxNIW/Y62bZyuPTKInPhZOR3A0fCXLRBlQiGKc=;
        b=SchyyQ+xuwQej2RenIDjEacp0cd72lQnkbVpDlWnrl1wXCcSmWqEHUfyiBGfCNHWp6
         VYQcGZ8WXpFFaNO386Bsot6Q8OFg+OgVB656Om+jI5+N7AqlJPQL5e9jmX40uzqj+WWC
         okITLQ9ZF344qvPSB116R52UrZtrZjVMLUG0LvwNeYkU5n/JL8VgSTSbV83ANQTIunSY
         Og0Rcnq9v2FZ+/nsFfrpFJnvb5pauUwaXBVdrS82dtaDHS6M9IWYWnouwM/KU9tpnMn5
         v+66lYoIcDUHwWDtaFzkB+nr1a3SS+sL56rhVrBlBBtXJNVD2aDMdoTZRE8BeRQUq5+J
         pWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681181841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd9SeLxNIW/Y62bZyuPTKInPhZOR3A0fCXLRBlQiGKc=;
        b=bzPMfi1jxQ8VAr+Xg0rO8hBI15lrfllgWPVZ4gFtUrSfkLcKhyROUINxcD/aQBfKg3
         +YJPyN+bVeGx6S4iVGhPC4Z9skpznienTSxDbaWhBG4k6wupcr5IfnImmyjdKVKzVDQA
         kksOAcSo7dddSXpMfg++5+wg4leknRgAey7z7G7Zi5hAcgHfOB+uSjs0qiiZgE4LF90N
         jzPZR2Iiyt7JRcrbg2h49UzxdJhya/oVSkj8Bk81b3t0v12DnXrQBYQXdEwrcC57usBi
         cRYI/yzRxjqazghZK71SXcbi/uOegioQSM3Ru2g+n/CA4rVOZI/hoyoLjLMSIS8cHUGJ
         xrCA==
X-Gm-Message-State: AAQBX9f7TeTlAv3rEB0Zusy7AHYyB4g9PIc4VxEIMzKaz0Vu4Rh8a76H
        t3tPhXDspBmWtdWJqwl5AFdmu0qcrXE=
X-Google-Smtp-Source: AKy350YpYQ3/97wQzoPf1rMvYEbdccbfpSiW32JlyGumSXnTDMgD+lnPGikxJ4J82BM68DkTfE7PpA==
X-Received: by 2002:a05:6870:648f:b0:177:8358:d03e with SMTP id cz15-20020a056870648f00b001778358d03emr926433oab.16.1681181840592;
        Mon, 10 Apr 2023 19:57:20 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id yx21-20020a056871251500b001842bb0a01csm2759882oab.27.2023.04.10.19.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 19:57:20 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:57:14 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 13/13] rust: sync: introduce `LockedBy`
Message-ID: <ZDTMitCiFC/K4Rxw@wedsonaf-dev>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-13-wedsonaf@gmail.com>
 <6855e33f-445e-12b8-33e4-6b9559e16097@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6855e33f-445e-12b8-33e4-6b9559e16097@protonmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:52:02PM +0000, Benno Lossin wrote:
> On 08.04.23 09:53, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This allows us to have data protected by a lock despite not being
> > wrapped by it. Access is granted by providing evidence that the lock is
> > held by the caller.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: Added build_assert to rule out zero-sized types
> > v2 -> v3: Improve comments around panics and support for ZSTs
> >
> >   rust/kernel/sync.rs           |   2 +
> >   rust/kernel/sync/lock.rs      |   2 +-
> >   rust/kernel/sync/locked_by.rs | 147 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 150 insertions(+), 1 deletion(-)
> >   create mode 100644 rust/kernel/sync/locked_by.rs
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 431402180aa8..d219ee518eff 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -10,10 +10,12 @@ use crate::types::Opaque;
> >   mod arc;
> >   mod condvar;
> >   pub mod lock;
> > +mod locked_by;
> >
> >   pub use arc::{Arc, ArcBorrow, UniqueArc};
> >   pub use condvar::CondVar;
> >   pub use lock::{mutex::Mutex, spinlock::SpinLock};
> > +pub use locked_by::LockedBy;
> >
> >   /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> >   #[repr(transparent)]
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index c365bc909dff..84d8d7d01aaa 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -111,7 +111,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
> >       _pin: PhantomPinned,
> >
> >       /// The data protected by the lock.
> > -    data: UnsafeCell<T>,
> > +    pub(crate) data: UnsafeCell<T>,
> >   }
> >
> >   // SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> > diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> > new file mode 100644
> > index 000000000000..ab0ecb013f54
> > --- /dev/null
> > +++ b/rust/kernel/sync/locked_by.rs
> > @@ -0,0 +1,147 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A wrapper for data protected by a lock that does not wrap it.
> > +
> > +use super::{lock::Backend, lock::Lock};
> > +use core::{cell::UnsafeCell, ptr};
> > +
> > +/// Allows access to some data to be serialised by a lock that does not wrap it.
> > +///
> > +/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
> > +/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
> > +/// possible. For example, if a container has a lock and some data in the contained elements needs
> > +/// to be protected by the same lock.
> > +///
> > +/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
> > +/// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
> > +/// refers to the wrong instance of the lock.
> > +///
> 
> Maybe add a small section that ZSTs are not allowed for `U`,
> since they do not have to have unique addresses.

As I said on the previous message, the restriction that `U` cannot be a ZST is a
restriction of `access` and `access_mut`, it's not one of the struct.
Therefore, I don't think it belongs here. 

In v3, I did add a small paragraph to both `access` and `access_mut` to reflect
this.

> > +/// # Examples
> > +///
> > +/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
> > +/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
> > +/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
> > +/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
> > +/// locked; we enforce at run time that the right `InnerDirectory` is locked.
> > +///
> > +/// ```
> > +/// use kernel::sync::{LockedBy, Mutex};
> > +///
> > +/// struct InnerFile {
> > +///     bytes_used: u64,
> > +/// }
> > +///
> > +/// struct File {
> > +///     _ino: u32,
> > +///     inner: LockedBy<InnerFile, InnerDirectory>,
> > +/// }
> > +///
> > +/// struct InnerDirectory {
> > +///     /// The sum of the bytes used by all files.
> > +///     bytes_used: u64,
> > +///     _files: Vec<File>,
> > +/// }
> > +///
> > +/// struct Directory {
> > +///     _ino: u32,
> > +///     inner: Mutex<InnerDirectory>,
> > +/// }
> > +///
> > +/// /// Prints `bytes_used` from both the directory and file.
> > +/// fn print_bytes_used(dir: &Directory, file: &File) {
> > +///     let guard = dir.inner.lock();
> > +///     let inner_file = file.inner.access(&guard);
> > +///     pr_info!("{} {}", guard.bytes_used, inner_file.bytes_used);
> > +/// }
> > +///
> > +/// /// Increments `bytes_used` for both the directory and file.
> > +/// fn inc_bytes_used(dir: &Directory, file: &File) {
> > +///     let mut guard = dir.inner.lock();
> > +///     guard.bytes_used += 10;
> > +///
> > +///     let file_inner = file.inner.access_mut(&mut guard);
> > +///     file_inner.bytes_used += 10;
> > +/// }
> > +///
> > +/// /// Creates a new file.
> > +/// fn new_file(ino: u32, dir: &Directory) -> File {
> > +///     File {
> > +///         _ino: ino,
> > +///         inner: LockedBy::new(&dir.inner, InnerFile { bytes_used: 0 }),
> > +///     }
> > +/// }
> > +/// ```
> > +pub struct LockedBy<T: ?Sized, U: ?Sized> {
> > +    owner: *const U,
> > +    data: UnsafeCell<T>,
> > +}
> > +
> > +// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
> > +unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
> > +
> > +// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> > +// data it protects is `Send`.
> > +unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> > +
> > +impl<T, U: ?Sized> LockedBy<T, U> {
> > +    /// Constructs a new instance of [`LockedBy`].
> > +    ///
> > +    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
> > +    /// that the right owner is being used to access the protected data. If the owner is freed, the
> > +    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
> > +    /// memory location*, the data becomes accessible again: none of this affects memory safety
> > +    /// because in any case at most one thread (or CPU) can access the protected data at a time.
> > +    pub fn new(owner: &Lock<U, impl Backend>, data: T) -> Self {
> 
> I suggested this already on v2, but I think it was to late, since
> you quickly sent v3 after I sent my reply, so reiterating the point here.
> 
> I think we should have `build_assert!(mem::size_of::<Lock<T, B>>() > 0)`
> here to ensure that you cannot have two locks referring to the same
> memory location.

Ok, I'll add this to v4.

> This is rather pedantic, since I doubt that we would introduce a
> `Backend` that has a ZST as the `State`, but it also does not hurt
> and might prevent a hard to identify bug later.
> 
> > +        Self {
> > +            owner: owner.data.get(),
> > +            data: UnsafeCell::new(data),
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized, U> LockedBy<T, U> {
> > +    /// Returns a reference to the protected data when the caller provides evidence (via a
> > +    /// reference) that the owner is locked.
> > +    ///
> > +    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&U` that matches
> > +    /// the data protected by the lock without actually holding it.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `owner` is different from the data protected by the lock used in
> > +    /// [`new`](LockedBy::new).
> > +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> > +        // Detect the usage of SZTs, which are supported, at compile time.
> 
> Typos: "SZTs" -> "ZSTs" and "supported" -> "unsupported"? Also found below.

Oh, thanks for spotting these!

> 
> > +        crate::build_assert!(core::mem::size_of::<U>() > 0);
> 
> Could you add a meaningful error message here? Like
> "Cannot use `LockedBy` where `U` is a ZST, since it does
> not guarantee address uniqueness."
> Also add this in the calls to `build_assert!` below and above.

I'm adding a message and removing the comment I had above in v4. Note, however,
that this message isn't displayed when the build fails, so it is of limited use
at the moment. (We do get a file name and line number, which helps bringing
attention to the right place.)

> 
> --
> Cheers,
> Benno
> 
> > +        if !ptr::eq(owner, self.owner) {
> > +            panic!("mismatched owners");
> > +        }
> > +
> > +        // SAFETY: `owner` is evidence that the owner is locked.
> > +        unsafe { &*self.data.get() }
> > +    }
> > +
> > +    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
> > +    /// mutable owner) that the owner is locked mutably.
> > +    ///
> > +    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&mut U` that
> > +    /// matches the data protected by the lock without actually holding it.
> > +    ///
> > +    /// Showing a mutable reference to the owner is sufficient because we know no other references
> > +    /// can exist to it.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `owner` is different from the data protected by the lock used in
> > +    /// [`new`](LockedBy::new).
> > +    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
> > +        // Detect the usage of SZTs, which are supported, at compile time.
> > +        crate::build_assert!(core::mem::size_of::<U>() > 0);
> > +        if !ptr::eq(owner, self.owner) {
> > +            panic!("mismatched owners");
> > +        }
> > +
> > +        // SAFETY: `owner` is evidence that there is only one reference to the owner.
> > +        unsafe { &mut *self.data.get() }
> > +    }
> > +}
> > --
> > 2.34.1
> >
> 
