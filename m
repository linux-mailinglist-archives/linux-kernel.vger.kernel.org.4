Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A772CB08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjFLQIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFLQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:08:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B85184;
        Mon, 12 Jun 2023 09:08:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AFA915C00ED;
        Mon, 12 Jun 2023 12:08:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Jun 2023 12:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686586114; x=1686672514; bh=W+
        YWxGp0s8MCc46uj4nZtRkd1oBYUkXrjQhs8ESEEQs=; b=lQ84EBnrnEFLLArYhg
        KsEmEXaKOxSwV1MuMTAniXYY+QYr0rhif9o2fgXzfdEUUTqRhIFH0ObSUuZOaKX2
        6OuWBtgWEXllJyMjO1jL3vUxojFs4xmQKnq+sgvz0LISyPVG7ezEpol5cEijyg5k
        IdtfNwWZ5+MIPcvczAZMryFhKfpOz+nJWT+azDGZZXRr8oVbmnrg0Mof/KTPdw+k
        DowtNR2zIwlMFcd0TYxsnQeCSfQDth+Ziryi/xcJN7OVEwjnXXwW8fVBNdghCp7x
        KL44Fmca0eWUpYfRVff51I6gQ/MmLaYkxP8ocMoEEVB9tLMHzTO3rKl2RL6NPlEX
        w+Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686586114; x=1686672514; bh=W+YWxGp0s8MCc
        46uj4nZtRkd1oBYUkXrjQhs8ESEEQs=; b=PvKkVhdcibjKTZTG4cGj0VlCC3GQx
        4/9r3/696JT7RuNWLm+79nP5Wfd0suxjliKsGlvd1ndUd4/BsKqZ1zVFsob4ZyYO
        Dw6mChv59u9xUWroTXE04gSSQmvCgrNIZ7jCWEf+pcf/GRtICeZuA/w8rdthdthX
        ExKn5y90KVsn933LEWY/xnhQsc9ob5i0n/IXVOkF1BZ8VmoSMkLf7zN694A1dTbS
        IZRq54JkS43QE+EDKG3IOgKEPsShnfDR0UGdEn+1A7dpxNC1qTbCncb2nn8vHKbv
        XZ2Ey2YkD1cCIkEHVSxMU+vYSVAulhCNAjP/jVcdIEBNvdAXVIDg8VMzg==
X-ME-Sender: <xms:AkOHZByHa2b9VPttPclVKZa9QCvCgGsHxT6tydlQ43yvfjdnI5Zkgw>
    <xme:AkOHZBTL8VRoQmFgctWa8KxXCaGMpmYiqcyEx5bKOMgXsuW6ZsQwsBy3OUBTpSqwY
    jL487cqNtrkd0yPuOM>
X-ME-Received: <xmr:AkOHZLXHN-0TFkWZcalXdwdLBWXyEfWhpKYIKicK1-xTFaYQyVMWvORJhpSkKt1-KQVqbd0B52iME9NEk5iGKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeludefgeduheevleejiefgheetvdffheejvdejvefhudeuveehueevvdev
    veeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:AkOHZDgS7HOUZvUTc6V2hpFJrCXN3uBruonBfa_DP08GRTMuAWhsVg>
    <xmx:AkOHZDDWxQvoc5gNXHei_cnskpcWZSs16YNB9bHunRUEeaO0svkulA>
    <xmx:AkOHZMLu0VbyvvNTGTtJLWcsRG_1kDoPocd0W2iAGfbtXXLsKeWXpQ>
    <xmx:AkOHZH5ONNZ0lNHVb4bdLt7hWjGXAqpeSOyDIYb2oee2eBg9ufDcyA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 12:08:33 -0400 (EDT)
Date:   Mon, 12 Jun 2023 18:08:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
Message-ID: <jlcpkn3pewnvdpugwmsrb277u4fzcns5eodnoxhlbkwtaf7pyc@u6vozmm7zl62>
References: <20230506195325.876871-1-aford173@gmail.com>
 <CAOMZO5AwixYybR1am=V4m1AnTkum+0Wn0xegU_y6Po9Y--G0mA@mail.gmail.com>
 <CAHCN7xLPKa2hrBMC1kaJkxVL9NC+c1TWgcQHMBPefnvxGPTCwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajqijpm7yca5ohr6"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLPKa2hrBMC1kaJkxVL9NC+c1TWgcQHMBPefnvxGPTCwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajqijpm7yca5ohr6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 12:02:42PM -0500, Adam Ford wrote:
> On Tue, Jun 6, 2023 at 1:45=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
> >
> > On Sat, May 6, 2023 at 4:53=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > Currently, certain clocks are derrived as a divider from their
> > > parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> > > is set, the parent clock is not properly set which can lead
> > > to some relatively inaccurate clock values.
> > >
>=20
> + Maxime
>=20
> > > Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> > > cannot rely on calling a standard determine_rate function,
> > > because the 8m composite clocks have a pre-divider and
> > > post-divider. Because of this, a custom determine_rate
> > > function is necessary to determine the maximum clock
> > > division which is equivalent to pre-divider * the
> > > post-divider.
> > >
> > > With this added, the system can attempt to adjust the parent rate
> > > when the proper flags are set which can lead to a more precise clock
> > > value.
> > >
> > > On the imx8mplus, no clock changes are present.
> > > On the Mini and Nano, this can help achieve more accurate
> > > lcdif clocks. When trying to get a pixel clock of 31.500MHz
> > > on an imx8m Nano, the clocks divided the 594MHz down, but
> > > left the parent rate untouched which caused a calulation error.
> > >
> > > Before:
> > > video_pll              594000000
> > >   video_pll_bypass     594000000
> > >     video_pll_out      594000000
> > >       disp_pixel       31263158
> > >         disp_pixel_clk 31263158
> > >
> > > Variance =3D -236842 Hz
> > >
> > > After this patch:
> > > video_pll               31500000
> > >   video_pll_bypass      31500000
> > >     video_pll_out       31500000
> > >       disp_pixel        31500000
> > >         disp_pixel_clk  31500000
> > >
> > > Variance =3D 0 Hz
> > >
> > > All other clocks rates and parent were the same.
> > > Similar results on imx8mm were found.
> > >
> > > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to =
determine_rate"")
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
>=20
> Peng / Abel,
>=20
> Any suggestions on how we can move this forward?  Looking at the
> clk-composite-8m driver, imx8m_clk_composite_compute_dividers uses the
> max values which is basically what my patch does.  There was some
> discussion about making determine_rate mandatory for muxes[1] and this
> patch should help with this in addition to making it easier to sync
> more video resolutions on the 8m Mini and Nano.

Those patches have been queued by Stephen for 6.6 :)

Maxime

--ajqijpm7yca5ohr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIdC/wAKCRDj7w1vZxhR
xT/rAP4168IzGe2wqB54UUm22nZTtuYMnl/lAiS5Wi3B+hk/1AEAlqeMz2Pzqosb
52WoBukifs1i73ziJij3UsJte2R6fwo=
=tAUo
-----END PGP SIGNATURE-----

--ajqijpm7yca5ohr6--
