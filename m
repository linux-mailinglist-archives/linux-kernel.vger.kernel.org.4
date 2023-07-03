Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A27455D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjGCHTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGCHTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:19:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF1D1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:19:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f875b267d9so6283375e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688368753; x=1690960753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtebQLIZdSRHMNweZtl9CpSzAwnJBH7sdxrx9vZRKrw=;
        b=lGnqf8ck325RiQ5OVd6sGeCefJKsgYsFl8jly9ocyhQWkA5msfGhD4jURmXrOHv5sz
         meUPXxFBWI0sNRmDPHfoOLubRlHEZVadeQoCBg6uAlz1ngzpez6oeh056v2pi5lLDLTX
         eci1Q42KmWblVKlI/BTHTWkDJXfjyDsMltClFXCDZLPFTeLHh3OjL7DhaQ+dP23dV2FH
         dz9EZgxPIXaS4w7xjGreU4SI1GQUV+c+e2LlCnyQdZu9zxBtjMUlbSO3MynGNOpi0Qg6
         jzrIjT4wWU7jRFPedwDgUYsRWI/lbMk5R5ScmrAclAiIm2br831D9EcIh+3VtRY7jgUP
         XJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688368753; x=1690960753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtebQLIZdSRHMNweZtl9CpSzAwnJBH7sdxrx9vZRKrw=;
        b=bHkhMZXR+md9XDiCyonOIpKC0Ij7PskbG5AIO33PGgubWOnD+2SCE71QcBjTjPZv4j
         FKOaimbPqWpw1sR+cx68u4/MeYq3hCBAD/9iUccK8VjasG3Wjl2eW4BsC1Ku+Hcz3q91
         rIqC4yESr7wM5g0rePqg+O/aBhqBuvmluR77IEgrVOVeru5mFa8gbES5wslAdxnCStk6
         meopu4XrKycrVs2jYGSb8t2jiHb5FGvV7jpnUtnmSfZuNXezjlcpjkym76TvCXTQiyg0
         jdVEr1J8EledAl3I+LZqgyzaZTNYWeI14HLLmNmLRa9KukgJzvamZzUmNViSAYu22MlD
         gcKg==
X-Gm-Message-State: ABy/qLa/3apFl3Xi4Kmx5KKnGOhjXk5I/IB9SQ4W/IvCdeXKHvoV2ZQf
        8YOmAOcO9672fjpAed69WoaGd8fk6kZDSjzaHffQHw==
X-Google-Smtp-Source: APBJJlG61zFjMe1dVqXS9PKK1Fv7xdR289e82FbM96Qx+97WUwUpWN+ceSsDmFGAl/NNio8E6NYwPhzSGKuB+eUQJgI=
X-Received: by 2002:a05:6512:4028:b0:4f9:69b8:1e7c with SMTP id
 br40-20020a056512402800b004f969b81e7cmr7043008lfb.46.1688368752911; Mon, 03
 Jul 2023 00:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702-headway-dreamlike-d7ba39ac4910@spud>
In-Reply-To: <20230702-headway-dreamlike-d7ba39ac4910@spud>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 15:19:01 +0800
Message-ID: <CAEEQ3wnzf=iDDHJATo2vdVz-SDNYRGBEEb7sXUyGojgP4ZAgaA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     Conor Dooley <conor@kernel.org>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, alexghiti@rivosinc.com,
        sunilvl@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor

On Sun, Jul 2, 2023 at 9:48=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> Hey,
> %subject: riscv: obtain ACPI RSDP from FFI.
>
> This subject is a bit unhelpful because FFI would commonly mean "foreign
> function interface" & you have not yet introduced it. It seems like it
> would be better to do s/FFI/devicetree/ or similar.

FFI: FDT FIRMWARE INTERFACE.

You are right, s/FFI/devicetree/ is of course possible=EF=BC=8C but I actua=
lly
want to use FFI as a general solution, put all relevant codes under
driver/firmware/, and use RISC-V arch to call general codes.

In this case, only one Kconfig CONFIG_FDT_FW_INTERFACE is enough=EF=BC=8C a=
nd
The FFI code will be placed first in the patchset.

But Ard's suggestion is to put the part of SMBIOS in the generic code,
and put the FFI for ACPI in the RISCV arch.

Please see  the v1:
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cui=
yunhui@bytedance.com/

Put the following to /driver/firmware/ffi.c , What do you think?
void __init ffi_acpi_root_pointer(void)
{
    ...
}


> Please also drop the full stop from the commit messages ;)
Okay, thanks.

>
> Please use a cover letter for multi-patch series & include changelogs.
OK, On v3 I would use.

>
> +CC Sunil, Alex:
>
> Can you guys please take a look at this & see if it is something that we
> want to do (ACPI without EFI)?
>
> On Sun, Jul 02, 2023 at 05:57:32PM +0800, Yunhui Cui wrote:
> > 1. We need to enable the ACPI function on RISC-V.
>
> RISC-V already supports ACPI, the "we" in this commit message is
> confusing. Who is "we"? Bytedance?
>
> > When booting with
> > Coreboot, we encounter two problems:
> > a. Coreboot does not support EFI
>
>
> > b. On RISC-V, only the DTS channel can be used.
>
> We support ACPI, so this seems inaccurate. Could you explain it better
> please?

Yes, Sunil already supports ACPI, But it is based on EDK2 boot which
supports EFI.
In fact, We use Coreboot which has the features of a and b above.

>
> > 2. Based on this, we have added an interface for obtaining firmware
> > information transfer through FDT, named FFI.
>
> Please use the long form of "FFI" before using the short form, since you
> are inventing this & noone knows what it means yet.
>
> > 3. We not only use FFI to pass ACPI RSDP, but also pass other
> > firmware information as an extension.
>
> This patch doesn't do that though?

Similar problems may be encountered on other arches, which is also the
purpose of this sentence.

> > +RISC-V FDT FIRMWARE INTERFACE (FFI) SUPPORT
> > +M:     Yunhui Cui cuiyunhui@bytedance.com
> > +S:     Maintained
> > +F:     arch/riscv/include/asm/ffi.h
> > +F:     arch/riscv/kernel/ffi.c
>
> Please add this in alphabetical order, these entries have recently been
> resorted. That said, maintainers entry for a trivial file in arch code
> seems a wee bit odd, seems like it would be better suited rolled up into
> your other entry for the interface, like how Ard's one looks for EFI?
>
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b49793cf34eb..2e1c40fb2300 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -785,6 +785,16 @@ config EFI
> >         allow the kernel to be booted as an EFI application. This
> >         is only useful on systems that have UEFI firmware.
> >
> > +config FFI
> > +     bool "Fdt firmware interface"
> > +     depends on OF
> > +     default y
> > +     help
> > +       Added an interface to obtain firmware information transfer
> > +       through FDT, named FFI. Some bootloaders do not support EFI,
> > +       such as coreboot.
> > +       We can pass firmware information through FFI, such as ACPI.
>
> I don't understand your Kconfig setup. Why don't you just have one
> option (the one from patch 2/3), instead of adding 2 different but
> similarly named options?
OK, let me try it=EF=BC=8C and use the Kconfig CONFIG_FDT_FW_INTERFACE.  EF=
I
seems to use two...

> >  config CC_HAVE_STACKPROTECTOR_TLS
> >       def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-protec=
tor-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> >
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acp=
i.h
> > index f71ce21ff684..f9d1625dd159 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -15,6 +15,8 @@
> >  /* Basic configuration for ACPI */
> >  #ifdef CONFIG_ACPI
> >
> > +#include <asm/ffi.h>
> > +
> >  typedef u64 phys_cpuid_t;
> >  #define PHYS_CPUID_INVALID INVALID_HARTID
> >
> > @@ -66,6 +68,13 @@ int acpi_get_riscv_isa(struct acpi_table_header *tab=
le,
> >                      unsigned int cpu, const char **isa);
> >
> >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> > +
> > +#define ACPI_HAVE_ARCH_GET_ROOT_POINTER
>
> How come this is not set in Kconfig like HAVE_FOO options usually are?
This is modeled after x86 historical code.
See arch/x86/include/asm/acpi.h

> > +static inline u64 acpi_arch_get_root_pointer(void)
> > +{
> > +     return acpi_rsdp;
> > +}
> > +
> >  #else
> >  static inline void acpi_init_rintc_map(void) { }
> >  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > diff --git a/arch/riscv/include/asm/ffi.h b/arch/riscv/include/asm/ffi.=
h
> > new file mode 100644
> > index 000000000000..847af02abd87
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/ffi.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _ASM_FFI_H
> > +#define _ASM_FFI_H
> > +
> > +extern u64 acpi_rsdp;
>
> /stuff/linux/drivers/acpi/osl.c:178:22: error: redefinition of 'acpi_rsdp=
' with a different type: 'unsigned long' vs 'u64' (aka 'unsigned long long'=
)
>
> Fails to build when Kexec is enabled.

Rename my acpi_rsdp to arch_acpi_rsdp? WDYT?

>
> > +extern void ffi_init(void);
> > +
> > +#endif /* _ASM_FFI_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 506cc4a9a45a..274e06f4da33 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -92,6 +92,7 @@ obj-$(CONFIG_CRASH_CORE)    +=3D crash_core.o
> >  obj-$(CONFIG_JUMP_LABEL)     +=3D jump_label.o
> >
> >  obj-$(CONFIG_EFI)            +=3D efi.o
> > +obj-$(CONFIG_FFI)              +=3D ffi.o
>
> This file uses tabs for alignment, not spaces.
Okay, got it.

>
> >  obj-$(CONFIG_COMPAT)         +=3D compat_syscall_table.o
> >  obj-$(CONFIG_COMPAT)         +=3D compat_signal.o
> >  obj-$(CONFIG_COMPAT)         +=3D compat_vdso/
> > diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
> > new file mode 100644
> > index 000000000000..c5ac2b5d9148
> > --- /dev/null
> > +++ b/arch/riscv/kernel/ffi.c
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ffi.c - FDT FIRMWARE INTERFACE
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/libfdt.h>
> > +
> > +u64 acpi_rsdp;
> > +
> > +void __init ffi_acpi_root_pointer(void)
> > +{
> > +     int cfgtbl, len;
> > +     fdt64_t *prop;
> > +
> > +     cfgtbl =3D fdt_path_offset(initial_boot_params, "/cfgtables");
> > +     if (cfgtbl < 0) {
> > +             pr_info("firmware table not found.\n");
> > +             return;
> > +     }
> > +
> > +     prop =3D fdt_getprop_w(initial_boot_params, cfgtbl, "acpi_phy_ptr=
", &len);
> > +     if (!prop || len !=3D sizeof(u64))
> > +             pr_info("acpi_rsdp not found.\n");
> > +     else
> > +             acpi_rsdp =3D fdt64_to_cpu(*prop);
> > +
> > +     pr_debug("acpi rsdp: %llx\n", acpi_rsdp);
>
> Same comments here about undocumented DT properties and pr_*()s that
> likely are not wanted (or correct).
Okay=EF=BC=8Cupdate it on v3.

>
> > +}
> > +
> > +void __init ffi_init(void)
> > +{
> > +     ffi_acpi_root_pointer();
>
> What happens if, on a system with "normal" ACPI support, ffi_init() is
> called & ffi_acpi_root_pointer() calls things like fdt_path_offset()?

According to the current logic, get it from FFI is enabled, if can
not,  continue to use =E2=80=9Cnormal=E2=80=9D ACPI.

> > +}
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 971fe776e2f8..5a933d6b6acb 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -36,6 +36,7 @@
> >  #include <asm/thread_info.h>
> >  #include <asm/kasan.h>
> >  #include <asm/efi.h>
> > +#include <asm/ffi.h>
> >
> >  #include "head.h"
> >
> > @@ -279,6 +280,7 @@ void __init setup_arch(char **cmdline_p)
> >       parse_early_param();
> >
> >       efi_init();
> > +     ffi_init();
>
> What provides ffi_init() if CONFIG_FFI is disabled?
Ok=EF=BC=8C Modified on v3,  put it with the CONFIG_FFI

>
> >       paging_init();
> >
> >       /* Parse the ACPI tables for possible boot-time configuration */
>
> Cheers,
> Conor.

Thanks,
Yunhui
