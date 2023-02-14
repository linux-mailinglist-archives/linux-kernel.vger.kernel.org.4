Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA3696441
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBNNH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjBNNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:07:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE123877
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF3961601
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98993C433D2;
        Tue, 14 Feb 2023 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676380044;
        bh=ZEPZLL2ZKUy55Unu8q0cOVpaiMguKqJHtB7H8o/4DV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgyBKVPaBr2HQXN43pZOzCb4H4tA2rtGobKxsA6L14FuS6dFETH9ZgzoQ6FmrI0Ez
         2TAL5S+VRc6+IpOCfgOmojZXMJx7+HPRuIS+ht+Oeku1CkNbgNOOMufT7bkYVBI0mU
         xrPn5SUwvNy4v5HmGPZoG+nkJRP+vviOhiEpWKyw+eb9OgnfYrtUYIYAUCGtY2mJIS
         YWt4IgzSqKs1L4hPKeSd4XQfdR6mMfFC6Fra4zFbPJfMEzUd+xq/T/POZoysW2fkgS
         ++HWk+aLYZy8agWztMf7gFcEcthd/nmGMijy4vGYSH9AWAfe0KxK6d+hJR4b2g7ZLK
         nRNT78SXT/rJw==
Date:   Tue, 14 Feb 2023 13:07:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Douglas Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SoC: rt5682s: Disable jack detection interrupt during
 suspend
Message-ID: <Y+uHiZ1D5rmFc2L3@sirena.org.uk>
References: <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ETlhmiRcEav6CrZn"
Content-Disposition: inline
In-Reply-To: <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ETlhmiRcEav6CrZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 01:20:23AM +0000, Matthias Kaehlcke wrote:
> The rt5682s driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682s_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ETlhmiRcEav6CrZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPrh4gACgkQJNaLcl1U
h9CtFwf/cETeyaTBqREWV1P0f3zFV9nLL3Hh1QF3i6dqz7TwD0wWHQHOOqUWZRWN
B2Tv1YwBEi9pfwbO5tv38mtzz3W1P2xphzbiJF/mP3kk0/bzLeoYCwhDtFsMBmFj
agRsU3GBFhkAuy3/iYuhDh8PSytgoAqTinNxVQU1CiWtk77JEmomm2Q+clxJpQrv
jcIkoKxq6BJNq8zP+TCMTi99h3BzywNhpL3reO31HVulZGxvfArQafPv03O1O3i8
ErpWtrNLq7sr6OhGApZjvCKEinQ4f22VGXbLEMj7fjpYgWM2UXRZeIyCC6/8jzxl
l5G6DJTuk3RflJq/nUqZj5NPL33ZPg==
=5BVe
-----END PGP SIGNATURE-----

--ETlhmiRcEav6CrZn--
