Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468C6B4B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjCJPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCJPoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:44:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A9137895;
        Fri, 10 Mar 2023 07:31:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E54B822DD;
        Fri, 10 Mar 2023 15:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2C7C433EF;
        Fri, 10 Mar 2023 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678462312;
        bh=nUzOTuEgT91ilSzmzilIEFK3iqUy+T792nACm/ObXo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVDFRff32CUeg4VYZc0KxwyW7FRibHcCgOsXmEDulirUJ1Y3IyxHc+k5rgu+krn+f
         LBLRHqN5iB4qujARfr6I9K6XSy+CpZYXKc9iBpNeqJgEQjktyxklC051kSVeXuXp86
         JVJvV5eicKe6jDyHOv2homy93sYvRn15szXjW3Tj1/dYeFN8Wt6oinxlLREFqNWcDj
         OiaZHKqvOX2i3j13+TXuGVlappDzZhw+hPOVsmKsc7A50KTP6aUO8ZEAsiAIbyz1QU
         Bmga1n6munzOp/7VgWSY+hRQ5BxxIuDpQJbVN4cUcijREMpgWaikEsXTllWMHmJTis
         IaWc+rpQsCniw==
Date:   Fri, 10 Mar 2023 15:31:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ASoC: Use of_property_present() for testing DT property
 presence
Message-ID: <ZAtNZUifDt/Yl2qp@sirena.org.uk>
References: <20230310144732.1546328-1-robh@kernel.org>
 <a23852d7-c70c-a03c-99fb-b453bdc750a1@linux.intel.com>
 <CAL_Jsq+XBzEMWrz=quxq4TkrejMMFRRvo0UinghmBphtmr=XXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQTqPomgC6kqCvBH"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+XBzEMWrz=quxq4TkrejMMFRRvo0UinghmBphtmr=XXw@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YQTqPomgC6kqCvBH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 09:14:08AM -0600, Rob Herring wrote:
> On Fri, Mar 10, 2023 at 9:01=E2=80=AFAM Amadeusz S=C5=82awi=C5=84ski
> > On 3/10/2023 3:47 PM, Rob Herring wrote:

> > > -             if (of_get_property(ep,   "reg", NULL))
> > > +             if (of_property_present(ep,   "reg"))

> > Bit of nit picking, but any reason, why there are multiple spaces,
> > before "reg" here?

> Only because there was before and it was a scripted change.

Yeah, I don't think there's any reason for that - perhaps at some
point it caused the code to line up?

--YQTqPomgC6kqCvBH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQLTWQACgkQJNaLcl1U
h9Ap4gf9HaaXZcTMkFjkbHzWE/oyzg7IX24irsYTqkShQjQs79+TcFLpH/R2wAJP
D5Op6bvPzyNokg0rlIA1bPuTtJxvAOgboa9LobpsLRNso9ezIW/7c+IXmDfa1ZAB
eWXBs3HN4IXKkDybSV2eyC5e9wckRJQfOAx2OTMeT7AmNs1nWTw4Ls6sIbAKxh4o
osLdFick4HeMgxdZtNeTFr9dvlGqjkh6zR78oavbu132XUlvfqctErcIQ9qh4w7Y
8yGUubnPOeOfr54Z5iT1MgcgLXXiyuziWdWaRGupAV8WqKmf8O0HySGKr1w3IVYP
vyuuWuc++z0Kg8zh15H/vsdrTSVlUg==
=7fFJ
-----END PGP SIGNATURE-----

--YQTqPomgC6kqCvBH--
