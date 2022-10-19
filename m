Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13165604B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiJSPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJSPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6582194;
        Wed, 19 Oct 2022 08:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B932561919;
        Wed, 19 Oct 2022 15:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5E0C433D7;
        Wed, 19 Oct 2022 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193353;
        bh=ZeCBqm38mn3n+d5SZUUxCTzmPVj5r0qAbJAA+fyNmvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJs/DS/UliRAFtIIesYSIidcO0JSTdP2v5kEg5XKtvlaWaxxmE5ty2UqujF/IRopU
         22LX1kc+cmCh9hQRfcxJJgQhlbWHkBxomrno9+R1aO/wHZ4lGfW9tOThGZgrRrFd7F
         swfK9Gb1aVMj5TKUp7tyzhm5FShgRyKPupU9mySwJI0iKi7rpYNSXdbawt45fHxJgO
         tX56Lvdsaj3Kadg6Jl30PdUcVxb+kGVG/4LtojvPBu6Fa47pRmAV5dzd2vBWCFVpSm
         r2fel0raTpscr19cKfV+aqtnHb8vhc3MHJx46M5wjMGp7VmIaAWwzKMUeqqh50BhnX
         jqe/04/BQJZlw==
Date:   Wed, 19 Oct 2022 16:29:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Fabrice Crohas <fcrohas@gmail.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 16/17] spi: remove omap 100K driver
Message-ID: <Y1AXwyQeKIVBmTcS@sirena.org.uk>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-16-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JtilZPBR8/u5i5oi"
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-16-arnd@kernel.org>
X-Cookie: There's no future in time travel.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JtilZPBR8/u5i5oi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 05:03:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The OMAP7xx/OMAP8xx support was removed since all of its boards
> have no remaining users. Remove its spi driver as well.

Acked-by: Mark Brown <broonie@kernel.org>

--JtilZPBR8/u5i5oi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNQF8IACgkQJNaLcl1U
h9CnqAf/Wk45nnZLCUyp2wYm5nfdmcISGZ/P1CRzixx24OAF/01z5hj20OSDZ/l+
wqKlsSnzd79CsieyyMtDcPthRK0KLfVItOZ30Jc+zXe3riwQNVAApeXr2Lh3WTZ5
GTdU6RP/i6M96fPTB75Dm+55NVL2YJHUuoKE4lFBIEXr4+bU0wsrCr3p+EBykNCn
hHWwAJ/tW4aDwE+kQ6UcHd6YdASXQZd6X9qfQfP/jXg2YM4tyoSxo+GMA12YYLI4
e9IcPV5WCwW34rFfp0wfgNJeSibZq9Td8IxV+TiZ6efDM7550AV4j50r2jW/39ue
rfaXrlQSW40SSGIHLD7SvOwHjvL9cQ==
=2vlK
-----END PGP SIGNATURE-----

--JtilZPBR8/u5i5oi--
