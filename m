Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05D62C54C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiKPQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbiKPQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:47:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E15E3DF;
        Wed, 16 Nov 2022 08:44:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 451B0B81DFB;
        Wed, 16 Nov 2022 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1D0C433D6;
        Wed, 16 Nov 2022 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668617052;
        bh=Nc8GXmqJbp7UfwY7PkJLkx/x8A/bzoUp01OtoRt312I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYVs2Z9iQvYDW2RRW5c7a/P0Jl8PlczcLUUj19tNQ6f3+8osJ/Mj/89xlqOMNoy9H
         YIq5BMbvTRWImJ39nj5qdbh2l1pUy6odl6Ct2pG2S/qkqXm1hMR3x/FYjF3vcSlxDQ
         1bfC6VPgf2IbBu+7t+YpT2eba8NyVq1iIqs+xbYcxogD0E8EU2ICUS2oA0L/WAxHaR
         dXyfdsO4JlYRXB8V7KEJI4A0LAbJ0dD5Db8xVMf7XU087LFcwpSh/l0wpFixftW7fL
         YjRv9/LNj6brw2RJqWSYdJK0xdNT5ONAvk17yPPyqXFitvWWVO2iy3L0MStxXO/XWj
         +1t79CGlAIKxw==
Date:   Wed, 16 Nov 2022 16:44:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, tglx@linutronix.de,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <Y3UTVVHiri1xEdi1@sirena.org.uk>
References: <20221109165331.29332-10-rf@opensource.cirrus.com>
 <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
 <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
 <87iljmve87.wl-maz@kernel.org>
 <Y21gwGDb5CFft0kp@sirena.org.uk>
 <87h6z5vs39.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EkEOai4hb/anVZ7n"
Content-Disposition: inline
In-Reply-To: <87h6z5vs39.wl-maz@kernel.org>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EkEOai4hb/anVZ7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 11, 2022 at 08:00:10AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Nov 10, 2022 at 06:47:20PM +0000, Marc Zyngier wrote:

> > > Either you describe the internal structure of your device in DT or
> > > ACPI, and make all client drivers use the standard API, or you make
> > > this a codec library, purely specific to your device and only used by
> > > it. But the current shape is not something I'm prepared to accept.

> > ACPI gets to be a lot of fun here, it's just not idiomatic to describe
> > the internals of these devices in firmware there and a lot of the
> > systems shipping this stuff are targeted at other OSs and system
> > integrators are therefore not in the least worried about Linux
> > preferences.

> Let me reassure the vendors that I do not care about them either. By
> this standard, we'd all run Windows on x86.

It turns out a bunch of these systems are intended to be used
with Linux, and even where the vendor does care about Linux we
also have to consider what's tasteful for ACPI.

> > You'd need to look at having the MFD add additional
> > description via swnode or something to try to get things going.  MFD

...

> > Given that swnode is basically DT written out in C code I'm not actually
> > convinced it's that much of a win, unless someone writes some tooling to
> > generate swnode data from DT files you're not getting the benefit of any

...

> > I do also have other concerns in the purely DT case, especially with
> > chip functions like the CODEC where there's a very poor mapping between
> > physical IPs and how Linux is tending to describe things internally at
> > the minute.  In particular these devices often have a clock tree

> I don't think this is a reason to continue on the current path that
> pretends to have something generic, but instead is literally a board
> file fragment with baked-in magic numbers.

> An irqchip is supposed to offer services to arbitrary clients
> (endpoint drivers) that are oblivious of the irqchip itself, of the
> hwirq mapping, and use the standard APIs to obtain a virtual interrupt
> number. None of that here. This is a monolithic driver, only split
> across multiple subsystem to satisfy a "not in my backyard"
> requirement.

> If the vendors/authors want to keep the shape of the code as is, they
> can do it outside of the irqchip code and have some library code with
> an internal API. At least they will stop pretending that this is a
> general purpose driver. And the existing madera code can also go in
> the process.

Yeah, I'm definitely not in the least bit convinced that the
irqchip code is a good home for this sort of glue (especially the
interrupt consumers) for the reasons you mention - my concern was
more that the firmware interface also has issues, and that
putting things into firmware is also putting them into ABI which
is much harder to do a good job with later.

--EkEOai4hb/anVZ7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN1E1QACgkQJNaLcl1U
h9DPewf8CpoDHHCI0FeSVsd2KhNQL3i/PMHFhg4eDzaVGsgA0IyP1yvktpJ7cS+b
Y4n2L6pA3jUqkU3VtSsXtayGbhBSKxPnMWYIMlquLTu7Kh+09T9djk/XnLokBbnC
V3RWe28DpZEgb+PJ9m5tjCBS9TlrqN0nHq4zpypLxMnJBS34BHweexzeT1O45o4v
7vcHxpbnKjeruo2dXCSXdt1kt3T0DOqsYSkh0l5rsj9mv30mnjUogcwIlTeK/7CF
BRiM9I5rEdpqO+Q656jBVuBafKBVaUlmbmIxuEFHvOYIQ7u4CjDx8pXyTLI1FMXd
N5s5licXyOd59BWkTOMo/uWD16eJZw==
=5F+X
-----END PGP SIGNATURE-----

--EkEOai4hb/anVZ7n--
