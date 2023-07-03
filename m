Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F1745770
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGCIgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGCIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:35:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6471BC;
        Mon,  3 Jul 2023 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688373337; x=1719909337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/VuNN8vAbwtoIAOscoPME46U2tJgXgmlj69V2xtFA4=;
  b=RyZ7HNR6bMhH0ZiNirsKaePdk/R7aFfPF09X40XE0DsC/YNmiozVZVMI
   u6yQXk69OrSaLBYhnQrLljk9uy2yGyB7/+tqbKZ3Kapul+cfSQJUnNLEe
   Iw2vc7BOO7ym13ZbTrcyyNW4yhHjuv+A+gLmfbBxxwHc0hJ1XRtYO2rQh
   9YqHBhN+BZ0/ChEKBl5sahQxA30xFvFvony7JpB2Env1fwrbmQgxkAfaT
   JCtU0er3nTO6Crw4++JcpLVARc0jfRV4RfV05LlU3cXD12wkjxAX/2OBc
   +Um9srdP/12RfqzbM0OzqaOuuvRh3603rZHL6pKE+U8CxtKztUGHBFHie
   g==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="asc'?scan'208";a="218667141"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 01:35:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 01:35:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 01:35:24 -0700
Date:   Mon, 3 Jul 2023 09:34:54 +0100
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
        <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v2 2/3] firmware: introduce FFI for SMBIOS
 entry.
Message-ID: <20230703-rebuff-smashing-6b2c6f80ba05@wendy>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702095735.860-2-cuiyunhui@bytedance.com>
 <20230702-collide-rumor-f0d915a4f1b2@spud>
 <CAEEQ3w=CMSMnYmfprYS4ydsA=EBJtLhQQHWky754EC-iifcYtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgEY+RpkWKJjg9BW"
Content-Disposition: inline
In-Reply-To: <CAEEQ3w=CMSMnYmfprYS4ydsA=EBJtLhQQHWky754EC-iifcYtg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mgEY+RpkWKJjg9BW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jul 03, 2023 at 04:23:53PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
>=20
> > nit: please don't write your commit messages as bullet lists
> Okay, thanks for your suggestion.
>=20
> > > +FDT FIRMWARE INTERFACE (FFI)
> > > +M:   Yunhui Cui cuiyunhui@bytedance.com
> > > +S:   Maintained
> > > +F:   drivers/firmware/ffi.c
> > > +F:   include/linux/ffi.h
> >
> > Are you going to apply patches for this, or is someone else?
> Yes,  it will be used by patch 3/3.

That's not what I asked :(

> > >  EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)
> > >  M:   MyungJoo Ham <myungjoo.ham@samsung.com>
> > >  M:   Chanwoo Choi <cw00.choi@samsung.com>
> > > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > > index b59e3041fd62..ea0149fb4683 100644
> > > --- a/drivers/firmware/Kconfig
> > > +++ b/drivers/firmware/Kconfig
> > > @@ -303,6 +303,17 @@ config TURRIS_MOX_RWTM
> > >         other manufacturing data and also utilize the Entropy Bit Gen=
erator
> > >         for hardware random number generation.
> > >
> > > +config FDT_FW_INTERFACE
> > > +       bool "An interface for passing firmware info through FDT"
> > > +       depends on OF && OF_FLATTREE
> > > +       default n
> > > +       help
> > > +         When some bootloaders do not support EFI, and the arch does=
 not
> > > +         support SMBIOS_ENTRY_POINT_SCAN_START, then you can enable =
this option
> > > +         to support the transfer of firmware information, such as sm=
bios tables.
> >
> > Could you express this dependency on !SMBIOS_ENTRY_POINT_SCAN_START in
> > Kconfig & then simply the text to:
> > "Enable this option to support the transfer of firmware information,
> > such as smbios tables, for bootloaders that do not support EFI."
> > since it would not even appear if the arch supports scanning for the
> > entry point?
> > If I was was a punter trying to configure my kernel in menuconfig or
> > whatever, I should be able to decide based on the help text if I need
> > this, not going grepping for #defines in headers.
> Okay=EF=BC=8C I'll update on v3.
>=20
>=20
> >
> > >  static void __init dmi_scan_machine(void)
> > > @@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
> > >       char __iomem *p, *q;
> > >       char buf[32];
> > >
> > > +#ifdef CONFIG_FDT_FW_INTERFACE
> > > +     if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
> >
> > "dmi_sacn_smbios"
> >
> > > +             goto error;
> > > +#endif
> >
> > Does this not mean that if FDT_FW_INTERFACE is enabled, but the platform
> > wants to use EFI, it won't be able to? The `goto error;` makes this look
> > mutually exclusive to my efi-unaware eyes.
>=20
> If you have enabled FFI, then if something goes wrong, you should goto er=
ror.
> Just like the origin code:
>         if (efi_enabled(EFI_CONFIG_TABLES)) {
>                 if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
>                         goto error;
>         } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
>                 p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10=
000);
>                 if (p =3D=3D NULL)
>                         goto error;

Does this not make FFI and EFI mutually exclusive Kconfig options?
Suppose you are on a system that does not implement FFI, but does
implement EFI - what's going to happen then?
AFAICT, dmi_sacn_smbios(ffi.smbios3, ffi.smbios) will fail & you'll do a
`goto error` & skip the EFI code. What am I missing?

> > >       if (efi_enabled(EFI_CONFIG_TABLES)) {
> > > -             /*
> > > -              * According to the DMTF SMBIOS reference spec v3.0.0, =
it is
> > > -              * allowed to define both the 64-bit entry point (smbio=
s3) and
> > > -              * the 32-bit entry point (smbios), in which case they =
should
> > > -              * either both point to the same SMBIOS structure table=
, or the
> > > -              * table pointed to by the 64-bit entry point should co=
ntain a
> > > -              * superset of the table contents pointed to by the 32-=
bit entry
> > > -              * point (section 5.2)
> > > -              * This implies that the 64-bit entry point should have
> > > -              * precedence if it is defined and supported by the OS.=
 If we
> > > -              * have the 64-bit entry point, but fail to decode it, =
fall
> > > -              * back to the legacy one (if available)
> > > -              */
> > > -             if (efi.smbios3 !=3D EFI_INVALID_TABLE_ADDR) {
> > > -                     p =3D dmi_early_remap(efi.smbios3, 32);
> > > -                     if (p =3D=3D NULL)
> > > -                             goto error;
> > > -                     memcpy_fromio(buf, p, 32);
> > > -                     dmi_early_unmap(p, 32);
> > > -
> > > -                     if (!dmi_smbios3_present(buf)) {
> > > -                             dmi_available =3D 1;
> > > -                             return;
> > > -                     }
> > > -             }
> > > -             if (efi.smbios =3D=3D EFI_INVALID_TABLE_ADDR)
> > > +             if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> > >                       goto error;
> > > -
> > > -             /* This is called as a core_initcall() because it isn't
> > > -              * needed during early boot.  This also means we can
> > > -              * iounmap the space when we're done with it.
> > > -              */
> > > -             p =3D dmi_early_remap(efi.smbios, 32);
> > > -             if (p =3D=3D NULL)
> > > -                     goto error;
> > > -             memcpy_fromio(buf, p, 32);
> > > -             dmi_early_unmap(p, 32);
> > > -
> > > -             if (!dmi_present(buf)) {
> > > -                     dmi_available =3D 1;
> > > -                     return;
> > > -             }
> > > diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
> > > new file mode 100644
> > > index 000000000000..169802b4a7a8
> > > --- /dev/null
> > > +++ b/drivers/firmware/ffi.c
> > > @@ -0,0 +1,36 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/of.h>
> > > +#include <linux/of_fdt.h>
> > > +#include <linux/libfdt.h>
> > > +#include <linux/ffi.h>
> > > +
> > > +#define FFI_INVALID_TABLE_ADDR       (~0UL)
> > > +
> > > +struct ffi __read_mostly ffi =3D {
> > > +     .smbios =3D FFI_INVALID_TABLE_ADDR,
> > > +     .smbios3 =3D FFI_INVALID_TABLE_ADDR,
> > > +};
> >
> > > +EXPORT_SYMBOL(ffi);
> >
> > > +// SPDX-License-Identifier: GPL-2.0-only
> >
> > Why not EXPORT_SYMBOL_GPL? But also, who is the user of this export?
> Just like efi.

I don't really understand how that is an answer to the questions.

> > > +
> > > +void __init ffi_smbios_root_pointer(void)
> > > +{
> > > +     int cfgtbl, len;
> > > +     fdt64_t *prop;
> > > +
> > > +     cfgtbl =3D fdt_path_offset(initial_boot_params, "/cfgtables");
> >
> > These DT properties need to be documented in a binding.
> >
> > > +     if (cfgtbl < 0) {
> > > +             pr_info("firmware table not found.\n");
> >
> > Isn't it perfectly valid for a DT not to contain this table? This print
> > should be, at the very least, a pr_debug().
> >
> > > +             return;
> > > +     }
> > > +     prop =3D fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy=
_ptr", &len);
> >
> > Again, undocumented DT property. Please document them in a binding.
> Okay, I'll add them into binding.
>=20
>=20
> >
> > > +     if (!prop || len !=3D sizeof(u64))
> > > +             pr_info("smbios entry point not found.\n");
> > > +     else
> > > +             ffi.smbios =3D fdt64_to_cpu(*prop);
> > > +
> > > +     pr_info("smbios root pointer: %lx\n", ffi.smbios);
> >
> > ffi.smbios is not set if (!prop || len !=3D sizeof(u64)), looks like yo=
ur
> > "if" should return and the contents of the else become unconditional?
> > Otherwise, this print seems wrong.

> OK, I will optimize this logic and print.

It's not an optimisation. If the if branch of your code is taken, it
currently will do
	pr_info("smbios entry point not found.\n");
	pr_info("smbios root pointer: %lx\n", ffi.smbios);
which makes no sense...

Thanks,
Conor.


--mgEY+RpkWKJjg9BW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKKILgAKCRB4tDGHoIJi
0sHCAP9oR6Zc2RsczALqIEh4yefVd02+y2p1qwmzjU1PUXkz+AD+OWkhwMcOhFzn
0UxULbuvEFFad2H/cRSU/EQJI0LbcAo=
=2KIj
-----END PGP SIGNATURE-----

--mgEY+RpkWKJjg9BW--
