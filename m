Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E8C74F46C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjGKQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGKQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DA11D;
        Tue, 11 Jul 2023 09:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7822961529;
        Tue, 11 Jul 2023 16:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC54C433C7;
        Tue, 11 Jul 2023 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689091651;
        bh=JzqdbMwppagfSDpscGlUsf8Nn0nudwa3m9LkCZQlS94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pz3WjobbzhkAcikJXcIu2XtQsP0O3vWHMtvTzDTfe2Jm1RxQ1aolD293DZtAp4QUZ
         WMqPk593QfaxFoopWPNkEieXAUNDyyVV5D+Wlyno5Q/EythJr/AEOgn9y9b7P1jde/
         sd6wDScb3V/Jek8G5ECnRf93oCf3yzuAQcNzheuOxYwF8N00IRN13Q6+OPw/cZe/GA
         VgwmYJJNFQ7C9BqBm1trK60XKD19eedO8tlSvbU3h5uUEQCGeoK7iWo3EOMAEaQdjI
         68ypAl4SZG2ss4PDK9bTXTIedpjxVxoSvg+LiqEf28QS0N8ABSp/m7ggn5B6UiSLPX
         oG32qi12DKS4Q==
Date:   Tue, 11 Jul 2023 17:07:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Subject: Re: [PATCH 12/18] soc: starfive: Move the power-domain driver to the
 genpd dir
Message-ID: <20230711-user-elves-9aebe921351e@spud>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-13-ulf.hansson@linaro.org>
 <20230707-vexingly-prologue-fea19dd3d962@spud>
 <CAPDyKFoy2HZLSqSpQ8jPgDLU10p1H0_WQkHXsL1LfXEcpJDcCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e10Q48OQXTWbo7Mh"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoy2HZLSqSpQ8jPgDLU10p1H0_WQkHXsL1LfXEcpJDcCA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e10Q48OQXTWbo7Mh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 03:57:49PM +0200, Ulf Hansson wrote:
> On Fri, 7 Jul 2023 at 17:51, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Jul 07, 2023 at 04:04:28PM +0200, Ulf Hansson wrote:
> > > Cc: Walker Chen <walker.chen@starfivetech.com>
> > > Cc: Conor Dooley <conor@kernel.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >

> > If you are not going to write a commit message with an explanation,
>=20
> I will, sorry for being lazy.
>=20
> > the least you could do is CC me on the cover letter.
>=20
> Yes, I will soon post a new version and add you to the cover letter and p=
atch 1.

Thanks. Obviously I was able to pull the message-id & look at lore etc,
but what goes for the goose, goes for the gander and all that.

> > > ---
> > >  MAINTAINERS                                                    | 2 +-
> > >  drivers/genpd/Makefile                                         | 1 +
> > >  drivers/genpd/starfive/Makefile                                | 2 ++
> > >  .../{soc/starfive/jh71xx_pmu.c =3D> genpd/starfive/jh71xx-pmu.c} | 0
> > >  drivers/soc/starfive/Makefile                                  | 3 -=
--
> >
> > Why not also move the Kconfig entry while you are at it?
>=20
> I just replied to Geert [1], who had similar questions. Hope that
> makes sense to you?

In general, it does explain why you did not do it.
I think that the Kconfig stuff should move too & the whole
soc/starfive directory should vanish, but that could be left for a
follow-up activity.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--e10Q48OQXTWbo7Mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK1+PwAKCRB4tDGHoIJi
0neiAQCpoVvhlBw/Sz3h6KFVmVfZbln4DunwB6BtYeJIJHlzhQEA21SiTMwAprMD
kaVKQjmT1tsbB2pBHzcS8UbKcDTIcAQ=
=uOmA
-----END PGP SIGNATURE-----

--e10Q48OQXTWbo7Mh--
