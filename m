Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E67160BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjE3M5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjE3M4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0CE5F;
        Tue, 30 May 2023 05:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370D762F9A;
        Tue, 30 May 2023 12:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A34C4339B;
        Tue, 30 May 2023 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685451323;
        bh=gB3DzdnTcOqeQ/yA5xB+mEAqSvWsE3BKi0eELAC2ZuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzdYG80fmSksEi1YqUZ/UD8oa6/83PEBXNA8vWUOjnLjj6dlwM8ykT+Kg8m0SBViG
         tiFksq2POWgCBG827I15unwmNmbyKokVztJsZu3e67tlkluMWjgL8/WFHku2stydtW
         ASOnoJomueeMvc8Z7GwvuUbkEs3tNmYqA3wXwoFJIZhsh62axEHtg3bVpISSNPqLk4
         dHktdeIJu0f8n07kxYk8SNWU5KbvZYR6yZ2SL76bLu7KwPKMQNV3VLhUDb5g6RiSqk
         szaSQS3PQcwd9+8rlDcKdcx3aMal6HROoXQln7Cg5tJaRscSfGLSUMc3zNaAadZK8B
         ykuyD3Cp99QhQ==
Date:   Tue, 30 May 2023 13:55:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 1/3] ASoC: es8316: Increment max value for ALC Capture
 Target Volume control
Message-ID: <d15fb475-07da-4273-8a4b-2b493f3feb4d@sirena.org.uk>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-2-cristian.ciocaltea@collabora.com>
 <5dbcbf84-602a-44de-ad99-268d4d5b4b2f@sirena.org.uk>
 <cfa23203-1626-440b-ec27-efe56cb297d2@collabora.com>
 <01fd1a9f-56c7-4864-bb2b-8b004284c8cc@sirena.org.uk>
 <3c6b67a4-4892-0057-3dfc-65ed6c7ebc37@collabora.com>
 <4a3f54a3-2cbd-4a22-9742-9ba60e78643b@sirena.org.uk>
 <8247660d-4b95-0ed7-9444-b23da23560ac@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VwKU/hThU0aasoKT"
Content-Disposition: inline
In-Reply-To: <8247660d-4b95-0ed7-9444-b23da23560ac@collabora.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VwKU/hThU0aasoKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 03:52:52PM +0300, Cristian Ciocaltea wrote:
> On 5/30/23 14:36, Mark Brown wrote:

> > The other option would be to change the value in the register during
> > probe to one that's in range, that wouldn't stop any existing saved
> > settings from generating errors but would mean there wouldn't be any new
> > ones.  Either approach is probably fine.

> Thanks, I will prepare v2 and keep the current approach.

OK.  Remember that the TLV will need to be updated to show the two
values having identical effect.

--VwKU/hThU0aasoKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR18jMACgkQJNaLcl1U
h9AK+gf/W47UY5pQEtAzD8tOdAXdQkK+SUUtr2KaUO7DO0hgR7cNOxU/oKB0MnLB
1JPcc2WAZd/t5T9zzvE9dXc0gyWN44UcrlJjRsYv2mVkarSBRSF7121NCcxeUhfB
MpXr4LSLG4F/7jsYsfwrqmHEH/5Rm3YtqacLuQLoajf2xvC/g//JJn1k51f3kgpd
WTCV4QQJSMBq35eCjXVEPS/vOIUAyZ7iYLE6ZgErkoxXgm9VcvKPXbhWdni9XuR3
5lpJHKyx9XEh9cDwNeq1dp5CAy9Pa8enWT5FOY1G0VAWgY2RGhJPvn3ACleHS7dX
Nrl0SlmWElUBaMDXpYAUslS9x0lP9w==
=wTrZ
-----END PGP SIGNATURE-----

--VwKU/hThU0aasoKT--
