Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC026F0402
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbjD0KPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjD0KPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:15:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF148A0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682590538; x=1714126538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8b6fS4/PQOVDls/TVoFmw/XTHTAH6akEATEOCqffBgY=;
  b=A00mtHlULcIn6vLXIH3qN6UCcmvnQUozGwzMWerVl4dsyehrSX5xOaRi
   PyM7wqOIcgFekK+RYL2ilfg0OB9pnjMlLO91xXIzzkaeB4ZJAqjge/GvC
   OByvrYInY3eoM+uxrPdubM5jdfy7rFzMsejntPwDlnyvfDCHELyg6Hez5
   qq0payxJHg2FSUyjMczny9GFTfji1mDWwO9y08ddEGpUNCZwH2AyiIQP0
   hVv2uLOHKo3A6klTV7jHWldBYTRxnbCLhaPkg6c5b3D3Z9zdc7q82yFZB
   IJobgg2kT6jPnngDWUZ2b+Q/HVfO95DtvYkB/xwfSOLK48qhgpo+VRoRD
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="asc'?scan'208";a="149214604"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 03:15:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 03:15:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 03:15:34 -0700
Date:   Thu, 27 Apr 2023 11:15:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alexghiti@rivosinc.com>,
        <heiko@sntech.de>, <guoren@kernel.org>,
        <anshuman.khandual@arm.com>, <mick@ics.forth.gr>,
        <samuel@sholland.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes V2] riscv: mm: remove redundant parameter of
 create_fdt_early_page_table
Message-ID: <20230427-prevail-upload-033ca439a54c@wendy>
References: <20230426100009.685435-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zFe0gN+LmyYDnho"
Content-Disposition: inline
In-Reply-To: <20230426100009.685435-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2zFe0gN+LmyYDnho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 06:00:09PM +0800, Song Shuai wrote:
> create_fdt_early_page_table() explicitly uses early_pg_dir for
> 32-bit fdt mapping and the pgdir parameter is redundant here.
> So remove it and its caller.
>=20
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>

Whoops, I missed the v2, so copy-pasting:

"and its caller" sounds like you're removing the caller itself when
that's not what you're doing!
I am certainly not suggesting that you resubmit because of that though.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Automation failed to apply this which is a bit weird. What was the
base-commit?

Cheers,
Conor.

> ---
> Changes in V1:
> https://lore.kernel.org/linux-riscv/83540cb1-0c9b-f572-849a-cb100437d049@=
ghiti.fr/T/#t
> - fix the typo
> ---
>  arch/riscv/mm/init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0f14f4a8d179..6ebb75a9a6b9 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -843,8 +843,7 @@ static void __init create_kernel_page_table(pgd_t *pg=
dir, bool early)
>   * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PG=
DIR
>   * entry.
>   */
> -static void __init create_fdt_early_page_table(pgd_t *pgdir,
> -					       uintptr_t fix_fdt_va,
> +static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
>  					       uintptr_t dtb_pa)
>  {
>  	uintptr_t pa =3D dtb_pa & ~(PMD_SIZE - 1);
> @@ -1034,8 +1033,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	create_kernel_page_table(early_pg_dir, true);
> =20
>  	/* Setup early mapping for FDT early scan */
> -	create_fdt_early_page_table(early_pg_dir,
> -				    __fix_to_virt(FIX_FDT), dtb_pa);
> +	create_fdt_early_page_table(__fix_to_virt(FIX_FDT), dtb_pa);
> =20
>  	/*
>  	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
> --=20
> 2.20.1
>=20

--2zFe0gN+LmyYDnho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEpLNAAKCRB4tDGHoIJi
0pEgAQD3m31cs3VtahRPXPTCH4i1LIzufQcpRdG6aAOc1Juk7wD5AR62nuAwA3MQ
MSz1apHcc5OiNw5Q8BSkobIIDdksPQs=
=PAQy
-----END PGP SIGNATURE-----

--2zFe0gN+LmyYDnho--
