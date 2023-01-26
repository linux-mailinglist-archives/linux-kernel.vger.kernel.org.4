Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533EE67D047
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjAZPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjAZPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:33:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F713515;
        Thu, 26 Jan 2023 07:33:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7885B81D00;
        Thu, 26 Jan 2023 15:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFCFC433D2;
        Thu, 26 Jan 2023 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674747180;
        bh=S+44FzgrppMOoavAOsmBiZEPceMlEDD+t+wy7gXfS24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGh3OnJ9GRcuM9g7cpO40tqn5NwbPhGgNnZvJmZceGjmMNFwaYbn18ZL6l5Enrhwu
         8wkHXS1zkWvjVr4qsCbdKCBIiwjWZzwf9B44GHoiOjRqeX0AeFIY9RK0Zrn4P8hSHJ
         unpaOhJ6bXJmCW3UbMJsncrqKCFgCpKYtUS/G5XvcmLps8VY2anze0C9uaHkB6tseZ
         Q3SaxF0JI0StKdUd/6JwJ33o8ndbF21+q6ssuvwe8yRXwJJ9NPnk3teFHsIFR8oi9m
         kN5kUutkHi+fb0yWQdlHkwqD2LyOtiduyBYmL/oJq2D8ajAPnoMTo+NAYx9YGnWdSV
         3JOccIhOvb9oA==
Date:   Thu, 26 Jan 2023 15:32:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@kernel.org>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l56: fix DT probe
Message-ID: <Y9KdIzlqHPL19YIB@sirena.org.uk>
References: <20230126135552.3625887-1-arnd@kernel.org>
 <Y9KIN7GerLd4ziw0@sirena.org.uk>
 <20230126144635.GA36097@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q1+h2puod9yEyzZ/"
Content-Disposition: inline
In-Reply-To: <20230126144635.GA36097@ediswmail.ad.cirrus.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q1+h2puod9yEyzZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2023 at 02:46:35PM +0000, Charles Keepax wrote:
> On Thu, Jan 26, 2023 at 02:03:35PM +0000, Mark Brown wrote:

> > Or there is no mandatory properties/platform data and the
> > defaults are fine for most systems (which is a common case).

> I think Arnd is right here, the driver appears to allocate a big
> block of zeros and then blat that over the top of everything it
> read from device tree. So you can literally never use any of the
> DT properties as it stands.

Oh, the fix is fixing a real issue - it's the claim in the commit
log that the driver could never have worked that's not obviously
correct.

--Q1+h2puod9yEyzZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPSnSIACgkQJNaLcl1U
h9DmDAf+P1aRExs02B6c0QhYJujZH3z8FJK6WQtLcZ6Tjhx8rdxgSJGvOgpyfU4H
3qVJD+/OgGJt10tP0uuO8dQ07L6Gb5dESWCcgDZrd2McR8jhYLaKjv9rjQoMxb42
zqDtN17vUrmp5AZ8CWfVjuMnrLi1sxBnfo4LvBrtOjAb8ZtOv9JHUaiSXbKZ3L5j
yZYaq5IlE10V3WkH7QFrchvI/owjd4JnP9eTGkfBoHbXcVbx/A9Q1PxLLDPgMIM6
ztd4KRFv2xv/PICsfnoxAxU+Lkca5yFQ+wRZOJ7Bj3lqNlN+RB6MTc1P/GBHXblT
nSZvTwX+ld8zvHcoylJxizJCtgOqNg==
=wS2J
-----END PGP SIGNATURE-----

--Q1+h2puod9yEyzZ/--
