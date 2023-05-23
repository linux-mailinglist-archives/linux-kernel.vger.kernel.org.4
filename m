Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1D70D465
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjEWG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjEWG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:57:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B04118;
        Mon, 22 May 2023 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684825023; x=1716361023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjxX5aifWvPwKx2G+wm0DbABvPy6iGFiIpFGJlbl0Q8=;
  b=jI5jIzMilpIoXQRdrTmG88PgPd15bN9Bvpyeirl/PIylHbYxzAP81Uhg
   ZXlpwo23mrnAM1OF/odJ8R1GHXWHXc81Bti2bL8LRmje+zg1wWnJUek0y
   0N7MvFucaNhH2I+YDtBKD6DRfdDUXqeQ1Nh5h51FvOuZrTEbZwzhnsmbQ
   dvKbko+zfoppP7yXgo7Th6gNPsxMpbYy+y5iuHcdmKYoHYHZAsW4P0bPQ
   1FNWZhW6ULU8/t+36kFV1cpGhI9U+xCoJ0XhPvkNCeyyfXz04UbWXk0vr
   gmPLA8TN8cmzUMk913LpkwkIpO15xz1+0O2+Wc5jMs4EnkdJO2yW0VTIj
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="asc'?scan'208";a="153439954"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 23:57:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 23:57:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 23:57:01 -0700
Date:   Tue, 23 May 2023 07:56:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] crypto: starfive - Depend on AMBA_PL08X instead of
 selecting it
Message-ID: <20230523-pelvis-unwritten-bedc9c75d899@wendy>
References: <20230522105257.562cb1ec@canb.auug.org.au>
 <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
 <20230523103637.20175fbc@canb.auug.org.au>
 <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwnFscTKPB7TisQY"
Content-Disposition: inline
In-Reply-To: <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mwnFscTKPB7TisQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:33:38AM +0800, Herbert Xu wrote:
> On Tue, May 23, 2023 at 10:36:37AM +1000, Stephen Rothwell wrote:
> >=20
> > That did not fix it :-(
>=20
> OK, this patch should fix it:
>=20
> ---8<---
> A platform option like AMBA should never be selected by a driver.
> Use a dependency instead.

Randy submitted a patch to change the driver to not conflict with
the arch symbols:
https://lore.kernel.org/all/20230523000606.9405-1-rdunlap@infradead.org/

The corresponding change here makes sense to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

@StarFive folks, you will need to go and submit a patch for
arch/riscv/Kconfig.socs that selects ARM_AMBA for your platform.

> Also remove the depenency on DMADEVICES because the driver builds
> just fine without it.  Instead add a dependency on HAS_DMA for dma
> mapping support.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>=20
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kc=
onfig
> index 908c162ba79a..59002abcc0ad 100644
> --- a/drivers/crypto/starfive/Kconfig
> +++ b/drivers/crypto/starfive/Kconfig
> @@ -4,14 +4,13 @@
> =20
>  config CRYPTO_DEV_JH7110
>  	tristate "StarFive JH7110 cryptographic engine driver"
> -	depends on (SOC_STARFIVE || COMPILE_TEST) && DMADEVICES
> +	depends on SOC_STARFIVE || AMBA_PL08X || COMPILE_TEST

While we are changing everything, would you mind doing s/SOC/ARCH/ here?
I didn't notice that while the series was being reviewed. Otherwise,
I'll send you a patch for it.

Cheers,
Conor.

--mwnFscTKPB7TisQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGxjpwAKCRB4tDGHoIJi
0jkjAQDhW8PL2V0KE7gy+aM8zfT9d7+sVE4zWp5d14k/Y9TMuQEAjrCesmDDqk1M
S+L8TVRjan4Zjd6DWos/qA629ZRVkwc=
=A/b4
-----END PGP SIGNATURE-----

--mwnFscTKPB7TisQY--
