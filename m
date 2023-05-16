Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131A704614
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjEPHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEPHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:15:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5C4215
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684221318; x=1715757318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lPE3+Tms4P+v+2cQbjBpM5WKXZt6mkEp7SjRlCCo7xg=;
  b=BLhvoyvs/HOlIr88MdOkJstX5gUJytEAypDZMgLZhxd6dCcm96/6Sx3h
   jSd60oLy/ILDd/kZqLJBKPidy4dx4O9cE+H+P/T0ABLV3WoppaDDTOeEW
   UytInNgVHSvWPwqz9dyh9hV/03timN/XFzIEWSUeo9k64rTESWiLH74Dl
   NoXmnuK48nF9cCUIFWwlv0tBe/sVeNXWDo4fpDW7EWpYtn0jBJWhNQGqb
   J9kbjVAPXkWWgBbXMXTJZdXJGcshXjz94S+vTYdTyLsR2Kir+QHPbrW12
   EUqCJTDGUu7yah3fb5YdrWpRBLUHjFJsicLr+gLCIsZv4gc5czZpFapiU
   w==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="211461672"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 00:15:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 00:15:15 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 00:15:14 -0700
Date:   Tue, 16 May 2023 08:14:53 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        Conor Dooley <conor@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] iommu: make IPMMU_VMSA dependencies more strict
Message-ID: <20230516-viable-resent-1fbeed2cfb90@wendy>
References: <20230330165817.21920-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q/A5eQxJmg5Xxvfz"
Content-Disposition: inline
In-Reply-To: <20230330165817.21920-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--q/A5eQxJmg5Xxvfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 09:58:17AM -0700, Randy Dunlap wrote:
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
> Add ARM || ARM64 || COMPILE_TEST dependencies to IPMMU_VMSA to prevent
> these issues, i.e., so that ARCH_RENESAS on RISC-V is not allowed.
>=20
> This makes the ARCH dependencies become:
> 	depends on (ARCH_RENESAS && (ARM || ARM64)) || COMPILE_TEST
> but that can be a bit hard to read.
>=20
> Fixes: 8292493c22c8 ("riscv: Kconfig.socs: Add ARCH_RENESAS kconfig optio=
n")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This is still presenting as a problem for randconfig builds:
https://lore.kernel.org/all/54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.=
org/

Could it get picked up please?

Thanks,
Conor.

> ---
>  drivers/iommu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -287,6 +287,7 @@ config EXYNOS_IOMMU_DEBUG
>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on ARM || ARM64 || COMPILE_TEST
>  	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE

--q/A5eQxJmg5Xxvfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGMtbQAKCRB4tDGHoIJi
0kMBAPwJGwl7WtTrpfXREf+3HDlL3dwdmjgApdWJepBttrCpGQEAgiaoWm139YqG
vRlkBlnZuHOBgoVpyTEOiTS9TdB38Qs=
=wO76
-----END PGP SIGNATURE-----

--q/A5eQxJmg5Xxvfz--
