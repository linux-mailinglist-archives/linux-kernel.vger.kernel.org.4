Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6F6AD0D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCFVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:51:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B867836;
        Mon,  6 Mar 2023 13:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B574260C8F;
        Mon,  6 Mar 2023 21:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A272EC433D2;
        Mon,  6 Mar 2023 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678139475;
        bh=ZrJmhyMhkUzjCOjMoKs2veezt+FJkmiy4IanCPeTgjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrdQhuBdaJwRseYaFYQvhZbNqmWMvL6JcWBgGrru0xtmfApoh9bVgDL91QyYtJu46
         H0oW9+6Gb41u6zMft3CmOoGewTA/b511tB3pw+UFtseZhnAqGvLzrt540ZdkhRiX2Z
         /A9jIQE3w/wZ/L7NHoa7CpXtnJf76tVy0GG5k2vGsDJT/jkLk4W2i7VrLHSZzae8dq
         0dyXmg+0+BvTiMSGvNIsWIjKWXQtTgJYxbQ+92QO/94c4TZD2PS/IzkWFhz/mUqKLo
         nOVVL59sstJYGawKikg5TZhc7C97QX0pzqe7PKg2o8jrSmz8QZcsfArVqle3tjmRNU
         x6ME9yGFkfgpQ==
Date:   Mon, 6 Mar 2023 21:51:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
Message-ID: <16007014-c5f2-4b07-baec-e19952236aa5@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="27Tfh9qw3tZtvGh2"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27Tfh9qw3tZtvGh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
> This patch series enables the basic ACPI infrastructure for RISC-V.
> Supporting external interrupt controllers is in progress and hence it is
> tested using poll based HVC SBI console and RAM disk.
>=20
> The first patch in this series is one of the patch from Jisheng's
> series [1] which is not merged yet. This patch is required to support
> ACPI since efi_init() which gets called before sbi_init() can enable
> static branches and hits a panic.
>=20
> Patch 2 and 3 are ACPICA patches which are not merged into acpica yet
> but a PR is raised already.
>=20
> Below are two ECRs approved by ASWG.
> RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l=
/view
> RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/=
view
>=20
> The series depends on Anup's IPI improvement series [2].
>=20
> [1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/
> [2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@ventanami=
cro.com/T/

Building a clang-15 allmodconfig (I didn't try gcc) with this series, and
Anup's IPI bits, results in a broken build, due to failings in cmpxchg:

/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
        while (unlikely((ret =3D cmpxchg(&c->value, old, new)) !=3D old)) {
                               ^
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
/stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error:=
 call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BU=
G failed
/stuff/linux/include/linux/atomic/atomic-instrumented.h:1916:2: note: expan=
ded from macro 'cmpxchg'
        arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
        ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from m=
acro 'arch_cmpxchg'
        (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                             ^
/stuff/linux/arch/riscv/include/asm/cmpxchg.h:335:3: note: expanded from ma=
cro '__cmpxchg'
                BUILD_BUG();                                            \
                ^
note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=3D0 =
to see all)
/stuff/linux/include/linux/compiler_types.h:385:2: note: expanded from macr=
o '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
/stuff/linux/include/linux/compiler_types.h:378:4: note: expanded from macr=
o '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:69:1: note: expanded from here
__compiletime_assert_335
^
9 errors generated.

--27Tfh9qw3tZtvGh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZgTQAKCRB4tDGHoIJi
0uBUAPwNyD6kqs6UahOkel8ihw22Ieds7rMpfQendImfuHvc+gD+N829uA3Fy+uc
i1UvPIQcaMWNUL2BVc8u+oJ4lyYh9Qc=
=APgi
-----END PGP SIGNATURE-----

--27Tfh9qw3tZtvGh2--
