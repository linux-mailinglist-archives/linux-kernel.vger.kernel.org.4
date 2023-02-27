Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1C6A480D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB0Rch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0Rcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:32:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E51EBED
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:31:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A74E160ECD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1C0C433EF;
        Mon, 27 Feb 2023 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677519105;
        bh=XO3Vzyzmr7SlyHdxfYq1CHmp4sGGjg8UTvqIAh6zv8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0dyJ4cB1haT4bseGJQbhBxSAUGDdRddM4vkg3FeFJjj01ff5oJLsq4nj7v2Q4Mxv
         +D6CWLtAmsbDEIiHbxLR5xGsok+nqOBlfnGqUUEUDOyOxQ0WB7q/oMdJIVDsG4ZyQp
         vgO8UzpI683r/2gcLFTVH4CTSkhGqjfdbRly6SukgWnZqJr5UmfQ1S2XrZY9qUAV/m
         pHE0oM0b9+xHj8DkwsoP9tixu5nrEM+L5Pgjp/4+Phi9q7XLDNC+ZAusD39kRG+v9c
         sDVHyTSYepYWxJ1qrnaH8NyC6yTQThKw4o2o6mFas8ee+hD9W+0xj0sU6NFF0bc+sI
         fzBJ5g1xBUeVA==
Date:   Mon, 27 Feb 2023 17:31:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sascha Hauer <sha@pengutronix.de>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: About regulator error events
Message-ID: <Y/zo/BEyC4G/B7XK@sirena.org.uk>
References: <20230227130542.GM32097@pengutronix.de>
 <Y/yt8nzVuO4sUg3v@sirena.org.uk>
 <CANhJrGMRoR5BfoTswmF8RtLbBd1RxQ77o_W4bNyAgEqZSzdU7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Owo6fkmJLecJk/NN"
Content-Disposition: inline
In-Reply-To: <CANhJrGMRoR5BfoTswmF8RtLbBd1RxQ77o_W4bNyAgEqZSzdU7A@mail.gmail.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Owo6fkmJLecJk/NN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 06:19:19PM +0200, Matti Vaittinen wrote:

> What was new is that the BD9576 also had configurable warning-level
> limits (stricter than the protection limits) - and when these were
> exceeded only a 'warning IRQ' was issued. This setup was requested
> from ROHM by a customer - and the information I received was the
> customer had a use-case where they wanted to do 'mitigation actions'
> before things get more severely off. Unfortunately, I never received
> the information about these 'mitigation actions' when I tried to ask
> what those could be. I am under impression that either out HW
> colleagues did not know the customer use-case in details, or that this
> information was 'top secret' (which seems to be the case pretty often
> :( )

That sounds like an industrial application with redundant instances
where you can fail the workload over to another system as thing start
failing.

> > > The strategy I had in mind was to disable the regulator, enable it again
> > > to see if the errors persists and if it does, permanently disable the
> > > device.  Disabling the regulator only works though when there's only one
> > > consumer.

> If it is obvious that disabling the regulator is required for
> preventing the damage, then it might be justified to use the
> regulator_force_disable()? Now, the question when this is obvious is

That is basically what it's there for, or at least such things when
detected from a consumer device (eg, over temperature warnings).
However it's an open question if you're likely to see a situation where
a regulator flagged a problem that critical and didn't autonomously shut
down.

> Now, I am not really sure but I have a feeling that ideally the
> regulator driver (provider, not the consumer) should have this
> information about the severity level in device-tree and select the use
> of notifier flag based on this. If an ERROR level event is emitted, it
> should mean the hardware has really failed and forced disable could be
> justified. If a WARNING level event is sent, then the handling should
> be more graceful - probably done by some very system specific driver.

It certainly seems like the regulator is a good place to inject the
configuration.

> My problem here is that I don't have the visibility or understanding
> regarding current use of those events. Not sure if all the hell would
> break loose if the regulators are forcibly shut down. By the very
> least I would expect such a consumer handling to be disabled by
> default - either via configs or via some runtime enable/disable
> mechanism.

Yeah, as we've discussed before AFAICT any real usage is entirely
downstream.

--Owo6fkmJLecJk/NN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP86PsACgkQJNaLcl1U
h9AprQf+M4v+SxSeAne8KRZIsfcNr5fw7JEYRo7BJj2qo8nMEoB87k1MrhgDm1VW
O0Y45E6byCCzV++G5MeP2vZONN4cz0hVWM3kpuZs4xfGF40iXfObs/7wwfnnOdd+
zQ7h/K8NlMUov7QciuKTGqaghLWDX4ERiTZM55adKpyfNwEUch35waQux+Tc9Q8c
10LRaH6GeQ4sXLi4sMT9eN9yhsXsW+pnCGHqG2bE1Mn+GNBYZJJT1OpcJ+evBGMJ
bI8HL/lTJ6mrrxDweNX2TYrHSOMnhCeDVGcZPqvMzFryt5SOmkbUNWwQLVRfryF6
IK/RReiFEHAda7kkLxegrcGrSXl8Ew==
=PsEF
-----END PGP SIGNATURE-----

--Owo6fkmJLecJk/NN--
