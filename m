Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40168F1D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjBHPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjBHPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:19:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290F8A77;
        Wed,  8 Feb 2023 07:19:16 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u7so234894ybk.0;
        Wed, 08 Feb 2023 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GLuIcRVqFE0NAalKrZJUisc9u4XSzDbGTvwQ/4oF4j8=;
        b=REUcwDrY0U9+AAorsO9T3C0TfMRiyib3AfWq2Qt/rWv53t1Gw5q2jYQ4/RN4kSLrgD
         8/iEGM7jO8ze+SP5ZCycjj0m5o+7m0+rZ0UeXtKCKde+yEs8K8BaciEn372RDtx9NtvN
         O/yP3F762pAfrbFXMKnqe817aaUpNapMFDm6xIGHOqEPzGqf4rSHEyoA5/BJzT/jlpWG
         NjubBxmBkU+5T2KmTIQaScoBly+x1eo43HavtP+YKT5JemMv0CNlIzL6ySroyl+Gc8is
         7DWhPGQkw9t7Zqj6VmEGHIyRFKZJkJKjpZAogHu7TLDgH1R8HzkSqavYP6yi7Y2Ilq+R
         BIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLuIcRVqFE0NAalKrZJUisc9u4XSzDbGTvwQ/4oF4j8=;
        b=wzcjjJObh+VTXm03vmmmmqNdVXlRrYnRUYzxr9EFGlux2Pr8YXphUZDpyUkzOpGK/C
         GTr/OC4S6Jy64WPg3RL7pi3gCL73IzWzYI8bxYXtC96ciyagniS23N9+gdu62ZsfhT8w
         OcxUFJSLxv3OAjkf3Rx2LAfToMFz6jL1KTvPR3FODJ/XNuKYeOWTXw7u55YmgPa6bUdH
         HwsKC4B+oFWA+uty2H4M9EObhnLd0qJSKkOtZm6bxCers0AkhizNUjpnrI4S0ohFr2ko
         6QqVWm62f7snLizIVOCp4Wg1ZHsf2aJNI7I9FBLJClM+9IfsCAyWDBvv/sZev52S3hcR
         5X2Q==
X-Gm-Message-State: AO0yUKXI7HTCFr72+6jQfwu0exEjU2AC8zWCXq1tRKvrHvATQKpvGTgr
        DMJ1dvU/RD+OP8wWfyNUn8mnbNcxy/R+H4zby0w=
X-Google-Smtp-Source: AK7set+fH9Gee2ZXDR0I8RrrgdNyEEvcCMLmuUZFErMA3ckO1viakRMTjazDaL/qOQaBJMbe54GrsaZgL+qIRq6WAZg=
X-Received: by 2002:a25:9207:0:b0:8b4:7e1d:edac with SMTP id
 b7-20020a259207000000b008b47e1dedacmr616864ybo.328.1675869555405; Wed, 08 Feb
 2023 07:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20230207185216.1314638-1-boqun.feng@gmail.com> <20230207185216.1314638-3-boqun.feng@gmail.com>
In-Reply-To: <20230207185216.1314638-3-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 8 Feb 2023 16:19:04 +0100
Message-ID: <CANiq72kyrz4efU5=MexgGNth1XxkU1z-GP6xVa7WxApB+PMdFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc printing
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        Finn Behrens <fin@nyantec.com>
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

On Tue, Feb 7, 2023 at 7:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> +    // Uses `dbg` to print, will move `c`.
> +    dbg!(c);

Perhaps:

    // Uses `dbg` to print, will move `c` (for temporary debugging purposes).
    dbg!(c);

To make it clear it is not meant to be usually committed into the tree.

> +    // Prints debug fmt with pretty-print "#" and number-in-hex "x".
> +    pr_info!("{:#x?}", a);

Apparently, `:#x?` is a bit of an accident: `#` means "alternate"
form, but it turns out it applies to both `x` and `?`, i.e. it is not
that `#` alone implies pretty-printing.

Given the above and that there are improvements under discussion
upstream, perhaps we could avoid giving details for the moment and
just say what it does as a whole, e.g.

    // Pretty-prints the debug formatting with lower-case hexadecimal integers.
    pr_info!("{:#x?}", a);

Some links for those interested:
https://doc.rust-lang.org/std/fmt/index.html#sign0,
https://github.com/rust-lang/rust/issues/75766,
https://github.com/rust-lang/rust/pull/99138#issuecomment-1385331055
and https://github.com/rust-lang/libs-team/issues/165.

Finally, there is a small typo in the commit title. What about:

    rust: samples: print: add sample code for `Arc` printing

I can change these bits on my side if you want & agree with them, to
avoid a v3 just for this.

Thanks for these patches, Boqun!

Cheers,
Miguel
