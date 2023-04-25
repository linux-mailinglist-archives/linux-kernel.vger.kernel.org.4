Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06C6EE431
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjDYOrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjDYOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:47:00 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006C26BD;
        Tue, 25 Apr 2023 07:46:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 07934582407;
        Tue, 25 Apr 2023 10:46:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Apr 2023 10:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682434013; x=1682441213; bh=en
        1RVV51OfqfCNU3FiRu/BosXNaMgZdQKojjPV9z+Rc=; b=fQzHTOZ6paF2GmxznV
        Yv4EqX4UawQN8UDH75BiX1XxbOrFyU34s885PjMpGmyFMhfA2Gsr+GJx6hMQ05IV
        0gJ+lU3HbK6G0vkyPFGb5q6b03Ka/Q4k6BOLyanUIeemgQyB0Ih17ta8J99y/cug
        hpRzOQ0KZRKhiCAUBGW5XcWVmf6BFlMx5FwlMlfY5UXqPWl0BcywSTzuBly2UEjc
        h7AU70R3O5OqjWix8REwSV3sblDjCOI2srd7fKlv5IWutajBwGjvCxdr76mhCs9N
        qkjPjTojtlO9cHj0dmUJuooH30DNVLAGbFufLHaBIbG9LKaU3ZUUmQji0imf2S/V
        N9aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682434013; x=1682441213; bh=en1RVV51OfqfC
        NU3FiRu/BosXNaMgZdQKojjPV9z+Rc=; b=I4t0FWm0dd6OFi2aSkWgpBABu+oaf
        WqgmyEJsiXORvFRmbJmFTqpY0AGTB7ZiQOFWetUU/JNxbjy4awAyYQ4JFunU6fQf
        Rz+Oo/78vsrhL7Xkd8XgDdzZc58Sn+bc2bhSNb9apFI6z32c4uxp7Jb7/JF84hLo
        50q5CCLpg7WyRTIQ/jjJak+lY0QtglRaq5zbBVpM7F0ejZDuJ3Jty6mNptPCS4lH
        IAavcbAaVhI2BTifppMGXs2pXMyXaUtNaP1H9y8Nfjphg2Obw5TFmGQit0AgN9sQ
        e6tJfBVMAZW+5CiaANrEmAqkn2M7v02jYqf1Ma7CXd24tcB0Zncp/Xktw==
X-ME-Sender: <xms:2udHZFwZ_QIiF6SL-QlmC_Lewd6M6MaNvyZn1MfROHTcLFhUquQfCw>
    <xme:2udHZFSQUhtCOxwN2fiIy3C_t4pC3IVp_h6i1PqECr5h6skrj7BGyl2fDN84P5jZV
    ibCEta40AdQ2KE4Rb8>
X-ME-Received: <xmr:2udHZPVDo6xGsCdHJlh86bbHJAp8xNFq-UiRmarNnxxDS1F3L26uiLFS8bOwjYUZsR7ELMSYtIqVyZm7eHacuuXL5xIZwXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2udHZHh5UZHEMBw8jN195wMlo8i_gan7Xb4fMuWhW1OoxPCppna0Zg>
    <xmx:2udHZHBMtlk6pfPmyMwPAprlvh-iE56gRWWUWOQmEoL8Gji1fZrb8g>
    <xmx:2udHZALIcRP02Uga96xJwRNOAbOCCE-tsfoPqljmdqRavM_KDfchpg>
    <xmx:3edHZBNJxelcn1gOxFFPqvUDnAdocnUy8ZCixw6-Tz1yPY9Rt8skdg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 10:46:48 -0400 (EDT)
Date:   Tue, 25 Apr 2023 16:46:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Lechner <david@lechnology.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jaroslav Kysela <perex@perex.cz>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v3 00/65] clk: Make determine_rate mandatory for muxes
Message-ID: <3nwpjtfa46zorfpuvvugximqe5qmovff76dqphoxbndr6mczcc@ndau7cegfxb2>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <636b8f855b6009ba068010e00c20e7f5.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75sfg4dfrxr3i5xc"
Content-Disposition: inline
In-Reply-To: <636b8f855b6009ba068010e00c20e7f5.sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75sfg4dfrxr3i5xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 02:44:51PM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2023-04-04 03:10:50)
> > Hi,
> >=20
> > This is a follow-up to a previous series that was printing a warning
> > when a mux has a set_parent implementation but is missing
> > determine_rate().
> >=20
> > The rationale is that set_parent() is very likely to be useful when
> > changing the rate, but it's determine_rate() that takes the parenting
> > decision. If we're missing it, then the current parent is always going
> > to be used, and thus set_parent() will not be used. The only exception
> > being a direct call to clk_set_parent(), but those are fairly rare
> > compared to clk_set_rate().
> >=20
> > Stephen then asked to promote the warning to an error, and to fix up all
> > the muxes that are in that situation first. So here it is :)
> >=20
>=20
> Thanks for resending.
>=20
> I was thinking that we apply this patch first and then set
> determine_rate clk_ops without setting the clk flag. The function name
> is up for debate.

Ack, I'll send a new version following your proposal

Maxime

--75sfg4dfrxr3i5xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEfn1wAKCRDj7w1vZxhR
xaSaAP96/77zpjIZ1yxHOKTWolPnSBrvZZStILbYFUHTfnf4ZQEAy9TnDb76xLC+
cV82CRmIHcP1MQoDgnjetPo+R14sLwk=
=xg1X
-----END PGP SIGNATURE-----

--75sfg4dfrxr3i5xc--
