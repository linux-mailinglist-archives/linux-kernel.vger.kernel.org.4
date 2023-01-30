Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874756805CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjA3F7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjA3F7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:59:42 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC27244A5;
        Sun, 29 Jan 2023 21:59:40 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t19so908011oiw.10;
        Sun, 29 Jan 2023 21:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tNmZuGDZCyWQXg6hFIAxrv4PleoJQNEUOdBk2GK1kxg=;
        b=iGWeRnXtJgA3FyG9eacCWWbhfKArLf7Ptm4JT9EMdtUhiVZtA7VYweqElcqjEDWWB0
         KY2iLgsUdQU7yBxq5y3YUEFKIkYTWaZEHVbPZB/y4u4dXIkdxAi7oQcuLSC2wsAxy1I8
         rFF87ahCfBb9QRfO1ONhclpbBbjqdZkbuZgpcbH4J2/UtEcRCtyDrAOwaORtdL88/2Is
         9TFoRVuepuGfFJZrj42xmsvOuEt2RmUf0MDnjXannuEMPjLRGK0nkqWEFDzQ+2MclVcn
         77ClEmAa6xGNR9oXfh48RIWfkrtPpyUBd2hf0KMOfwCcusVeEMRPPuUzD4h+APJYmdnb
         7WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNmZuGDZCyWQXg6hFIAxrv4PleoJQNEUOdBk2GK1kxg=;
        b=xZLd8Nu4B5e6ibaQiyV2ltbFVIVCA5Gi6EEjLyc+kK87VLa4CFlpqRADNwyI9b/0CA
         +fDVpewmnw/zf15KbT4tBGXe+8EtP/FEWWgM6S837fO2RFY0M4ZT4e8nJXGdaAHRNJMN
         3ovxWawDZD0Swi8unapFmS/xnIIJtbUCmakU3Mt+AIfbIN3IdKj7ZPqPaEKW2uK1IMiJ
         mHiVQ9OE/fb8KxngYpn41vsbO0VZi6g8lqxrDs+EtHeg5EpIXX+RquuzK4ruzX3QOwjx
         Sz2T3nFOuVBRNEkbVqDcoLazy7u/PFcS6t94imtCl7+9/h8YalmvEni+3j1szFLcfdhm
         3g8w==
X-Gm-Message-State: AFqh2koB3IhjpzPvaiYwQAWc9c2X6l5954boDRhbsgvLoiFYxl1Ndbng
        l7JoXoHODjIkNJkZEcq4/W8GDOMbJvjWixYz7jyMkU/IybHdnw==
X-Google-Smtp-Source: AMrXdXtcuZpMtJb4fyuOObKXjBnMCeuJRm+6Xi/FEp6gyng2AFmCX+AgUgsG6LrM3LoHlRNLy+QTah86ySGEqP/E9kw=
X-Received: by 2002:a05:6808:4346:b0:369:e573:3e54 with SMTP id
 dx6-20020a056808434600b00369e5733e54mr2248233oib.215.1675058378588; Sun, 29
 Jan 2023 21:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-2-wedsonaf@gmail.com>
 <20230127135533.3dfc7440.gary@garyguo.net>
In-Reply-To: <20230127135533.3dfc7440.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Mon, 30 Jan 2023 02:59:27 -0300
Message-ID: <CANeycqrWd4Tn8KpfY0Jga-7nrWN9pM23Y3B+j2HAphPbdEOM-Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 10:55, Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 19 Jan 2023 14:40:33 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > It was originally called `PointerWrapper`. It is used to convert
> > a Rust object to a pointer representation (void *) that can be
> > stored on the C side, used, and eventually returned to Rust.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > ---
> >  rust/kernel/lib.rs   |  1 +
> >  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index e0b0e953907d..223564f9f0cc 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -16,6 +16,7 @@
> >  #![feature(coerce_unsized)]
> >  #![feature(core_ffi_c)]
> >  #![feature(dispatch_from_dyn)]
> > +#![feature(generic_associated_types)]
> >  #![feature(receiver_trait)]
> >  #![feature(unsize)]
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index f0ad4472292d..5475f6163002 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -9,6 +9,60 @@ use core::{
> >      ops::{Deref, DerefMut},
> >  };
> >
> > +/// Used to transfer ownership to and from foreign (non-Rust) languages.
> > +///
> > +/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
> > +/// later may be transferred back to Rust by calling [`Self::from_foreign`].
> > +///
> > +/// This trait is meant to be used in cases when Rust objects are stored in C objects and
> > +/// eventually "freed" back to Rust.
> > +pub trait ForeignOwnable {
> > +    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
> > +    /// [`ForeignOwnable::from_foreign`].
> > +    type Borrowed<'a>;
> > +
> > +    /// Converts a Rust-owned object to a foreign-owned one.
> > +    ///
> > +    /// The foreign representation is a pointer to void.
> > +    fn into_foreign(self) -> *const core::ffi::c_void;
> > +
> > +    /// Borrows a foreign-owned object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> > +    /// for this object must have been dropped.
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> > +
> > +    /// Mutably borrows a foreign-owned object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> > +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> > +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
>
> I feel that this should could its own guard (maybe `PointerGuard`?) to
> be more semantically meaningful than a `ScopeGuard`.

I prefer not to add yet another type just for this internal type. It's
only used in the implementation of abstractions, and is exported only
to make it simpler for users to refer to types indirectly (e.g., `<T
as ForeignOwnable>::Borrowed<'_>`).

>
> > +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> > +        // `into_foreign`.
> > +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
> > +            d.into_foreign();
> > +        })
> > +    }
> > +
> > +    /// Converts a foreign-owned object back to a Rust-owned one.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> > +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> > +}
> > +
> >  /// Runs a cleanup function/closure when dropped.
> >  ///
> >  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
>
