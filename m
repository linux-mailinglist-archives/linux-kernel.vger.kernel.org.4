Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8C6EE18C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjDYMC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjDYMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:02:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E3D32C;
        Tue, 25 Apr 2023 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682424143; x=1713960143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ktZDAmJABhXIc6D5OVFisqlZkbF33qJIsMcwJhPUgkw=;
  b=Bn6pkPidVvH4WT3yCWj6jWi7dvOh3Rus4CqZ+ghE0BUHV5AbKFfTXYro
   jwGA24KpLVUmZpVOvNqFimxpACzS3F5GHf4GUKmCgn2SBlBeOx0vnD3fR
   LPsyZanz2oL611KT4FuNroWjwajzsakfMGLVQj4BC8tdymjYDhHIS/BOh
   uQUDufSy8wGiwUk6sn5dFlmQ3AMWr2/diNNP1diGVVgz/vgE723fDBpTj
   qQctcdEu7lC5SmFbll0Ytft2TGMZ7uAsXnNXxQapzdO70fDntmmjaKVfm
   Z2asKAypo0mWJZNPTTCjQ6UzSE73ChAyJYIB2hA4KySWqWBOfQnr7EvwW
   A==;
X-IronPort-AV: E=Sophos;i="5.99,225,1677567600"; 
   d="asc'?scan'208";a="210584387"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2023 05:02:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Apr 2023 05:02:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Apr 2023 05:02:20 -0700
Date:   Tue, 25 Apr 2023 13:02:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-clk@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@kvack.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be
 selected in a specified case
Message-ID: <20230425-filtrate-nearby-f62515de1ec1@wendy>
References: <20230418123756.62495-1-hal.feng@starfivetech.com>
 <20230418123756.62495-2-hal.feng@starfivetech.com>
 <aab34ed5-5b83-7e90-0bf9-a24fdf4c55a5@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GHeW0EClyRQDEg0y"
Content-Disposition: inline
In-Reply-To: <aab34ed5-5b83-7e90-0bf9-a24fdf4c55a5@starfivetech.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GHeW0EClyRQDEg0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 07:53:04PM +0800, Hal Feng wrote:
> On Tue, 18 Apr 2023 20:37:56 +0800, Hal Feng wrote:
> > When (ARCH_STARFIVE [=3Dn] && COMPILE_TEST [=3Dy] && RESET_CONTROLLER [=
=3Dn]),
> > RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
> > and CLK_STARFIVE_JH7110_AON.
> >=20
> > Add a condition `if RESET_CONTROLLER` to fix it. Also, delete redundant
> > selected options of CLK_STARFIVE_JH7110_AON because these options are
> > already selected by the dependency.
> >=20
> > Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock d=
river")
> > Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on cloc=
k driver")
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>=20
> Hi, Stephen,
>=20
> Could this patch be merged into v6.4? Thanks.

Whoops, I thought I had replied to this a week ago. In case it helps,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Best regards,
> Hal
>=20
> > ---
> >  drivers/clk/starfive/Kconfig | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> > index 71c1148ee5f6..5d2333106f13 100644
> > --- a/drivers/clk/starfive/Kconfig
> > +++ b/drivers/clk/starfive/Kconfig
> > @@ -26,7 +26,7 @@ config CLK_STARFIVE_JH7110_SYS
> >  	depends on ARCH_STARFIVE || COMPILE_TEST
> >  	select AUXILIARY_BUS
> >  	select CLK_STARFIVE_JH71X0
> > -	select RESET_STARFIVE_JH7110
> > +	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
> >  	default ARCH_STARFIVE
> >  	help
> >  	  Say yes here to support the system clock controller on the
> > @@ -35,9 +35,6 @@ config CLK_STARFIVE_JH7110_SYS
> >  config CLK_STARFIVE_JH7110_AON
> >  	tristate "StarFive JH7110 always-on clock support"
> >  	depends on CLK_STARFIVE_JH7110_SYS
> > -	select AUXILIARY_BUS
> > -	select CLK_STARFIVE_JH71X0
> > -	select RESET_STARFIVE_JH7110
> >  	default m if ARCH_STARFIVE
> >  	help
> >  	  Say yes here to support the always-on clock controller on the
>=20

--GHeW0EClyRQDEg0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEfBOgAKCRB4tDGHoIJi
0rbrAP0V0yJ1YNh+S+KxDVsTxngYTKlRNjGmYP5q5MQo37uTyAEA24mDl+HcIrF5
XyZakrHAwWpNtM6Z4Ux111f6UVJsRwQ=
=wdU7
-----END PGP SIGNATURE-----

--GHeW0EClyRQDEg0y--
