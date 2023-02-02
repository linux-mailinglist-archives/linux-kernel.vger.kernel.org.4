Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085F68892C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjBBVrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBBVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:32 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF6A3803C;
        Thu,  2 Feb 2023 13:47:25 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-50aa54cc7c0so44586827b3.8;
        Thu, 02 Feb 2023 13:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8gkWPf7lJ67OvU9LHBcvdIcjt8jjpO4P9Sxwi83WSZA=;
        b=QGC3JJagucBjv+RH24fewQZRqYAhIJ2yivaozx88CrtNNGGcE0Tgj2DN8gF5ZA2T3w
         RzOgL1mBJiylXmbkfGd+wvhxkN3f4Hn1BfIgr5r5BoZbXTG6LgyMLoXY3BVQ1E9tK0gL
         4R9I1h58joD8RmVoVQkVOvs5Xrz2R7mrTvswqirSuVI3Bta8AYU+roPDXDq3DfhzOIVG
         W7QGZ3ojMO5U7DykglNIZSS1h72/CToE/I+27yTR2uVzwFzHl8u8973ryCkusbOBLFP2
         s7HweZE2ZyZgfBT+2R2/lYSR/43niXASZkYVjUxXPwfGvxmRVXVj+dY+2mn4ILk+DDWx
         y0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gkWPf7lJ67OvU9LHBcvdIcjt8jjpO4P9Sxwi83WSZA=;
        b=0KSX2B2DWOlVsUqRZ61731F0f0tyHLUjxYu0pkVFEDLWhjCpZe1koqm2R7Vg7CqHR+
         9cSQnsUOB9vp/YclYZf4nQ9htK8C7M7CZu1UueXk1qOtHa51nUUVNEZinlt1hg+qtotv
         H+wi8p7wOAS0V0NxfYzzprPj1ZfHcdJxjocijvBQQOh1BcOhwbZdZVqjMWeXzuyvMVNB
         8yxR99KEVrrKu1z41wGx7s8dyg02x/zWalxF+J0+3poh3BPIiAM4rY3pd2eAlVGw0s5f
         TUMHpR07ckp+zblbyO5sb8Ur8VgpysrkEvGWFDjxFnfGlF3MczEsmsxgU25mA2sCCEuS
         WBnw==
X-Gm-Message-State: AO0yUKXM/i1SCyKkGjqrgotbKvcZG2F+UusiwxDI3tJX4FPbfziUae9h
        kpc80ETIZ9NHrANEXTK9K+HQN7VakYWkV1ZgfMY=
X-Google-Smtp-Source: AK7set+iUIWjo0IGErehz+meeBVlUcr59HD7wNAbWzsGBYorqb1I/wXAWMCCGny5WhbEAfsJ6+Q67BfrGim8dwH23aE=
X-Received: by 2002:a05:690c:c08:b0:3d8:8c0e:6d48 with SMTP id
 cl8-20020a05690c0c0800b003d88c0e6d48mr673000ywb.462.1675374444108; Thu, 02
 Feb 2023 13:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20230201232244.212908-1-boqun.feng@gmail.com> <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net> <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com> <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com> <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
In-Reply-To: <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Feb 2023 22:47:12 +0100
Message-ID: <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
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

On Thu, Feb 2, 2023 at 5:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> As I said, I'm open to remove the printing of the refcount, and if you
> and Peter think maybe it's OK to do that after the explanation above,

Perhaps part of the confusion came from the overloaded "safe" term.

When Gary and Boqun used the term "safe", they meant it in the Rust
sense, i.e. calling the method will not allow to introduce undefined
behavior. While I think Peter and Greg are using the term to mean
something different.

In particular, "safe" in Rust does not mean "hard to misuse" or "OK to
use in production" or "avoids functional bugs" or "prevents crashes"
and so on. And, yeah, this is a common source of misunderstandings,
and some argue a better term could have been chosen.

So it is possible to have perfectly safe Rust functions that are very
tricky to use or unintended for common usage. Now, of course, whether
having a particular function is a good idea or not is a different
story.

Boqun: maybe appending a small paragraph to the doc comments of the
function would alleviate concerns.

Cheers,
Miguel
