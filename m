Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6316B2489
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCIMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCIMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:52:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B1EDB75;
        Thu,  9 Mar 2023 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678366351; x=1709902351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNQWFcbNiSx0YgFF7RrawPwzS3TsDDcIUIvyv/UuNkQ=;
  b=zab2grTjejgAds4m28QsgDfWkbxZzBzbSFj2ucF63GoNRo68CX7AZiDt
   2u5Fj4qyleMdSL4YiiJXnBfIBJ1gmy1/Oo33NREof4r9tzJRB5QqTa0r0
   F3OGOz/r0X28+I+HiYYCxrmSx43Jj3fuQYTtQu9uIK8jLoois/imVHEeo
   DoP6Pg7zUUwzpeAIDQ8oWyw2b8SPHoCzUUCQQ4zoNFT7zNYtKl8n/xnrD
   mhllaQuz256rt0PYHZ1TPMsEJa4Q/BTYwey9kquEU6fTkO7XK366M2mhd
   LlJ8u81GbpAyZ5vJftOSZoG9JeEC7JHGhNmzKYtzJFYJusJ2x4DAqj85L
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673938800"; 
   d="asc'?scan'208";a="204527753"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2023 05:52:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Mar 2023 05:52:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 9 Mar 2023 05:52:28 -0700
Date:   Thu, 9 Mar 2023 12:51:59 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Mike Rapoport <rppt@kernel.org>, Conor Dooley <conor@kernel.org>,
        <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <frowand.list@gmail.com>, <robh+dt@kernel.org>,
        <mick@ics.forth.gr>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <Valentina.FernandezAlanis@microchip.com>,
        <Daire.McNamara@microchip.com>
Subject: Re: RISC-V reserved memory problems
Message-ID: <b797bd15-ef3d-4d28-9aad-ffe0a32aa0b0@spud>
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com>
 <Y9wytv5KSt1ca+td@spud>
 <ZAchb/DfbIh+qaE4@kernel.org>
 <8abfb680-e1dd-8d1f-dd10-0a8bf086f5c3@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mUvIqHBQ7/8R2dhI"
Content-Disposition: inline
In-Reply-To: <8abfb680-e1dd-8d1f-dd10-0a8bf086f5c3@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mUvIqHBQ7/8R2dhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 01:45:05PM +0100, Alexandre Ghiti wrote:
>=20
> On 3/7/23 12:35, Mike Rapoport wrote:
> > Hi Conor,
> >=20
> > Sorry for the delay, somehow this slipped between the cracks.
> >=20
> > On Thu, Feb 02, 2023 at 10:01:26PM +0000, Conor Dooley wrote:
> > > Hullo Palmer, Mike & whoever else may read this,
> > >=20
> > > Just reviving this thread from a little while ago as I have been in t=
he
> > > area again recently...
> > TBH, I didn't really dig deep into the issues, but the thought I had was
> > what if DT was mapped via fixmap until the setup_vm_final() and then it
> > would be possible to call DT methods early.
> >=20
> > Could be I'm shooting in the dark :)
>=20
>=20
> I think I understand the issue now, it's because In riscv, we establish 2
> different virtual mappings and we map the device tree at 2 different virt=
ual
> addresses, which is the problem.
>=20
> So to me, the solution is:
>=20
> - to revert your previous fix, that is calling
> early_init_fdt_scan_reserved_mem() before any call to memblock_alloc()
> (which could result in an allocation in the area you want to reserve)
>=20
> - to map the device tree at the same virtual address, because
> early_init_fdt_scan_reserved_mem() initializes reserved_mem with the dtb
> mapping established in setup_vm() and uses reserved_mem with the new mapp=
ing
> from setup_vm_final (which is what Mike proposes, we should use the fixmap
> region to have the same virtual addresses)
>=20
> Hope that makes sense: I'll come up with something this afternoon for you=
 to
> test!

Sounds good. Please give me some ELI5 commit messages if you can,
explanations for this stuff (which I found took a lot of archaeology to
understand) would be very welcome next time we need to go back looking
at this stuff.

Thanks Alex!
Conor.

--mUvIqHBQ7/8R2dhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAnWbwAKCRB4tDGHoIJi
0lV+AP9XtW6MNhLD0bRLapXZEAgZkQBrftMGSKL9GmKJ4sPmyAD/SQYlZ6j9k1xD
+QKAkqJQ6hBfnbtegzICGOBWOil3ngk=
=dF4f
-----END PGP SIGNATURE-----

--mUvIqHBQ7/8R2dhI--
