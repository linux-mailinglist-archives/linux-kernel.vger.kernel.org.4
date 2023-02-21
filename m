Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC169EA24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBUW1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBUW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:27:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB131E08;
        Tue, 21 Feb 2023 14:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D18B0B810D5;
        Tue, 21 Feb 2023 22:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4B7C433EF;
        Tue, 21 Feb 2023 22:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677018421;
        bh=P06SrSSCbTF2Xgb/8rAJuCEF9liIHWSGJ4BAANKNp1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tf1Ivc7RJbuxndkFsSDprYpWOJFuUVMUrixHOsDLE0cIAeW11Lhkoai/L+JMqFc1j
         G3IRZ5K26SpWw4f6vFEsYb7fITg6VWoekVGOZ5K5XC6RF4MERwBYvKmhht8wf7ekz2
         BWM9sYFEHYoFi0C+jtVXHOH0OoTAyjBn6f9B3hndiH8mut1OYojq8r+XWBcW6R/h1o
         6ORgkSSWbfE+vg3yiBi/rKu0qjTapANCjQ2YJDmlhLK+xmxlv8Bt1leQ9X42ckYZ0a
         XQPqkaNhx3qwfBIPUIPap4mCKK9bywYWS0ts6FDNFAxvCDWEPcZdrOHfOE9/A84pq5
         WrXqpa2zYfkgQ==
Date:   Tue, 21 Feb 2023 22:26:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 07/10] ARM: tegra: transformers: update bindings of
 sound graph
Message-ID: <Y/VFMl5Darm7YEK1@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-8-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yuk3nqAxVaP3OTyz"
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-8-clamor95@gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yuk3nqAxVaP3OTyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 08:32:08PM +0200, Svyatoslav Ryhel wrote:
> - fix headset detection in common device tree;

At least this should probably be split out as a separate change
so it can be backported as a fix.

> - diverge control and detect elements for mic;
> - use GPIO mic detection on wm8903 devices;

--yuk3nqAxVaP3OTyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP1RTEACgkQJNaLcl1U
h9A4OAf8DMi/om6e4mm8TBFtglGASJyWKbwfRlPfnmHfZe9NRFocDsboQo+U6XFK
qxHu7nNOMUpIioEO5BEmw8UI1d3UWv28a2FLvEZODA08cBKmg2G0OPiUTQtb5kUc
eG2PvDWMskSVbzr0eSZBWObIXM4rn/83gvsLwdFJM6PYkUHPgsDtW0wTK+S8dIWK
BwyeF5IodplgwhhC9LQDH5rjGbXHWZIWOBCIQO4d4nhKQH/qDou2CXoENIAmZk0W
fvrnmz/hqv6IgLI81L9Teh7Q+eko/opWAJa9r4I9SCOMW/MLlveyc2oDA0zlI93p
fku7U+Z2zBKL5qyGRIRbhQTNPzUsXQ==
=ZxfP
-----END PGP SIGNATURE-----

--yuk3nqAxVaP3OTyz--
