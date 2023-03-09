Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061976B2DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCITnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCITnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:43:37 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56FDC0BB;
        Thu,  9 Mar 2023 11:43:34 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53d277c1834so54481537b3.10;
        Thu, 09 Mar 2023 11:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678391013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fzFppmaiKwMNk0er/cwV+CNdXpU1VQrp0ms6icnzwQ=;
        b=farO1s2lLl1ZzC6+RaeHAywmVA8pH4+eSu+hQdD9EidYgOA19kAR9fKQcenYXFpJEq
         i3MfPhRQbdfjbJTQNjLTZ0oX0aCm2mbIAAtrCThMHktDEX0e9oq48nI4jJIUkTh2fFHZ
         npOLUp8J03k2yH2COT7eGF0K/b5oC4cSgl4AfERUion2pEb0Eg7V3CnryJnZK9Eji6Tp
         IRJRVRWutXbyz0xigxp8gKjteJPNIxdjp4OEYTCq98VHw2XoJMDQg3w3JzBR83IDH3ZK
         GlxUQ43zw/o2/dxlmiQMsf0BvLP/SsY3Py1MMc9t2nQZReVfbYfCkw7knA5L6D43CQkw
         CD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678391013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fzFppmaiKwMNk0er/cwV+CNdXpU1VQrp0ms6icnzwQ=;
        b=DEjJMgJHacD+BdRjvHg6muwgUsyyWPwxrCkS3WUATeJStdPsm9gIMg+7/ndtSQZ3d0
         Lo96AaD/YYOd8N2Xl1Xmd4RAY0NJ6K0jq2qZ7NSKwATFzMNs0NP9yotjbKBXBhA75b1r
         SAf4K8pUeVUw0OkOmsPNpXpDTerJpREcBA8t0D5JYgLmsr1WFtWuDPgjPDQBYStGwWf3
         4RMbEr86dpZhy8DUdkD9CS9KexpKeJuuBUJwrJb8AtPX8Wiu5edOt/zoratY/WOvmZb+
         yDOaoi5tfjFL+lCYX7yC7x/ljWX4dD0toQdpfJKX3cjCF9XzWSwYEOsK6DG+YLX0W5rl
         fyjw==
X-Gm-Message-State: AO0yUKWOKX6sfzH+POvtC3sMAc2AotaFr12ZveKC4a+d3Rlen9/aykaP
        erKVKHMDKjBU0VaqRM04rOKgxx6mLk9ToO5VD1g=
X-Google-Smtp-Source: AK7set81OVQ0jMTTm9Fysqt7xMJGFBdLCoTZwS68fmOf8B+wf3hflmeCwvASOIQ5OHY6uzAabYbB+3iLzPcgyJVe8l4=
X-Received: by 2002:a81:a983:0:b0:52e:e095:d840 with SMTP id
 g125-20020a81a983000000b0052ee095d840mr15226417ywh.0.1678391013537; Thu, 09
 Mar 2023 11:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com> <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
 <ZAnB/DozWsir1cIE@kroah.com> <CANeycqrtjKMfpae_DUp-VrDZugJVO7mcbBvUBB+zAc=E6aU4tw@mail.gmail.com>
 <ZAoTNlF+bHyyGs7x@kroah.com>
In-Reply-To: <ZAoTNlF+bHyyGs7x@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 9 Mar 2023 20:43:22 +0100
Message-ID: <CANiq72nkqu+o5QvmLKvk82rJ6b6O2KdC-iYq9zFZFwVyf_Fv9A@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
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

On Thu, Mar 9, 2023 at 6:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I don't understand, why do you need both of these?  Why can't one just
> do?  Why would you need one without the other?  I would think that
> "Device" and "RawDevice" here would be the same thing, that is a way to
> refer to a "larger" underlying struct device memory chunk in a way that
> can be passed around without knowing, or caring, what the "real" device
> type is.
>
> That sounds like a question, and would return a boolean, not a structure =
:)
>
> I don't really understand that, sorry.

To complement what Wedson wrote, perhaps this helps a bit, since there
are a few `*Device` things around (I will prefix things with the
module they are in for clarity):

  - `device::RawDevice` is a trait, not a struct. This means it is
just an interface/property/tag/feature. Then types (like structs) can
say "I support/provide/implement this trait". In this case, it
requires those types implementing `device::RawDevice` to provide a
suitable `raw_device()` method.

  - Then, you have `device::Device`. This is an actual struct,
containing a `struct device *`. It implements `device::RawDevice`, by
returning the pointer.

  - Then there are others like `platform::Device` or `amba::Device`.
They are also structs, containing e.g. `struct platform_device *` or
anything they may need. They implement `device::RawDevice` too if it
makes sense, say, by returning a pointer to the `->dev` in their C
struct.

So you have two different kinds of entities here. One is the trait,
and the others are structs that promise to implement that trait
correctly, regardless of how each struct manages to do it.

The trait can also then provide extra default functionality for those
that have implemented it. For instance, the `clk_get()` method Wedson
mentioned can be defined in the trait, and in its body we can call the
`raw_device()` to do so. `raw_device()` is available because we are
inside the trait, even if each struct implementing the trait provides
a different implementation.

Traits are sometimes named after the "main" method they contain, e.g.
`ToString` may be a trait with a `to_string()` method. Here
`device::RawDevice` has a `raw_device()` method, so it makes sense in
that way.

Wedson was suggesting `device::IsDevice` as an alternative, because
`device::Device` is taken for the ref-counted device. Of course, other
arrangements of names could be possible.

`IsDevice` uses Pascal case, so by convention it would be fairly clear
that it would not be a function returning a boolean. But one may
expect that it is a trait that implements a `is_device()` method,
though. (And if that was the case, which it isn't, one could then
indeed expect that such a method would return the boolean you
expected).

Cheers,
Miguel
