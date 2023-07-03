Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E19745CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGCNDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGCNDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:03:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78062CA;
        Mon,  3 Jul 2023 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688389384; x=1719925384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKDOENosKmEiL2k4tBZQmuXWBUtv1K4FuCfUPDPb270=;
  b=RBVMA+7/YD5TQF2fmMiOeeUCNouhjysPpTbtwl6+FH8D7XrcgZgHQQeg
   XrEXlrTE3YEC9SZ5SYQL0PUfnYgSyzarmZ8ihsX4w9rF5PCfYBtyIoMXP
   ULLzM/+vY0KZsPnR8d0JUcxHllrlPoO8uKCY9zBILnhCZJ5Wr1JxFicX6
   7Q6bnTCrPy5y/5sBci5m2odpFw7go/sUY5HMibPBiCQjiIbnHsyFFL6Oo
   d2nWiayBQO3sqEqkAsNF9cHrv8mLEuMAhvrwwopKu9mMNZgYbYHFiKM3Z
   glm4ZVs5w6oICr339Bbu4O4OoFRbX1ytS5QSIrzO0DzspixQ/ScNrIkVD
   w==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="asc'?scan'208";a="221065931"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 06:02:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 06:02:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 06:02:45 -0700
Date:   Mon, 3 Jul 2023 14:02:15 +0100
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
Message-ID: <20230703-patrol-paced-76cd5e24db6b@wendy>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702095735.860-2-cuiyunhui@bytedance.com>
 <20230702-collide-rumor-f0d915a4f1b2@spud>
 <CAEEQ3w=CMSMnYmfprYS4ydsA=EBJtLhQQHWky754EC-iifcYtg@mail.gmail.com>
 <20230703-rebuff-smashing-6b2c6f80ba05@wendy>
 <CAEEQ3w=-1Zns_pZRSeM0+Wv46y6RttcT5jFy_ENnq--RptYp2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Uht1cacpbtCJeEos"
Content-Disposition: inline
In-Reply-To: <CAEEQ3w=-1Zns_pZRSeM0+Wv46y6RttcT5jFy_ENnq--RptYp2g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Uht1cacpbtCJeEos
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 08:41:30PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> On Mon, Jul 3, 2023 at 4:36=E2=80=AFPM Conor Dooley <conor.dooley@microch=
ip.com> wrote:
> > On Mon, Jul 03, 2023 at 04:23:53PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 w=
rote:

> > > > > +FDT FIRMWARE INTERFACE (FFI)
> > > > > +M:   Yunhui Cui cuiyunhui@bytedance.com
> > > > > +S:   Maintained
> > > > > +F:   drivers/firmware/ffi.c
> > > > > +F:   include/linux/ffi.h
> > > >
> > > > Are you going to apply patches for this, or is someone else?
> > > Yes,  it will be used by patch 3/3.
> >
> > That's not what I asked :(
>=20
> Sorry,  ok,  what do you want to ask?

Who is going to apply patches for drivers/firmware/ffi*?

> > > > >  static void __init dmi_scan_machine(void)
> > > > > @@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
> > > > >       char __iomem *p, *q;
> > > > >       char buf[32];
> > > > >
> > > > > +#ifdef CONFIG_FDT_FW_INTERFACE
> > > > > +     if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
> > > >
> > > > "dmi_sacn_smbios"
> > > >
> > > > > +             goto error;
> > > > > +#endif
> > > >
> > > > Does this not mean that if FDT_FW_INTERFACE is enabled, but the pla=
tform
> > > > wants to use EFI, it won't be able to? The `goto error;` makes this=
 look
> > > > mutually exclusive to my efi-unaware eyes.
> > >
> > > If you have enabled FFI, then if something goes wrong, you should got=
o error.
> > > Just like the origin code:
> > >         if (efi_enabled(EFI_CONFIG_TABLES)) {
> > >                 if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
> > >                         goto error;
> > >         } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBAC=
K)) {
> > >                 p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, =
0x10000);
> > >                 if (p =3D=3D NULL)
> > >                         goto error;
> >
> > Does this not make FFI and EFI mutually exclusive Kconfig options?
> > Suppose you are on a system that does not implement FFI, but does
> > implement EFI - what's going to happen then?
> > AFAICT, dmi_sacn_smbios(ffi.smbios3, ffi.smbios) will fail & you'll do a
> > `goto error` & skip the EFI code. What am I missing?
>=20
> Code is not intended to be mutually exclusive, get the correct value and =
return,
> The code is going to be changed to this:
>=20
> #ifdef CONFIG_FDT_FW_INTERFACE

Ideally, these would be IS_ENABLED() instead of #ifdef - but if you copy
what EFI does, then you don't need either, as there will always be an
ffi_enabled() defined.

>         if (ffi_enabled(FFI_CONFIG_TABLES)) {

I don't know what this function is, but this code seems like a step in
the right direction.

>                 if (!dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
>                         return;
>         }
> #endif

Thanks,
Conor.

--Uht1cacpbtCJeEos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKLG1wAKCRB4tDGHoIJi
0p4CAP9UFrVTshkvkiDgNgv0fkaJeO/6lTdr5tKFaGdb9LpN5gD9HCH4Z3GCfUq8
vJfacU093Un2qeuoIdVM+04hLm4hnQ0=
=/UOt
-----END PGP SIGNATURE-----

--Uht1cacpbtCJeEos--
