Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC746247AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiKJQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiKJQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:55:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECEC1C924;
        Thu, 10 Nov 2022 08:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2FDBB8225B;
        Thu, 10 Nov 2022 16:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D424AC433C1;
        Thu, 10 Nov 2022 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668099312;
        bh=qGC1ASd6YLdkSOCo/KqD1UYwY3TeafFhoJvfxCxFnCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQfDlf5BK4dJHrVFk7IehyY8tj2sKalFuTIQ8MsSJm8HyNTdGinzsLiF+ZNP2OafM
         Bcit/JIOEkqOIWCdSyRlXpJylL/LDBbIv9cBuokUY+24W+uKmh1w2upF3C9i3waZ8L
         3nFD3Wl6lWqALhoqL8XXbwqEb45+WrkCOxxUUII/Cuwe4luzs2ynwwMD2dL6a6zemQ
         wTKxrwwHnQABWCeRHtBKDECDTmandtAh16d3/l4uditCnXFRu4wvitEIS1/CN1/Qa7
         cw0pvWYlau2dq+CUvxgtQsj356diXO0Vn46GN8P6qUGxXm2h2S4hxSjYiOr+cfzKMh
         o9tXfEdLYOGyA==
Date:   Thu, 10 Nov 2022 16:55:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Marc Zyngier <maz@kernel.org>, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        tglx@linutronix.de, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <Y20s6UCsYyB+/nfK@sirena.org.uk>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-10-rf@opensource.cirrus.com>
 <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
 <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpzSAZ/C+hH7f6Oc"
Content-Disposition: inline
In-Reply-To: <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
X-Cookie: Torque is cheap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpzSAZ/C+hH7f6Oc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2022 at 04:31:06PM +0000, Richard Fitzgerald wrote:
> On 10/11/2022 15:13, Marc Zyngier wrote:

> > > If we put them in the MFD with DT definitions it would make a
> > > circular dependency between MFD and its child, which is not a great
> > > situation. If it's these handlers that are bothering you, we could move
> > > them to the audio driver.

> > And what's left? Nothing.

> Ah, I see. You've missed that the bulk of the implementation re-uses
> existing library code from regmap. It does say this in the commit
> message.

>   "the generic regmap_irq functionality is used to do most of the work."

> and I've also said this in previous replies.

The thread prompted me to have a look at regmap-irq earlier today and
see what it's still doing that peers into the regmap core internals and
it seems it's just getting the register stride which has had an external
API added already and getting the device for the regmap.  It should be
straightforward to repaint it and move it into the irqchip subsystem
which would be a much more sensible home for a library for implementing
irqchips in this day and age.  I started looking at the code changes for
that a bit.

> This is no way driver that does nothing. There's over 1000 lines of code
> handling the PIC and dispatching its interrupts to other drivers that
> want to bind to them. It's just that it makes no sense to duplicate 1300
> lines of interrupt handling code from elsewhere when we can re-use that
> by calling regmap_add_irq_chip(). That gives us all the interrupt-
> controller-handling code in drivers/base/regmap/regmap-irq.c

TBF that's 1000 lines of overly generic code, a bunch of it is
conditional stuff and it's unlikely that any individual driver would
want all of it.  Equally it does mean that all the users are just
providing data rather than writing any code which generally makes things
easier to maintain and was the main goal.

--IpzSAZ/C+hH7f6Oc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNtLOkACgkQJNaLcl1U
h9Czzgf+MDPNrKaCh6tGeXTVbFjlxx2mex0I6klShYbJTgtJXdJl+8Yqy82h0XI8
TZOB30riAERaTu61UvhbFFKADZfg6KSSLqRY9F0aloY7KWA+Lo6tCPZ4VrDCKxvs
yAk5rWlbfN2QUS0Sd0+1N8E/8IQql3OPCUx4/2OXN1h0hnppTwkFsY5Zbres+PJO
Aw/PhihEP74ddp7mp6W85hTn6+rol8pluzJJCTVBC70myEG2hppTcMKzN0r9cNqR
z2/+nz3aIO0BE65HI7/yB+fNegixinMAiZRGoiYfHj4ubdrYnbw5O1WBWAVG7gSq
DZoqpARh4bX8hFAkkjbUsBh9pQP9gA==
=zQ3R
-----END PGP SIGNATURE-----

--IpzSAZ/C+hH7f6Oc--
