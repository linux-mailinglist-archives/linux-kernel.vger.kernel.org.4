Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A582972E565
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbjFMOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbjFMOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071110F9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603D862CFD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF51C433F0;
        Tue, 13 Jun 2023 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686665400;
        bh=o8EXcZWP6D1fQmLjGg+FvASyQnglX4HVwqy+2to6C5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkhlScchy90wqe2imcplxeuot/NZH4/9ZSLT8qBW7xXfORudVmTSO1AwJ88xQ+fSu
         xJ257XjyRIx5GnZbgDvzeoOiyB7nKD4ofBrQggq25FTL2wPW7kKqabLRr+Q126fygH
         4MNbg9bAsuUHGLd8SCzW0xvRIy0BmQMvZ2pqaG0Obj1lqBX2M310jtHvrn8yGF9g46
         sxpssiEl9bX2JGCxD28Ep3mYvpwqPGonhtdwP31h48gZVZeZ9jrHN+roXmt43uTP1c
         JMt7atwh39UbKdC9RaiGc+ZSsdT1IVYxmaHbUjZCP1QHzzgK0kXSDmKJ/aO8NCa+Sy
         dyMoY5i4gVuBA==
Date:   Tue, 13 Jun 2023 15:09:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
        mastan.katragadda@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: correct pm_runtime enable sequence
Message-ID: <317a0f1b-94a7-4bd4-9f64-8877e0552b6a@sirena.org.uk>
References: <20230614003206.933147-1-arungopal.kondaveeti@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t1NPVEr5bJW1JzkT"
Content-Disposition: inline
In-Reply-To: <20230614003206.933147-1-arungopal.kondaveeti@amd.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t1NPVEr5bJW1JzkT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 06:01:59AM +0530, Arun Gopal Kondaveeti wrote:

> Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> & pm_runtime_set_active() in pm_runtime enable sequence for
> dma drivers.

This says what the change does but it doesn't say why the old sequence
was a problem and the new one is better.

--t1NPVEr5bJW1JzkT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIeLEACgkQJNaLcl1U
h9AlkQf+IKLQ0NDoQi6rzDHjoOd3/5jO3kp/pibHdhq77SZ6JH2dDmTM/+VA8G1P
fr3LNHwXk6Xkahyn5xA7+eL//sAZTozBpbFcd2BZuYYawdETKIQFYhX7z8U00PpW
EyAi4H9Ek9C5nYd6JrQmY7gVCuir2aoE5Dw5kMQwxIRMvOvnJM2dtuMMUUQQ31nE
iG1PBYX05Cua2DLQyJD5cmoaQjOL4EieVYFXl+ptMUBW4NS48OVpIfH+Nr7Ic7o2
1gVJm8vcUOqkR9w0x/2fdLE+WsK3CBRx728IijLhFg86QfPiZhkfiSfoLjJzsGPd
LHgy5hqjp2RWkt/DxGDo5yh3jwb4QA==
=B8SW
-----END PGP SIGNATURE-----

--t1NPVEr5bJW1JzkT--
