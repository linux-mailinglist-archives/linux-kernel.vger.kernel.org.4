Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4C685CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjBABin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBABil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:38:41 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16D9521DE;
        Tue, 31 Jan 2023 17:38:40 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4fd37a1551cso226563057b3.13;
        Tue, 31 Jan 2023 17:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYV1PkpzfhgRPyGiRj90Sy3TFLGA2xJdyexuKq3v2Js=;
        b=XHlEdUJ03iay/M2j1In2oyHo1cfXjMnm6H/Xi6VsNeZKosP/0RmGkFBacbgKUEqBVX
         i172XHg+X678FCHVRBQi2E68EIzWRcuYKCJvqJBx6Coagl5R8GB+rZ7N0+YKqyxU1mOL
         NTJs2QKMsZ+HcAxWmPozJVLy8AHNYY+RloncPJWJrgcK9s9rIkB2LZhH8hCccxxrPjM4
         pV6ss8Ab8SzeVUB1Q7leZXnLYqrd9wv5DMeAR/hI6djn4/OZ4i5+5na7Oa0sCm7/fZjq
         ojprYntFM7hrCLW+mUs7bU5jfaJurqEiZoiWAeJNCIYXNOrLM4ugSWuJ1fnw7POtAUnl
         5Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYV1PkpzfhgRPyGiRj90Sy3TFLGA2xJdyexuKq3v2Js=;
        b=5cQ+Ly+og9ra4nSjCN6tEsO0OH/rfveqbdFr9zERcQcampZ7lY9jQOa7DwArbgYCm4
         sSEF465LH2dbP+OAK14xbio0fLbRnTTX4H4Cnu9azvP78lQ+JyaePVfJvGEoPO1JdNIF
         rzxfUwBIJlIESLWAHYKgGaDvGl4E/7QxfdPbDbCY5xoQ9vbhGw2uTFntusAZ0ixo0bB0
         kcmUPv54RXezOPT9YCwDmxJ83F9GtnmzHsOmkt2OnPIHxSod3Io12kE5Mo6hC9aXGVhy
         aYle2cNqIIZBPTb5kEWhTlZafRc4ZSHFTD6kNfUyeYW0DmbASigLiKJ4P5Hhk3Y/I1Su
         KcAA==
X-Gm-Message-State: AO0yUKW9CyKnuGumRRZUJAVjgiu6zE27yw5p2q7tnevazrCxt9RDRVv+
        SCJsRFchr2u158ehcTfIqOZu0fNzCXgklC5mdaA5fXZrMoajqw==
X-Google-Smtp-Source: AK7set+iERPfWWyWGiZoAkGhsc3jflB/Hj7kF17HirXukKDxN68JkyGKqVX+lFBorVZcSEKyqJWfcQ+mEh5HrXyxyBg=
X-Received: by 2002:a05:690c:c87:b0:506:c44:ca69 with SMTP id
 cm7-20020a05690c0c8700b005060c44ca69mr40089ywb.67.1675215519931; Tue, 31 Jan
 2023 17:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20230128072258.3384037-1-boqun.feng@gmail.com>
In-Reply-To: <20230128072258.3384037-1-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 1 Feb 2023 02:38:28 +0100
Message-ID: <CANiq72mGk72tvLx+uH-puXZ=MvAA9dzNVqTXYmPq2iadwYuyWA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: MAINTAINERS: Add the zulip link
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
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

On Sat, Jan 28, 2023 at 8:23 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Zulip organization "rust-for-linux" has been created since about 2 years

"was created about 2 years ago ... and has proven" maybe?

> [1]: https://lore.kernel.org/rust-for-linux/CANiq72=3DxVaMQkgCA9rspjV8bhW=
DGqAn4x78B0_4U1WBJYj1PiA@mail.gmail.com/

We typically do links as a tag, like:

    Link: https://..../ [1]

>  R:     Gary Guo <gary@garyguo.net>
>  R:     Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
>  L:     rust-for-linux@vger.kernel.org
> +C:     zulip://rust-for-linux.zulipchat.com
>  S:     Supported
>  W:     https://github.com/Rust-for-Linux/linux
>  B:     https://github.com/Rust-for-Linux/linux/issues

The preferred order according to the top of the file is `C:` after
`B:` -- could you please move it? (even if not everybody follows it)

Thanks Boqun!

Also, for reference for others: a few of us discussed a bit in Zulip
whether to use `zulip://` or `https://` here: `zulip://` hints at the
fact that it is possible to join with apps/clients and not just with a
web browser, which is why Boqun wants to use this one. Support for the
URI scheme in place of the `https://` one isn't great in some of the
apps, though, so I worried it could be confusing.

Hopefully the URI scheme support will improve in the future. So let's
try `zulip://` -- it may help getting better support for that URI
scheme too :)

Cheers,
Miguel
