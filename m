Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BE73CE0B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFYCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFYCdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:33:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1E11B;
        Sat, 24 Jun 2023 19:33:31 -0700 (PDT)
X-QQ-mid: bizesmtp65t1687660394tl91i76s
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 25 Jun 2023 10:33:12 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: 9fp+MOMfZT2Hi+Gda3sOetVnCxNoh4yevvINpbTqOxRkk3fDgCzOpc7GqFZdo
        mt46aDDFnCMCkQVcz7SILtMAhMe1OkW1P7emknCYUgTG7xCg2joHXmxis5n3xyzROYZ4IWL
        mdBAOLL6vrcjcpQU8jZjuP3o/ZPwUFmLlfCcDVAJ1JNAG63U7KBmJecH7Gq3NkcEnooyseT
        QtLZsIhOT5bBgHEsHN3zsVBVfXMYZrmg+njmdZgItpRzvoeN5Cl4sjHrhqfI59g0frdUyoU
        DORVJCKU5kU0tfN7+MA/MvgHXvPGiYkAmugaNWdTicg6xBw8iOgWpwqAFZ8xGu8Yx/M4XK6
        NBXWbrMxT9xCcTNdX8L0UDVQXOVSq76TZFtkuiBLrT6cXiAFUQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13324433151780188638
Message-ID: <0CA7B9606F2F6A97+92845fff-d6ad-31d9-aca7-da7a9347d702@tinylab.org>
Date:   Sun, 25 Jun 2023 10:33:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] Documentation: riscv: Add early boot document
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230623095547.51881-1-alexghiti@rivosinc.com>
 <20230623095547.51881-2-alexghiti@rivosinc.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20230623095547.51881-2-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/23 17:55, Alexandre Ghiti 写道:
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   Documentation/riscv/boot-image-header.rst |   3 -
>   Documentation/riscv/boot.rst              | 170 ++++++++++++++++++++++
>   Documentation/riscv/index.rst             |   1 +
>   3 files changed, 171 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/riscv/boot.rst
> 
> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
> index d7752533865f..a4a45310c4c4 100644
> --- a/Documentation/riscv/boot-image-header.rst
> +++ b/Documentation/riscv/boot-image-header.rst
> @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
>   
>   This document only describes the boot image header details for RISC-V Linux.
>   
> -TODO:
> -  Write a complete booting guide.
> -
>   The following 64-byte header is present in decompressed Linux kernel image::
>   
>   	u32 code0;		  /* Executable code */
> diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> new file mode 100644
> index 000000000000..09997bbe1b52
> --- /dev/null
> +++ b/Documentation/riscv/boot.rst
> @@ -0,0 +1,170 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================
> +RISC-V Kernel Boot Requirements and Constraints
> +===============================================
> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +This document describes what the RISC-V kernel expects from bootloaders and
> +firmware, but also the constraints that any developer must have in mind when
> +touching the early boot process. For the purposes of this document, the
> +'early boot process' refers to any code that runs before the final virtual
> +mapping is set up.
> +
> +Pre-kernel Requirements and Constraints
> +=======================================
> +
> +The RISC-V kernel expects the following of bootloaders and platform firmware:
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
> +  * `$satp = 0`: the MMU, if present, must be disabled.
> +
> +Reserved memory for resident firmware
> +-------------------------------------
> +
> +The RISC-V kernel must not map any resident memory, or memory protected with
> +PMPs, in the direct mapping, so the firmware must correctly mark those regions
> +as per the devicetree specification and/or the UEFI specification.
> +
> +Kernel location
> +---------------
> +
> +The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for rv64
> +and 4MB aligned for rv32). Note that the EFI stub will physically relocate the
> +kernel if that's not the case.
> +
> +Hardware description
> +--------------------
> +
> +The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
> +
> +The devicetree is either passed directly to the kernel from the previous stage
> +using the `$a1` register, or when booting with UEFI, it can be passed using the
> +EFI configuration table.
> +
> +The ACPI tables are passed to the kernel using the EFI configuration table. In
> +this case, a tiny devicetree is still created by the EFI stub. Please refer to
> +"EFI stub and devicetree" section below for details about this devicetree.
> +
> +Kernel entrance
> +---------------
> +
> +On SMP systems, there are 2 methods to enter the kernel:
> +
> +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, one hart
> +  wins a lottery and executes the early boot code while the other harts are
> +  parked waiting for the initialization to finish. This method is mostly used to
> +  support older firmwares without SBI HSM extension and M-mode RISC-V kernel.
> +- `Ordered booting`: the firmware releases only one hart that will execute the
> +  initialization phase and then will start all other harts using the SBI HSM
> +  extension. The ordered booting method is the preferred booting method for
> +  booting the RISC-V kernel because it can support cpu hotplug and kexec.
> +
> +UEFI
> +----
> +
> +UEFI memory map
> +~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the RISC-V kernel will use only the EFI memory map to
> +populate the system memory.
> +
> +The UEFI firmware must parse the subnodes of the `/reserved-memory` devicetree
> +node and abide by the devicetree specification to convert the attributes of
> +those subnodes (`no-map` and `reusable`) into their correct EFI equivalent
> +(refer to section "3.5.4 /reserved-memory and UEFI" of the devicetree
> +specification v0.4-rc1).
> +
> +RISCV_EFI_BOOT_PROTOCOL
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the EFI stub requires the boot hartid in order to pass
> +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hartid using
> +one of the following methods:
> +
> +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> +- `boot-hartid` devicetree subnode (**deprecated**).
> +
> +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the devicetree
> +based approach is deprecated now.
> +
> +Early Boot Requirements and Constraints
> +=======================================
> +
> +The RISC-V kernel's early boot process operates under the following constraints:
> +
> +EFI stub and devicetree
> +-----------------------
> +
> +When booting with UEFI, the devicetree is supplemented (or created) by the EFI
> +stub with the same parameters as arm64 which are described at the paragraph
> +"UEFI kernel support on ARM" in Documentation/arm/uefi.rst.
> +
> +Virtual mapping installation
> +----------------------------
> +
> +The installation of the virtual mapping is done in 2 steps in the RISC-V kernel:
> +
> +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> +   :c:var:`early_pg_dir` which allows discovery of the system memory. Only the
> +   kernel text/data are mapped at this point. When establishing this mapping, no
> +   allocation can be done (since the system memory is not known yet), so
> +   :c:var:`early_pg_dir` page table is statically allocated (using only one
> +   table for each level).
> +
> +2. :c:func:`setup_vm_final` creates the final kernel mapping in
> +   :c:var:`swapper_pg_dir` and takes advantage of the discovered system memory
> +   to create the linear mapping. When establishing this mapping, the kernel
> +   can allocate memory but cannot access it directly (since the direct mapping
> +   is not present yet), so it uses temporary mappings in the fixmap region to
> +   be able to access the newly allocated page table levels.
> +
> +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able to correctly
> +convert direct mapping addresses to physical addresses, they need to know the
> +start of the DRAM. This happens after step 1, right before step 2 installs the
> +direct mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c).
> +Any usage of those macros before the final virtual mapping is installed must
> +be carefully examined.
> +
> +Devicetree mapping via fixmap
> +-----------------------------
> +
> +As the :c:var:`reserved_mem` array is initialized with virtual addresses
> +established by :c:func:`setup_vm`, and used with the mapping established by
> +:c:func:`setup_vm_final`, the RISC-V kernel uses the fixmap region to map the
> +devicetree. This ensures that the devicetree remains accessible by both virtual
> +mappings.
> +
> +Pre-MMU execution
> +-----------------
> +
> +A few pieces of code need to run before even the first virtual mapping is
> +established. These are the installation of the first virtual mapping itself,
> +patching of early alternatives and the early parsing of the kernel command line.
> +That code must be very carefully compiled as:
> +
> +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, since
> +  otherwise, any access to a global symbol would go through the GOT which is
> +  only relocated virtually.
> +- `-mcmodel=medany`: Any access to a global symbol must be PC-relative to avoid
> +  any relocations to happen before the MMU is setup.
> +- *all* instrumentation must also be disabled (that includes KASAN, ftrace and
> +  others).
> +
> +As using a symbol from a different compilation unit requires this unit to be
> +compiled with those flags, we advise, as much as possible, not to use external
> +symbols.
> diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
> index 175a91db0200..1f66062def6d 100644
> --- a/Documentation/riscv/index.rst
> +++ b/Documentation/riscv/index.rst
> @@ -5,6 +5,7 @@ RISC-V architecture
>   .. toctree::
>       :maxdepth: 1
>   
> +    boot
>       boot-image-header
>       vm-layout
>       hwprobe

Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
-- 
Thanks
Song Shuai
