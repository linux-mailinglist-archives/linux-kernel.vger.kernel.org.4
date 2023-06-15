Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67129730FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbjFOGtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjFOGtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549C42D62;
        Wed, 14 Jun 2023 23:47:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b41e700103so8525101fa.2;
        Wed, 14 Jun 2023 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686811677; x=1689403677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3hoT+7D5pHhrPbVSfAK0c9rFMVCQODh4bvnFJ3aIXs=;
        b=RxypO+7ulWZW2Xd+Brv2amG47hyOVkgve8lccmYw435rjgP5mnEHwEMJ5l9qE06jxr
         BATtcCQ9MnLq591v6s1aOZXOf0oNj3RcEg800iQbMrThqogq2CP6cDxs25JQaD5vvZ9w
         Ng4KG5g4BdnnHaP/3BFBCJnQiJvHxZcvZgdaiGw5+PUMY7Qy4atu5/oQ7YCesivzrIbZ
         hEmsvXsfRaVeuHtK0QzQODKWMfPBnGvrU+XACovC8DysfDvLWoU8VXKXhrK0JJA7fe3r
         rkkNBr5cjVgY/SEWCDPyAJukNrIftsomrpQJlCPgEmVhsyNbEruckQUGWyyyviqPAZWw
         bnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686811677; x=1689403677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3hoT+7D5pHhrPbVSfAK0c9rFMVCQODh4bvnFJ3aIXs=;
        b=Ce3xNLtxZ29D0oJjlTGQOI3wvsR7e1sdQeeRW15Clrp9trjUUoCvdTMSM7bjhRX2gx
         4ZcjBg18DZyW8g+nI+r50aLcGxYrtNga+05UF9PMDfITMpuO6og5V1HUES2g17BP7oeI
         ki9v6Csw4fNOVFjjYknRMvKvjj24NNjctaHBZR7vZDfe+nveEQFPPKt0HP2wJAIKbijC
         dBhx/9Eafq2TV2/jGxh7iCsthJ/hpDUSaHlXgy001blS5VQvqrPm3KYj8nwVJIbo4jbk
         8BWyobCB1UHc652oVAUYVhKW6ZLGvYp3QzQch9CEDfvUB85LXCGFiE06re57ASIEiY4M
         /EkA==
X-Gm-Message-State: AC+VfDyLR66gisioGBiNNfEgapnMiW6fN1N069rCk45KHehtYXHH3POU
        GmGnArIpHWQlbiYHXlCeSVkIpzJ3egEtIvyJVUukIYnqWVEOzdYU
X-Google-Smtp-Source: ACHHUZ5TG9GTRx5egU/FbTNEndD607mf6f3ksMH2dhB+MQ7nXugStpQPhd/DAXiYROaM8g4S6iaJBdyGbNFHKnd0LmM=
X-Received: by 2002:a2e:7d18:0:b0:2b1:fcb2:3026 with SMTP id
 y24-20020a2e7d18000000b002b1fcb23026mr7426249ljc.5.1686811677057; Wed, 14 Jun
 2023 23:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230612194311.24826-1-aakashsensharma@gmail.com> <20230614194930.5da4e418.gary@garyguo.net>
In-Reply-To: <20230614194930.5da4e418.gary@garyguo.net>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 15 Jun 2023 09:47:45 +0300
Message-ID: <CAPDJoNu42E-_qrKB0s27POgaL6Np7-4=UO_5D27oOPaB4fEgwA@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: upgrade to 0.65.1
To:     Gary Guo <gary@garyguo.net>
Cc:     Aakash Sen Sharma <aakashsensharma@gmail.com>, corbet@lwn.net,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, bjorn3_gh@protonmail.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, masahiroy@kernel.org,
        me@kloenk.de, aliceryhl@google.com, benno.lossin@proton.me,
        dev@niklasmohrin.de, lina@asahilina.net, hca@linux.ibm.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Ariel Miculas <amiculas@cisco.com>

On Wed, Jun 14, 2023 at 9:52=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue, 13 Jun 2023 01:13:11 +0530
> Aakash Sen Sharma <aakashsensharma@gmail.com> wrote:
>
> > * Rationale:
> >
> > Upgrades bindgen to code-generation for anonymous unions, structs, and =
enums [7]
> > for LLVM-16 based toolchains.
> >
> > The following upgrade also incorporates `noreturn` support from bindgen
> > allowing us to remove useless `loop` calls which was placed as a
> > workaround.
> >
> > * Truncated build logs on using bindgen `v0.56.0` prior to LLVM-16 tool=
chain:
> >
> > ```
> > $ make rustdoc LLVM=3D1 CLIPPY=3D1 -j$(nproc)
> >   RUSTC L rust/core.o
> >   BINDGEN rust/bindings/bindings_generated.rs
> >   BINDGEN rust/bindings/bindings_helpers_generated.rs
> >   BINDGEN rust/uapi/uapi_generated.rs
> > thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/=
include/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macr=
o2-1.0.24/src/fallback.rs:693:9
> > ...
> > thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/=
include/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macr=
o2-1.0.24/src/fallback.rs:693:9
> > ...
> > ```
> >
> > * LLVM-16 Changes:
> >
> > API changes [1] were introduced such that libclang would emit names lik=
e
> > "(unnamed union at compiler_types.h:146:2)" for unnamed unions, structs=
, and
> > enums whereas it previously returned an empty string.
> >
> > * Bindgen Changes:
> >
> > Bindgen `v0.56.0` on LLVM-16 based toolchains hence was unable to proce=
ss the
> > anonymous union in `include/linux/compiler_types` `struct ftrace_branch=
_data`
> > and caused subsequent panics as the new `libclang` API emitted name was=
 not
> > being handled. The following issue was fixed in Bindgen `v0.62.0` [2].
> >
> > Bindgen `v0.58.0` changed the flags `--whitelist-*` and `--blacklist-*`
> > to `--allowlist-*` and `--blocklist-*` respectively [3].
> >
> > Bindgen `v0.61.0` added support for `_Noreturn`, `[[noreturn]]`, `__att=
ribute__((noreturn))` [4],
> > hence the empty `loop`s used to circumvent bindgen returning `!` in pla=
ce of `()`
> > for noreturn attributes have been removed completely.
> >
> > Bindgen `v0.61.0` also changed default functionality to bind `size_t` t=
o `usize` [5] and
> > added the `--no-size_t-is-usize` [5] flag to not bind `size_t` as `usiz=
e`.
> >
> > Bindgen `v0.65.0` removed `--size_t-is-usize` flag [6].
> >
> > Link: https://github.com/llvm/llvm-project/commit/19e984ef8f49bc3ccced1=
5621989fa9703b2cd5b [1]
> > Link: https://github.com/rust-lang/rust-bindgen/pull/2319 [2]
> > Link: https://github.com/rust-lang/rust-bindgen/pull/1990 [3]
> > Link: https://github.com/rust-lang/rust-bindgen/issues/2094 [4]
> > Link: https://github.com/rust-lang/rust-bindgen/commit/cc78b6fdb6e829e5=
fb8fa1639f2182cb49333569 [5]
> > Link: https://github.com/rust-lang/rust-bindgen/pull/2408 [6]
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1013 [7]
> > Signed-off-by: Aakash Sen Sharma <aakashsensharma@gmail.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> > ---
> >  Documentation/process/changes.rst |  2 +-
> >  rust/Makefile                     |  6 +++---
> >  rust/helpers.c                    | 13 ++++++-------
> >  rust/kernel/lib.rs                |  3 ---
> >  scripts/min-tool-version.sh       |  2 +-
> >  5 files changed, 11 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/=
changes.rst
> > index ef540865ad22..5f21c4c6cf5c 100644
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@ -32,7 +32,7 @@ you probably needn't concern yourself with pcmciautil=
s.
> >  GNU C                  5.1              gcc --version
> >  Clang/LLVM (optional)  11.0.0           clang --version
> >  Rust (optional)        1.62.0           rustc --version
> > -bindgen (optional)     0.56.0           bindgen --version
> > +bindgen (optional)     0.65.1           bindgen --version
> >  GNU make               3.82             make --version
> >  bash                   4.2              bash --version
> >  binutils               2.25             ld -v
> > diff --git a/rust/Makefile b/rust/Makefile
> > index f88d108fbef0..c187c6f3a384 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -279,7 +279,7 @@ quiet_cmd_bindgen =3D BINDGEN $@
> >       $(BINDGEN) $< $(bindgen_target_flags) \
> >               --use-core --with-derive-default --ctypes-prefix core::ff=
i --no-layout-tests \
> >               --no-debug '.*' \
> > -             --size_t-is-usize -o $@ -- $(bindgen_c_flags_final) -DMOD=
ULE \
> > +             -o $@ -- $(bindgen_c_flags_final) -DMODULE \
> >               $(bindgen_target_cflags) $(bindgen_target_extra)
> >
> >  $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags =
=3D \
> > @@ -293,8 +293,8 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindi=
ngs/bindings_helper.h \
> >  # given it is `libclang`; but for consistency, future Clang changes an=
d/or
> >  # a potential future GCC backend for `bindgen`, we disable it too.
> >  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_=
flags =3D \
> > -    --blacklist-type '.*' --whitelist-var '' \
> > -    --whitelist-function 'rust_helper_.*'
> > +    --blocklist-type '.*' --allowlist-var '' \
> > +    --allowlist-function 'rust_helper_.*'
> >  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_=
cflags =3D \
> >      -I$(objtree)/$(obj) -Wno-missing-prototypes -Wno-missing-declarati=
ons
> >  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_=
extra =3D ; \
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 121583282976..98d9ef47225b 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -122,19 +122,18 @@ void rust_helper_put_task_struct(struct task_stru=
ct *t)
> >  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> >
> >  /*
> > - * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t=
` type
> > - * as the Rust `usize` type, so we can use it in contexts where Rust
> > - * expects a `usize` like slice (array) indices. `usize` is defined to=
 be
> > - * the same as C's `uintptr_t` type (can hold any pointer) but not
> > - * necessarily the same as `size_t` (can hold the size of any single
> > + * `bindgen` binds the C `size_t` type the Rust `usize` type, so we ca=
n
> > + * use it in contexts where Rust expects a `usize` like slice (array) =
indices.
> > + * `usize` is defined to be the same as C's `uintptr_t` type (can hold=
 any pointer)
> > + * but not necessarily the same as `size_t` (can hold the size of any =
single
> >   * object). Most modern platforms use the same concrete integer type f=
or
> >   * both of them, but in case we find ourselves on a platform where
> >   * that's not true, fail early instead of risking ABI or
> >   * integer-overflow issues.
> >   *
> >   * If your platform fails this assertion, it means that you are in
> > - * danger of integer-overflow bugs (even if you attempt to remove
> > - * `--size_t-is-usize`). It may be easiest to change the kernel ABI on
> > + * danger of integer-overflow bugs (even if you attempt to add
> > + * `--no-size_t-is-usize`). It may be easiest to change the kernel ABI=
 on
> >   * your platform such that `size_t` matches `uintptr_t` (i.e., to incr=
ease
> >   * `size_t`, because `uintptr_t` has to be at least as big as `size_t`=
).
> >   */
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index ee27e10da479..1b0dcf03b9c2 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -95,7 +95,4 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
> >      pr_emerg!("{}\n", info);
> >      // SAFETY: FFI call.
> >      unsafe { bindings::BUG() };
> > -    // Bindgen currently does not recognize `__noreturn` so `BUG` retu=
rns `()`
> > -    // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/=
issues/2094>.
> > -    loop {}
> >  }
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 20d483ec6f5f..5b80c5d3a9f8 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -30,7 +30,7 @@ rustc)
> >       echo 1.62.0
> >       ;;
> >  bindgen)
> > -     echo 0.56.0
> > +     echo 0.65.1
> >       ;;
> >  *)
> >       echo "$1: unknown tool" >&2
> > --
> > 2.40.1
> >
>
