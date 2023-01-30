Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9288E6806C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjA3Hyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjA3Hys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:54:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E0279BF;
        Sun, 29 Jan 2023 23:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675065284; x=1706601284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WesUET345ugTfJZy/nJ9gDULy86DO/4dGSyE+q4VP1E=;
  b=sXkDFINytR71Ha7kdmnMUwgZ1PTRX0DK+wifR2DDGCtrok1nybAD0s11
   lxyN25LUi5xkPJZEdZ9RNIHJKzlPJmqfrazvBt9HJU4gYgzYAnn8OFnrd
   EFBJJrUYilZTcWChgt3i2pN1UTqlbjKdAXJvKLztn+S4j6eDDMt9y3q2d
   ZFPjUTKVkA/lHvDodzZ3QK4xskFYJSVnl+MH3/63wapIxU+yU8YGpQaQf
   MuXEvsDbsNxjEUtICowQGPJMa5H51qKAYbCAqlhXahy3XQ2YWbPC9kPf0
   ygAd9UK2QWsOx/LgrlM+lxsqfBd+Rl7DTGcZppexle0r0Lc1P4MmEWfhP
   w==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="asc'?scan'208";a="134573322"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 00:54:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 00:54:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 30 Jan 2023 00:54:41 -0700
Date:   Mon, 30 Jan 2023 07:54:17 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Jenny Zhang <jenny.zhang@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>
Subject: Re: linux-next: manual merge of the crypto tree with the riscv-soc
 tree
Message-ID: <Y9d3qWZYlULl8Vxq@wendy>
References: <20230130114128.692c7961@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NvR2dxayvgF+UicQ"
Content-Disposition: inline
In-Reply-To: <20230130114128.692c7961@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NvR2dxayvgF+UicQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:41:28AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the crypto tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   08b9a94e8654 ("soc: starfive: Add StarFive JH71XX pmu driver")
>=20
> from the riscv-soc tree and commit:
>=20
>   c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
>=20
> from the crypto tree.

> Note, please keep MAINTAINERS file entries in alphabetical order.

Huh, good point. I didn't notice the PMU entry was added out of order.

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen

--NvR2dxayvgF+UicQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9d3iwAKCRB4tDGHoIJi
0rKXAP9XsN9TwPiTn6NtRxbzzgXVP4IccdRaJxPHAriEpcyAFgEAvZf4E5L5iVRz
wltg1n/FIKDvPFgrEmDggSNxtuaCug8=
=J/5E
-----END PGP SIGNATURE-----

--NvR2dxayvgF+UicQ--
