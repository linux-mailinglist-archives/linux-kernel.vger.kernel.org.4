Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9D72DC54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjFMIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjFMIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:23:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F81AC;
        Tue, 13 Jun 2023 01:23:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CC125C00BB;
        Tue, 13 Jun 2023 04:23:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Jun 2023 04:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686644624; x=1686731024; bh=/C
        dbbkQw2JgvECapcYhzDdCpNmrXlO/cyqRMfqJjWFQ=; b=ns8G9UmRINxWqsG+A/
        56bLukbhzJVd2XOQEgXFwVwHDUxB7JKJdwTQfUOuEqn+eli2+/dB7r5b4E4WzX/q
        FfgMIwdcv6QSD57QuQtHnEUmCCo55NTvlfR2r/w/LARkXMybgbOCLUMlOore5wyy
        LkZgClN/MH3JPc+LS+I0Zh0b/Jt05uqBaNCtCgWnqjXe71Ja0N4P6k10kSbTz6vT
        BXXrDyCwTTkkjGpFL/btQlJgyF/nDX/nt9x4JKfs9mXvYtdJHTnPRGF03RmnE7wg
        MsHuMkTgtUCYgkabgpU2h+hlEBTbhQoI9WCORU9d+ytMZt6i3sOwQSEQ6+ejaTdh
        Yz+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686644624; x=1686731024; bh=/CdbbkQw2JgvE
        CapcYhzDdCpNmrXlO/cyqRMfqJjWFQ=; b=DVcPvl6v5rSDVR/UPtFzDzPUS9dEH
        sRp/SqgGyFoTHzrMQNDGoXhKKbKspjaRw8VL+WFDe8TCgqCQFQXsMJKsI5gNMJ7S
        BFxdu9pfIBD6+y/0LaQPDhG6hWM54QNtU+3BcpUCtlt6S2hDG39afNiCj/X7AEeN
        lrELR4FYsJPPeSkLnXC2IA54aIEAe8Dib+LOJzJ3x6uY8AMVjYCvqzl/cHHcqkWY
        hkEIzlsEl6BS874LX8ngrXH3jurQz8sFAYolzqMjH0mT+CCWgsMi9EhuCrPnBsHK
        8pgdiwX/DrCSY6wAzNWYU7CDEMghWKP9VMJMwt0GMYDvIYvFWaafLC9cA==
X-ME-Sender: <xms:jyeIZIG22ODEGbZ8iBL8gy4zFIpZPj43NbDMvQsn739oACSm7xvkcw>
    <xme:jyeIZBW3H9UBjtSVQmWZF7ofP4SfvHbFRebt-gfq9rsTCLmeGUHuy7MNPbNkGXvem
    nTg-395LRofbvucWsk>
X-ME-Received: <xmr:jyeIZCIqujFr2N7uWdPLyYE789WGPchGEuCgN0bKJlCSSv0ckP4BacYVZ6EiDUU47cjk8-2ibqpH-fvVk3_g6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduiedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepledufeegudehveeljeeigfehtedvffehjedvjeevhfduueevheeuvedv
    veevueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jyeIZKHoWQbrNo3mvxXQ6R5ELOs84cyyxI38pwz3S-sXaxGMQHlCjw>
    <xmx:jyeIZOV2-MnfdQ0cyvTkvTm-5opKHxGbM-syC2NZ74c6uJSFC7nVJA>
    <xmx:jyeIZNP5nuswWJUjyqO7Va5pZ282qX02Q3pv7G-mCPXTtk0cBPZ4hQ>
    <xmx:kCeIZPvTepcw35kkxwFKQCZSav8fUwN_ZSryIhJtxaUoucVyjJxRsQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 04:23:43 -0400 (EDT)
Date:   Tue, 13 Jun 2023 10:23:42 +0200
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
Message-ID: <7j2zd5aszxenphluy7weslzrjkg7nglymcukxxv2xhbt3z2lql@qifooseclzy6>
References: <20230506195325.876871-1-aford173@gmail.com>
 <CAOMZO5AwixYybR1am=V4m1AnTkum+0Wn0xegU_y6Po9Y--G0mA@mail.gmail.com>
 <CAHCN7xLPKa2hrBMC1kaJkxVL9NC+c1TWgcQHMBPefnvxGPTCwQ@mail.gmail.com>
 <jlcpkn3pewnvdpugwmsrb277u4fzcns5eodnoxhlbkwtaf7pyc@u6vozmm7zl62>
 <CAHCN7xKuvkBHuDBiprsXg3hX+P6Y+ciKSZMcauU=5Y-REwjE=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nwyrv6kg3riqg7ne"
Content-Disposition: inline
In-Reply-To: <CAHCN7xKuvkBHuDBiprsXg3hX+P6Y+ciKSZMcauU=5Y-REwjE=A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nwyrv6kg3riqg7ne
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 11:11:21AM -0500, Adam Ford wrote:
> On Mon, Jun 12, 2023 at 11:08=E2=80=AFAM Maxime Ripard <maxime@cerno.tech=
> wrote:
> >
> > On Sun, Jun 11, 2023 at 12:02:42PM -0500, Adam Ford wrote:
> > > On Tue, Jun 6, 2023 at 1:45=E2=80=AFPM Fabio Estevam <festevam@gmail.=
com> wrote:
> > > >
> > > > On Sat, May 6, 2023 at 4:53=E2=80=AFPM Adam Ford <aford173@gmail.co=
m> wrote:
> > > > >
> > > > > Currently, certain clocks are derrived as a divider from their
> > > > > parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> > > > > is set, the parent clock is not properly set which can lead
> > > > > to some relatively inaccurate clock values.
> > > > >
> > >
> > > + Maxime
> > >
> > > > > Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> > > > > cannot rely on calling a standard determine_rate function,
> > > > > because the 8m composite clocks have a pre-divider and
> > > > > post-divider. Because of this, a custom determine_rate
> > > > > function is necessary to determine the maximum clock
> > > > > division which is equivalent to pre-divider * the
> > > > > post-divider.
> > > > >
> > > > > With this added, the system can attempt to adjust the parent rate
> > > > > when the proper flags are set which can lead to a more precise cl=
ock
> > > > > value.
> > > > >
> > > > > On the imx8mplus, no clock changes are present.
> > > > > On the Mini and Nano, this can help achieve more accurate
> > > > > lcdif clocks. When trying to get a pixel clock of 31.500MHz
> > > > > on an imx8m Nano, the clocks divided the 594MHz down, but
> > > > > left the parent rate untouched which caused a calulation error.
> > > > >
> > > > > Before:
> > > > > video_pll              594000000
> > > > >   video_pll_bypass     594000000
> > > > >     video_pll_out      594000000
> > > > >       disp_pixel       31263158
> > > > >         disp_pixel_clk 31263158
> > > > >
> > > > > Variance =3D -236842 Hz
> > > > >
> > > > > After this patch:
> > > > > video_pll               31500000
> > > > >   video_pll_bypass      31500000
> > > > >     video_pll_out       31500000
> > > > >       disp_pixel        31500000
> > > > >         disp_pixel_clk  31500000
> > > > >
> > > > > Variance =3D 0 Hz
> > > > >
> > > > > All other clocks rates and parent were the same.
> > > > > Similar results on imx8mm were found.
> > > > >
> > > > > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support=
 to determine_rate"")
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >
> > >
> > > Peng / Abel,
> > >
> > > Any suggestions on how we can move this forward?  Looking at the
> > > clk-composite-8m driver, imx8m_clk_composite_compute_dividers uses the
> > > max values which is basically what my patch does.  There was some
> > > discussion about making determine_rate mandatory for muxes[1] and this
> > > patch should help with this in addition to making it easier to sync
> > > more video resolutions on the 8m Mini and Nano.
> >
> > Those patches have been queued by Stephen for 6.6 :)
>=20
> One of the patches in the older series was reverted, but this was to
> address the patch that was reverted.

Was it? I haven't been cc'd and it doesn't seem to be in -next either?

Maxime

--nwyrv6kg3riqg7ne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgnjQAKCRDj7w1vZxhR
xeECAQCW6BrJCTYOwaTtOLoq9I6KrLKDuhOEnpgjdPNxMnDiMwEAm1AJbnoZRKG+
3MpnJ+ukedK/884Qm9erqEyS+2oQxAo=
=HR4v
-----END PGP SIGNATURE-----

--nwyrv6kg3riqg7ne--
