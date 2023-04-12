Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB876DFCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDLRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:41:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0461BE;
        Wed, 12 Apr 2023 10:41:47 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h198so19154898ybg.12;
        Wed, 12 Apr 2023 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681321307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tn44oq08WLrPK/Pkq/fh/WP0qih2cPlQbxYtLxEJKoY=;
        b=biFriAUp2wwHfytb1pNE7xJhCOEW96RmYk/sbRkLOF8+eVNrwyBGWaVXUyG3RPvCpD
         8D/MRk6Gat+/mh/fyIGnvUu9ikLzFh2RVOV6q1yoFthExxq6gsiTby/XV2QvJVVWnIUA
         SiMLe8HtiF0Svz+lxG7rA0evyLX16+tAs+wh4p2rRpz7tV0atb9/CvKxjbRpLnB02DcO
         iaxu+EA+7ReJ7NIcFoJnKIlJqO92OS0/jBzNPdGNlYyzE87AHdjpk+MYK3B5D9Cz+/Ri
         FrUp9dcQfYNkzI1v/TBNKfJuxXXxoaqIWGvf4neI5j+9hInU8C9/kSQci7BJ5GCml7ya
         ZEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tn44oq08WLrPK/Pkq/fh/WP0qih2cPlQbxYtLxEJKoY=;
        b=VxHnU3gv7hC4uZIpQUvRZ6T2V9A8xnJ0gA0jHrFTpilOZTPvHuAwsyd8r5Erjcri35
         o6+k5/IcQxc0OdDkS8p79CCv7mCQhZB8gEDWMv3YKl+oHLR5zTCCCH/yJP7e8RH7muMO
         TDo5h9QZfdqxog/u7R3TcHzlEoihJ4NT4L7t0woo5xH7MD21PmYfl4NaeHEm3jFjL1Dn
         1uvar7iOxCwIDvwffLH6/RovLz/Q/sG0JJKFuArNQhKMOM0gs6XdkDm6MZiMQjMna52q
         +XIo5mSTYVomtwE4yGpJ50TfjDZKm13XDGNk6iOpD7fCXVTp1tjW/SC15UgoAcAgbkl/
         u/pA==
X-Gm-Message-State: AAQBX9e8W7pXQ+XTb2FQIA4xQCVHeeLDog6yepnGlWNoifhcqhbbXRX1
        DHtCH5VzBlgPWQ6iih/CmzfRY0oWPSC9VvD2fIA=
X-Google-Smtp-Source: AKy350bif0UPYzg3/z4jpHczSSqhBc4QcLcPKwzm36dVukvfBPiHlrDZKWuE4U9Q79Gginc4pZk+rGzjH4dhxKXqjZc=
X-Received: by 2002:a5b:647:0:b0:b8f:5474:2f33 with SMTP id
 o7-20020a5b0647000000b00b8f54742f33mr160038ybq.5.1681321307006; Wed, 12 Apr
 2023 10:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-11-wedsonaf@gmail.com>
 <ZDZOzzMvvxr4rsW4@Boquns-Mac-mini.local> <CANeycqqpR6Gs5Qb_pc2j_QV-JAc8xR360vth6We8xWU1GU5ASA@mail.gmail.com>
 <ZDbBsBIZwMhbquRG@Boquns-Mac-mini.local>
In-Reply-To: <ZDbBsBIZwMhbquRG@Boquns-Mac-mini.local>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 12 Apr 2023 14:41:37 -0300
Message-ID: <CANeycqpGZd4r-BdTJ4C4jfftGxyV4_aEcysbPh+-fjj+WyVZaQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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

On Wed, 12 Apr 2023 at 11:35, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Wed, Apr 12, 2023 at 08:07:40AM -0300, Wedson Almeida Filho wrote:
> > On Wed, 12 Apr 2023 at 03:25, Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Tue, Apr 11, 2023 at 02:45:41AM -0300, Wedson Almeida Filho wrote:
> > > [...]
> > > > +
> > > > +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> > > > +        let _ = match guard_state {
> > > > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > > > +            // initialised.
> > > > +            None => unsafe { Self::lock(ptr) },
> > > > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > > > +            // initialised.
> > > > +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> > > > +        };
> > > > +    }
> > > >  }
> > > >
> > >
> > > One thing I'm little worried about the above is that we don't store back
> > > the new GuardState into `guard_state`, the particular case I'm worried
> > > about is as follow:
> > >
> > >         // IRQ is enabled.
> > >         // Disabling IRQ
> > >         unsafe { bindings::local_irq_disable(); }
> > >
> > >         let mut g = unsafe { SpinLockBackend::lock(&mut lock as *mut _) };
> > >         // `g` records irq state is "irq disabled"
> > >
> > >         unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
> > >         // restore into "irq disabled" mode.
> > >         // IRQ is disabled.
> > >
> > >         // Enabling IRQ
> > >         unsafe { bindings::local_irq_enable(); }
> > >         // IRQ is enabled.
> > >
> > >         unsafe { SpinLockBackend::relock(&mut lock as *mut _, &mut g) }
> > >         // `g` still records irq state is "irq disabled"
> >
> > Yes, that's by design. If you want it to record the new "irq enabled"
> > state, then you should call `lock()`, not `relock()`.
> >
> > >         unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
> > >         // restore into "irq disabled" mode.
> > >         // IRQ is disabled.
> > >
> > >
> > > This looks pretty scary to me, I would expect `relock()` updates the
> > > latest GuardState to the guard. Any reason it's implemented this way?
> >
> > A `relock()` followed by an `unlock()` takes the state back to how it
> > was when `lock()` was originally called: this is precisely why
> > `relock()` exists.
> >
> > Consider the following case:
> >
> > ```
> > local_disable_irq();
> > let mut guard = spinlock.lock();
>
> I think you meant `spinlock.lock_irqsave()` here, right?

Yes, sorry, I meant `lock_irqsave()`.

> >
> > guard.do_unlocked(|| {
> >     local_irq_enable();
> >     schedule();
> > });
> >
> > drop(guard);
> > ```
> >
> > What would you expect the state to be? It's meant to be the state
>
> I understand your point but I would expect people to code like:
>
> ```
> local_disable_irq();
> let mut guard = spinlock.lock(); // or lock_irqsave(), doesn't matter
>
> guard.do_unlocked(|| {
>     local_irq_enable();
>     schedule();
>     local_irq_disable();
> });
>
> drop(guard);
> ```

Well, `relock` works with the code above as well.

> And the closure in do_unlocked() can also be something like:
> ```
>         guard.do_unlocked(|| {
>             local_irq_enabled();
>             let _g = ScopeGuard::new(|| {
>                 local_irq_disabled();
>             });
>
>             schedule();
>
>             if (some_cond) {
>                 return; // return early
>             }
>
>             if (other_cond) {
>                 return;
>             }
>         })
>
> ```
>
> One benefit (other that code looks symmetric) is we can use the same
> closure in other place. Also it helps klint since we keep the irq
> enablement state change as local as possible: we can go ahead and
> require irq enabled state should not be changed between the closure in
> do_unlock().

Note that the only user of `do_unlocked` at the moment works for any
type of lock, including mutexes, so we can't really have this kind of
code there. All irq handling needs to happen on the backends.

> Maybe I'm missing something, but the current `relock` semantics is
> really tricky to get ;-)

It seems straightforward to me: reacquire the lock in the same mode as
the original lock() call (e.g., lock() vs lock_irqsave()) such that
the `unlock()` will restore any state it manages to what it was right
before the original locking call.

But callers are not going to deal with these unsafe backend functions
directly, they'll deal with guards, so the high-level requirement that
`relock()` enforces is the following, given something like:

```
// 1
let guard = spinlock.lock_irqsave();
// Some code, which may include calls to a condvar, and may change the
irq state.
drop(guard);
// 2
```

At 2, the irq state must be the same as in 1, that's why one would use
the `lock_irqsave` variant.

This is a common pattern (seen in a bunch of unrelated places): save
the current state, make changes to the state, and eventually restore
the saved state (independently of what changes were made between
saving and restoring).

> Regards,
> Boqun
>
> > right before `spinlock.lock()` was called, that's what the guard
> > represents.
> >
> > If you want to preserve a new state, then you don't want `relock()`,
> > you just want a new `lock()` call.
> >
> > > Regards,
> > > Boqun
> > >
> > > >  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
> > > >  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
> > > >  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
> > > >  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> > > > -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> > > > +unsafe impl IrqSaveBackend for SpinLockBackend {
> > > >      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
> > > >          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> > > >          // memory, and that it has been initialised before.
> > > > --
> > > > 2.34.1
> > > >
