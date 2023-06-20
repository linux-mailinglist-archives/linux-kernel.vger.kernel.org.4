Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E4736B96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjFTMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjFTMG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:06:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC11C6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:06:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f86e1bdce5so3342225e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687262814; x=1689854814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLydGTIWW1L6p8nWmxO80K1g2yQP3Od4h4FMa6lJY3M=;
        b=frhjQU6RFgXYzCkJcSmQ3d70Ob91iOSuMtk04T99p56QxQJ/VqciaRherElT7Ne/Pd
         c61vwvkpTg62LzftNkeh1kXPeS3nIJZChl+w1N2XzafO7iKdHK3+Fns0k7lfDxfmeahg
         TAF8GCKQPsiKuaVK5KXSFThX05ZkqebVyW5yqv/1EiUgUFl2Qmy3y3TnEk4dF/0R3WAh
         sd7+E7/N6dAa11YoaSp8F+Eu7KiLgdqHe6k+dD7xHA8zD+opJLKNd5U9cAyAepoKJQMr
         U4VHKqie1BZO5uH4Zb2qlfjvQ1LckAANb933XfYghiNfVz2BJc5e88XTsCbxArYbrJhI
         n39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262814; x=1689854814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLydGTIWW1L6p8nWmxO80K1g2yQP3Od4h4FMa6lJY3M=;
        b=QWPfXBPDWLIPvmIjV8wZ583/cQsk0a6pPUG0mxNmCW1O3K0wlbYRiNxh03pN6Nraxp
         tJ7mpIyzcTzdKld3kNxrFbG1Qzgi7ygBiWCI7K8HqfV8K2EwzITjM3MRnWLq9sqFvSBx
         3lcLc4gU2sfdmQkUqN7BPwt0agfN1gS9RR6PQ+wSYV5bqXuWkdvrPRDFD8hGYcp1wOL8
         V9h9jDiVcimc6I31bB0yUyL+tMqv57LD3dNryKU2IuiEGmHklL+cKePJClK0vCJKrxrH
         UCB1tkBk1/2bvURpgQJiBS5ltFv94BbsLh0rzuZ8Hm1TfTwoSw4aqGEPmWKZiS4V+X4f
         GaqA==
X-Gm-Message-State: AC+VfDwHP6A9pOW8fnHHAWTNdIR/fpBdAU5afj+sR1upyitTVwkPPG4A
        f4UcuDM+LAWSF9zm6Obd8ByVHykfLxEOfO/UlSOsEg==
X-Google-Smtp-Source: ACHHUZ52j+KulP8+OQ3GMSobwdYytSflKlEVT8LhbO4JDHFvwvrmjO21e7ScGU5nx3XM4yVN6rZLExvwfWNnE0rmSoI=
X-Received: by 2002:a19:791d:0:b0:4f8:6f40:4773 with SMTP id
 u29-20020a19791d000000b004f86f404773mr3070743lfc.7.1687262813819; Tue, 20 Jun
 2023 05:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com> <6B5FC5C805CA568D+43d4ca18-deca-8d1a-394f-0cf69509ca53@tinylab.org>
In-Reply-To: <6B5FC5C805CA568D+43d4ca18-deca-8d1a-394f-0cf69509ca53@tinylab.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 20 Jun 2023 14:06:43 +0200
Message-ID: <CAHVXubiEvLFnQMWsUomoG3FJhQNGqoXC41dWDuGhXcUdCnL2ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 20, 2023 at 12:32=E2=80=AFPM Song Shuai <songshuaishuai@tinylab=
.org> wrote:
>
>
>
> =E5=9C=A8 2023/6/19 17:47, Alexandre Ghiti =E5=86=99=E9=81=93:
> > This document describes the constraints and requirements of the early
> > boot process in a RISC-V kernel.
> >
> > Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >   Documentation/riscv/boot-image-header.rst |   3 -
> >   Documentation/riscv/boot.rst              | 181 +++++++++++++++++++++=
+
> >   Documentation/riscv/index.rst             |   1 +
> >   3 files changed, 182 insertions(+), 3 deletions(-)
> >   create mode 100644 Documentation/riscv/boot.rst
> >
> > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/=
riscv/boot-image-header.rst
> > index d7752533865f..a4a45310c4c4 100644
> > --- a/Documentation/riscv/boot-image-header.rst
> > +++ b/Documentation/riscv/boot-image-header.rst
> > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> >
> >   This document only describes the boot image header details for RISC-V=
 Linux.
> >
> > -TODO:
> > -  Write a complete booting guide.
> > -
> >   The following 64-byte header is present in decompressed Linux kernel =
image::
> >
> >       u32 code0;                /* Executable code */
> > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rs=
t
> > new file mode 100644
> > index 000000000000..b02230818b79
> > --- /dev/null
> > +++ b/Documentation/riscv/boot.rst
> > @@ -0,0 +1,181 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Early boot requirements/constraints on RISC-V
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > +:Date: 23 May 2023
> > +
> > +This document describes what the RISC-V kernel expects from the previo=
us stages
> > +and the firmware, but also the constraints that any developer must hav=
e in mind
> > +when touching the early boot process, e.g. before the final virtual ma=
pping is
> > +setup.
> > +
> > +Pre-kernel boot (Expectations from firmware)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Registers state
> > +---------------
> > +
> > +The RISC-V kernel expects:
> > +
> > +  * `$a0` to contain the hartid of the current core.
> > +  * `$a1` to contain the address of the device tree in memory.
> > +
> > +CSR state
> > +---------
> > +
> > +The RISC-V kernel expects:
> > +
> > +  * `$satp =3D 0`: the MMU must be disabled.
> > +
> > +Reserved memory for resident firmware
> > +-------------------------------------
> > +
> > +The RISC-V kernel expects the firmware to mark any resident memory wit=
h the
> > +`no-map` flag, thus the kernel won't map those regions in the direct m=
apping
> > +(avoiding issues with hibernation, speculative accesses and probably o=
ther
> > +subsystems).
> > +
> > +Kernel location
> > +---------------
> > +
> > +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv64=
 and 4MB
> > +for rv32). Note though that the EFI stub will physically relocate the =
kernel if
> > +that's not the case.
> > +
> > +Device-tree
> > +-----------
> > +
> > +The RISC-V kernel always expects a device tree, it is:
> > +
> > +- either passed directly to the kernel from the previous stage using t=
he `$a1`
> > +  register,
> > +- or when booting with UEFI, the device tree will be retrieved by the =
EFI stub
> > +  using the EFI configuration table or it will be created.
> > +
> > +Bootflow
> > +--------
> > +
> > +There exist 2 methods to enter the kernel:
> > +
> > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel=
, one hart
> > +  wins a lottery and executes the early boot code while the other hart=
s are
> > +  parked waiting for the initialization to finish. This method is now
> > +  **deprecated**.
> > +- Ordered booting: the firmware releases only one hart that will execu=
te the
> > +  initialization phase and then will start all other harts using the S=
BI HSM
> > +  extension.
> > +
> > +UEFI
> > +----
> > +
> > +UEFI memory map
> > +~~~~~~~~~~~~~~~
> > +
> > +When booting with UEFI, the RISC-V kernel will use only the EFI memory=
 map to
> > +populate the system memory.
> > +
> > +The UEFI firmware must parse the subnodes of the `/reserved-memory` de=
vice tree
> > +node and abide by the device tree specification to convert the attribu=
tes of
> > +those subnodes (`no-map` and `reusable`) into their correct EFI equiva=
lent
> > +(refer to section "3.5.4 /reserved-memory and UEFI" of the device tree
> > +specification).
> how about declare the version of Device Tree specification?
> like the devicetree-specification-v0.4-rc1 we recently reference

You're right, the section number refers to this version of the
specification, so it should be noted.

> > +
> > +RISCV_EFI_BOOT_PROTOCOL
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +When booting with UEFI, the EFI stub requires the boot hartid in order=
 to pass
> > +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hart=
id using
> > +one of the following methods:
> > +
> > +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> > +- `boot-hartid` device tree subnode (**deprecated**).
> > +
> > +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the devic=
e tree
> > +based approach is deprecated now.
> > +
> > +During kernel boot: (Kernel internals)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +EFI stub and device tree
> > +------------------------
> > +
> > +When booting with UEFI, the device tree is supplemented by the EFI stu=
b with the
> > +following parameters (largely shared with arm64 in Documentation/arm/u=
efi.rst):
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +Name                        Size     Description
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +linux,uefi-system-table     64-bit   Physical address of the UEFI Syst=
em Table.
> > +
> > +linux,uefi-mmap-start       64-bit   Physical address of the UEFI memo=
ry map,
> > +                                     populated by the UEFI GetMemoryMa=
p() call.
> > +
> > +linux,uefi-mmap-size        32-bit   Size in bytes of the UEFI memory =
map
> > +                                     pointed to in previous entry.
> > +
> > +linux,uefi-mmap-desc-size   32-bit   Size in bytes of each entry in th=
e UEFI
> > +                                     memory map.
> > +
> > +linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor fo=
rmat.
> > +
> > +kaslr-seed                  64-bit   Entropy used to randomize the ker=
nel image
> > +                                     base address location.
> > +
> > +bootargs                             Kernel command line
> how about use "string" to declare the type of "bootargs"
> and replace the "Size" in header with "Type"

Why not, this will be more accurate.

> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +Virtual mapping setup
> > +---------------------
> > +
> > +The installation of the virtual mapping is done in 2 steps in the RISC=
-V kernel:
> > +
> > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> > +   :c:var:`early_pg_dir` which allows to discover the system memory: o=
nly the
> > +   kernel text/data are mapped at this point. When establishing this m=
apping,
> > +   no allocation can be done (since the system memory is not known yet=
), so
> > +   :c:var:`early_pg_dir` page table is statically allocated (using onl=
y one
> > +   table for each level).
> > +
> > +2. :c:func:`setup_vm_final` creates the final kernel mapping in
> > +   :c:var:`swapper_pg_dir` and takes advantage of the discovered syste=
m memory
> > +   to create the linear mapping. When establishing this mapping, the k=
ernel
> > +   can allocate memory but cannot access it directly (since the direct=
 mapping
> > +   is not present yet), so it uses temporary mappings in the fixmap re=
gion to
> > +   be able to access the newly allocated page table levels.
> > +
> > +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able to co=
rrectly
> > +convert direct mapping addresses to physical addresses, it needs to kn=
ow the
> > +start of the DRAM: this happens after 1, right before 2 installs the d=
irect
> > +mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c)=
. So
> > +any usage of those macros before the final virtual mapping is installe=
d must be
> > +carefully examined.
> > +
> > +Device-tree mapping via fixmap
> > +------------------------------
> > +
> > +The RISC-V kernel uses the fixmap region to map the device tree becaus=
e the
> > +device tree virtual mapping must remain the same between :c:func:`setu=
p_vm` and
> > +:c:func:`setup_vm_final` calls since :c:var:`reserved_mem` array is in=
itialized
> > +with virtual addresses established by :c:func:`setup_vm` and used with=
 the
> > +mapping established by :c:func:`setup_vm_final`.
> > +
> > +Pre-MMU execution
> > +-----------------
> > +
> > +Any code that executes before even the first virtual mapping is establ=
ished
> > +must be very carefully compiled as:
> > +
> > +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`=
, since
> > +  otherwise, any access to a global symbol would go through the GOT wh=
ich is
> > +  only relocated virtually.
> > +- `-mcmodel=3Dmedany`: Any access to a global symbol must be PC-relati=
ve to avoid
> > +  any relocations to happen before the MMU is setup.
> > +- Also note that *all* instrumentation must also be disabled (that inc=
ludes
> > +  KASAN, ftrace and others).
> > +
> > +As using a symbol from a different compilation unit requires this unit=
 to be
> > +compiled with those flags, we advise, as much as possible, not to use =
external
> > +symbols.
> > diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.=
rst
> > index 175a91db0200..1f66062def6d 100644
> > --- a/Documentation/riscv/index.rst
> > +++ b/Documentation/riscv/index.rst
> > @@ -5,6 +5,7 @@ RISC-V architecture
> >   .. toctree::
> >       :maxdepth: 1
> >
> > +    boot
> >       boot-image-header
> >       vm-layout
> >       hwprobe
>
> --
> Thanks
> Song Shuai
>

Thanks Song!
