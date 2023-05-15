Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD02702AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjEOKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjEOKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF111990;
        Mon, 15 May 2023 03:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DCE615C4;
        Mon, 15 May 2023 10:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB75C4339B;
        Mon, 15 May 2023 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684147868;
        bh=io4J5rFtWRubjfwy7aiwD5CIoNUnGdBdd48t4O4XGbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPhi5hYEqrh2Bq2YZS6bCRTjHMGCiqPxcEGfOH/RW32uvF2vxqB/EWwBq7cBibMTM
         1C3BzSbQJH9K2Ovo9G14Nk4ytYtz0/V+2BYs5ahZHB4fldSqWYXk3jcxiGXwAZ2zgD
         sDqlgOzO7s2wvMiH2vOegNgHeYkg2V/dgJaxOWe9b+OPYBF8JDUNto8AwztpSgqdmJ
         JvkBWag0E+qGBTVl+l2/XACqvOfPGBp55tGqdaGPw/QV++kA+hNbBCCrh1uTevdBG+
         7IZmKxGE7EU2H8jQ78uUYiz0FSPGDEl8l/NdyM3aTelGqsrQ7Xz57awJGIJOkgMoGn
         EM5Xec3sGxmmA==
Date:   Mon, 15 May 2023 19:51:05 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] ASoC: starfive: Add JH7110 TDM driver
Message-ID: <ZGIOmWyxPGOuWHx+@finisterre.sirena.org.uk>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-3-walker.chen@starfivetech.com>
 <21bc5b06-3d3e-5a30-a90d-ea9f7abc6575@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nLJs/sEpOhNQJzse"
Content-Disposition: inline
In-Reply-To: <21bc5b06-3d3e-5a30-a90d-ea9f7abc6575@starfivetech.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nLJs/sEpOhNQJzse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 04:29:07PM +0800, Walker Chen wrote:

> I have submitted new version of patch for TDM driver. Could you please he=
lp to review and give your comments?=20

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--nLJs/sEpOhNQJzse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRiDpgACgkQJNaLcl1U
h9CHJgf8DPHBxTaAmn9FNyXgqSV4aT0FqSJQ2RK6Jgls0b5SpIQuIRWFyk+OHUiw
PlCg9J1Ohg+YDGsgvrzwqbvU0VcUmxl1IJjEcT4o2di/bm70vkqv5L/Kfm1Vfu35
SBMzYSScyEW2tk/7A1VJK4ngJssreMyJgu0O1rePTl+fkwxJaFiEnMQCVvcltvfA
H5lQp1qhqS2zz2jpBbjQJFu6vlvvDIscznZ4ItCfHPGaazC3rO9qbpLSz9jdk1aX
36mhrJEWN2Q0YEZatiFIb5B2ItoUCW3gj+QLcfaf8dN6gwGDPk+zF2hFbyE0fweh
k/dF9R3SXQCMhuxtL9ipJ9rVNjD5xQ==
=WDUc
-----END PGP SIGNATURE-----

--nLJs/sEpOhNQJzse--
