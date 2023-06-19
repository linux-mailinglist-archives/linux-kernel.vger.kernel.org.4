Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851B735920
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjFSOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjFSOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:05:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B5E64
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:05:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31121494630so4061354f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687183504; x=1689775504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCGYxl6AyJ/saoS/h1ABlPdNg9Cx7Y9LPoKeEBG9kVk=;
        b=SJVho1mbGu/WDzR9Ee2V7LIoBl5bIPCXFhRCOmuSMEPDOveCyT0I2mSYDPBNlABA36
         qhugiWdq57rKl3RQnMsBvR0IyekdTBsxAVO6nK/7bXhBNTsEl87aE68tkdOrEs6FfT60
         SNXg5wyLVSszdMO4zoNbO24gVcRy70SpZzNebz1dWp7lYzw+ES1S+8lrdpziCKYGn8Sr
         LF+FtSVjo04NAqL+5FnnI+tm0a9LQgNw8YInkovdiwaWDpPvFsLDqeRpVNBIhy6PfZpS
         FWREVKOwggv4jjr3qppUQM/IISL2bfLOa4ghDte68YxQg0S/t6Q7mwkPSttqkZTobQow
         a86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183504; x=1689775504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCGYxl6AyJ/saoS/h1ABlPdNg9Cx7Y9LPoKeEBG9kVk=;
        b=OG/GjmawKtO20ujzDuqj9IXJTl401ihx/7jRLCs6apQzHwQMx9hNpOw70tWlqqW19N
         AFxe0bYG+b3pOuamSRdImC+dKbt4SVevXJRHH73BsOsxtRS7eM0p/3FswEYXPpzAn8tV
         t1D+5lrMLt32fkR5ldHM5KL3dmcPsrT1CDSm4oCR6/r2GmnOz0uAAOjdNrnND3VZM5JP
         LIi9McnbOcotnAq0+NxT+Ef8e23NySeJBQLpWuDehPb+pS8+dbuSgG9eylPVHMtYISBe
         HoGXbthWWvCm/rYdv13a+0d2XoKwHxS8eturQJiK9Cvr2bfQKtpuPaXvL/rgep2Ttu4P
         5agA==
X-Gm-Message-State: AC+VfDw7hhbGJV+5c3BgKsX50+6T0COebnHzf4/QJPdzBHKxs9sHfjFY
        Goef+JpTuWpfrNHElfg1wrZDWo/4twuHXXLdJoxhoQ==
X-Google-Smtp-Source: ACHHUZ58SGTmWfQVBvFO4N0HJy6JUNnubdcW9T4jyIoJdcrcOB/7NZn2zqBGsFqrBc7ihtG1C5JzZH3+mgxFuOd3LtI=
X-Received: by 2002:adf:e684:0:b0:30e:412a:841b with SMTP id
 r4-20020adfe684000000b0030e412a841bmr7379094wrm.37.1687183503600; Mon, 19 Jun
 2023 07:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com> <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
In-Reply-To: <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 19 Jun 2023 16:04:52 +0200
Message-ID: <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
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

On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Alex,
>
> Thanks for working on this :) I've got a mix of suggestions and
> questions below. Hopefully it is not too disjoint, since I didn't write
> them in order.
>
> On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
> > This document describes the constraints and requirements of the early
> > boot process in a RISC-V kernel.
> >
> > Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  Documentation/riscv/boot-image-header.rst |   3 -
> >  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++++
> >  Documentation/riscv/index.rst             |   1 +
> >  3 files changed, 182 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/riscv/boot.rst
> >
> > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/=
riscv/boot-image-header.rst
> > index d7752533865f..a4a45310c4c4 100644
> > --- a/Documentation/riscv/boot-image-header.rst
> > +++ b/Documentation/riscv/boot-image-header.rst
> > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> >
> >  This document only describes the boot image header details for RISC-V =
Linux.
> >
> > -TODO:
> > -  Write a complete booting guide.
> > -
> >  The following 64-byte header is present in decompressed Linux kernel i=
mage::
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
>
> Please use "title case", here and elsewhere in the doc.

You mean using "title: " instead of "=3D=3D=3D=3D"? Or using uppercase for =
the
first letter of each word? FYI I followed
https://docs.kernel.org/doc-guide/sphinx.html?highlight=3Dtitle#specific-gu=
idelines-for-the-kernel-documentation

> I'd also be inclined to drop the "Early" from here, as it permits more
> natural section headings. Perhaps "RISC-V Kernel Boot Requirements and
> Constraints"?

Good suggestion, I'll go with that, thanks

>
> > +
> > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > +:Date: 23 May 2023
> > +
> > +This document describes what the RISC-V kernel expects from the previo=
us stages
>
> "the previous stages" is a bit vague IMO. You mean bootloader stages I
> assume, but I think it should be explicit. Perhaps:
> "...what a RISC-V kernel expects from bootloaders and firmware, and the
> constraints..."
>
> > +and the firmware, but also the constraints that any developer must hav=
e in mind
> > +when touching the early boot process, e.g. before the final virtual ma=
pping is
> > +setup.
>
> s/setup./set up./
>
> Do you mean to have "For example" here? Or is "before the final virtual
> mapping is set up" the definition or "early boot"? If the latter, I
> would reword this as something like:
> "...when modifying the early boot process. For the purposes of this
> document, the 'early boot process' refers to any code that runs before
> the final virtual mapping is set up."

Thanks, that's what I meant.

>
> > +Pre-kernel boot (Expectations from firmware)
>
> Firmware or bootloaders? TBH, I would just drop the section in () and
> do something like:
>         Pre-kernel Requirements and Constraints
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>         The RISC-V kernel expects the following of bootloaders and platfo=
rm
>         firmware:
>

Ok

> > +
> > +Registers state
>
> s/Registers state/Register State/

Ok

>
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
>
> "the MMU, if present, must be disabled." ;)

Ahah forgot the !mmu case, thanks :)

>
> > +
> > +Reserved memory for resident firmware
> > +-------------------------------------
> > +
> > +The RISC-V kernel expects the firmware to mark any resident memory wit=
h the
>
> Should this be
> "...resident memory, or memory it has protected with PMPs, with..."
> ?

I used "resident" memory instead of "PMP" memory because it was more
general. I mean you can have a region that is resident but not
protected by PMP, and I don't think the kernel should ask for this
resident memory to be protected with PMP right?

>
> > +`no-map` flag, thus the kernel won't map those regions in the direct m=
apping
>
> "no-map" is a DT specific term, should this section be moved down under
> DT, as a sub-section of that?

Maybe I can rephrase with something like that:

"The RISC-V kernel must not map any resident memory in the direct
mapping, so the firmware must correctly mark those regions as follows:
- when using a devicetree, using the `no-map` flag,
- when booting with UEFI without devicetree, either as
`EfiRuntimeServicesData/Code` or `EfiReserved`."

>
> > +(avoiding issues with hibernation, speculative accesses and probably o=
ther
> > +subsystems).
>
> I'm not sure that this () section is beneficial. To be honest, recent
> issues aside, this section here seems like a statement of the obvious...

But I made the mistake, so it was not that straightforward to
me...I'll remove the ().

>
> > +
> > +Kernel location
> > +---------------
> > +
> > +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv64=
 and 4MB
>
> Would that be better worded as "(2 MB aligned for rv64 and 4 MB aligned
> for rv32)"? It might be overly explicit, but I figure there's no harm...

Sure I can add that.

>
> > +for rv32). Note though that the EFI stub will physically relocate the =
kernel if
>
> s/though//

Ok

>
> > +that's not the case.
> > +
> > +Device-tree

Damn, missed this one, thanks!

>
> s/Device-tree/Devicetree/ and...
>
> > +-----------
> > +
> > +The RISC-V kernel always expects a device tree, it is:
>
> ...s/device tree/devicetree/ to match elsewhere in the kernel docs.
> Same applies to the other instances of "device tree" in this patch,
> please.

Ok I'll do that (but I'm happy to say that I thought about that and it
was intentional since "git grep "device tree" | wc -l" returns a
significant number of instances :)).

>
> > +
> > +- either passed directly to the kernel from the previous stage using t=
he `$a1`
> > +  register,
> > +- or when booting with UEFI, the device tree will be retrieved by the =
EFI stub
> > +  using the EFI configuration table or it will be created.
>
> Can I suggest changing this around a little, pulling the "either" &
> dropping some boilerplate so that it reads (to me!) a little more
> naturally:
>         The RISC-V kernel always expects a devicetree, it is either:
>
>         - passed directly to the kernel from the previous stage using the=
 `$a1`
>           register,
>         - retrieved by the EFI stub when booting with UEFI, using the EFI
>           configuration table or it will be created by ____.
>
> Also, please elaborate on what it will be created by.

Is it better this way:

"The RISC-V kernel always expects a devicetree, it is either:

- passed directly to the kernel from the previous stage using the
`$a1`
  register,
- retrieved by the EFI stub if present in the EFI configuration table,
- created by the EFI stub otherwise."

>
> > +
> > +Bootflow
>
> "Boot Flow", no?
> I am not sure that this is the "correct" heading for the content it
> describes, but I have nothing better to offer :/

Yes you're right, what about simply "Kernel Entrance"? Not sure this
is easily understandable though.

>
> > +--------
> > +
> > +There exist 2 methods to enter the kernel:
> > +
> > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel=
, one hart
> > +  wins a lottery and executes the early boot code while the other hart=
s are
> > +  parked waiting for the initialization to finish. This method is now
>
> nit: s/now//

Ok

>
> What do you mean by deprecated? There's no requirement to implement the
> HSM extension, right?

I would say yes, you have to use a recent version of openSBI that
supports the HSM extension. @Atish Kumar Patra WDYT?

>
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
>
> With the other section titles changed, this could be:
>         Early Boot Requirements and Constraints
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>         The RISC-V kernel's early boot process operates under the
>         following constraints:
>
> Thoughts?

I think it's better as you propose, I changed it, thanks.

>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +EFI stub and device tree
>
> Same comments about "device tree" here etc.
>
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
>
> nit: Hmm, I think for all of these sizes s/-bit/ bits/.

That's a copy-paste from the link just above the table.

But maybe I should have pointed to the doc and added only the
"bootargs" stuff (maybe that's also present for arm64 actually).

>
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
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +Virtual mapping setup
>
> nit: s/setup/Installation/

Ok

>
> > +---------------------
> > +
> > +The installation of the virtual mapping is done in 2 steps in the RISC=
-V kernel:
> > +
> > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> > +   :c:var:`early_pg_dir` which allows to discover the system memory: o=
nly the
>
> s/to discover/discovery of/

You mean "the discovery of" right?

> s/: only/. Only/

Ok

>
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
>
> nit: s/it/they/

Ok

>
> > +start of the DRAM: this happens after 1, right before 2 installs the d=
irect
>
> s/:/./

Ahah, you really don't like long sentences :) But of course ok :)

> Also how about s/1/step 1/ & s/2/step 2/?

Way better, thanks

>
> > +mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c)=
. So
>
> s/So//
>

Ok

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
>
> Missing a "the" before reserved_mem.

Ok

>
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
>
> Could you point out what the non-obvious examples of this code are?

I can do a list, yes

>
> > +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`=
, since
>
> Is there a reason why the capitalisation is different for the two
> compiler flags?

No idea!

>
> > +  otherwise, any access to a global symbol would go through the GOT wh=
ich is
> > +  only relocated virtually.
> > +- `-mcmodel=3Dmedany`: Any access to a global symbol must be PC-relati=
ve to avoid
> > +  any relocations to happen before the MMU is setup.
> > +- Also note that *all* instrumentation must also be disabled (that inc=
ludes
>
> nit: s/Also note that//

Ok

>
> > +  KASAN, ftrace and others).
> > +
> > +As using a symbol from a different compilation unit requires this unit=
 to be
> > +compiled with those flags, we advise, as much as possible, not to use =
external
> > +symbols.
>
> If the use of early alternatives grows, are we going to have to split
> the vendors early alternatives into a different compilation unit from
> their regular alternatives?

Indeed, that would relax this constraint for the non-early part of the
file, but as we already talked, the goal is to remove all those
constraints by moving all this code in kernel/pi (at least it is my
goal :)).

>
> Cheers,
> Conor.

Thanks for your thorough review!
