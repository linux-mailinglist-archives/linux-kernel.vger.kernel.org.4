Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF0623198
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiKIRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKIRi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:38:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4797C77A;
        Wed,  9 Nov 2022 09:38:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8323E61B8D;
        Wed,  9 Nov 2022 17:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC570C433C1;
        Wed,  9 Nov 2022 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668015535;
        bh=Jhd6aCma2Qjlqkwlxvewothq3IuiiBcixDdKQqWZQoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqHLVc+YYMqqaL3t7XggSXyYKPMyrjib1stj/zXTNiZn4hsSg52BCI1dm18P7Q7H4
         7tbUR/ESyED4uHx8geKe9OSBhNFx6KuLHtkYAcvoulAvCT9E0jlBfUOKkROcb6+GkN
         goCG0aemFGOfx7wXDNHMot0CS1lZO7wHvPDorHpR4CUWa7L9eoWzAma78QdzAicZxp
         m1hxyhoDt6hPPrH84dcpgNDxSvskaaNbh23jyrOSm9xfFQEXdzR4+T5Ge3hMwgla+m
         RsWcoUJagoIdZdhKqLm+8Hejby7fR53WBXpZMZ9olYj/1Iw1Ry+dgnPR2YCx343vha
         iI38/RafASC+w==
Date:   Wed, 9 Nov 2022 17:38:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Message-ID: <Y2vlqatX7dfPJ3Zi@sirena.org.uk>
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120@epcas5p2.samsung.com>
 <20221014102151.108539-3-p.rajanbabu@samsung.com>
 <Y0lPz91gbovAub9D@sirena.org.uk>
 <04a101d8e523$30804b80$9180e280$@samsung.com>
 <Y1KIT4nk7C8SQ45x@sirena.org.uk>
 <01ba01d8f332$44eb3810$cec1a830$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vJpVlYaVMgKIVLqK"
Content-Disposition: inline
In-Reply-To: <01ba01d8f332$44eb3810$cec1a830$@samsung.com>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vJpVlYaVMgKIVLqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 10:53:40AM +0530, Padmanabhan Rajanbabu wrote:

> > > We can overcome this scenario to an extent if we can get a flexibility
> > > to Configure both PSR as well as RFS.

> > Why does it make sense for the machine driver to worry about this rather
> > than having the I2S controller driver configure the clock tree?

> _____           |                  __
> |=20
> |         |	        |	             |   \
> |
> |CMU|	        |	             |     \
> |
> |FSD  |-  |---|-|--------->|       \        _________    _________
> |
> |___  |    |    | |op_clk0|         |      |               |     |
> |             |
> 	  |    | |	             |MUX|----|  PSR       |----|  RFS
> |--cdclk  |
> 	  |    | |              |         |      |_______|     |_______|
> |
> 	  |    | |--------->|        /
> |
> 	  |    |  op_clk1 |      /
> |
> 	  |    | 	             |_ /
> |
> 	  |    |___________________________________________|
> 	  |
> 	  |-----> To other FSD SoC Peripherals

> In FSD I2S, the clock source is not an independent source but a common cl=
ock
> source being shared by many IPs in the same domain.

> Changing the clock tree will impact other IPs in the domain as they are
> dependent on the same source for functionality.

I'm not sure I follow.  Perhaps your diagram is unclear but it looks
like PSR and RFS are both after a mux which appears to select which
clock is going to be used by the I2S controller?  The usage by other
clocks appears to be upstream of the mux and dividers.

> We can understand your point to bring the PSR changes under the I2S CPU D=
AI
> driver by adding a separate compatible and data for the FSD SoC. But If we
> take
> the example of existing sound cards such as sound/soc/samsung/tm2_wm5110.=
c,
> the op_clk is supplied via external audio pll to the controller and PLL
> configuration
> is taken care by the sound card. Since the configuration of PLL is more
> specific to
> the tm2 platform, it makes use of the flexibility of changing the RFS and
> BFS
> using the sysclk and clkdiv hooks provided by exynos7-i2s CPU DAI along w=
ith
> PLL tuning for precise sampling frequency.

The big reason for the clocking control (and indeed having a custom
machine driver) with the WM5110 is that it has multiple clocks to
control and a good deal of flexibility with placing them in clock
domains and so on which have power and performance impacts.  It's
frankly a bit unclear to me if the CPU I2S controller even needs the
bitclock configuring given that the clocks are being driven by the CODEC
there, but regardless it's not clear to me why the I2S controller would
need anything other than the input clock to the block configuring?=20

> Similar to the above example, the choice of clock source under discussion=
 is
> not a
> limitation of exynos7-i2s controller, but instead is a limitation on the =
FSD
> SoC.
> By using the proposed change, we can ensure that the exynos CPU DAI driver
> is
> giving additional hooks similar to existing hooks for BFS, RFS and CDCLK
> direction
> so that sound cards can use snd_soc_dai_set_sysclk and
> snd_soc_dai_set_clkdiv
> to customize the same.

I'm still not seeing anything that articulates why pushing the
configuration of the dividers within the block into the machine driver
solves a problem here.  Again, what's the upside to configuring clocks
that are purely within the block?

--vJpVlYaVMgKIVLqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNr5agACgkQJNaLcl1U
h9Aa8wf6AtuTJerKp9o05gCs7egH+tVbReZ3DrGcTxoejtlSSUPw7JySho88VBSn
VxEx9NUF+oL1nxUZOSbSmPdZfVD0uysuFnoenUvCf0VYOR2MhRVqXJH8huPDaDYG
7In86Zog3gWu4bCGkKaxLRAxUkf7Jp+46bDbZiE8a0TOFZbGL5WNJoj56xVs3ZR7
UHF08nRupMRBdLi8iE4T4mn7+/F8L5S3bXFUlZNc74eeVo91rfARXb1xVUtse39x
bJK0QMRx3RgA7vpnCDftzk4bYvVY7Gf8CGIvLMGMQpHE8Y5YNZicdhah47hEVPvB
3gPf+6fw/Qxa4oCotwNGY8B/yaXyPA==
=P1ty
-----END PGP SIGNATURE-----

--vJpVlYaVMgKIVLqK--
