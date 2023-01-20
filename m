Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC2674ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjATIAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjATH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:59:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB25FE8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674201597; x=1705737597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jpyof8guJ12KkRZFQStUtNOohsq/r/JPUTfiWJHH+7s=;
  b=P/MpaCbCTNNX4ah4WGah2G1A1tHPSf9dKw1pEIyrxmNPyYtb8wdJgLYv
   C57P/QyG28CB4S669rBe2Mlo7xQEiB5UbI8HEeU7l+8/3oM947Ogow18f
   ej59V2kK+FhP+GPvmNqrtlDuUs8gmGZ7aRec06wf6dNmcCU9Thg+S+8U0
   WKRnKUuBZ4J9+aGkqHc7KS+TykWy9bEAz1s2JQcQhp/JqX1vVIfPZWr05
   DIChw/nnSupaJ58LM3fah4OKxdlbyd3eRZzAC2TrVjTYtb6xq9t+LFhVx
   3Yuh2WafWmMc7KQ1lDIOUVqid2y60ErXt+a2L8LovS2zh2Ivx1qfH94u2
   g==;
X-IronPort-AV: E=Sophos;i="5.97,231,1669100400"; 
   d="asc'?scan'208";a="197425432"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 00:59:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 00:59:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 00:59:55 -0700
Date:   Fri, 20 Jan 2023 07:59:31 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Message-ID: <Y8pJ4y7FyBDQPqIT@wendy>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbTIlntymQsP/HCi"
Content-Disposition: inline
In-Reply-To: <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kbTIlntymQsP/HCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Since you'll have to re-submit, making sure that allowing !MMU on rv32
doesn't break the build due to canaan k210 drivers being enabled despite
relying on 64-bit divisions, I've got some nits for you.

On Thu, Jan 19, 2023 at 12:26:41AM -0500, Jesse Taube wrote:
> From: Yimin Gu <ustcymgu@gmail.com>
>=20
> Some RISC-V 32bit ores do not have an MMU, and the kernel should be

 s/ores/cores

> able to build for them. This patch enables the RV32 to be built with
> no MMU support.
>=20
> Signed-off-by: Yimin Gu <ustcymgu@gmail.com>
> CC: Jesse Taube <Mr.Bossman075@gmail.com>
> Tested-By: Waldemar Brodkorb <wbx@openadk.org>

And the automation complains that this tag is not "Tested-by:"

Thanks,
Conor.

> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  arch/riscv/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 59d18881f35b..49759dbe6a8f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,8 +163,8 @@ config MMU
> =20
>  config PAGE_OFFSET
>  	hex
> -	default 0xC0000000 if 32BIT
> -	default 0x80000000 if 64BIT && !MMU
> +	default 0xC0000000 if 32BIT && MMU
> +	default 0x80000000 if !MMU
>  	default 0xff60000000000000 if 64BIT
> =20
>  config KASAN_SHADOW_OFFSET
> @@ -262,7 +262,6 @@ config ARCH_RV32I
>  	select GENERIC_LIB_ASHRDI3
>  	select GENERIC_LIB_LSHRDI3
>  	select GENERIC_LIB_UCMPDI2
> -	select MMU
> =20
>  config ARCH_RV64I
>  	bool "RV64I"
> --=20
> 2.39.0
>=20
>=20

--kbTIlntymQsP/HCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8pJtAAKCRB4tDGHoIJi
0v8hAQCg6NogRf0JH3QdHCaCxBlrL7fsKxZip4ENRHkEh4G2tAD+Pcys/xq+pyND
ccOwmR8ujVh1aJspaKZJXPguL85k0Ak=
=BVpA
-----END PGP SIGNATURE-----

--kbTIlntymQsP/HCi--
