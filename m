Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB26A3431
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBZU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:59:43 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC113D52;
        Sun, 26 Feb 2023 12:59:37 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-53852143afcso125741997b3.3;
        Sun, 26 Feb 2023 12:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a3uSDlfsqZGmv0N4D8ujOHHg7vKPERtZBqNuW3pgYs=;
        b=qHaN8xbcrctTIZLJmLgSzE/JjYY4a5wt8mpHQixH3Cpthj7X6bTegUsDqKK3X0ezqc
         t+3FqVF1QElwmSLcZPo4U0OLbPpjqX/OOHrr6TrhgQcZA3ObniMc6HOvXCMAcrBx1eKz
         RCZCnNnTQwADm//81Y/FuvuNZBO/iq7QX4hd87kr4dPO8uS+FrCtjzd+mciO/pW/byUd
         FGzem7IH+wT96mdSI8IR3w72Xe4yAEwq0JQT4m34E7CxQ5jnY0G/BmhU8mqUmwiXVP19
         9vJef43XC0BjzKkLz5kep6z8dJSDCahWVeDymF6Xn6gOrtfX71S7Ht4U5zdwniWh4hCc
         sCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a3uSDlfsqZGmv0N4D8ujOHHg7vKPERtZBqNuW3pgYs=;
        b=GMlMvnjXhgNMWNffEinqS0zBP5ZFW2GpNR1Dgkplvoppx/mDTU4WvkbKFxNh8PWcVU
         +OeTc7awnD9tHtUITNCd22WwxTSShSGlhsdvuPHa4Jhx/9C8I6Nanv+NOaSQH1hBSE93
         X79XLGf9tAD+L59DMeB+xpx/2YsP4JdfZa52iEWgECAhoTaASLAjyjend0eMNdfIYRhy
         8t3DMaRZjqfVbtnfLDvUEjex33vP/XrDH2N54ofsXqHHDELuVFDMqiFsXTrQqU328Gen
         UMj7nbT1yYeFDj6bYu+XachOWQV/3qtp1Ww/5w93MZ4hID5dqzKXyV+OuCc61AmE84Pv
         w94w==
X-Gm-Message-State: AO0yUKUyzHzK0qeCmEYLsA2FQIifVymSG2YccT0fQYMgFOSUc34qEZ3D
        jSxDsnw4Vj30NWS1EVNifprdVD2CaHpt7asP+to=
X-Google-Smtp-Source: AK7set/61TNdgiOUotaSqBJ3oG75bxwjctCYlnS41y9hd20++fxhpwwM2eiH4YykdQu4/DE7h9xuedSgKUzR30dWaCU=
X-Received: by 2002:a05:690c:c1a:b0:533:9d13:a067 with SMTP id
 cl26-20020a05690c0c1a00b005339d13a067mr6032856ywb.3.1677445177037; Sun, 26
 Feb 2023 12:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net> <Y/lOlcSpc+d9ytq/@boqun-archlinux>
 <20230225222340.34d749ee.gary@garyguo.net> <Y/rCU1S+GDgIojNf@boqun-archlinux>
 <20230226133606.583cd1d8.gary@garyguo.net> <Y/uiAfZnfbbMrQuD@boqun-archlinux>
In-Reply-To: <Y/uiAfZnfbbMrQuD@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Feb 2023 21:59:25 +0100
Message-ID: <CANiq72kTiHF76T0AycM43qj4rUgQpHzBqXujdvk+H2qoDz22AQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 7:17=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> My preference to function instead of macro here is because I want to
> avoid the extra level of abstraction and make things explict, so that
> users and reviewers can understand the API behavior solely based on
> Rust's types, functions and closures: they are simpler than macros, at
> least to me ;-)

There is one extra problem with the macro: `rustfmt` does not format
the contents if called with braces (as we currently do).

So when I was cleaning some things up for v8, one of the things I did
was run manually `rustfmt` on the blocks by removing the macro
invocation, in commit 77a1a8c952e1 ("rust: kernel: apply `rustfmt` to
`from_kernel_result!` blocks").

Having said that, it does format it when called with parenthesis
wrapping the block, so we could do that if we end up with the macro.

> First, I think the macro version here is just a poor-man's try block, in
> other words, I'd expect explicit use of try blocks intead of
> `from_kernel_result` when the feature is ready. If that's the case, we
> need to change the use sites anyway.

Yeah, if we eventually get a better language feature that fits well,
then we should use it.

> Do both implementation share the same behavior?

Yeah, a `return` will return to the outer caller in the case of a
`try` block, while it returns to the closure (macro) in the other
case. Or do you mean something else?

In that case, I think one could use use a labeled block to `break`
out, not sure if `try` blocks will allow an easier way.

We have a case of such a `return` within the closure at `rust/rust` in
`file.rs`:

    from_kernel_result! {
        let off =3D match whence as u32 {
            bindings::SEEK_SET =3D> SeekFrom::Start(offset.try_into()?),
            bindings::SEEK_CUR =3D> SeekFrom::Current(offset),
            bindings::SEEK_END =3D> SeekFrom::End(offset),
            _ =3D> return Err(EINVAL),
        };
        ...
        Ok(off as bindings::loff_t)
    }

Cheers,
Miguel
