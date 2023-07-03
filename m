Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157E1745708
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGCINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGCIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:12:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA1E40;
        Mon,  3 Jul 2023 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688371976; x=1719907976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fo5QyQNXlcBbrMO3f5a48E5JRc20DIlH7LgTLlJFjn8=;
  b=cNj8wdDoGbWExnJ5wIzoPkUXapcQqnKej+Hs90p+Wj+UXEj5aaiYNOCE
   m+3O0eN3zrtzeiLS0RYbGavNz8O1PWOl75o/bWn8pP6TYIZmw+c5O7N5B
   zrsaLfSo9l7TVU4Tgoue343u6i1CAxehHnFscbqBjgaBGBCzHcOfouw5w
   dEOWBwC+lFDthMJ9S2PdXRyQZtcmZOF3GDrP2yrsy9REKWAp1RVpVZWxe
   8voxo+wIlAYhUrVI+4G8Z78m+IGaAUV9bLZDWcD2qBFDBEF9AxhFa9C+2
   DLn9yx1ue8aQ4KAbG2VZ42OnZkXUkzgii1UY+lh8xgFXNeFMyONyrhHwd
   w==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="asc'?scan'208";a="221733761"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 01:12:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 01:12:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 01:12:49 -0700
Date:   Mon, 3 Jul 2023 09:12:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
CC:     Conor Dooley <conor@kernel.org>, <ardb@kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <rminnich@gmail.com>, <mark.rutland@arm.com>,
        <lpieralisi@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <jdelvare@suse.com>, <yc.hung@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <allen-kh.cheng@mediatek.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <tinghan.shen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <geshijian@bytedance.com>,
        <weidong.wd@bytedance.com>, <alexghiti@rivosinc.com>,
        <sunilvl@ventanamicro.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <20230703-glorified-headless-16e998608eaa@wendy>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702-headway-dreamlike-d7ba39ac4910@spud>
 <CAEEQ3wnzf=iDDHJATo2vdVz-SDNYRGBEEb7sXUyGojgP4ZAgaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M1EhX71m2I9eeqlT"
Content-Disposition: inline
In-Reply-To: <CAEEQ3wnzf=iDDHJATo2vdVz-SDNYRGBEEb7sXUyGojgP4ZAgaA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--M1EhX71m2I9eeqlT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jul 03, 2023 at 03:19:01PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> On Sun, Jul 2, 2023 at 9:48=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > %subject: riscv: obtain ACPI RSDP from FFI.
> >
> > This subject is a bit unhelpful because FFI would commonly mean "foreign
> > function interface" & you have not yet introduced it. It seems like it
> > would be better to do s/FFI/devicetree/ or similar.
>=20
> FFI: FDT FIRMWARE INTERFACE.
>=20
> You are right, s/FFI/devicetree/ is of course possible=EF=BC=8C but I act=
ually
> want to use FFI as a general solution, put all relevant codes under
> driver/firmware/, and use RISC-V arch to call general codes.

Yes, I read the patchset. It's still unhelpful to someone reading
$subject because nobody knows what your version of FFI is IMO.

> In this case, only one Kconfig CONFIG_FDT_FW_INTERFACE is enough=EF=BC=8C=
 and
> The FFI code will be placed first in the patchset.
>=20
> But Ard's suggestion is to put the part of SMBIOS in the generic code,
> and put the FFI for ACPI in the RISCV arch.
>=20
> Please see  the v1:
> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-c=
uiyunhui@bytedance.com/

I read this too, I was following along with the discussion on the v1.

> Put the following to /driver/firmware/ffi.c , What do you think?
> void __init ffi_acpi_root_pointer(void)
> {
>     ...
> }

Usually the NOP versions just go in the headers.

> > Please also drop the full stop from the commit messages ;)
> Okay, thanks.
>=20
> >
> > Please use a cover letter for multi-patch series & include changelogs.
> OK, On v3 I would use.
>=20
> >
> > +CC Sunil, Alex:
> >
> > Can you guys please take a look at this & see if it is something that we
> > want to do (ACPI without EFI)?
> >
> > On Sun, Jul 02, 2023 at 05:57:32PM +0800, Yunhui Cui wrote:
> > > 1. We need to enable the ACPI function on RISC-V.
> >
> > RISC-V already supports ACPI, the "we" in this commit message is
> > confusing. Who is "we"? Bytedance?

Who is the "we"?

> > > When booting with
> > > Coreboot, we encounter two problems:
> > > a. Coreboot does not support EFI
> >
> >
> > > b. On RISC-V, only the DTS channel can be used.
> >
> > We support ACPI, so this seems inaccurate. Could you explain it better
> > please?
>=20
> Yes, Sunil already supports ACPI, But it is based on EDK2 boot which
> supports EFI.
> In fact, We use Coreboot which has the features of a and b above.

My point is that the commit message has gaps in it.
This point b & point 1 make it seem like this patch adds ACPI support to
an architecture that only supports devicetree. "DTS channel" needs to be
explained further, to be frank I have no idea what that means. Does it
mean that coreboot on RISC-V only supports DT, or that the RISC-V linux
kernel requires a mini-DT when booting with EFI?

> > > 2. Based on this, we have added an interface for obtaining firmware
> > > information transfer through FDT, named FFI.
> >
> > Please use the long form of "FFI" before using the short form, since you
> > are inventing this & noone knows what it means yet.
> >
> > > 3. We not only use FFI to pass ACPI RSDP, but also pass other
> > > firmware information as an extension.
> >
> > This patch doesn't do that though?
>=20
> Similar problems may be encountered on other arches, which is also the
> purpose of this sentence.

Right, but that has nothing to do with this patch? This patch only
implements the ACPI side of things for RISC-V, it doesn't do the SMBIOS
stuff. Leave that for the patch that actually does that please.

> > > +RISC-V FDT FIRMWARE INTERFACE (FFI) SUPPORT
> > > +M:     Yunhui Cui cuiyunhui@bytedance.com
> > > +S:     Maintained
> > > +F:     arch/riscv/include/asm/ffi.h
> > > +F:     arch/riscv/kernel/ffi.c
> >
> > Please add this in alphabetical order, these entries have recently been
> > resorted. That said, maintainers entry for a trivial file in arch code
> > seems a wee bit odd, seems like it would be better suited rolled up into
> > your other entry for the interface, like how Ard's one looks for EFI?
> >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index b49793cf34eb..2e1c40fb2300 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -785,6 +785,16 @@ config EFI
> > >         allow the kernel to be booted as an EFI application. This
> > >         is only useful on systems that have UEFI firmware.
> > >
> > > +config FFI
> > > +     bool "Fdt firmware interface"
> > > +     depends on OF
> > > +     default y
> > > +     help
> > > +       Added an interface to obtain firmware information transfer
> > > +       through FDT, named FFI. Some bootloaders do not support EFI,
> > > +       such as coreboot.
> > > +       We can pass firmware information through FFI, such as ACPI.
> >
> > I don't understand your Kconfig setup. Why don't you just have one
> > option (the one from patch 2/3), instead of adding 2 different but
> > similarly named options?
> OK, let me try it=EF=BC=8C and use the Kconfig CONFIG_FDT_FW_INTERFACE.  =
EFI
> seems to use two...

It doesn't use two different options, AFAIR. There's an EFI option in
the arch Kconfigs and then a menu in drivers/firmware/efi/Kconfig that
allows enabling sub-components. You've got two entries that appear
unrelated, despite parsing the same DT bits.

>=20
> > >  config CC_HAVE_STACKPROTECTOR_TLS
> > >       def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-prot=
ector-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> > >
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/a=
cpi.h
> > > index f71ce21ff684..f9d1625dd159 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -15,6 +15,8 @@
> > >  /* Basic configuration for ACPI */
> > >  #ifdef CONFIG_ACPI
> > >
> > > +#include <asm/ffi.h>
> > > +
> > >  typedef u64 phys_cpuid_t;
> > >  #define PHYS_CPUID_INVALID INVALID_HARTID
> > >
> > > @@ -66,6 +68,13 @@ int acpi_get_riscv_isa(struct acpi_table_header *t=
able,
> > >                      unsigned int cpu, const char **isa);
> > >
> > >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_=
NO_NODE; }
> > > +
> > > +#define ACPI_HAVE_ARCH_GET_ROOT_POINTER
> >
> > How come this is not set in Kconfig like HAVE_FOO options usually are?

> This is modeled after x86 historical code.
> See arch/x86/include/asm/acpi.h

Is that a good reason for propagating the pattern? Is there a benefit to
this, other than "x86 did this"?

> > > +static inline u64 acpi_arch_get_root_pointer(void)
> > > +{
> > > +     return acpi_rsdp;
> > > +}
> > > +
> > >  #else
> > >  static inline void acpi_init_rintc_map(void) { }
> > >  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cp=
u)
> > > diff --git a/arch/riscv/include/asm/ffi.h b/arch/riscv/include/asm/ff=
i.h
> > > new file mode 100644
> > > index 000000000000..847af02abd87
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/ffi.h
> > > @@ -0,0 +1,9 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef _ASM_FFI_H
> > > +#define _ASM_FFI_H
> > > +
> > > +extern u64 acpi_rsdp;
> >
> > /stuff/linux/drivers/acpi/osl.c:178:22: error: redefinition of 'acpi_rs=
dp' with a different type: 'unsigned long' vs 'u64' (aka 'unsigned long lon=
g')
> >
> > Fails to build when Kexec is enabled.
>=20
> Rename my acpi_rsdp to arch_acpi_rsdp? WDYT?

You could do s/arch/riscv/ either, that'd match what we prefix a lot of
stuff with.

> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 506cc4a9a45a..274e06f4da33 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -92,6 +92,7 @@ obj-$(CONFIG_CRASH_CORE)    +=3D crash_core.o
> > >  obj-$(CONFIG_JUMP_LABEL)     +=3D jump_label.o
> > >
> > >  obj-$(CONFIG_EFI)            +=3D efi.o
> > > +obj-$(CONFIG_FFI)              +=3D ffi.o
> >
> > This file uses tabs for alignment, not spaces.
> Okay, got it.
>=20
> >
> > >  obj-$(CONFIG_COMPAT)         +=3D compat_syscall_table.o
> > >  obj-$(CONFIG_COMPAT)         +=3D compat_signal.o
> > >  obj-$(CONFIG_COMPAT)         +=3D compat_vdso/
> > > diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
> > > new file mode 100644
> > > index 000000000000..c5ac2b5d9148
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/ffi.c

> > > +void __init ffi_init(void)
> > > +{
> > > +     ffi_acpi_root_pointer();
> >
> > What happens if, on a system with "normal" ACPI support, ffi_init() is
> > called & ffi_acpi_root_pointer() calls things like fdt_path_offset()?
>=20
> According to the current logic, get it from FFI is enabled, if can
> not,  continue to use =E2=80=9Cnormal=E2=80=9D ACPI.

I find it hard to understand what you mean here. Do you mean something
like "The calls to fdt_path_offset() will use the mini EFI DT and are
harmless. If the config table is not present, it will continue to use
\"normal\" ACPI."?

> > > +}
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 971fe776e2f8..5a933d6b6acb 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -36,6 +36,7 @@
> > >  #include <asm/thread_info.h>
> > >  #include <asm/kasan.h>
> > >  #include <asm/efi.h>
> > > +#include <asm/ffi.h>
> > >
> > >  #include "head.h"
> > >
> > > @@ -279,6 +280,7 @@ void __init setup_arch(char **cmdline_p)
> > >       parse_early_param();
> > >
> > >       efi_init();
> > > +     ffi_init();
> >
> > What provides ffi_init() if CONFIG_FFI is disabled?

> Ok=EF=BC=8C Modified on v3,  put it with the CONFIG_FFI

Sorry, what does this mean?

>=20
> >
> > >       paging_init();
> > >
> > >       /* Parse the ACPI tables for possible boot-time configuration */

Cheers,
Conor.

--M1EhX71m2I9eeqlT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKKC4AAKCRB4tDGHoIJi
0i/rAQDK0N2PCs56a6/oa3r2mQ2FioR6czsH3HeC5FmV/3I1ZgEApe0a2iAiXi9S
89iw8GcZkYMQI9puOTWjNbM3uBBumQs=
=JgN0
-----END PGP SIGNATURE-----

--M1EhX71m2I9eeqlT--
