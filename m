Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30E46CFB7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjC3GZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC3GZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:25:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6772720
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680157539; x=1711693539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5EGj2XhAyY9wzau/N0SV9k/j+g1O3v8mLGQWAMN9hys=;
  b=JOY/YBBLDeiImst1BfnKDSQ8EZLOh3DPs/ad14L1HXgyye0flD+5wVdo
   xeD9xOZZZsszleDYKL00uT+MKTQmYOtDHRZTipyaHWQVF734VVyhIhmVh
   a+Hbam+xmErVidLOSrFUmDJNHGl70daPcHFcxKiJzBNuHOJMWAechVGr9
   U5SZDjnecfjvK7viVkfMHZIxWC2ZHE9TWJn+vYtTf359KBbQoaLqX6hPy
   88IHZah3qA4sUq+W+eqT7gC7wMKyxHqXQzGqXbQ3AIJ18qtqmsdvNZ/bq
   kdoIfANJwCmUOS6mFwMy7TQ1QfRP+9TZ6dQ9vEZ/LO66VdLfsrOGXjy5L
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="asc'?scan'208";a="218638271"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 23:25:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 23:25:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Mar 2023 23:25:37 -0700
Date:   Thu, 30 Mar 2023 07:25:23 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        Conor Dooley <conor@kernel.org>,
        <linux-riscv@lists.infradead.org>, <geert+renesas@glider.be>
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Message-ID: <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
References: <20230330060105.29460-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="voV2wf9Drw69lJ6G"
Content-Disposition: inline
In-Reply-To: <20230330060105.29460-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--voV2wf9Drw69lJ6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Randy,

On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
> On riscv64, linux-next-20233030 (and for several days earlier),
> there is a kconfig warning:
>=20
> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>   Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST [=
=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
>   Selected by [y]:
>   - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] || =
COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
>=20
> and build errors:
>=20
> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgt=
able_ops'
> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgta=
ble_ops'
> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
>=20
> Add RISCV as an allowed ARCH dependency to fix these problems.
>=20
> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Cc: Conor Dooley <conor@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> ---
>  drivers/iommu/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"

I'm probably missing something here, but why would we want to enable
"ARMv7/v8 Long Descriptor Format" on RISC-V?
Would it not be better to make the Renesas depend on, rather than
select the option? It does seem highly arch specific, and I feel like
Geert previously mentioned that the RZ/Five (their RISC-V offering)
didn't use it.

Cheers,
Conor.

>  	select IOMMU_IO_PGTABLE
> -	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on ARM || ARM64 || RISCV || COMPILE_TEST
>  	depends on !GENERIC_ATOMIC64	# for cmpxchg64()
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.
>=20

--voV2wf9Drw69lJ6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCUrRAAKCRB4tDGHoIJi
0mUOAQC/6NyhN5R0KrNSLvgjSttTTgoOT7Q7tk3qW1ws7ymJKAD/RCBEsz++6L3M
0m6tx3tTnLt6jB6secRd7TkULa4UGwo=
=UDBy
-----END PGP SIGNATURE-----

--voV2wf9Drw69lJ6G--
