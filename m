Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7C6A41B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjB0McL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0McJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:32:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224D1DB88;
        Mon, 27 Feb 2023 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677501129; x=1709037129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RO6aTFXermoMWjG0Tt8TtnTKM9NV8n7SoUu00FD0WU8=;
  b=SqUltUsXjDojHVVwEProOQMgGIAAZec89IrbIb7tgPgyy9HvoTYE+ARs
   zVJnUwiNutvqhgu6zI/mnLZALMEKdm0M+igOcBMxv9qvVocbrNchgyJ7Q
   vyni6PqQmVQEACVZBZUfRv8AvH9MvgtlL3rl4ehAuk2E76SA0n3eIzfOq
   2+200MnRsZwQuQL8gLAYwch/g1qr+W7Ho59xBXlGA4IJk9DXO9Gm2k1up
   k3ADLLGKCBaLwQV7LpZJ/ZZP6SfxjLzmRHDHsv5+tLU8giBKcl3rpKcaf
   QW+5mJzAdWtA+5psG/+9d/rILFXNZnmIVyrpoKefYmC6P0CjqI0LVZhsy
   w==;
X-IronPort-AV: E=Sophos;i="5.97,332,1669100400"; 
   d="asc'?scan'208";a="202701616"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 05:31:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 05:31:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 27 Feb 2023 05:31:43 -0700
Date:   Mon, 27 Feb 2023 12:31:16 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <nathan@kernel.org>, <llvm@lists.linux.dev>,
        <ndesaulniers@google.com>
Subject: Re: [PATCH v7 1/1] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <Y/yilORflGv3vXjX@wendy>
References: <20230224100218.1824569-1-alexghiti@rivosinc.com>
 <20230224100218.1824569-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8ORzwRGnfaATysc6"
Content-Disposition: inline
In-Reply-To: <20230224100218.1824569-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8ORzwRGnfaATysc6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex, clang/llvm folk,

On Fri, Feb 24, 2023 at 11:02:18AM +0100, Alexandre Ghiti wrote:
> Add 2 early command line parameters that allow to downgrade satp mode
> (using the same naming as x86):
> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>=20
> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>=20
> In KASAN kernels, we can't use the libfdt that early in the boot process
> since we are not ready to execute instrumented functions. So instead of
> using the "generic" libfdt, we compile our own versions of those functions
> that are not instrumented and that are prefixed so that they do not
> conflict with the generic ones. We also need the non-instrumented versions
> of the string functions and the prefixed versions of memcpy/memmove.
>=20
> This is largely inspired by commit aacd149b6238 ("arm64: head: avoid
> relocating the kernel twice for KASLR") from which I removed compilation
> flags that were not relevant to RISC-V at the moment (LTO, SCS, pie).
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> Reviewed-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +-
>  arch/riscv/kernel/Makefile                    |  2 +
>  arch/riscv/kernel/pi/Makefile                 | 37 +++++++++++
>  arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++

+      4 ld.lld: warning: vmlinux.a(arch/riscv/kernel/pi/string.pi.o):(.ini=
t.sdata) is being placed in '.init.sdata'

I'm getting 4 new linker warnings with LLVM=3D1 clang-15 allmodconfig
builds - but I don't really understand this issue.
Is this spurious, and a just consequence of...

> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
> new file mode 100644
> index 000000000000..4002ed94b6d3
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/Makefile
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# This file was copied from arm64/kernel/pi/Makefile.
> +
> +KBUILD_CFLAGS	:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> +		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
> +		   $(call cc-option,-mbranch-protection=3Dnone) \
> +		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
> +		   -D__DISABLE_EXPORTS -ffreestanding \
> +		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
> +		   $(call cc-option,-fno-addrsig)
> +
> +CFLAGS_cmdline_early.o +=3D -D__NO_FORTIFY
> +CFLAGS_lib-fdt_ro.o +=3D -D__NO_FORTIFY
> +
> +GCOV_PROFILE	:=3D n
> +KASAN_SANITIZE	:=3D n
> +KCSAN_SANITIZE	:=3D n
> +UBSAN_SANITIZE	:=3D n
> +KCOV_INSTRUMENT	:=3D n
> +
> +$(obj)/%.pi.o: OBJCOPYFLAGS :=3D --prefix-symbols=3D__pi_ \
> +			       --remove-section=3D.note.gnu.property \
> +			       --prefix-alloc-sections=3D.init

=2E..this?

> +$(obj)/%.pi.o: $(obj)/%.o FORCE
> +	$(call if_changed,objcopy)
> +
> +$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +
> +$(obj)/string.o: $(srctree)/lib/string.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +
> +$(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
> +	$(call if_changed_rule,cc_o_c)
> +
> +obj-y		:=3D cmdline_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-f=
dt_ro.pi.o
> +extra-y		:=3D $(patsubst %.pi.o,%.o,$(obj-y))

--8ORzwRGnfaATysc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/yilAAKCRB4tDGHoIJi
0vndAQC4f+NCDSCyNXYj0njkGSVRxmlHAyLfwBzffl3veDQDTwD+Ll58OPQxpsri
ApRUvSTvYGRl+S21vQH6TERahcXL2gI=
=2KwQ
-----END PGP SIGNATURE-----

--8ORzwRGnfaATysc6--
