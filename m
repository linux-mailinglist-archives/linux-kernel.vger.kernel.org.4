Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688062D91A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiKQLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiKQLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:10:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93676E572;
        Thu, 17 Nov 2022 03:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64219B81FF8;
        Thu, 17 Nov 2022 11:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A05C433D6;
        Thu, 17 Nov 2022 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668683384;
        bh=rlMFnUfQu8GJbpUZVcINUpGICn6p1+U5R0s89aqiluY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3x/iGCbNuMvys+UHPYxXfBNEAjRTHTA7o32s2r636M+YBziRU2SonABy/5UU1DnQ
         3YSZBpbLlV16b0wTYkkbOka0EYaToulvwQQ6YLZf1ROtwkCUY/mYWSKCusjvL5vfl5
         GtXRdaGwEu5jajg8VLb3TOuqu8rtnFdEm4Xr02tIqPUgI6oDOyw0ISkleOPBWQv1Uh
         Q4l5z6Y53UO3FFCyK7OG8Af7IuGHk5lPUop3+BjBi3gh4Pw65qxsKsd9Ug2shYBllT
         zLwERhd4dFhs4bctzw0za1HB8NQRl6Qh5d7eU+rxh+CyqFs4sAk8zNQCSfWflRXOXM
         +GanqHZNquZlw==
Date:   Thu, 17 Nov 2022 11:09:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Carlo Caione <ccaione@baylibre.com>
Cc:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/tiny: ili9486: Do not assume 8-bit only SPI
 controllers
Message-ID: <Y3YWdeTLfmDh7UyB@sirena.org.uk>
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQcIBCJXd6N58uwP"
Content-Disposition: inline
In-Reply-To: <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQcIBCJXd6N58uwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 09:47:40AM +0100, Carlo Caione wrote:
> The ILI9486 driver is wrongly assuming that the SPI panel is interfaced
> only with 8-bit SPI controllers and consequently that the pixel data
> passed by the MIPI DBI subsystem are already swapped before being sent
> over SPI using 8 bits-per-word.
>=20
> This is not always true for all the SPI controllers.
>=20
> Make the command function more general to not only support 8-bit only
> SPI controllers and support sending un-swapped data over SPI using 16
> bits-per-word when dealing with pixel data.

I don't understand what the commit log is saying here.  The
meson-spicc driver advertises support for 8 bit words, if the
driver is sending data formatted as a byte stream everything
should be fine.  It may be that there is some optimisation
available from taking advantage of the hardware's ability to
handle larger word sizes but there should be no data corruption
issue.

> +	/*
> +	 * Check whether pixel data bytes needs to be swapped or not
> +	 */
> +	if (*cmd =3D=3D MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes)
> +		bpw =3D 16;
> +

You should check the SPI controller compatibility here.

--LQcIBCJXd6N58uwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2FnQACgkQJNaLcl1U
h9DkAQf/ZO81DRjufOHQCe4TT3YQX0I4BQbc6tjxpvEJsPkgTRL6r1vfxKJOjA6j
gBJqo8B7TdFYzqzWf4hJwieTLgUKdg4pWERfMQ5O/g9bHsc0BwLUTzg6asgynPqk
ZdxyCvC5QTA/b9ZIWdKPRN9com67mNQRrebpkwcRjFQ1alJxlLDi2P+yrsCE+WOj
Q77RLUtE3cVmxP1tFERDaS6TTTxc51nqK/HT0t6x3LURP6nnPdp5o8s2+AU88Vfv
QoJDmpltiUw2lUScF9jTJjc3ATKhvXAY2NuY1xpVOUMfd4noH1MX5L97UPVedrY2
24k3w5zahZP+JTUtK7epT6eO/eckVg==
=opWd
-----END PGP SIGNATURE-----

--LQcIBCJXd6N58uwP--
