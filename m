Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F294738724
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjFUOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjFUOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A007E7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5B961572
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F9CC433C0;
        Wed, 21 Jun 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358155;
        bh=W2XF7Oua9MyLK7f+VdvwpICbplyFhJN3xZ2lUbZlqAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mwbyt3bvhlfW6wb6ioKf7FJCJWZRoFxdcB2Ji6NuyPM2bDnwGq3tAA9thyNMVbLhh
         IIezVbNSq+ffB2Z0OqoIYQ2nar3HKK1GoRDSbwuqdwnheDmZ5nhDBDHhIIhMIMadRm
         KciOMEcloer9Nio3dK1oTx0dmJF8mBebye6tjT65BZE8rhY4YHmgk6n0fAkmzzfYMb
         jLu7cWNk8Xu/+Tuo3o0s7BrJS1EGjI5STnc1FYO7cyMJj6rcq34n4nNWXJ7Jw5ZCxC
         M1Skx4oSqflz7MLg3y8MXzr/a6H85SAifVg1KU5YQAVKYEXJLGDe8pP3/ua1m5LI4W
         Z2llrRYsFG/MA==
Date:   Wed, 21 Jun 2023 15:35:49 +0100
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
Message-ID: <c054b036-d5fd-482b-adc4-913edbcd007c@sirena.org.uk>
References: <20230621115328.156457-1-fido_max@inbox.ru>
 <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
 <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
 <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
 <ed9606a4-4be6-7403-6e32-1c045ac0bdf6@inbox.ru>
 <adbe1b82-9478-4462-ace9-968723a6ce3f@sirena.org.uk>
 <0ada8334-4006-438f-8461-5c4c8e13f65d@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2neDLP738ecGvEVW"
Content-Disposition: inline
In-Reply-To: <0ada8334-4006-438f-8461-5c4c8e13f65d@inbox.ru>
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


--2neDLP738ecGvEVW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 05:28:41PM +0300, Maxim Kochetkov wrote:

> Yep. But we have to specify TDM parameters (slot masks, slot width, etc) any
> way. Because there is no default TDM configuration like I2S and so. And pure
> DSP_A/B mode just have no sense.

No, they make perfect sense and are widely supported - the sample size
is chosen based on the hwparams instead of being forced by configuring
TDM mode.

> Anyway. What do you suggest? Should I perform some refactoring for the
> driver? Should I move M98090_REG_TDM_FORMAT/M98090_REG_TDM_CONTROL registers
> setup to the max98090_dai_set_fmt()?

To repeat:

> > > I'm saying there should be some interlock between these two settings, if
> > > nothing else setting DSP A mode should force TDM mode with automatically
> > > configured slot sizes.

--2neDLP738ecGvEVW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSTCsQACgkQJNaLcl1U
h9D+2Qf+OXZ936gjrm5garp8HyHsxJi4cDxPg+iRNTE2bFGPiZZGalEyqDobvnT+
+V3eOdmPrirjskcEkG1J+YGJkfMFtvoRg2+O613K3yRKx27jEZK7zkwCMmjaXKA1
1SPuLLuG0xuTiFR5XCWQ3TlextQXT9Bd8yzEjKQ5v8IF3jkxBUi6tUmk3S7s05Ow
ZytXngPOb15z/tIJa3/1GwQ+ICN/BVXRfexX22SIFyRrfZMuRRQH4hdpJpjWXHe7
bUMsxFYPB45ULLHHVAET28DckyE0K3V0gKSDBdrH5g1lbXCDtz4M2YZGQh70s+Ub
1hM84darU01Y53RTLeS5w/tr70Ua+w==
=FNmd
-----END PGP SIGNATURE-----

--2neDLP738ecGvEVW--
