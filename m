Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1769E9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBUWIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBUWId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:08:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7817CDA;
        Tue, 21 Feb 2023 14:08:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28642611E1;
        Tue, 21 Feb 2023 22:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18985C433EF;
        Tue, 21 Feb 2023 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677017311;
        bh=0bDCc37RZMk8RynOgZTjNXQJhNd6CT6r7FfzrYYttJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5XPxWPbMbW/tAdU7Hqb28QdxCL1IVodMYfmI8ay7BzUDUAJZ6Axl4ZcbD6afo4pg
         ys4yY4zghy3oURzE9fmYdKTmYPJUYThI+PkJ7a1932jWj/HS01EAlmzTDFuoDi+UVz
         kqZE1DMUmbi0dKNATsCKtfSEJhp8iopo+aYOwHfTpEYPeu7wcKt3IfdamagVxVSelv
         Vl4OJiznG2PO5eeC5oYMnsahSix0a/Gb85PPMVH/wREH4AHlvBqLb/O5DhmP8QGIJb
         Sj9Ve0z4sc0UnRSET29GL025luO8c6Ee45ITWbXJNUoKMK2f2osP83/qXgQtYdhpGf
         OCxh6nhmp7ecw==
Date:   Tue, 21 Feb 2023 22:08:28 +0000
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
Subject: Re: [PATCH v1 02/10] sound: soc: jack: allow multiple interrupt per
 gpio
Message-ID: <Y/VA3HK/jGVPbrqb@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qmxly6Gn0iLCwqrs"
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-3-clamor95@gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qmxly6Gn0iLCwqrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 08:32:03PM +0200, Svyatoslav Ryhel wrote:
> This feature is required for coupled hp-mic quirk used
> by some Nvidia Tegra 3 based devices work properly.

Please submit this separately, there's no meaningful dependency
on the rest of the series.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qmxly6Gn0iLCwqrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP1QNsACgkQJNaLcl1U
h9DWeQf/VRGoxVKrQTgsSjSQxv1jc70l5vn+sMEJB2VkseJw0TvSyTVBDvQlAvrP
y+gKeYz10KvANtdVfgXhWqeUnZv6criGYBX/aoT35qkboa0fk+eMz8Pmj2C+G3LB
YWRa+Q+Qy7MI3vF3vAYVBl8ElSzym4MKc5jAccVeFZGDIKC14nEKaPNDWC/odv7g
NXapa17rA/uezOIATkgqOmWfDZq3pj6WJM/IgIyJB7s/1EOF3RXUasX/BLbMer2u
rYr5sV7RWK47W9zqyXkFcTnLbwRfLBocJnuS39GSipXbRBHTuJLKfN0p17JYhEzY
2I/4OHcaaNxAMATbKQAt7rmK7MOmjw==
=BGs8
-----END PGP SIGNATURE-----

--qmxly6Gn0iLCwqrs--
