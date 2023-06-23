Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC873BB07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjFWPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjFWPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A61BD0;
        Fri, 23 Jun 2023 08:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E810261A87;
        Fri, 23 Jun 2023 15:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D87EC433C8;
        Fri, 23 Jun 2023 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687532790;
        bh=e+a+4BATBYrRzsOkBrqxRovCKuWSKjmHQcwb1cDujGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ruu+xWOFPHKWhkiXYBamQH3a1O7WYhjwV0KSCk0V9vIkMjr/5ukCWbPiElNnyh34i
         HafIA1FnRzh7lt4IOpMWHci84/o7STBWc/TyXISN7OTqhC89TkiB8nEi9KSE9Nr8Zj
         yXGyV8fVnUFORFoOXUIEL6hplgiKDd/PjY1nuK3cK/DCR5hrrmSFBsxVIMin648H5V
         9yAnjsuKwaFxzGRDQqGoKw4TAt4rWjDqt/CGBd7XQpnm6iBleGdgQMRuEZFN1QIrCo
         5qVZzEsGT+mpccPQ3le+EX0wMqVCTLozS8Mwf8jh22n4srU2eYdnkHICZNxL8Qi5uM
         S194IuXoBB7WA==
Date:   Fri, 23 Jun 2023 16:06:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v7 00/10] Add Renesas PMIC RAA215300 and built-in RTC
 support
Message-ID: <ZJW08YIZROKg2a2c@finisterre.sirena.org.uk>
References: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PrFTxRZ3tAieVKnp"
Content-Disposition: inline
In-Reply-To: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PrFTxRZ3tAieVKnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2023 at 03:09:38PM +0100, Biju Das wrote:

> v6->v7:
>  * Updated the test logs by running rtc_test.
>  * Dropped patch#1 and instead using i2c_new_client_device() to instantiate
>    RTC driver.
>  * Replaced i2c_new_ancillary_device->i2c_new_client_device for RTC client
>    instantiation.

This means that there's now no longer any interdependencies for the
regulator patches AIUI?

--PrFTxRZ3tAieVKnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSVtOoACgkQJNaLcl1U
h9CNkQf+L8QAWTX9jfhaftVUlDzH4M99K07AI8GwkTBA5Wye4g8umeTApRkBRhpr
xH7waepC2/Qe82sv0O7WGDADsDx7W/5s/6sJUejxcRkye310syWd88oEvhmIcgZV
qc6TY7zhG7hqVSe0J4sbZtMZfb4yRBbzC3C2BXDKJGIUXcSGDTj+8XX1pMyzn/OX
FYftDVoPojs+qVxf3HYaWon5A0Tp5slUFsbO357UsoTCEtjIspM36KF73OrUPfFD
u3VPSPASda8Rw1aUiABPTjwmNFCs8sSfxuO7g+5aWE5DNY4LUtdh+y5JIX6mXKCe
lW0h24Ncuvp5fjbvR6vV8B23iECAHQ==
=Q2eB
-----END PGP SIGNATURE-----

--PrFTxRZ3tAieVKnp--
