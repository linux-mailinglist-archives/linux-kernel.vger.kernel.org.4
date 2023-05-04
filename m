Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846636F7059
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjEDRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:01:35 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD030C0;
        Thu,  4 May 2023 10:01:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8758A5803C8;
        Thu,  4 May 2023 13:01:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 04 May 2023 13:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683219691; x=1683226891; bh=92
        1YgmgJDyX8fTpEjsf680K9b88j6xKzseERDrln0VI=; b=UYj68jiu63Xrv9446C
        U+7U9vT/DXuEOuF3C0zduG+D5WwodyQMk5zwxbNyx6IQ/IHLcFFKytQ58Niabyii
        HVter6AnK4ozGstpWcb5IyV/Epexltg5yOm/kFrPSmr4yj5YIzaeiVlfA1JjwN+q
        eZIFziOXq/OXFg/9YSOYo2OZTG7PRgSnfuJ/SjE7Y4ew/Bj25quWLuh/t0BdQ1nN
        gr29J1wULKDJhJMUQ5sC6VZCQ0LmvT5mvjrh1ge/K441JeWExDM+jU8TvC9BbaI7
        FZBNgnpNSIK7wXulqF9ONHUxtHhw/a67TW9cQwyucpsYz4ig7GrlTNbCH5W9yCeh
        W5gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683219691; x=1683226891; bh=921YgmgJDyX8f
        TpEjsf680K9b88j6xKzseERDrln0VI=; b=WZAQbTl4KhdIBGFggnepbC24ozON+
        Y9P7RamUUn7KUOWfYKgsofJKMU48g+a442uJvpwU3eSyLQOp4GW03QHV/nxVQUZy
        kwx1JFK0G0n3OX0QxctPhaenfPjSDIRHfhQCLLL2k/1SNkO0+tdr2ePUDWuuQElv
        hAIWgE5sxPtyjiqrYoW9Xzd1CGRPuuuJqVj0jqU1tNQgYccAk9hmIGX4ChAah8ut
        YyPTN1JU564F6RHSmzHnxPcTGjFo5Vzs3IXod7C95xqFT6q0ULFQe2gA2K8RFkeH
        AkTeomH/mAn/3XjfXDtpF5l4Y14mA6UOEaSmMPu86fbGpwwMJ8npfGAjQ==
X-ME-Sender: <xms:6eRTZBd0Ca4UchpFkmcVRifBZTiLzDjaNYIL7ROKZYaoG-tDG7sJzw>
    <xme:6eRTZPMzfdcnM01gMAo4h9ncJjXV2G6Nnz_K08C0TtkeGA9U0GpVI924kPDOXLzG1
    o3H35qXB0mAKR_nHJo>
X-ME-Received: <xmr:6eRTZKjIX9LfZkO66qX4gILAEZHe-iK55SIBd3aO1CEJWIS47IOXh50_YQkpM_GGYDtiztC_5PPESExggI7WAxdKyZmWwh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeftddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6eRTZK_L0pD3f9C6mQznCyuZW59l3sB-Df_ouW1uu_huJ9lMp9fZrQ>
    <xmx:6eRTZNu3V9DGdTelUE-VIZ4R-xjzfJTdBioowM4FVQ2sC0il4NTMOQ>
    <xmx:6eRTZJGmUm2SjMFMmFm9mJ4FpEruFnIuKFeUcXhEvcHdHm2GnQML-Q>
    <xmx:6-RTZB2mU23ipge8XMotfaWkDt4t3YRIYZvJ9OpnSv1sp4-zCY_M7A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 13:01:27 -0400 (EDT)
Date:   Thu, 4 May 2023 19:01:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Abel Vesa <abelvesa@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 43/65] ASoC: tlv320aic32x4: Add a determine_rate hook
Message-ID: <leuxcmkwyb6k77oh47jcpcyp3dujy5f7gjijvkaxjz6gy5im3f@c4kvrnq6auug>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-43-9a1358472d52@cerno.tech>
 <01f32440-8dd2-4030-9006-a3123be55845@sirena.org.uk>
 <erm4iq3mygnrr4h2gd5cag3sfuovv47ibdqsbmxcfabngvnwy4@z63ksvj55zuu>
 <fcc11e4d-eba6-4eff-b3e5-9488a4da84c3@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="co3427ienkolccfs"
Content-Disposition: inline
In-Reply-To: <fcc11e4d-eba6-4eff-b3e5-9488a4da84c3@sirena.org.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--co3427ienkolccfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Apr 05, 2023 at 04:34:31PM +0100, Mark Brown wrote:
> On Wed, Apr 05, 2023 at 05:17:21PM +0200, Maxime Ripard wrote:
> > On Tue, Apr 04, 2023 at 04:26:18PM +0100, Mark Brown wrote:
>=20
> > > To be honest it's surprising that we'd have to manually specify this,=
 I
> > > would expect to be able to reparent.  I suspect it'd be better to go =
the
> > > other way here and allow reparenting.
>=20
> > Yeah, I think I'd prefer to allow reparenting too, but as can be seen
> > from the other reviewers in that thread, it seems like we have a very
> > split community here, so that doesn't sound very realistic without some
> > major pushback :)
>=20
> For these ASoC drivers I think we should just do the reparenting,
> they're very much at the leaf of the tree so the considerations that
> make it a problem sometimes are unlikely to apply.

I'd still prefer to remain conservative on this series and try not to
change the behaviour in it. It's pretty massive already, I'd like to
avoid tracking regressions left and right :)

Would sending a subsequent series that would do this acceptable for you?

Maxime

--co3427ienkolccfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZFPk5QAKCRDj7w1vZxhR
xYK/AQDT76loaORROKC2ghqyIIHmBg+xw8VB5nThUFKuIO4RhgD9ERaCF31CTPdE
PdgL4dyZrWlQGqGmbyHbk465s505Jww=
=OlOa
-----END PGP SIGNATURE-----

--co3427ienkolccfs--
