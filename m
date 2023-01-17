Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006266DD53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjAQMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjAQMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:16:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013235279
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:16:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B251BB815CC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FC4C433D2;
        Tue, 17 Jan 2023 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673957786;
        bh=CH00r/9Pn2XE7EulWgDqTXg/j/uImnDKxyYLPQzgINQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4pAaYCijnR2Jh5ardSYMv+kNtARk43yKUR8aFoN1eAK1nSCtowM3er26Hk5owErw
         qJF83rQVcLuw76etpoXDqglX6bl2e3yCWOA6185/HeUwfjtjzgK/xfXgMUDsZ+5XLy
         ww9aSWVpLO5Od8LFZpHVZqvgSMb1x1o1U/qvEvPV0DsNQh0JMugR6ATQ2UFalaJqVc
         Tms6XBCTyy5tM6vgoaWFuHZStKPmAS586riWX+TAhRVPgxSmcLxIcxT511GOLDGJFy
         vWyR6KgnzKHYAe+tl0Cbkv7edbON6+kQmC/txTj0Qyqu3JAoFlkOGTcN7Nhdutfrnh
         449aUVP27GDGQ==
Date:   Tue, 17 Jan 2023 12:16:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org, Mastan.Katragadda@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Message-ID: <Y8aRlJRsCjIzYuqa@sirena.org.uk>
References: <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
 <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
 <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
 <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
 <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
 <62272f17-bb97-aa10-d5d9-0914595e5431@linux.intel.com>
 <b61474ce-01a9-7602-e3c0-df8fdc5191c6@amd.com>
 <625915d5-0c2a-ce63-e71b-ff4f4f2c6d07@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNkUA4FEK8u/5lc6"
Content-Disposition: inline
In-Reply-To: <625915d5-0c2a-ce63-e71b-ff4f4f2c6d07@linux.intel.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNkUA4FEK8u/5lc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 17, 2023 at 05:51:03AM -0600, Pierre-Louis Bossart wrote:
> On 1/17/23 05:33, Mukunda,Vijendar wrote:

> [    2.758904] rt1316-sdca sdw:0:025d:1316:01:0: ASoC: error at
> snd_soc_component_update_bits on sdw:0:025d:1316:01:0 for register:
> [0x00003004] -110

> The last one is clearly listed in the regmap list.

> You probably want to reverse-engineer what causes these accesses.
> I see this suspicious kcontrol definition that might be related:

> 	SOC_SINGLE("Left I Tag Select", 0x3004, 4, 7, 0),

Looks like a case for putting the CODEC in cache only mode...

--tNkUA4FEK8u/5lc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPGkZQACgkQJNaLcl1U
h9CzBwf+PhuLttG+/GNupysKygNCy0Z6q5gL3sKpB9KTyaLYIgN0ZY4bLEUHXQE6
mQrf8QZG0TdQsxq9oAedn7rtOQ11ev/lXJ8mj0pF9xArwaWhfILwAW80qANdc6Wq
pZuAU5JwqoAfib/5xCcoQmGK37giNEltn14fV2BnAwbYgUbFsfY479ydXUvsDoHl
E/pOTZ/PotFq1mO0F/J0Wy2bh4kUSyNvnQ3Tu6tqU2BrViskQf9+AdkpKmD3qYZB
YGunhLBrGdFmbAEz1meauMlIgI9qWwIuCxsqlgW4hXauuk49ZtUsLKokCkaQ04l7
En1HWemmcmLjbHs/mTCxB4s6k1Qzvw==
=VA1T
-----END PGP SIGNATURE-----

--tNkUA4FEK8u/5lc6--
