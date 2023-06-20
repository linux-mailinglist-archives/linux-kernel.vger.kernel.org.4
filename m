Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2852736959
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjFTKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjFTKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:32:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81BFE3;
        Tue, 20 Jun 2023 03:32:14 -0700 (PDT)
X-QQ-mid: bizesmtp66t1687257119t55sryol
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 20 Jun 2023 18:31:58 +0800 (CST)
X-QQ-SSF: 00200000000000B08000000A0000000
X-QQ-FEAT: IV30oiqrgAYqEkrkILod6wD5r4YAsmhbPF2WsSmnEire3X+6darf0RmK8O7Bu
        scAgdYTIiWMGIZG4y/8D9wu/Ua5/KH0jyz0YlziQmJVqvAkdTpWMfToYN/y6SUC4W5KlTzJ
        ZBdzMSTyUsqFsy2nbTAFfzveD2H8YaSJ7/xhR/XBcQL7LrcezFMd+3Uize5YmsFRG7ZL2EI
        Z9afvuxEpyjYUyTbv67yJX02y3eenA6xPeshdBPN+laqQBcdQSDUEJuj2NHsO0H1PE4cTUX
        cGKdyxtKLz7I2RRMWsxqpcqbwnGbFAo+uG1+jQqsD2VPGrFbGWJKHBLkDUDhmIsCAkxYndi
        Nb6AFpgU6kpReBIOlfoN4URHJG2MUd/ZZsBxSm9h98aaAq2k6ULgx6Lwx/vHQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4760579341191134598
Message-ID: <6B5FC5C805CA568D+43d4ca18-deca-8d1a-394f-0cf69509ca53@tinylab.org>
Date:   Tue, 20 Jun 2023 18:31:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
Cc:     songshuaishuai@tinylab.org
In-Reply-To: <20230619094705.51337-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/19 17:47, Alexandre Ghiti 写道:
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
> 
> Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   Documentation/riscv/boot-image-header.rst |   3 -
>   Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++++
>   Documentation/riscv/index.rst             |   1 +
>   3 files changed, 182 insertions(+), 3 deletions(-)
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
> index 000000000000..b02230818b79
> --- /dev/null
> +++ b/Documentation/riscv/boot.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================================
> +Early boot requirements/constraints on RISC-V
> +=============================================
> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +This document describes what the RISC-V kernel expects from the previous stages
> +and the firmware, but also the constraints that any developer must have in mind
> +when touching the early boot process, e.g. before the final virtual mapping is
> +setup.
> +
> +Pre-kernel boot (Expectations from firmware)
> +============================================
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
> +  * `$satp = 0`: the MMU must be disabled.
> +
> +Reserved memory for resident firmware
> +-------------------------------------
> +
> +The RISC-V kernel expects the firmware to mark any resident memory with the
> +`no-map` flag, thus the kernel won't map those regions in the direct mapping
> +(avoiding issues with hibernation, speculative accesses and probably other
> +subsystems).
> +
> +Kernel location
> +---------------
> +
> +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv64 and 4MB
> +for rv32). Note though that the EFI stub will physically relocate the kernel if
> +that's not the case.
> +
> +Device-tree
> +-----------
> +
> +The RISC-V kernel always expects a device tree, it is:
> +
> +- either passed directly to the kernel from the previous stage using the `$a1`
> +  register,
> +- or when booting with UEFI, the device tree will be retrieved by the EFI stub
> +  using the EFI configuration table or it will be created.
> +
> +Bootflow
> +--------
> +
> +There exist 2 methods to enter the kernel:
> +
> +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, one hart
> +  wins a lottery and executes the early boot code while the other harts are
> +  parked waiting for the initialization to finish. This method is now
> +  **deprecated**.
> +- Ordered booting: the firmware releases only one hart that will execute the
> +  initialization phase and then will start all other harts using the SBI HSM
> +  extension.
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
> +The UEFI firmware must parse the subnodes of the `/reserved-memory` device tree
> +node and abide by the device tree specification to convert the attributes of
> +those subnodes (`no-map` and `reusable`) into their correct EFI equivalent
> +(refer to section "3.5.4 /reserved-memory and UEFI" of the device tree
> +specification).
how about declare the version of Device Tree specification?
like the devicetree-specification-v0.4-rc1 we recently reference
> +
> +RISCV_EFI_BOOT_PROTOCOL
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the EFI stub requires the boot hartid in order to pass
> +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hartid using
> +one of the following methods:
> +
> +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> +- `boot-hartid` device tree subnode (**deprecated**).
> +
> +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the device tree
> +based approach is deprecated now.
> +
> +During kernel boot: (Kernel internals)
> +======================================
> +
> +EFI stub and device tree
> +------------------------
> +
> +When booting with UEFI, the device tree is supplemented by the EFI stub with the
> +following parameters (largely shared with arm64 in Documentation/arm/uefi.rst):
> +
> +==========================  ======   ===========================================
> +Name                        Size     Description
> +==========================  ======   ===========================================
> +linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
> +
> +linux,uefi-mmap-start       64-bit   Physical address of the UEFI memory map,
> +                                     populated by the UEFI GetMemoryMap() call.
> +
> +linux,uefi-mmap-size        32-bit   Size in bytes of the UEFI memory map
> +                                     pointed to in previous entry.
> +
> +linux,uefi-mmap-desc-size   32-bit   Size in bytes of each entry in the UEFI
> +                                     memory map.
> +
> +linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
> +
> +kaslr-seed                  64-bit   Entropy used to randomize the kernel image
> +                                     base address location.
> +
> +bootargs                             Kernel command line
how about use "string" to declare the type of "bootargs"
and replace the "Size" in header with "Type"
> +==========================  ======   ===========================================
> +
> +Virtual mapping setup
> +---------------------
> +
> +The installation of the virtual mapping is done in 2 steps in the RISC-V kernel:
> +
> +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> +   :c:var:`early_pg_dir` which allows to discover the system memory: only the
> +   kernel text/data are mapped at this point. When establishing this mapping,
> +   no allocation can be done (since the system memory is not known yet), so
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
> +convert direct mapping addresses to physical addresses, it needs to know the
> +start of the DRAM: this happens after 1, right before 2 installs the direct
> +mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c). So
> +any usage of those macros before the final virtual mapping is installed must be
> +carefully examined.
> +
> +Device-tree mapping via fixmap
> +------------------------------
> +
> +The RISC-V kernel uses the fixmap region to map the device tree because the
> +device tree virtual mapping must remain the same between :c:func:`setup_vm` and
> +:c:func:`setup_vm_final` calls since :c:var:`reserved_mem` array is initialized
> +with virtual addresses established by :c:func:`setup_vm` and used with the
> +mapping established by :c:func:`setup_vm_final`.
> +
> +Pre-MMU execution
> +-----------------
> +
> +Any code that executes before even the first virtual mapping is established
> +must be very carefully compiled as:
> +
> +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, since
> +  otherwise, any access to a global symbol would go through the GOT which is
> +  only relocated virtually.
> +- `-mcmodel=medany`: Any access to a global symbol must be PC-relative to avoid
> +  any relocations to happen before the MMU is setup.
> +- Also note that *all* instrumentation must also be disabled (that includes
> +  KASAN, ftrace and others).
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

-- 
Thanks
Song Shuai

