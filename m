Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A464CF43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbiLNSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiLNSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:16:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98725E8A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:16:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E298B818E1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF8AC433D2;
        Wed, 14 Dec 2022 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671041771;
        bh=ng31iXQhKawiBXKC1+Kublzbonz8fQyZH1Nmxo6bePg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t54WnSv0sRHPaJmCCm7xTDbksmTeQ3PTzxAY4qwNPKyvI4uAEisUU/MwQgIW8IPH3
         w9SbtdISPgNVMHumGAvmzG+evjHyxqmLWUG8Rmk1ffsSXdRNEO5UvUb9IsNOuv8i7b
         S/l09/3vH1bDB5aGnbQvrGrbuL/aE2TFOZe2D1f7gvUIsrAa7k7V7BW6V908iqD8yb
         H1b2vrwIg6lVYvzov/bLflgizG/dwDDXAX37DaTt1f8Wl+xL0BY4lDkdCv31vz2rkS
         OjP7xEx98oYJJ4NwuDpS11ILQmbmpw5C+1UYotceg1XsVX12AL+q3RZaQBv1AwLuth
         ZXNRUbfj/0ZAQ==
Date:   Wed, 14 Dec 2022 18:16:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Moises Cardona <moisesmcardona@gmail.com>,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, oder_chiou@realtek.com,
        akihiko.odaki@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Message-ID: <Y5oS4vys3Mb/BSXk@sirena.org.uk>
References: <20221213173550.1567875-1-moisesmcardona@gmail.com>
 <08403fff-359b-b5f4-d039-18eeef660637@linux.intel.com>
 <92358ff1-86ca-76b0-c4f3-3d4e0dddc80a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A+xD78oh22A6e791"
Content-Disposition: inline
In-Reply-To: <92358ff1-86ca-76b0-c4f3-3d4e0dddc80a@redhat.com>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A+xD78oh22A6e791
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2022 at 04:42:34PM +0100, Hans de Goede wrote:

> Mark, please merge the new version (which unfortunately
> was not marked as v2) which correctly drops
> the BYT_RT5640_MONO_SPEAKER flag.

It's already going through my queue.

--A+xD78oh22A6e791
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOaEuEACgkQJNaLcl1U
h9Cd5wf/cBMsjkQaxA6DsEBZoUFBHHtA9UIJEujMdDzw/Ln7v2qTx8yNdMCefPKk
Am2EGLl2ARc6Mzp0miEoybGl4hJPQxUZkSqF21OmLaDBDTbzVf4iPz/OuHqErzRB
6WgiSJwmg2JFhCJXGxJBwb0GHA+VG37Cn2Alh+QFhJcZ7Rs9D6QLUsEZB8EnYjSr
C3YYoADbjgw/Qoqjkl/jZ/mubQsq7vZbZFSE851g7IKxxHRqCTXvbWRPvxGjYJKw
e7YULkbwFsiewh5HaNys6kZjsw4CqM9tSUoqzbS0Fs64lEr9ZXUa/U3gdJxWaF4+
tseuvTdtJWQGF6rIfk4kYhea9mTlug==
=Clkm
-----END PGP SIGNATURE-----

--A+xD78oh22A6e791--
