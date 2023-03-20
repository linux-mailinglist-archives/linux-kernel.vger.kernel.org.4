Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2B6C1191
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCTMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCTMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:12:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877355B6;
        Mon, 20 Mar 2023 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679314323; x=1710850323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0cFu0waq1sUq+AFu96iKtjuSciX3NLthHqTvv/AT2A=;
  b=eMg1sYRUdPDJnjwMuCE0M2fZtTnbvC4m5tyJZ+CJYyUTqFa6WOhlUH+3
   psIaUsOb2be857XaoLwmlD8wy8gZgU6kd6YwOZK2dU0CXtDjSFd3LamId
   3kAbq1QbVG41Qce4Hwkd9AtD7Vn603nLc3w7t6VeaRGBLQ/CrQjL9niL9
   emgHDX/nkmmbCHJVtMXmXjbowlnLpd/dwBOY3S64m7sFXT8mpPo5hZ3dH
   jMs4ecPUBXPV67auiOuvd2jlfvJRvIo1T6R7kLV6cdCrcxIUtJelip3cx
   bohqoYKBR8litpM1JIc9xfUATjUiIH5+DKzBxfzaa04aebr2dpNLyzHjE
   g==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673938800"; 
   d="asc'?scan'208";a="205502494"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Mar 2023 05:12:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 05:12:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 20 Mar 2023 05:11:59 -0700
Date:   Mon, 20 Mar 2023 12:11:29 +0000
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
Message-ID: <e2203659-e1ac-4fbf-9b5d-2c561255b645@spud>
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com>
 <Y9wytv5KSt1ca+td@spud>
 <ZAchb/DfbIh+qaE4@kernel.org>
 <8abfb680-e1dd-8d1f-dd10-0a8bf086f5c3@ghiti.fr>
 <b797bd15-ef3d-4d28-9aad-ffe0a32aa0b0@spud>
 <de204b7c-7c1d-bd7b-0072-d128757258e2@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pKzsOyM01oqrnRqw"
Content-Disposition: inline
In-Reply-To: <de204b7c-7c1d-bd7b-0072-d128757258e2@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pKzsOyM01oqrnRqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 04:12:57PM +0100, Alexandre Ghiti wrote:
> On 3/9/23 13:51, Conor Dooley wrote:
> > On Thu, Mar 09, 2023 at 01:45:05PM +0100, Alexandre Ghiti wrote:
> > > On 3/7/23 12:35, Mike Rapoport wrote:
> > > > Hi Conor,
> > > >=20
> > > > Sorry for the delay, somehow this slipped between the cracks.
> > > >=20
> > > > On Thu, Feb 02, 2023 at 10:01:26PM +0000, Conor Dooley wrote:
> > > > > Hullo Palmer, Mike & whoever else may read this,
> > > > >=20
> > > > > Just reviving this thread from a little while ago as I have been =
in the
> > > > > area again recently...
> > > > TBH, I didn't really dig deep into the issues, but the thought I ha=
d was
> > > > what if DT was mapped via fixmap until the setup_vm_final() and the=
n it
> > > > would be possible to call DT methods early.
> > > >=20
> > > > Could be I'm shooting in the dark :)
> > >=20
> > > I think I understand the issue now, it's because In riscv, we establi=
sh 2
> > > different virtual mappings and we map the device tree at 2 different =
virtual
> > > addresses, which is the problem.
> > >=20
> > > So to me, the solution is:
> > >=20
> > > - to revert your previous fix, that is calling
> > > early_init_fdt_scan_reserved_mem() before any call to memblock_alloc()
> > > (which could result in an allocation in the area you want to reserve)
> > >=20
> > > - to map the device tree at the same virtual address, because
> > > early_init_fdt_scan_reserved_mem() initializes reserved_mem with the =
dtb
> > > mapping established in setup_vm() and uses reserved_mem with the new =
mapping
> > > from setup_vm_final (which is what Mike proposes, we should use the f=
ixmap
> > > region to have the same virtual addresses)
> > >=20
> > > Hope that makes sense: I'll come up with something this afternoon for=
 you to
> > > test!
> > Sounds good. Please give me some ELI5 commit messages if you can,
> > explanations for this stuff (which I found took a lot of archaeology to
> > understand) would be very welcome next time we need to go back looking
> > at this stuff.
>=20
>=20
> Can you give it a try here:
> https://github.com/AlexGhiti/riscv-linux/commits/dev/alex/conor_dtb_fixma=
p_v1
> ?
>=20
> That works for me but I need to carefully explain and check that's correct
> though, not upstreamable as is.

Hey Alex,

So I ended up being pretty sick & had to take a week off. I gave this an
initial spin today & it appears to work.
I'll take it for a longer test-drive when you send a "real" patch for
it, but I tested both the lookup by name & the situation that was
allocating in reserved memory and both were not an issue.

Thanks for working on this,
Conor.

--pKzsOyM01oqrnRqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBhNcQAKCRB4tDGHoIJi
0jHSAQDYXV+uHHctZPqRy4OTzH84+s3JkFLcich/mv5xUvEIsAEAttjvErnc91Wo
/sgB9RuUAHwyl42K555VXdhZIr5oHQg=
=vZ1A
-----END PGP SIGNATURE-----

--pKzsOyM01oqrnRqw--
