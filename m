Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D96999F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBPQZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBPQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:25:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B5171C;
        Thu, 16 Feb 2023 08:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3962B828E5;
        Thu, 16 Feb 2023 16:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D7FC4339C;
        Thu, 16 Feb 2023 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564736;
        bh=nve5Ue1AJALAEX5aeOHUuJl3EWYyR+RvB0oWPuHaAPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBZMIvmfJx1sZUYx1H8P5shukqoca3HUxhoEXbs4GcQ92K/u/FoElpUYqPYSpvRiV
         Fm1P02Pa6E5qop2uEvlLhHd6SFcUXyOX8QR0zQt6uNxFfiad4C7pjw5jUv61G9+BzS
         QPnytouh/mh+JXwcXq1k5wM5nGWp0QhVbFSPStv0jHJyLNQWG1E6yIzd25BLdJn9iE
         80TIEb/pxpt0pjPclxiVe1x8PmRbjbBZ4RuNBKMELesl0AH/AksyCQfNVxl3xI5ZG/
         v6wHirlmmX922evaG3Gxfy+GmO1E/Mjf77j33GoJy5orW4V0ad22xj5+MIq1wJCgJD
         hN2LdYcwkPsFA==
Date:   Thu, 16 Feb 2023 16:25:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Kazuki <kazukih0205@gmail.com>
Subject: Re: [PATCH v2 0/3] SPI core CS delay fixes and additions
Message-ID: <Y+5Y/ZW/FFJ5rRwv@sirena.org.uk>
References: <20230113102309.18308-1-marcan@marcan.st>
 <167362544665.163457.10878671229075890152.b4-ty@kernel.org>
 <20230214185234.uj63aovylzixs6xa@kazuki-mac>
 <20230216090411.GH17933@jannau.net>
 <Y+5SCAj4Vk8NLrW9@sirena.org.uk>
 <20230216162107.GJ17933@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Skpj9itf0StfGeN"
Content-Disposition: inline
In-Reply-To: <20230216162107.GJ17933@jannau.net>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Skpj9itf0StfGeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 05:21:07PM +0100, Janne Grunau wrote:

> I think something went wrong with "[GIT PULL] SPI updates for=20
> v6.2-rc8-abi". The message reads is if you intended to just send
> "spi: Use a 32-bit DT property for spi-cs-setup-delay-ns" and not 62=20
> commits.

You're right, thanks for noticing.

--8Skpj9itf0StfGeN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuWPwACgkQJNaLcl1U
h9Dt5Qf/V37kgFrW3nZL8VczgXJCUxn0MrUOxlKpy/vM+ZfigCJE9UiOOuyfJDBj
yfuYyHRtTPSNwAPavgUVH820gCixnE80ipxKe2X3ot7PonmsvLiq0lwqvx9qQYkc
w51k3981ZGo835FVP1+mH0gt4ZuyUj7W40K5v3r4sM4N+zyctFhPNdVB3k+TsdHJ
qoIyZprlsDL+JmO009DqGTiVI3Ov/0yQDq5VpWDS7mnRrFaFh5wNBjkgOy+4S7H5
6KLAJAQ7n4IeQTQsoltTufBfnlDkRcMcpSx+CekxsbugvxgRla+QqcCUYzFYEdVX
06htheZlFcCLELzYpHanojB+V3r/BA==
=1u9h
-----END PGP SIGNATURE-----

--8Skpj9itf0StfGeN--
