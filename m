Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CCE6E450D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDQKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:21:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48455FD8;
        Mon, 17 Apr 2023 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681726844; x=1713262844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j90NrPShotCaZx7oLA6qnGzplSr/mn/dLWX6fn/QM3M=;
  b=lChBamXAKavWJ+MWx6XbXCks88WpE7ziUDGKOYMuSF9EKBr54/uvgy8i
   fOdF/bTYy9OvAGMcfvu5eIt9yhqnCeWFGcyUH3Du5NoBF7o9f7aedpQId
   4sKJx08olPK+rJtYR66eDWWDfCBQSNhNntHJe0vPPhOrSuwKUNYSivkrw
   XALH48REktlLOrSzyvYAEx3bDWcj8m4nR/iLtOzTJre60VCLbfc/KP5HQ
   eoDEpAGbWzmZdMHSyRQuPo3+HnQox3WVLc6OvQuXG1+fvrQmR5cR4EGOD
   Yh2jZkU9VvZkTwybKnyRrylgLbg7ExziW0Q4A4hHkrTUKq07w8bWrzro/
   g==;
X-IronPort-AV: E=Sophos;i="5.99,203,1677567600"; 
   d="asc'?scan'208";a="206819426"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 03:18:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 03:18:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Apr 2023 03:18:51 -0700
Date:   Mon, 17 Apr 2023 11:18:35 +0100
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
Subject: Re: [PATCH v1 1/2] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be
 selected in a specified case
Message-ID: <20230417-bolster-vitality-89d279146497@wendy>
References: <20230417074115.30786-1-hal.feng@starfivetech.com>
 <20230417074115.30786-2-hal.feng@starfivetech.com>
 <20230417-buckwheat-wilt-92a4e85a5ca0@wendy>
 <83c5a35a-c646-cbc7-83f9-c02fcb24e069@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UNJQkeLLzUY54mLk"
Content-Disposition: inline
In-Reply-To: <83c5a35a-c646-cbc7-83f9-c02fcb24e069@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UNJQkeLLzUY54mLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 06:06:29PM +0800, Hal Feng wrote:
> On Mon, 17 Apr 2023 10:54:09 +0100, Conor Dooley wrote:
> > On Mon, Apr 17, 2023 at 03:41:14PM +0800, Hal Feng wrote:
> >> When (ARCH_STARFIVE [=3Dn] && COMPILE_TEST [=3Dy] && RESET_CONTROLLER =
[=3Dn]),
> >> RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
> >> and CLK_STARFIVE_JH7110_AON.
> >>=20
> >> Considering RESET_STARFIVE_JH7110 is not a necessary option for compil=
ation
> >> test, we should select it only if ARCH_STARFIVE=3Dy. Also, delete redu=
ndant
> >> selected options of CLK_STARFIVE_JH7110_AON because these options are
> >> already selected by the dependency.
> >>=20
> >> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock =
driver")
> >> Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on clo=
ck driver")
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> ---
> >>  drivers/clk/starfive/Kconfig | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>=20
> >> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconf=
ig
> >> index 71c1148ee5f6..3fad4adee841 100644
> >> --- a/drivers/clk/starfive/Kconfig
> >> +++ b/drivers/clk/starfive/Kconfig
> >> @@ -26,7 +26,7 @@ config CLK_STARFIVE_JH7110_SYS
> >>  	depends on ARCH_STARFIVE || COMPILE_TEST
> >>  	select AUXILIARY_BUS
> >>  	select CLK_STARFIVE_JH71X0
> >> -	select RESET_STARFIVE_JH7110
> >> +	select RESET_STARFIVE_JH7110 if ARCH_STARFIVE
> >=20
> > Hmm, I don't really follow the logic above.
> > Why not just make the if be `if RESET_CONTROLLER` rather than
> > ARCH_STARFIVE?
> > I'm probably missing some obvious reason why not.
>=20
> Note that RESET_CONTROLLER is selected by ARCH_STARFIVE. Thanks.

Aye, just the explicit dependency seems like it'd be less fragile and
more obvious in the future.

--UNJQkeLLzUY54mLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD0c+wAKCRB4tDGHoIJi
0t0qAP0bDI0dkJnvMY43FLoFsCdFD9aKvpBWdIVKMFuU7DdCRgD+LYUvWpnj9rcQ
r3DR0VCbP4gpvyqBUR/uXruV26OQjgA=
=HWYz
-----END PGP SIGNATURE-----

--UNJQkeLLzUY54mLk--
