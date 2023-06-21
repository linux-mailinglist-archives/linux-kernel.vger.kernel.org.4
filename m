Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B677383B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjFUM05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjFUM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:26:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A1129
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC75161558
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F59C433C0;
        Wed, 21 Jun 2023 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687350414;
        bh=PLITsDgO3ORD0mg3V7mhV6h2SmUAQMBGXJc9EYuerXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLV/oYtbs/fbY/+X+RrQQ3etO+S2POSQOMlWQUHaHBV0nxettqx44kC2XPj3PsGSv
         h0PmIUC+uPI8hGVnINnWpio+bRB8P1u11+htVaIrHEOFcn+3m1rSCIQX3hGiIs2xee
         LiE/7Iclz5wCAEKygcc9t1vrMZ0csidLUFmQJj4+J90up/pHb0Ri5YRlC7JzgiYoau
         BkcAqeK+pP7ptB7EDk0GTQsbjCKRvCTL9lQIt4TkZLwt65XQ/uU2W6LG2Z/WJp2vLn
         CTepY8KbcEC7QTao/nyIUvM7y1Su3VynJnIPUerRbTzsq+Ho8rwiHdDn1li5iq4nhd
         i/Nxh5NDa97Nw==
Date:   Wed, 21 Jun 2023 13:26:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
Message-ID: <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
References: <20230621115328.156457-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1wavB8RUXkPItFLO"
Content-Disposition: inline
In-Reply-To: <20230621115328.156457-1-fido_max@inbox.ru>
X-Cookie: When among apes, one must play the ape.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1wavB8RUXkPItFLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 02:53:27PM +0300, Maxim Kochetkov wrote:

> TDM mode for max98090 is dsp_a compatible. So allow it.

>  		case SND_SOC_DAIFMT_DSP_A:
> -			/* Not supported mode */
> +			break;

This is configuring DSP A identically to left justified mode, it looks
like the format configuration needs at least some interlock with the TDM
configuration.

--1wavB8RUXkPItFLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSS7IcACgkQJNaLcl1U
h9Cw1Af/Zrtw6Cu27PuZfjQDBdN6p8BYFU4FGO6T63zJOyqe6zD3US6X2RfJm/nK
VFJ9fBoluougbUsISB5OvDmrmatK4z2PHbHS4VNh8JxHyoFkq94S11ljUB2NbGHl
EeqoNI8gvJ8k3bx3Qubyn/6YkJL1wWprlbwQ6cY3Vmq/DKH8A+iZgnnotw53AgYy
e3gs6k1xAJNavHHz+IjumhjBPpnwhZaF8yNCPu+rWbbaB3Xs8vWnIvJocoJzHC59
uYmrmhPYcUCJHLVdbRPKehqLvJxgDhFcgr+C5P1sBnRtWdv0VmnkaWrdh39bdnOZ
IWbvDkGM6scf87qrJDCl6xuZutQDzw==
=kkOL
-----END PGP SIGNATURE-----

--1wavB8RUXkPItFLO--
