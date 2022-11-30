Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4E63DA88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiK3QZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiK3QZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:25:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F04E40D;
        Wed, 30 Nov 2022 08:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7819CE198B;
        Wed, 30 Nov 2022 16:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D79C433D6;
        Wed, 30 Nov 2022 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669825535;
        bh=gYhV1pkLE7/VIfbsCrMpLxmO+6AVZfk0sX0HWTswr9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0wlVpFPVP0ol2aYDuQx4iWJYMPUnIKVkbZCcBNN8Ei1KO3mY5lNAEya9x/IJvBrI
         IARieiF9iuNj+Svo9Ye8cUMe3U8OHhsWy+pYB7koqszORtkyWJfl/h7crGMulduePP
         6GnqZVs5UZcPwrDIPvvq51sXzXkB5ujA0r+tufMm6XuGh6SAGiUww3qBCihZBVHp1U
         lRMfS0/LgyW/MLKI/Ltez4pM9gF9TIgfndwFf1STaNCgJK+K96JJt9tIxCSBdj9aQk
         3oIOFma3ml6dFybTmhjvfylkvdP/OOio8YwpVRpgVH2FPTU8YxnSLGTQAm/VTHjxrK
         1Ncvd4Vyw8CJg==
Date:   Wed, 30 Nov 2022 16:25:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Message-ID: <Y4eD+rrvL/Wdh9e5@sirena.org.uk>
References: <20221130143948.426640-1-alexander.sverdlin@siemens.com>
 <Y4dvdzVQZDEt09+p@sirena.org.uk>
 <ae71f8d6acac42f7e85fd111259e578305e938ed.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l3vPnKV0AbSKgmyt"
Content-Disposition: inline
In-Reply-To: <ae71f8d6acac42f7e85fd111259e578305e938ed.camel@siemens.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l3vPnKV0AbSKgmyt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 03:43:27PM +0000, Sverdlin, Alexander wrote:
> On Wed, 2022-11-30 at 14:57 +0000, Mark Brown wrote:

> > What about SPI_IOC_RD_MODE_32?=A0 On the write path the code is
> > shared...

> you are right, thanks for this hint!
> I'll re-send if there are no objections to this approach in general.

Should be fine.

--l3vPnKV0AbSKgmyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOHg/kACgkQJNaLcl1U
h9Aq2wf/QCWJZdoTNM9hzI08RKkd1miDHyWm4pNK9rXWBaAeLoSTAh5R4U7UDrIX
4Sr6ZZOLQ0IBFKrU/GjXLKwuVDahyW9c3C83PQn1X2p9Wmo04kmMlFiJ/0QdA3ze
mDDPscWEu42prsyJb3eOdEcAiNZaHoVoovuLoIJCBMhv9BvjTDwdXq97pDtp7eha
lhP/q2+nh6EA/j7z/WCeyjWU0SUIUj1C8BR6qgxcWOMpuzKhzYZD/VfV+2oKyTTo
/lVdf+ixeWlJcN625yRxbtSUiUX+ltWEN68cUJTRGL9ulKblOBc3eT0XvhoMgoGF
kQ88HasF+TrEWogPEai3k3Ra5TM2sA==
=C5Ue
-----END PGP SIGNATURE-----

--l3vPnKV0AbSKgmyt--
