Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206417390FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFUUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFUUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2D10D2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ADE5616BE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774D8C433C0;
        Wed, 21 Jun 2023 20:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687380371;
        bh=ripGwAImlGjHyuVMQp4ULj5BV9Mh3c5XiZNw2xG5rgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVBcOHwhn0CyYV41IepkWHkwOLDC90bWDSETmIEgsSmKVFfLrujsPj+2TCVUCZL3I
         fCCY6O630u2/2UT+FmlYwb1mRzUIBIarCqsh+WyAfJgc93kgMM3dWHiwl3eUxRs/Ex
         jeqyuK8j7PbhySN0qjL+ymyq2h6lXjrf8NCgh+upNWbLZNEfoyQkwKZd4HLPkoD+cF
         jnM17i98t4ZD3caWn/A4HimWCt5MUyjXkljMZnbgcJeogpqa4ZCji4yDU9mc5l6sEX
         3yVgsVW7L9CkuBnMjEU5063vEhc3WV9UcMW9do9/QTQ+N9zX858C0X79YKQeB1l/j8
         r9D2BU96+X0bw==
Date:   Wed, 21 Jun 2023 21:46:05 +0100
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
Message-ID: <b83bf5c9-5998-4683-8f28-1eff432742ed@sirena.org.uk>
References: <20230621115328.156457-1-fido_max@inbox.ru>
 <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
 <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
 <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
 <ed9606a4-4be6-7403-6e32-1c045ac0bdf6@inbox.ru>
 <adbe1b82-9478-4462-ace9-968723a6ce3f@sirena.org.uk>
 <0ada8334-4006-438f-8461-5c4c8e13f65d@inbox.ru>
 <c054b036-d5fd-482b-adc4-913edbcd007c@sirena.org.uk>
 <08fb24b9-ab7d-da27-5ab7-e1d3270c8b43@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xFMqdEWfE/HZ3Aek"
Content-Disposition: inline
In-Reply-To: <08fb24b9-ab7d-da27-5ab7-e1d3270c8b43@inbox.ru>
X-Cookie: When among apes, one must play the ape.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xFMqdEWfE/HZ3Aek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 10:57:18PM +0300, Maxim Kochetkov wrote:
> On 21.06.2023 17:35, Mark Brown wrote:

> > > > > I'm saying there should be some interlock between these two settings, if
> > > > > nothing else setting DSP A mode should force TDM mode with automatically
> > > > > configured slot sizes.

> Ok. How about that:
> ---
>  sound/soc/codecs/max98090.c | 52 ++++++++++++++++++++-----------------
>  sound/soc/codecs/max98090.h |  2 ++
>  2 files changed, 30 insertions(+), 24 deletions(-)

That looks plausible, yes.

I do note that the driver ignores tdm_width (and the entire TDM
configuration) when configuring BCLK, I guess it only works in clock
consumer mode for TDM?  If that's the case there should really be some
validation, and there should probably be a check for slot width being 16
since that looks like the only thing supported.  Those were already
broken though.

--xFMqdEWfE/HZ3Aek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSTYYwACgkQJNaLcl1U
h9Cdegf+M3QEGRYrVk+Y7+QiD1MfHGt5GVDIMEyPuTUJDRGem8nC1umYM/jbF1VN
Y35F5/Wc6UeD+VmMuvNKqwzX2xrB6NAvRdVtFXcC1L9TSldc55IT1pYT/+XFZe3Q
YT0OWIObLCAOQHUnKmzAXQDbBnInswna9MFIi530D8VxL0D+ovILaNJhKWINjRGe
gsMwcH/0zfKFGPsPkG+oeZWUADq2Pnio6YuEuhXgRrTz44mGGO2F2NQJuF1bsw0t
kHqE3yFFj1sAz6CT0C2VBLCmEdZa7GJJJIih62gaKgPLi9IOyYLYRSq8WeekAjHB
RU64YCU1LaHwwtpU4ZDKmwuEuejrEg==
=sbbb
-----END PGP SIGNATURE-----

--xFMqdEWfE/HZ3Aek--
