Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D966B039
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjAOJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjAOJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:52:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD2FC16C;
        Sun, 15 Jan 2023 01:52:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mp20so15148012ejc.7;
        Sun, 15 Jan 2023 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5PAT5gbvWpFDd1BNXjDXD80icdVt9qEy9mpZ08aYmo=;
        b=WQ4Xd3o0yl7OwvS0CQuGLOkQt7LhxH97PP1tRKaLpsp8qT66GRhTYKK7Krd9u08srU
         Ose2Bxt3LyQbxOUr67gy9Gq3dKftWNikDYnc8Rt5NzFLl0r2xUygvixzShVudLm/AZ8M
         2aoidnTW2MhFnkxftgjMUAOwHOEGjUrB/Z+HbUvNktMNu1TcsOBqVoSc2UIEyQD5Hzk8
         Ec4z6y2XWUq/0Lhiq+rCV7P2tWMUo8y1YfuCIOMH+D0xNdu29eAKQQgNDK8Wg5mAF7Q5
         wJDi4vJdIpAaBfFdSTXLB3987jySetsU2c3uCC63cwIx1wl4BHO0pHamaSoTN0pCxRl4
         hPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5PAT5gbvWpFDd1BNXjDXD80icdVt9qEy9mpZ08aYmo=;
        b=sD2Ni9aQfsnH7RNMN8ayeYEq7iOQSZfJLfLuXvYEugKXxnLI91fHnCtbHDuffbpG7F
         UA8UMt0nOQs6B6AhRnneOU0uJmpjXyRX970zpI892gifje2lyKxLaxF2DdPMYoNgpwHG
         0lPd8ntwZJ2Dkdbt1t52NECJ+KsdEkf7nryupfQ5bB3M3vi2RGQ6vtRmm/nOoPjcRvpl
         lWuYzF9xx8rV2vTsnt49VmFEkhjXVtxX2u3VSLV3lIoriWMcakZDG56m9QvUXMSF1aiK
         Kyzdq3+dwT0N7QOFsO1VhypuzP3wEVeUbmlGmXE3S1+veFw5CE4oA1SGRa+Ef69AeVan
         WuBA==
X-Gm-Message-State: AFqh2kqISJMSrZ7SvOOlU0f5XlEgIrX+bJGUZhpCH0utbLYf6qh+yBQa
        fyGLrnzC4HcNHlKoGkUC6qA//bTQE4KCVqHEnsM=
X-Google-Smtp-Source: AMrXdXuvjhkV2ClOM+3EpkLdKMrORPwLfBO58Wf3CxxW7d8MbpeXD7S7sYjkBAemUJorzQ8FZWS6J8eVwUrFgsnZsv8=
X-Received: by 2002:a17:906:cf84:b0:84d:3b6b:74d9 with SMTP id
 um4-20020a170906cf8400b0084d3b6b74d9mr3040829ejb.281.1673776326442; Sun, 15
 Jan 2023 01:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-4-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-4-davidgow@google.com>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Sun, 15 Jan 2023 10:51:29 +0100
Message-ID: <CAA76j92tenVrXX_GfpbUnLBWLdMm1NUrOFqj9Ff8FTzu9P0h9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under
 x86_64 UML
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
        llvm@lists.linux.dev, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
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

On Sat, 17 Dec 2022 at 05:48, David Gow <davidgow@google.com> wrote:
>
> CONFIG_RUST currently supports x86_64, but does not support it under
> UML. With the previous patches applied, adding support is trivial:
> add CONFIG_HAVE_RUST to UML if X86_64 is set.
>
> The scripts/generate_rust_target.rs file already checks for
> CONFIG_X86_64, not CONFIG_X86, so is prepared for UML support.
>
> The Rust support does not currently support X86_32.
>
> Also, update the Rust architecture support documentation to not that
> this is being maintained: I intend to look after this as best I can.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/rust/arch-support.rst | 2 ++
>  arch/um/Kconfig                     | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arc=
h-support.rst
> index 6982b63775da..a526ca1c688b 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -17,3 +17,5 @@ Architecture  Level of support  Constraints
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  ``x86``       Maintained        ``x86_64`` only.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +``um``        Maintained        ``x86_64`` only.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index ad4ff3b0e91e..4db186f019ae 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -28,6 +28,7 @@ config UML
>         select TRACE_IRQFLAGS_SUPPORT
>         select TTY # Needed for line.c
>         select HAVE_ARCH_VMAP_STACK
> +       select HAVE_RUST                        if X86_64
>
>  config MMU
>         bool
> --
> 2.39.0.314.g84b9a713c41-goog
>

Tested-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>

sergio@laptop:~/repos/rust-for-linux$ git log -4 --oneline
888468208678 (HEAD) rust: arch/um: Add support for CONFIG_RUST under x86_64=
 UML
055730a58ded rust: arch/um: Disable FP/SIMD instruction to match x86
924ccc99887f rust: arch/um: Use 'pie' relocation mode under UML
615131b8e9bc (tag: rust-v6.1-rc1, origin/for-next/rust) MAINTAINERS: Rust
sergio@laptop:~/repos/rust-for-linux$ ./tools/testing/kunit/kunit.py
run --kconfig_add CONFIG_RUST=3Dy --make_options LLVM=3D1
[10:43:28] Configuring KUnit Kernel ...
[10:43:28] Building KUnit Kernel ...
Populating config with:
$ make ARCH=3Dum O=3D.kunit olddefconfig LLVM=3D1
Building with:
$ make ARCH=3Dum O=3D.kunit --jobs=3D12 LLVM=3D1
/usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack
section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in
a future version of the linker
/usr/bin/ld: init/main.o: warning: relocation in read-only section `.ref.te=
xt'
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with
RWX permissions
/usr/bin/ld: warning: creating DT_TEXTREL in a PIE
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing
.note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in
a future version of the linker
/usr/bin/ld: init/main.o: warning: relocation in read-only section `.ref.te=
xt'
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with
RWX permissions
/usr/bin/ld: warning: creating DT_TEXTREL in a PIE
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing
.note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in
a future version of the linker
/usr/bin/ld: init/main.o: warning: relocation in read-only section `.ref.te=
xt'
/usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
/usr/bin/ld: warning: creating DT_TEXTREL in a PIE

[10:44:20] Starting KUnit Kernel (1/1)...
[10:44:20] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D time_test_cases (1=
 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] time64_to_tm_test_date_range
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] tim=
e_test_cases =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D resource =
(2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] resource_test_union
[10:44:21] [PASSED] resource_test_intersection
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] resource =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D sysctl_test (10=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] sysctl_test_api_dointvec_null_tbl_data
[10:44:21] [PASSED] sysctl_test_api_dointvec_table_maxlen_unset
[10:44:21] [PASSED] sysctl_test_api_dointvec_table_len_is_zero
[10:44:21] [PASSED] sysctl_test_api_dointvec_table_read_but_position_set
[10:44:21] [PASSED] sysctl_test_dointvec_read_happy_single_positive
[10:44:21] [PASSED] sysctl_test_dointvec_read_happy_single_negative
[10:44:21] [PASSED] sysctl_test_dointvec_write_happy_single_positive
[10:44:21] [PASSED] sysctl_test_dointvec_write_happy_single_negative
[10:44:21] [PASSED] sysctl_test_api_dointvec_write_single_less_int_min
[10:44:21] [PASSED] sysctl_test_api_dointvec_write_single_greater_int_max
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSE=
D] sysctl_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D binfmt_el=
f (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] total_mapping_size_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSE=
D] binfmt_elf =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cpumas=
k (6 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] test_cpumask_weight
[10:44:21] [PASSED] test_cpumask_first
[10:44:21] [PASSED] test_cpumask_last
[10:44:21] [PASSED] test_cpumask_next
[10:44:21] [PASSED] test_cpumask_iterators
[10:44:21] [PASSED] test_cpumask_iterators_builtin
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] cpumask =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D has=
h (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] [PASSED] test_string_or
[10:44:21] [PASSED] test_hash_or
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D [PASSED] hash =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D list_sort=
 (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] list_sort_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] list_sort =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D lib_so=
rt (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] test_sort
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] lib_sort =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit_executor_test (4 s=
ubtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] parse_filter_test
[10:44:21] [PASSED] filter_suites_test
[10:44:21] [PASSED] filter_suites_test_glob_test
[10:44:21] [PASSED] filter_suites_to_empty_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] kunit_exe=
cutor_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit-try-catch-test (2 sub=
tests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] kunit_test_try_catch_successful_try_no_catch
[10:44:21] [PASSED] kunit_test_try_catch_unsuccessful_try_does_catch
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] kunit-try-ca=
tch-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit-resource-test (8 s=
ubtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] kunit_resource_test_init_resources
[10:44:21] [PASSED] kunit_resource_test_alloc_resource
[10:44:21] [PASSED] kunit_resource_test_destroy_resource
[10:44:21] [PASSED] kunit_resource_test_remove_resource
[10:44:21] [PASSED] kunit_resource_test_cleanup_resources
[10:44:21] [PASSED] kunit_resource_test_proper_free_ordering
[10:44:21] [PASSED] kunit_resource_test_static
[10:44:21] [PASSED] kunit_resource_test_named
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] kunit-res=
ource-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit-log-test =
(1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] kunit_log_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] kun=
it-log-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit_status (2=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] kunit_status_set_failure_test
[10:44:21] [PASSED] kunit_status_mark_skipped_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] =
kunit_status =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (3 su=
btests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] string_stream_test_empty_on_creation
[10:44:21] [PASSED] string_stream_test_not_empty_after_add
[10:44:21] [PASSED] string_stream_test_get_string
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-st=
ream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D exampl=
e (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] example_simple_test
[10:44:21] [SKIPPED] example_skip_test
[10:44:21] [SKIPPED] example_mark_skipped_test
[10:44:21] [PASSED] example_all_expect_macros_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] example =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D bitfields=
 (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] test_bitfields_constants
[10:44:21] [PASSED] test_bitfields_variables
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] bitfields =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D list-kunit-test (39 s=
ubtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] list_test_list_init
[10:44:21] [PASSED] list_test_list_add
[10:44:21] [PASSED] list_test_list_add_tail
[10:44:21] [PASSED] list_test_list_del
[10:44:21] [PASSED] list_test_list_replace
[10:44:21] [PASSED] list_test_list_replace_init
[10:44:21] [PASSED] list_test_list_swap
[10:44:21] [PASSED] list_test_list_del_init
[10:44:21] [PASSED] list_test_list_del_init_careful
[10:44:21] [PASSED] list_test_list_move
[10:44:21] [PASSED] list_test_list_move_tail
[10:44:21] [PASSED] list_test_list_bulk_move_tail
[10:44:21] [PASSED] list_test_list_is_head
[10:44:21] [PASSED] list_test_list_is_first
[10:44:21] [PASSED] list_test_list_is_last
[10:44:21] [PASSED] list_test_list_empty
[10:44:21] [PASSED] list_test_list_empty_careful
[10:44:21] [PASSED] list_test_list_rotate_left
[10:44:21] [PASSED] list_test_list_rotate_to_front
[10:44:21] [PASSED] list_test_list_is_singular
[10:44:21] [PASSED] list_test_list_cut_position
[10:44:21] [PASSED] list_test_list_cut_before
[10:44:21] [PASSED] list_test_list_splice
[10:44:21] [PASSED] list_test_list_splice_tail
[10:44:21] [PASSED] list_test_list_splice_init
[10:44:21] [PASSED] list_test_list_splice_tail_init
[10:44:21] [PASSED] list_test_list_entry
[10:44:21] [PASSED] list_test_list_entry_is_head
[10:44:21] [PASSED] list_test_list_first_entry
[10:44:21] [PASSED] list_test_list_last_entry
[10:44:21] [PASSED] list_test_list_first_entry_or_null
[10:44:21] [PASSED] list_test_list_next_entry
[10:44:21] [PASSED] list_test_list_prev_entry
[10:44:21] [PASSED] list_test_list_for_each
[10:44:21] [PASSED] list_test_list_for_each_prev
[10:44:21] [PASSED] list_test_list_for_each_safe
[10:44:21] [PASSED] list_test_list_for_each_prev_safe
[10:44:21] [PASSED] list_test_list_for_each_entry
[10:44:21] [PASSED] list_test_list_for_each_entry_reverse
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] lis=
t-kunit-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D hlist =
(18 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] hlist_test_init
[10:44:21] [PASSED] hlist_test_unhashed
[10:44:21] [PASSED] hlist_test_unhashed_lockless
[10:44:21] [PASSED] hlist_test_del
[10:44:21] [PASSED] hlist_test_del_init
[10:44:21] [PASSED] hlist_test_add
[10:44:21] [PASSED] hlist_test_fake
[10:44:21] [PASSED] hlist_test_is_singular_node
[10:44:21] [PASSED] hlist_test_empty
[10:44:21] [PASSED] hlist_test_move_list
[10:44:21] [PASSED] hlist_test_entry
[10:44:21] [PASSED] hlist_test_entry_safe
[10:44:21] [PASSED] hlist_test_for_each
[10:44:21] [PASSED] hlist_test_for_each_safe
[10:44:21] [PASSED] hlist_test_for_each_entry
[10:44:21] [PASSED] hlist_test_for_each_entry_continue
[10:44:21] [PASSED] hlist_test_for_each_entry_from
[10:44:21] [PASSED] hlist_test_for_each_entry_safe
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D [PASSED] hlist =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D bits-test=
 (3 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] genmask_test
[10:44:21] [PASSED] genmask_ull_test
[10:44:21] [PASSED] genmask_input_check_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] bits-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cmdlin=
e (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] cmdline_test_noint
[10:44:21] [PASSED] cmdline_test_lead_int
[10:44:21] [PASSED] cmdline_test_tail_int
[10:44:21] [PASSED] cmdline_test_range
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] cmdline =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D slub_test=
 (5 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] test_clobber_zone
[10:44:21] [PASSED] test_next_pointer
[10:44:21] [PASSED] test_first_word
[10:44:21] [PASSED] test_clobber_50th_byte
[10:44:21] [PASSED] test_clobber_redzone_free
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] slub_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D memcpy=
 (3 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] memset_test
[10:44:21] [PASSED] memcpy_test
[10:44:21] [PASSED] memmove_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] memcpy =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D overflow =
(11 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] u8_overflow_test
[10:44:21] [PASSED] s8_overflow_test
[10:44:21] [PASSED] u16_overflow_test
[10:44:21] [PASSED] s16_overflow_test
[10:44:21] [PASSED] u32_overflow_test
[10:44:21] [PASSED] s32_overflow_test
[10:44:21] [PASSED] u64_overflow_test
[10:44:21] [PASSED] s64_overflow_test
[10:44:21] [PASSED] overflow_shift_test
[10:44:21] [PASSED] overflow_allocation_test
[10:44:21] [PASSED] overflow_size_helpers_test
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] overflow =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D stackinit (6=
5 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] test_u8_zero
[10:44:21] [PASSED] test_u16_zero
[10:44:21] [PASSED] test_u32_zero
[10:44:21] [PASSED] test_u64_zero
[10:44:21] [PASSED] test_char_array_zero
[10:44:21] [PASSED] test_small_hole_zero
[10:44:21] [PASSED] test_big_hole_zero
[10:44:21] [PASSED] test_trailing_hole_zero
[10:44:21] [PASSED] test_packed_zero
[10:44:21] [PASSED] test_small_hole_dynamic_partial
[10:44:21] [PASSED] test_big_hole_dynamic_partial
[10:44:21] [PASSED] test_trailing_hole_dynamic_partial
[10:44:21] [PASSED] test_packed_dynamic_partial
[10:44:21] [PASSED] test_small_hole_assigned_dynamic_partial
[10:44:21] [PASSED] test_big_hole_assigned_dynamic_partial
[10:44:21] [PASSED] test_trailing_hole_assigned_dynamic_partial
[10:44:21] [PASSED] test_packed_assigned_dynamic_partial
[10:44:21] [PASSED] test_small_hole_static_partial
[10:44:21] [PASSED] test_big_hole_static_partial
[10:44:21] [PASSED] test_trailing_hole_static_partial
[10:44:21] [PASSED] test_packed_static_partial
[10:44:21] [PASSED] test_small_hole_static_all
[10:44:21] [PASSED] test_big_hole_static_all
[10:44:21] [PASSED] test_trailing_hole_static_all
[10:44:21] [PASSED] test_packed_static_all
[10:44:21] [PASSED] test_small_hole_dynamic_all
[10:44:21] [PASSED] test_big_hole_dynamic_all
[10:44:21] [PASSED] test_trailing_hole_dynamic_all
[10:44:21] [PASSED] test_packed_dynamic_all
[10:44:21] [PASSED] test_small_hole_runtime_partial
[10:44:21] [PASSED] test_big_hole_runtime_partial
[10:44:21] [PASSED] test_trailing_hole_runtime_partial
[10:44:21] [PASSED] test_packed_runtime_partial
[10:44:21] [PASSED] test_small_hole_runtime_all
[10:44:21] [PASSED] test_big_hole_runtime_all
[10:44:21] [PASSED] test_trailing_hole_runtime_all
[10:44:21] [PASSED] test_packed_runtime_all
[10:44:21] [PASSED] test_small_hole_assigned_static_partial
[10:44:21] [PASSED] test_big_hole_assigned_static_partial
[10:44:21] [PASSED] test_trailing_hole_assigned_static_partial
[10:44:21] [PASSED] test_packed_assigned_static_partial
[10:44:21] [PASSED] test_small_hole_assigned_static_all
[10:44:21] [PASSED] test_big_hole_assigned_static_all
[10:44:21] [PASSED] test_trailing_hole_assigned_static_all
[10:44:21] [PASSED] test_packed_assigned_static_all
[10:44:21] [PASSED] test_small_hole_assigned_dynamic_all
[10:44:21] [PASSED] test_big_hole_assigned_dynamic_all
[10:44:21] [PASSED] test_trailing_hole_assigned_dynamic_all
[10:44:21] [PASSED] test_packed_assigned_dynamic_all
[10:44:21] [SKIPPED] test_small_hole_assigned_copy
[10:44:21] [SKIPPED] test_big_hole_assigned_copy
[10:44:21] [SKIPPED] test_trailing_hole_assigned_copy
[10:44:21] [PASSED] test_packed_assigned_copy
[10:44:21] [PASSED] test_u8_none
[10:44:21] [PASSED] test_u16_none
[10:44:21] [PASSED] test_u32_none
[10:44:21] [PASSED] test_u64_none
[10:44:21] [PASSED] test_char_array_none
[10:44:21] [SKIPPED] test_switch_1_none
[10:44:21] [SKIPPED] test_switch_2_none
[10:44:21] [PASSED] test_small_hole_none
[10:44:21] [PASSED] test_big_hole_none
[10:44:21] [PASSED] test_trailing_hole_none
[10:44:21] [PASSED] test_packed_none
[10:44:21] [PASSED] test_user
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PA=
SSED] stackinit =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D qos-kunit-test (3 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] freq_qos_test_min
[10:44:21] [PASSED] freq_qos_test_maxdef
[10:44:21] [PASSED] freq_qos_test_readd
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] qos=
-kunit-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D property-entry (7 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] [PASSED] pe_test_uints
[10:44:21] [PASSED] pe_test_uint_arrays
[10:44:21] [PASSED] pe_test_strings
[10:44:21] [PASSED] pe_test_bool
[10:44:21] [PASSED] pe_test_move_inline_u8
[10:44:21] [PASSED] pe_test_move_inline_str
[10:44:21] [PASSED] pe_test_reference
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] pro=
perty-entry =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:44:21] Testing complete. Ran 208 tests: passed: 201, skipped: 7
[10:44:21] Elapsed time: 52.940s total, 0.001s configuring, 52.223s
building, 0.696s running

sergio@laptop:~/repos/rust-for-linux$ date
dom 15 ene 2023 10:44:26 CET
sergio@laptop:~/repos/rust-for-linux$ grep CONFIG_RUST .kunit/.config
CONFIG_RUST_IS_AVAILABLE=3Dy
CONFIG_RUST=3Dy
CONFIG_RUSTC_VERSION_TEXT=3D"rustc 1.62.0 (a8314ef7d 2022-06-27)"
# CONFIG_RUST_DEBUG_ASSERTIONS is not set
CONFIG_RUST_OVERFLOW_CHECKS=3Dy
