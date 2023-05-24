Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9189070F197
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbjEXI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjEXI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908119C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B3063B19
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EE4C433D2;
        Wed, 24 May 2023 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684918682;
        bh=D5d6mBIlSxvhMaND02II0k3IaiNYbeQM4kSCl9JoOmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7cxjMCmb6oKhOdh5jbG0/aWdwmk5EY0zmVXs9YHngGMybX5ACa6LQgQGPw/FUUTq
         gaFb2Fa92W48YR2fBls55A0+2O2p6KIxnfd0i+ubwrP0imJWsWk1AdTOc1hB4oPk3e
         qh9pUb1tM/UFqfqqdRv7qZWPQYk15beuM3ddznUrwb21n/E4K3zEjzwku+/uwOobh8
         RnErEpSEndTGhIm1kEgLkmsWC5yXgTTMYS+ba63TwzTjFcSDZ8GAh+QbdIqTcndZlO
         IOFbm2lwiJIuUq+eHJC9ZhQvn7bzU/D37n7Q9rClnDZTiYnqRrDV2jHC+eWr3dUy87
         ahBYR23M9J8jg==
Date:   Wed, 24 May 2023 09:57:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <d94e734c-e816-4b3f-9fb3-a6589063c05a@sirena.org.uk>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
 <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="etqstALKWZ9H8K4L"
Content-Disposition: inline
In-Reply-To: <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--etqstALKWZ9H8K4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 09:51:00AM +0100, Srinivas Kandagatla wrote:
> On 23/05/2023 17:55, Mark Brown wrote:

> > Does the CODEC support mulitple writes?  If so it seems better to leave

> No, the codec itself does not support multi-write. All the codec register
> level interface is via SoundWire Bus. which also does not support with the
> existing code.

I'm unclear, is this a limitation of the hardware or of the current
Soundwire code?

--etqstALKWZ9H8K4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt0ZQACgkQJNaLcl1U
h9AOMgf/WO5YS4C+JsjQSfwCknP55UoFjGXPXq3xXsBDSAWWsAoYmn1YChO63rdG
SdIFrP/9qYLeBViWCnkc6eoDNAx/yCcgt2EOyNHe6AaOK1NFiFItGVfb0EZH9pzE
irNrK33iUtmj5wFJBS7/xk4G3zrW9rjd8PHIQw/f23uo+Ghv44zptBrOC8FCP4q+
wjbtQ/XzpsZlyudpHg1ABYEw4qdsML0F6cj+P/t8/Y0NCiYESnhBt6bazvEl2LAf
fcWuSbSrRxcyVyWgIGwwg/HRnXVROs8pX9kLlj/Y+ek8jHP5TObHNuiRrVh95OJM
o279APGUrW9DQldUk5LGDKDxNV8uIw==
=c42b
-----END PGP SIGNATURE-----

--etqstALKWZ9H8K4L--
