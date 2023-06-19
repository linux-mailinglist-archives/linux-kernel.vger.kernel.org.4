Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F267350E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjFSJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFSJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:49:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D88E74
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:49:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3113306a595so1943868f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687168164; x=1689760164;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufa16yfHg1UfYlFcId+qjKJpIKBcEo4CXfpKbltJ6KE=;
        b=1Ub0G9OJ3TJ81RkK0SxJkqcnUm5wrQytH+F33vxYOX/Uu6TN/0w6AN89i+8m062Eax
         1y25P4YNKikwclhlCKMfD52SqOy7ztZh7czWl0x/s7oBLyHQppgjusRpQrq8eSxeBoP1
         1Ip8BET6mifDOIXCrNMpeiyckLgKrCQ6ldVV5BKa+zvvB2bpLuCczA27cgDLhombunI9
         LefsOyUf0YkPnugSIS9TNMhsCr8vZv6HMrKb/7vJbC9WL4keOqpbqYRVMXlwveUfc6uz
         hrnVtQm0QtBzI1GC9LKSP7ZeEv69nbeJnebFye6hoVcoYxGwEfE+tph4o/h0E18hgngF
         i29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168164; x=1689760164;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufa16yfHg1UfYlFcId+qjKJpIKBcEo4CXfpKbltJ6KE=;
        b=kT9VH0nYYn9Sj7EEV6WI+DC5tYdu6Bt79NQGc8fvRpF9OyvWsd/g/47dP7rgLrp4hr
         /X5BkHB0Jk7oMedyMoMGnKqyWur+OFdYC1u35H2N3Hvrir34JCgdmPH32+vc6MoBoKhS
         9uNt1TsRl9XeySCTM8LqX8PABgdjUNeEDj5tf+o2lo/xGk7mMuNOpiRySvGNH+Hg8Zjw
         hNt7c663aNZ66dUyKxtibm7YhaIv1bRJNU9MSrTWbZxzmHQ7xiKFmUs83lb037UHiGZ5
         DNnZk8lVhNy0T63x54r9eIcq6Pdb3r2sRkU3S3JuZy0FqwvBSQyqklboM6TzK1f1T5T8
         +V9w==
X-Gm-Message-State: AC+VfDzRR8y6nRdM4tVEYm9A8NqiKl9qebmYDj9hEMF5CcIKz+dJ8uez
        hcIIrvi4zcLY43o3yxbsf5apF+BSKr9977NmL6o40g==
X-Google-Smtp-Source: ACHHUZ6T/j24USN/3db4YO9ETaLLLVVA0hQph5G5QQ36wEUXpcKABd/IbKv7GTVdrbSQ1S0CgJ2eWI2dQqnYCai5i/Y=
X-Received: by 2002:adf:fd8d:0:b0:30f:bff8:3f67 with SMTP id
 d13-20020adffd8d000000b0030fbff83f67mr9987250wrr.38.1687168164096; Mon, 19
 Jun 2023 02:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
In-Reply-To: <20230619094705.51337-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 19 Jun 2023 11:49:13 +0200
Message-ID: <CAHVXubjOUeEtnFnERjT2YOG+h5=2YX7kxeEBFSStO3WZvcv36A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sunil V L <sunilvl@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Sunil V L Something about ACPI is more than welcome :)

And thanks to @Bj=C3=B6rn T=C3=B6pel and @Atish Kumar Patra for helping in
writing this document!

On Mon, Jun 19, 2023 at 11:47=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
>
> Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/riscv/boot-image-header.rst |   3 -
>  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++++
>  Documentation/riscv/index.rst             |   1 +
>  3 files changed, 182 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/riscv/boot.rst
>
> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/ri=
scv/boot-image-header.rst
> index d7752533865f..a4a45310c4c4 100644
> --- a/Documentation/riscv/boot-image-header.rst
> +++ b/Documentation/riscv/boot-image-header.rst
> @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
>
>  This document only describes the boot image header details for RISC-V Li=
nux.
>
> -TODO:
> -  Write a complete booting guide.
> -
>  The following 64-byte header is present in decompressed Linux kernel ima=
ge::
>
>         u32 code0;                /* Executable code */
> diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> new file mode 100644
> index 000000000000..b02230818b79
> --- /dev/null
> +++ b/Documentation/riscv/boot.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Early boot requirements/constraints on RISC-V
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +This document describes what the RISC-V kernel expects from the previous=
 stages
> +and the firmware, but also the constraints that any developer must have =
in mind
> +when touching the early boot process, e.g. before the final virtual mapp=
ing is
> +setup.
> +
> +Pre-kernel boot (Expectations from firmware)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Registers state
> +---------------
> +
> +The RISC-V kernel expects:
> +
> +  * `$a0` to contain the hartid of the current core.
> +  * `$a1` to contain the address of the device tree in memory.
> +
> +CSR state
> +---------
> +
> +The RISC-V kernel expects:
> +
> +  * `$satp =3D 0`: the MMU must be disabled.
> +
> +Reserved memory for resident firmware
> +-------------------------------------
> +
> +The RISC-V kernel expects the firmware to mark any resident memory with =
the
> +`no-map` flag, thus the kernel won't map those regions in the direct map=
ping
> +(avoiding issues with hibernation, speculative accesses and probably oth=
er
> +subsystems).
> +
> +Kernel location
> +---------------
> +
> +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv64 a=
nd 4MB
> +for rv32). Note though that the EFI stub will physically relocate the ke=
rnel if
> +that's not the case.
> +
> +Device-tree
> +-----------
> +
> +The RISC-V kernel always expects a device tree, it is:
> +
> +- either passed directly to the kernel from the previous stage using the=
 `$a1`
> +  register,
> +- or when booting with UEFI, the device tree will be retrieved by the EF=
I stub
> +  using the EFI configuration table or it will be created.
> +
> +Bootflow
> +--------
> +
> +There exist 2 methods to enter the kernel:
> +
> +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, =
one hart
> +  wins a lottery and executes the early boot code while the other harts =
are
> +  parked waiting for the initialization to finish. This method is now
> +  **deprecated**.
> +- Ordered booting: the firmware releases only one hart that will execute=
 the
> +  initialization phase and then will start all other harts using the SBI=
 HSM
> +  extension.
> +
> +UEFI
> +----
> +
> +UEFI memory map
> +~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the RISC-V kernel will use only the EFI memory m=
ap to
> +populate the system memory.
> +
> +The UEFI firmware must parse the subnodes of the `/reserved-memory` devi=
ce tree
> +node and abide by the device tree specification to convert the attribute=
s of
> +those subnodes (`no-map` and `reusable`) into their correct EFI equivale=
nt
> +(refer to section "3.5.4 /reserved-memory and UEFI" of the device tree
> +specification).
> +
> +RISCV_EFI_BOOT_PROTOCOL
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the EFI stub requires the boot hartid in order t=
o pass
> +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hartid=
 using
> +one of the following methods:
> +
> +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> +- `boot-hartid` device tree subnode (**deprecated**).
> +
> +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the device =
tree
> +based approach is deprecated now.
> +
> +During kernel boot: (Kernel internals)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +EFI stub and device tree
> +------------------------
> +
> +When booting with UEFI, the device tree is supplemented by the EFI stub =
with the
> +following parameters (largely shared with arm64 in Documentation/arm/uef=
i.rst):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Name                        Size     Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +linux,uefi-system-table     64-bit   Physical address of the UEFI System=
 Table.
> +
> +linux,uefi-mmap-start       64-bit   Physical address of the UEFI memory=
 map,
> +                                     populated by the UEFI GetMemoryMap(=
) call.
> +
> +linux,uefi-mmap-size        32-bit   Size in bytes of the UEFI memory ma=
p
> +                                     pointed to in previous entry.
> +
> +linux,uefi-mmap-desc-size   32-bit   Size in bytes of each entry in the =
UEFI
> +                                     memory map.
> +
> +linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor form=
at.
> +
> +kaslr-seed                  64-bit   Entropy used to randomize the kerne=
l image
> +                                     base address location.
> +
> +bootargs                             Kernel command line
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Virtual mapping setup
> +---------------------
> +
> +The installation of the virtual mapping is done in 2 steps in the RISC-V=
 kernel:
> +
> +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> +   :c:var:`early_pg_dir` which allows to discover the system memory: onl=
y the
> +   kernel text/data are mapped at this point. When establishing this map=
ping,
> +   no allocation can be done (since the system memory is not known yet),=
 so
> +   :c:var:`early_pg_dir` page table is statically allocated (using only =
one
> +   table for each level).
> +
> +2. :c:func:`setup_vm_final` creates the final kernel mapping in
> +   :c:var:`swapper_pg_dir` and takes advantage of the discovered system =
memory
> +   to create the linear mapping. When establishing this mapping, the ker=
nel
> +   can allocate memory but cannot access it directly (since the direct m=
apping
> +   is not present yet), so it uses temporary mappings in the fixmap regi=
on to
> +   be able to access the newly allocated page table levels.
> +
> +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able to corr=
ectly
> +convert direct mapping addresses to physical addresses, it needs to know=
 the
> +start of the DRAM: this happens after 1, right before 2 installs the dir=
ect
> +mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c). =
So
> +any usage of those macros before the final virtual mapping is installed =
must be
> +carefully examined.
> +
> +Device-tree mapping via fixmap
> +------------------------------
> +
> +The RISC-V kernel uses the fixmap region to map the device tree because =
the
> +device tree virtual mapping must remain the same between :c:func:`setup_=
vm` and
> +:c:func:`setup_vm_final` calls since :c:var:`reserved_mem` array is init=
ialized
> +with virtual addresses established by :c:func:`setup_vm` and used with t=
he
> +mapping established by :c:func:`setup_vm_final`.
> +
> +Pre-MMU execution
> +-----------------
> +
> +Any code that executes before even the first virtual mapping is establis=
hed
> +must be very carefully compiled as:
> +
> +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, =
since
> +  otherwise, any access to a global symbol would go through the GOT whic=
h is
> +  only relocated virtually.
> +- `-mcmodel=3Dmedany`: Any access to a global symbol must be PC-relative=
 to avoid
> +  any relocations to happen before the MMU is setup.
> +- Also note that *all* instrumentation must also be disabled (that inclu=
des
> +  KASAN, ftrace and others).
> +
> +As using a symbol from a different compilation unit requires this unit t=
o be
> +compiled with those flags, we advise, as much as possible, not to use ex=
ternal
> +symbols.
> diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rs=
t
> index 175a91db0200..1f66062def6d 100644
> --- a/Documentation/riscv/index.rst
> +++ b/Documentation/riscv/index.rst
> @@ -5,6 +5,7 @@ RISC-V architecture
>  .. toctree::
>      :maxdepth: 1
>
> +    boot
>      boot-image-header
>      vm-layout
>      hwprobe
> --
> 2.39.2
>
