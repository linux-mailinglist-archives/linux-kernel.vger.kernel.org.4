Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC0736327
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFTF1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTF1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EA185;
        Mon, 19 Jun 2023 22:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FD260F38;
        Tue, 20 Jun 2023 05:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E00FC433D9;
        Tue, 20 Jun 2023 05:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687238830;
        bh=tiI3VGfsL8gKc/bRU3EleHUPx2M61lfNJEcBUuB9vq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jo5XT1eH8P9E1q9rMYFPNxTTfxBO4FO181LfsG6wKE2KIzeB7qiTR0zzqL9Y5aZZm
         HA0uqEnlC1U/j8swQtMPARhkivxwBykY1b3ee5cv4tkgZFaZK9Rve2CSGuXNtCcc4g
         WmP+TaGYaI2kF2ZsWJNfzMvgUKo3mcCeK6rxRVAisO5tL+wrQI3oH4SYTG+0mToZkl
         jx7yZIYQpHlhjn3rZuTrBiP2b4fOUK4KXNQ0Se+GAar/zA5TXDlPt6FQyC4kQrt41F
         lgwwpT9CTp+PsZHgolTIDizdyVv5FuHjy7eMZzBSzWdQu2qoaVjVVHygE+jGaQ+SeY
         bRxVyTL3iYOiQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-558a79941c6so2874463eaf.3;
        Mon, 19 Jun 2023 22:27:10 -0700 (PDT)
X-Gm-Message-State: AC+VfDwgFS0n1na18gAvvg+ha1EYlAU4bc/nMejaDkVicyEmKDIpxDkw
        NQP/VID3HAUwypsBzsXkcbRpcTAjQmVHsFuNlTg=
X-Google-Smtp-Source: ACHHUZ4kT05bFp2F2OhC5RWNtAb18rJ72zRh1SDV2eWBsz3V+QuG9vxyaYsjeed4LIGpthO6PGccOVOyynF8Mx3pv5Y=
X-Received: by 2002:a4a:a7cd:0:b0:55e:54db:c453 with SMTP id
 n13-20020a4aa7cd000000b0055e54dbc453mr3955562oom.7.1687238829822; Mon, 19 Jun
 2023 22:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230616001631.463536-1-ojeda@kernel.org> <20230616001631.463536-5-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-5-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 14:26:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWkqKNGKNWJpzFLxSLjE5NhJ0rzbbM3QGTahfsrF2ccQ@mail.gmail.com>
Message-ID: <CAK7LNARWkqKNGKNWJpzFLxSLjE5NhJ0rzbbM3QGTahfsrF2ccQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] kbuild: rust_is_available: print docs reference
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Finn Behrens <fin@nyantec.com>
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

On Fri, Jun 16, 2023 at 9:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> People trying out the Rust support in the kernel may get
> warnings and errors from `scripts/rust_is_available.sh`
> from the `rustavailable` target or the build step.
>
> Some of those users may be following the Quick Start guide,
> but others may not (likely those getting warnings from
> the build step instead of the target).
>
> While the messages are fairly clear on what the problem is,
> it may not be clear how to solve the particular issue,
> especially for those not aware of the documentation.
>
> We could add all sorts of details on the script for each one,
> but it is better to point users to the documentation instead,
> where it is easily readable in different formats. It also
> avoids duplication.
>
> Thus add a reference to the documentation whenever the script
> fails or there is at least a warning.
>
> Reviewed-by: Finn Behrens <fin@nyantec.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/rust_is_available.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 0c9be438e4cd..6b8131d5b547 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -19,6 +19,20 @@ get_canonical_version()
>         echo $((100000 * $1 + 100 * $2 + $3))
>  }
>
> +# Print a reference to the Quick Start guide in the documentation.
> +print_docs_reference()
> +{
> +       echo >&2 "***"
> +       echo >&2 "*** Please see Documentation/rust/quick-start.rst for d=
etails"
> +       echo >&2 "*** on how to set up the Rust support."
> +       echo >&2 "***"
> +}
> +
> +# If the script fails for any reason, or if there was any warning, then
> +# print a reference to the documentation on exit.
> +warning=3D0
> +trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference; =
fi' EXIT


I confirmed that
pressing Ctrl-C while rust_is_available.sh is running
does not invoke print_docs_reference().
(and I believe that is the right behavior).

I also checked bash and dash work in the same way.
(I usually test both because the POSIX does not define the exact
condition when the EXIT handler is invoked.)


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>












> +
>  # Check that the Rust compiler exists.
>  if ! command -v "$RUSTC" >/dev/null; then
>         echo >&2 "***"
> @@ -60,6 +74,7 @@ if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_=
cversion" ]; then
>         echo >&2 "***   Your version:     $rust_compiler_version"
>         echo >&2 "***   Expected version: $rust_compiler_min_version"
>         echo >&2 "***"
> +       warning=3D1
>  fi
>
>  # Check that the Rust bindings generator is suitable.
> @@ -87,6 +102,7 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bi=
ndings_generator_min_cvers
>         echo >&2 "***   Your version:     $rust_bindings_generator_versio=
n"
>         echo >&2 "***   Expected version: $rust_bindings_generator_min_ve=
rsion"
>         echo >&2 "***"
> +       warning=3D1
>  fi
>
>  # Check that the `libclang` used by the Rust bindings generator is suita=
ble.
> @@ -126,6 +142,7 @@ if [ "$cc_name" =3D Clang ]; then
>                 echo >&2 "***   libclang version: $bindgen_libclang_versi=
on"
>                 echo >&2 "***   Clang version:    $clang_version"
>                 echo >&2 "***"
> +               warning=3D1
>         fi
>  fi
>
> --
> 2.41.0
>


--
Best Regards
Masahiro Yamada
