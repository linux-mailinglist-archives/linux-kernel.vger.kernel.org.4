Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887E760F7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiJ0Mom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiJ0Moh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5B63E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50FCE622CC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142E2C433C1;
        Thu, 27 Oct 2022 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666874672;
        bh=8seYPbRcHrC9RaVdyY+jCwH9pq3w1IwKUS5IjVpXrek=;
        h=Date:From:To:Cc:Subject:References:From;
        b=H/mnobNiDp7uLhXAJb1gnFTZbWq2q+TBFTubAOnx2WV7NPing6WVKPoSHN1YdbakR
         h/aEjOn+BCMQgMG5ceybxGFF5wL9k4Y8bvf5Gct96JEKQpjHAT9kjcFxn83PRLdP9+
         5WqK2RdlMHyR0xemt/V4NUDGVG2o0Mls/c6KalVGoPhaN2+M9cG1e+ejrUfBqZC1sd
         ihCShfUyR3LB8czCXr1tsGKfx6VC902iWCBhwNbs4enHI+qkFSL36EONKBUyjM1CRo
         pWZyrwNErEC5f5LM/5moBvB7S/nr4R3kh3RB5ALbjQI4IEmAsH4F89FMyi96k3gvCx
         hRMZZK3ZwxpNQ==
Date:   Thu, 27 Oct 2022 13:44:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ASoC: Intel: boards: add missing dependency from
 realtek-common
Message-ID: <Y1p9KqKsmRVnSHeG@sirena.org.uk>
References: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0tAhm89lRwGRaF2L"
Content-Disposition: inline
X-Cookie: Forgive and forget.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0tAhm89lRwGRaF2L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 08:17:12AM +0200, Adam Borowski wrote:
> These boards use code from sound/soc/sof/sof-audio.c
>=20
> Fixes: e1d5e13324020c4b405e63cae34560c7992bec2e
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

You've not incldued a cover letter for this and only copied me on some
patches, are there any dependency issues?

--0tAhm89lRwGRaF2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNafSoACgkQJNaLcl1U
h9DMsAf/WBd4wBIjKZXcDD50HLmbXKoAlwY5HM9ZE4tCqM18MUQ6WPQ3tPXH00HO
jM6c3rj3fJJNb8qpvHf6fRm6IKPZRj5SO5gohM5ZUTl6Q5qjBh1BqkKEYzj1638i
P95FH1qsulsYrZQeh5H63dsCy4IHmHAV2Q6/3D/dlmJvtArRvDdEmPAKwZKP/huD
SNcqTerlldIkbvlXRtYIPSWFBJPeFBA6hxZc4MXpCw/fJQ6c4GC/XHX1XJaAKx/x
KgsMUbg2ynQ9sZjfrimk8a/rX7XfKY3wSmwwQLjNi/89kwxRRGnFag1cmQEyDQqq
4wlKXUXNNIzEZXqLd7taC+Q5vgWixA==
=6roM
-----END PGP SIGNATURE-----

--0tAhm89lRwGRaF2L--
