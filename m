Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6323265C1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjACOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjACOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:19:56 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8392259;
        Tue,  3 Jan 2023 06:19:55 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-476e643d1d5so321631187b3.1;
        Tue, 03 Jan 2023 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8rtKZ+QTL7/5Qarqo9MftuoiK8ia4Q77nefU4MQ9Yc=;
        b=hL9WauySBN/sRqfbNsfyrbzhd90BB6grt3xtnVeuw9DJ/r70Gme9mRyLvv5T2RmAFk
         PZwIafpHFUf4cs6672O3Gj0q1zHDbiAE5ESGSfX/mZbIYuX5U2LywtIWBCdjIoDgA3QX
         DxCj6Z4POfGVN4Tgghz6N1RwPzO/aoXKBOUU2e2s08CF72tzJ1iFv2+NoQUqIVtn1y/y
         SR6CHMDBSlzGDUzCrVm3zhstnxYs8+A344wE4//bvCSQm7TOoM5YVO6nwiGWQWfZkqYi
         x6JgRoX+Ri7pmiUvLhV4lqSfUJqePmelttnRIU26nrgxZazBsJFMXUYbRnV6dGSooZ58
         jDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8rtKZ+QTL7/5Qarqo9MftuoiK8ia4Q77nefU4MQ9Yc=;
        b=7ICm3eweH9HtIzVtK6UQuNi0RsE5kzmIGjbEEL6A6V7whS0evDi4g+FH5XLkX9VriT
         MAK2Zzqxu3vWeFp17iR2NX+SxeFI9/FkbjYJmYtSjqzexf8qcoEOiCmVXIJTC1NINWNP
         HCqZ8swxDzGpGFcvK83nVKVeed4ErOwlmg3Nuqbj0/Bpd3obtPVg0z1BI/Wqx4Ll0OIK
         ImUMlqZp/RhHjRWgF54bFDQli4gd4auEdpo4vqWtglMnSFpdqsNEgIPbOlS64QGshIT+
         Q5Wl3EeORvoxc3R7tnNf4wW2FlRf+MkydlBteiIsUKXSc9XGGEkiWT8Zq12SYcWE4sru
         p/MQ==
X-Gm-Message-State: AFqh2krhDh+AaW50bX5D7Ko7HsTwXiWEkC2kzRWfKZMv6qKtOi8gQU19
        oW8cOZZAlCTl9nH9YZJv5SDmXQhLm2WffJlb05Q=
X-Google-Smtp-Source: AMrXdXsB/B7CRNRIAy1wo10Zbloi+XkYaCnF9Tc4hrhG4A3JJ+5E6EVThxaM6wenO0q2R6hu65m3APjLlB/q9UH2RL8=
X-Received: by 2002:a81:7343:0:b0:484:a94f:210 with SMTP id
 o64-20020a817343000000b00484a94f0210mr3055550ywc.129.1672755595132; Tue, 03
 Jan 2023 06:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com> <87wn64fq7d.fsf@meer.lwn.net>
In-Reply-To: <87wn64fq7d.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 15:19:44 +0100
Message-ID: <CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org
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

On Tue, Jan 3, 2023 at 12:54 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> - It forces the generation of a kernel configuration, something that the
>   docs build has never done until now.  What are our changes of
>   eliminating that?

We could workaround it by providing a fixed, preset config that does
not interfere with the usual `.config`.

We would still need to compile some things like we normally would do,
though (see next point).

> - It did a bunch of other building, starting with objtool - again, never
>   needed for the docs build before.

Yeah, rustdoc, like the compiler, requires dependencies to be
available to understand the code. Thus some things need to be
compiled, like for the normal build.

This is definitely different than the current docs, of course, which
is why I raised these questions back then.

> In the end, it died with:
>
> > BINDGEN rust/bindings/bindings_generated.rs
> > Failed to run rustfmt: No such file or directory (os error 2) (non-fatal, continuing)

This one is unrelated -- it happens when rustfmt is not installed, so
that those interested in only building (but not developing) the kernel
can avoid it. We could hide the message, though for developers it is
useful to know.

This is one instance where knowing in the build system whether the
user intends to developer the kernel or not could be useful (e.g. we
could hide it for some of the distribution/packaging targets); but I
would prefer to simply make rustfmt mandatory, since in principle
there could be a rustfmt bug that makes a behavioral change, and it
would simplify things (it comes with the compiler anyway).

> >   BINDGEN rust/bindings/bindings_helpers_generated.rs
> > error: Found argument '--blacklist-type' which wasn't expected, or isn't valid in this context
> >
> >       Did you mean '--blocklist-type'?
>
> Perhaps this is because I ignored the warnings about my Rust toolchain
> being too new? (Rust 1.65.0, bindgen 0.63.0).  I get that only one

Yeah, that is due to bindgen 0.63.0 removing [1] some flags deprecated
[2] in 0.58.0.

[1] https://github.com/rust-lang/rust-bindgen/blob/v0.63.0/CHANGELOG.md#removed-1
[2] https://github.com/rust-lang/rust-bindgen/blob/v0.58.0/CHANGELOG.md#deprecated-1

> version is really supported, but it would be nice to fail a bit more
> gracefully if at all possible.

Do you mean failing in the `scripts/rust_is_available.sh` step instead
of warning? We could also add versioning information to that script,
so that it knows more about which versions work etc., but I guess at
that point it would be best to simply start supporting several
versions, which may be a bit too early to split CI runs on that since
it would require some degree of testing.

Cheers,
Miguel
