Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC16DC0C0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjDIQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDIQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:50:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912F46A1;
        Sun,  9 Apr 2023 09:49:34 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so20898130otd.3;
        Sun, 09 Apr 2023 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058968;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=abBZow0F95kr3n16bDWfRFde3+5CPReF5FYRx7blgww=;
        b=L/fL5d+3/9/7CClZ+TviZPpoC7zbUgtFgdjHeP//JpnTIRrbYdnJLad8xyAW2nGzmJ
         NWiHrJ/AK8LNtByFfcfYI7WsIIwvK+eNZajB64ybuRoBxw8vhpJZ88yjr3l98H3ipkwf
         ob4jAtqHFblqGmpsLGL4GXC/TyCgSks5BxhEmgHzieRGsGDD7MmP6Aq6GQk7dQSMh9iC
         udGZomyDx/dH5OXPfS8fnT+7SxXFOcE13rJqjUHPRsZF05iwc6koOEENk7+ym0YVXO2p
         PGWflEV/9xItIgoGg2yj74s3g7HzyED4DgORnM6ATiD0oONWMJy8pireeAR3SQGkNbE6
         WKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058968;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abBZow0F95kr3n16bDWfRFde3+5CPReF5FYRx7blgww=;
        b=U230UPybGWjapJTiIHh3jtwsZA8gcxTjuGCYSfWV9pNuNTso+YR48YuYPac44zGETT
         PUt45d9Jhk/EZtS6XWAk0icnSPywSwIeLIN84Q4KfRq0Z62Ymgx1q0pGPloNP+1LT0ug
         6Gf5iSN9I1G7si2+sMwWmPycfVWSGAmWWq9xDa3GKmVlb8H7GQI7YgiF2WgQh9Yjk4Mh
         VTSvCmt3fCB+eXCml9KB9+A3jWwGO0hXxKanL993KyPJY0NA/gaejMO2eeq1H6JhpZvX
         Lzxt5U5YHv6a356AzHKj+RiZg+JW5KQpXMo/4vivVnlMEx4HmGUO7QDjcOY3vgT2GhAb
         d+uA==
X-Gm-Message-State: AAQBX9dOMD7QjYT00Uj/mbIqaPbb3iPaY2OrrFn1mEDLy8ZSgn7oJ0qT
        ku6cUxFgGIS1Bo2im9t4h9Kfdw9Uh68=
X-Google-Smtp-Source: AKy350YZUygYC1aVJWSPAAuSFwKo3avPKyxOp3x2uuWGK90+wM90Tnv96kysFo0qEG8DDNa8ppLXIw==
X-Received: by 2002:a05:6830:1493:b0:69c:36e6:5413 with SMTP id s19-20020a056830149300b0069c36e65413mr3396486otq.11.1681058968047;
        Sun, 09 Apr 2023 09:49:28 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v5-20020a0568301bc500b006a2fd720f82sm3525086ota.7.2023.04.09.09.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:49:27 -0700 (PDT)
Message-ID: <8ecf6b1f-71a6-53df-626c-9cdac133a7fb@gmail.com>
Date:   Sun, 9 Apr 2023 13:49:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 13/13] rust: sync: introduce `LockedBy`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-13-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-13-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 04:53, Wedson Almeida Filho wrote:
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
