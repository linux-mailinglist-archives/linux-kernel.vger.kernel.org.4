Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8047B7045E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjEPHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjEPHMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:12:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24441BF5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684221154; x=1715757154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8CijbnvNDIu5h7DZKaUt0LbJeKMTc2o7hsFHeeJoGY=;
  b=oNuPs/G7WP62xEgwj7e+flEShDwJkYySXAgrSaEvPZxCv9ovJeY+fZad
   KSrHM7/W8HxJHX1jYAy2cgvUejHZWCgNXQEdQ+sE972Io85egKE3DypvM
   J7TXcNPwZ3ZaSX07vmkTXEmrjXtGwcyAbp4uwcHufaX6cXvDzxoouGJeG
   r50KGqqex4sAbkXnIhVHGmT6uOQupfO3+ApN3u9qGP61UnUZ24en2pAlh
   ymbqWa6Z8ztEviaFM+4LyDsw+VpJK0k/qBKfT/jjl1Ta5SqrQCX9lPHuP
   JY72XoHD/PD0mi+73q8MATs3enStwJ0XBeGqw8IBekz6URtlDzmuEYk8c
   g==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="213481929"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 00:12:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 00:12:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 00:12:31 -0700
Date:   Tue, 16 May 2023 08:12:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, <iommu@lists.linux.dev>,
        Conor Dooley <conor@kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Message-ID: <20230516-gristle-spill-e27c58770a47@wendy>
References: <20230330060105.29460-1-rdunlap@infradead.org>
 <2529dd93-2cb2-6ed8-20c0-c424e6613717@arm.com>
 <833203b0-aee5-eb23-afb4-ff71a3024258@infradead.org>
 <280c0994-f7cd-bb0e-8c68-62f72a4a38ca@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kEpcCnhkORFemaUM"
Content-Disposition: inline
In-Reply-To: <280c0994-f7cd-bb0e-8c68-62f72a4a38ca@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kEpcCnhkORFemaUM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 09:02:50AM +0200, Alexandre Ghiti wrote:
> Hi Randy,
>=20
>=20
> On 3/30/23 18:49, Randy Dunlap wrote:
> >=20
> > On 3/30/23 09:34, Robin Murphy wrote:
> > > On 2023-03-30 07:01, Randy Dunlap wrote:
> > > > On riscv64, linux-next-20233030 (and for several days earlier),
> > > > there is a kconfig warning:
> > > >=20
> > > > WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LP=
AE
> > > >  =A0=A0 Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || CO=
MPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> > > >  =A0=A0 Selected by [y]:
> > > >  =A0=A0 - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESA=
S [=3Dy] || COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> > > >=20
> > > > and build errors:
> > > >=20
> > > > riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L14=
0':
> > > > io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_=
io_pgtable_ops'
> > > > riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L16=
8':
> > > > io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_i=
o_pgtable_ops'
> > > > riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
> > > > ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable=
_ops'
> > > > riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
> > > > ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtab=
le_ops'
> > > >=20
> > > > Add RISCV as an allowed ARCH dependency to fix these problems.
> > > >=20
> > > > Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> > > BTW that doesn't look like the right fix target - this presumably dat=
es back as far as when ARCH_RENESAS was added to RISCV, such that it was po=
ssible to start selecting IPMMU_VMSA without COMPILE_TEST?
> > OK, I can go with that. Thanks for your help.
> >=20
>=20
> Any updates on this fix?

Superseeded by
https://lore.kernel.org/linux-iommu/20230330165817.21920-1-rdunlap@infradea=
d.org/

I guess that never went anywhere?


--kEpcCnhkORFemaUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGMsygAKCRB4tDGHoIJi
0vOKAQCLR9m9tYztuGYjhMQ0trXZPKE2Y8xVwNtfr5jJy14lRgD/WEmttGELpMve
zitK847mqPuq6YE2XnjnZvsdGcD6cAc=
=WJ81
-----END PGP SIGNATURE-----

--kEpcCnhkORFemaUM--
