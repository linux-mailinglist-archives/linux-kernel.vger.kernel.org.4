Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCC674C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjATFYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjATFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265360C86;
        Thu, 19 Jan 2023 21:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6884B823D6;
        Thu, 19 Jan 2023 13:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB92BC433F2;
        Thu, 19 Jan 2023 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674136633;
        bh=3P1Nc86yRs6xRt0uuD8SSAASBWVJ0TJDhG0FA7Feguc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THgm7mSVdJKL0kAA+WIgCqGJbjB6wJt8FgOWbrAT1l2e1UGgX6T+NOch1V0VlI2Mw
         F2eVMjUaFrMvKzf9tdgoqhhLh5c/jY/tg2mKGe5KQ51wE+6Q7vE1Se6iNwhYorEZIL
         FeFTwU/U3Y52k1AJleh4dvTY0/SxmWOd6fIhcggZY9Xr7rdlY02YAA67zwUY5QK+6r
         zQails68ACDxiAru/1wMhLmlgK4PXcjAwjys1D+4iDzPvKweRA1Ka/NpH+7OkumlfW
         Y8ViudQncoii4+/NrdvBO1YH2lf9h6qnJpbEPbdAUDxdRZxO9Anlppo69uo0o8QBPB
         8EWyimyRPg/qQ==
Date:   Thu, 19 Jan 2023 13:57:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 15/15] spi: pensando-sr: Add AMD Pensando SoC System
 Resource
Message-ID: <Y8lMNUH/lJuJPbLp@sirena.org.uk>
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-16-blarson@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8D6WBjU4dhTr3Lss"
Content-Disposition: inline
In-Reply-To: <20230119035136.21603-16-blarson@amd.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8D6WBjU4dhTr3Lss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2023 at 07:51:36PM -0800, Brad Larson wrote:

> Add support for the AMD Pensando SoC System Resource chip using
> the SPI interface.  The device functions are accessed using
> four chip-selects and the device can be a CPLD or FPGA depending
> on functionality.

> ---
>  drivers/spi/Kconfig           |  14 ++
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-pensando-sr.c | 454 ++++++++++++++++++++++++++++++++++
>  3 files changed, 469 insertions(+)

This isn't a SPI controller driver so doesn't belong here,
drivers/soc might be a better fit based on the summary above?

--8D6WBjU4dhTr3Lss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJTDAACgkQJNaLcl1U
h9AX9gf9GML5TThEYc7iRhGulDaUGtLkpUtyjl6vvp1rs5FAt6yU8pZ5smmtQK9G
FzGZsvNDSPbQ952jyy7EBQQ7gswjo+kF4Eg+6UpE8WJTY95WPjkji0E/DPOxhruK
2ByAWFyW8bx7r/Sqng7jJRN6/rc4F9+rppguTNKJGF5xdwArMulKAPwNW9qzUit4
BmaUhuKxdVwLXCW6d9sAcOV7GDFW8iMTHXXE2uZcOijYpOz5jaOnSQu/esQZz/8D
Sc7Xa9XLvJTWif+OxUB7qzWlyUTy5ul//1dJja5VYG/IUTWvfIH2LsgGAzEhv6zF
8/ciby0aIavZsRidSNFBl4kexezCHQ==
=/8v4
-----END PGP SIGNATURE-----

--8D6WBjU4dhTr3Lss--
