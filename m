Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AAE73630D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFTFOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTFOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874F10D4;
        Mon, 19 Jun 2023 22:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE7A60F35;
        Tue, 20 Jun 2023 05:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E11FC433C0;
        Tue, 20 Jun 2023 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687238077;
        bh=tSbgfbEMjBLEEAVbj8xv8hBno3G6UMoqv4nf2rzY0Sk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b1VAT1BWgHCEbs9AyPVecDH4VMhDc+EAG5acf4B6gqOdV+gY5yWT8IfGM9NyhlUKI
         ANzbmiLJygQw/gQ6JhN/3R0RJrdQPXk5hzmxfbBCRsEnI7cjgb0St4xi6o9LI2L3d7
         Ap7sZuTRGi5+kUwRu/6QW+9wPkjvJspEMTiDaUTTW6ixb5DEBEThOAIl/TY1ot2IXW
         yiu37kJwVfT8SczMCBPcf2exO/JU2pW2ejaDEqx9bfm8UVtEr+bKPKXFQNOYY4sJ26
         dczeJHq3dnmT7QFslKMj/6fD55nWN21xL9DRpxhPMtCkgXNW6hFXx7b44BUinN8wQn
         HBjaWRGqHf8Dg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6b47f3f5358so1143800a34.3;
        Mon, 19 Jun 2023 22:14:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDxt+KUxv0LL5Vb74DhG+fvgM2DPrVCWpzFvgX3Nct4AkvZYIKQL
        uAoDF1+8m9pgxyozFZI9r5Mv2W9DAMP1nZEyjy8=
X-Google-Smtp-Source: ACHHUZ4TedQEyOyNlDl9ckn5WcHyeii1NIgJKE20on5yzLcd9430oT16nGeQYx8F1v6pTgoENP3b5CfK9ueKxwplFpk=
X-Received: by 2002:a9d:6d86:0:b0:6b5:92e9:98cb with SMTP id
 x6-20020a9d6d86000000b006b592e998cbmr757411otp.29.1687238075964; Mon, 19 Jun
 2023 22:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230616001631.463536-1-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 14:13:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnFe8eTGcbh9zxy0eF4HiMbyFzU1vXQ92exFecdAFmxA@mail.gmail.com>
Message-ID: <CAK7LNAQnFe8eTGcbh9zxy0eF4HiMbyFzU1vXQ92exFecdAFmxA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] `scripts/rust_is_available.sh` improvements
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 9:16=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the patch series to improve `scripts/rust_is_available.sh`.
>
> The major addition in v2 is the test suite in the last commit. I added
> it because I wanted to have a proper way to test any further changes to
> it (such as the suggested `set --` idea to avoid forking by Masahiro),
> and so that adding new checks was easier to justify too (i.e. vs. the
> added complexity).
>
> In addition, there are also a few new checks in the script, to cover for
> even some more cases, which hopefully make problematic setups easier to
> identify and solve by users building the kernel. For instance, running
> the script externally gives:
>
>     $ scripts/rust_is_available.sh
>     ***
>     *** Environment variable 'RUSTC' is not set.
>     ***
>     *** This script is intended to be called from Kbuild.
>     *** Please use the 'rustavailable' target to call it instead.
>     *** Otherwise, the results may not be meaningful.
>     ***
>     *** Please see Documentation/rust/quick-start.rst for details
>     *** on how to set up the Rust support.
>     ***
>
> I also changed it to avoid setting `-e` as Masahiro suggested.
> Similarly, I now check for `$RUSTC`, `$BINDGEN` and `$CC`, instead of
> `$MAKEFLAGS`, as he also suggested (but I gave it their own error
> message rather than use the `${CC?: is not set}` approach. This goes in
> line with the reasons outlined above, i.e. trying to give users a clear
> error of what step exactly failed).
>
> In the test suite I included previously problematic compiler version
> strings we got reports for. The test suite covers all current branches
> in the script, and we should keep it that way in the future.
>
> The patch series also include Masahiro's patch to remove the `-v`
> option, as well as Russell's patch for supporting multiple arguments
> in `$CC`.
>
> All in all, this should solve all the issues we got so far (unless I
> have missed something) and improve things further with the new checks
> plus the test suite to hopefully have an easier time in the future.
>
> Testers for this one are appreciated, especially if you have uncommon or
> custom setups for building the kernel.
>
> This could go through either the Kbuild or the Rust tree.


Please feel free to apply it to the Rust tree.
Perhaps I may add minor comments, but it is up to you.





Best Regards
Masahiro Yamada
