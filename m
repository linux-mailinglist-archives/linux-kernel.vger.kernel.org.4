Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C673BEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjFWTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjFWTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:12:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CCB2695
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:12:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b44eddb52dso17149341fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1687547532; x=1690139532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7smO8BqnziJYtPvVFAlNDMSXp68Ci5Rd101XkqS5jQ=;
        b=hEVWY4kBmQPS2B+AOgxvo3AEsTEZjZTFeccN9ZAWIWYR7qOSjEHRZTa5dQz+aKXgnr
         caTrWLz+/ngMYQZQ4oFYGjx5ab124fNkmU6yzCOsacMbof8WLdLcCxyIV5SZ86gM69H2
         QAQmY5prNjAw1HN655nHqE7mt94KX84ewjl3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687547532; x=1690139532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7smO8BqnziJYtPvVFAlNDMSXp68Ci5Rd101XkqS5jQ=;
        b=Ybd2cZnILaASraoHt3nE8pbG3v+B85awuFm99/24KEMcVUzG0/Y6fVXikWi2ymWfQS
         tNOWT91KIt/dR0M4eXqrihif7iEbvRY4lPqzQc/32aO6Jj4/jkvvBr0Q9lhWoCPmmWbE
         iUBKQT3SLn4R2tfh67IrpgKaK9jtsJrGnF0mBawnNVcg3L6d8BpX4rTWKRgNAbfgIHt9
         NqA5aZC6Lec3ne1bgqCsqexB2wyHSJrbgt5ccY5kkj+Ic6/IZZwseK9OQIJ8/k2EPxbP
         Hb/LFUaqMGx35yvtwRQEO0You21FPXP43OZU+OlHr1IpWRdFZGBJ43T0w1JSkk3FUMSc
         onaA==
X-Gm-Message-State: AC+VfDwq/24Ew0G9CaqFQ4+qw4hea5yCJQxkly7STJGwuJJWx66IGA3K
        EUNxwwv7/kdrsqrPbGkaYY/CCh6z0yj0vfCOE7P0
X-Google-Smtp-Source: ACHHUZ5D3LajqwKEJzK4Sc9Rj608YLONCPql24UcCarQtzACjJ7csqsDeG5fPnAbj2ZKPBczdOzvDGEcfSybckJ8CPA=
X-Received: by 2002:a2e:7317:0:b0:2b4:7029:3631 with SMTP id
 o23-20020a2e7317000000b002b470293631mr11737138ljc.51.1687547531827; Fri, 23
 Jun 2023 12:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230623095547.51881-1-alexghiti@rivosinc.com> <20230623095547.51881-2-alexghiti@rivosinc.com>
In-Reply-To: <20230623095547.51881-2-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 23 Jun 2023 12:12:00 -0700
Message-ID: <CAOnJCUJHBJjmxjE=-_5W142A=qtkP0=d49mtgeU_q+UvwUTNBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Documentation: riscv: Add early boot document
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 2:57=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  Documentation/riscv/boot-image-header.rst |   3 -
>  Documentation/riscv/boot.rst              | 170 ++++++++++++++++++++++
>  Documentation/riscv/index.rst             |   1 +
>  3 files changed, 171 insertions(+), 3 deletions(-)
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
> index 000000000000..09997bbe1b52
> --- /dev/null
> +++ b/Documentation/riscv/boot.rst
> @@ -0,0 +1,170 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +RISC-V Kernel Boot Requirements and Constraints
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +This document describes what the RISC-V kernel expects from bootloaders =
and
> +firmware, but also the constraints that any developer must have in mind =
when
> +touching the early boot process. For the purposes of this document, the
> +'early boot process' refers to any code that runs before the final virtu=
al
> +mapping is set up.
> +
> +Pre-kernel Requirements and Constraints
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The RISC-V kernel expects the following of bootloaders and platform firm=
ware:
> +
> +Register state
> +--------------
> +
> +The RISC-V kernel expects:
> +
> +  * `$a0` to contain the hartid of the current core.
> +  * `$a1` to contain the address of the devicetree in memory.
> +
> +CSR state
> +---------
> +
> +The RISC-V kernel expects:
> +
> +  * `$satp =3D 0`: the MMU, if present, must be disabled.
> +
> +Reserved memory for resident firmware
> +-------------------------------------
> +
> +The RISC-V kernel must not map any resident memory, or memory protected =
with
> +PMPs, in the direct mapping, so the firmware must correctly mark those r=
egions
> +as per the devicetree specification and/or the UEFI specification.
> +
> +Kernel location
> +---------------
> +
> +The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned fo=
r rv64
> +and 4MB aligned for rv32). Note that the EFI stub will physically reloca=
te the
> +kernel if that's not the case.
> +
> +Hardware description
> +--------------------
> +
> +The firmware can pass either a devicetree or ACPI tables to the RISC-V k=
ernel.
> +
> +The devicetree is either passed directly to the kernel from the previous=
 stage
> +using the `$a1` register, or when booting with UEFI, it can be passed us=
ing the
> +EFI configuration table.
> +
> +The ACPI tables are passed to the kernel using the EFI configuration tab=
le. In
> +this case, a tiny devicetree is still created by the EFI stub. Please re=
fer to
> +"EFI stub and devicetree" section below for details about this devicetre=
e.
> +
> +Kernel entrance
> +---------------
> +
> +On SMP systems, there are 2 methods to enter the kernel:
> +
> +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, =
one hart
> +  wins a lottery and executes the early boot code while the other harts =
are
> +  parked waiting for the initialization to finish. This method is mostly=
 used to
> +  support older firmwares without SBI HSM extension and M-mode RISC-V ke=
rnel.
> +- `Ordered booting`: the firmware releases only one hart that will execu=
te the
> +  initialization phase and then will start all other harts using the SBI=
 HSM
> +  extension. The ordered booting method is the preferred booting method =
for
> +  booting the RISC-V kernel because it can support cpu hotplug and kexec=
.
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
cetree
> +node and abide by the devicetree specification to convert the attributes=
 of
> +those subnodes (`no-map` and `reusable`) into their correct EFI equivale=
nt
> +(refer to section "3.5.4 /reserved-memory and UEFI" of the devicetree
> +specification v0.4-rc1).
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
> +- `boot-hartid` devicetree subnode (**deprecated**).
> +
> +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the devicet=
ree
> +based approach is deprecated now.
> +
> +Early Boot Requirements and Constraints
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The RISC-V kernel's early boot process operates under the following cons=
traints:
> +
> +EFI stub and devicetree
> +-----------------------
> +
> +When booting with UEFI, the devicetree is supplemented (or created) by t=
he EFI
> +stub with the same parameters as arm64 which are described at the paragr=
aph
> +"UEFI kernel support on ARM" in Documentation/arm/uefi.rst.
> +
> +Virtual mapping installation
> +----------------------------
> +
> +The installation of the virtual mapping is done in 2 steps in the RISC-V=
 kernel:
> +
> +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> +   :c:var:`early_pg_dir` which allows discovery of the system memory. On=
ly the
> +   kernel text/data are mapped at this point. When establishing this map=
ping, no
> +   allocation can be done (since the system memory is not known yet), so
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
> +convert direct mapping addresses to physical addresses, they need to kno=
w the
> +start of the DRAM. This happens after step 1, right before step 2 instal=
ls the
> +direct mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/in=
it.c).
> +Any usage of those macros before the final virtual mapping is installed =
must
> +be carefully examined.
> +
> +Devicetree mapping via fixmap
> +-----------------------------
> +
> +As the :c:var:`reserved_mem` array is initialized with virtual addresses
> +established by :c:func:`setup_vm`, and used with the mapping established=
 by
> +:c:func:`setup_vm_final`, the RISC-V kernel uses the fixmap region to ma=
p the
> +devicetree. This ensures that the devicetree remains accessible by both =
virtual
> +mappings.
> +
> +Pre-MMU execution
> +-----------------
> +
> +A few pieces of code need to run before even the first virtual mapping i=
s
> +established. These are the installation of the first virtual mapping its=
elf,
> +patching of early alternatives and the early parsing of the kernel comma=
nd line.
> +That code must be very carefully compiled as:
> +
> +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, =
since
> +  otherwise, any access to a global symbol would go through the GOT whic=
h is
> +  only relocated virtually.
> +- `-mcmodel=3Dmedany`: Any access to a global symbol must be PC-relative=
 to avoid
> +  any relocations to happen before the MMU is setup.
> +- *all* instrumentation must also be disabled (that includes KASAN, ftra=
ce and
> +  others).
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
