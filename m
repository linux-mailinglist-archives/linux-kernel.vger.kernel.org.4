Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F116A72DD71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbjFMJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbjFMJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:16:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E91B3;
        Tue, 13 Jun 2023 02:16:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 65FA45C0065;
        Tue, 13 Jun 2023 05:16:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Jun 2023 05:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686647787; x=1686734187; bh=Y0
        ahhceEFkOrWNGEf1B3K7FfOu/yMcR4EVDU/x3+V7k=; b=C3viU2lPrFX3VNsni/
        C2386cky6BCk6PBJnPRmcJsBvTLSjP+Frph7g5k6GGnkAT4OIcUh95OZF7dLiHj5
        6NSSan11/rbWnTkSgltLeDUvjgunaVPxQSqua0+QDYIWu77l6V6mmQwHpoINomzI
        MqiAAv0XBM4+xgIIZ6p4RQ/WPFvcJqhjKJKZ5xQAm5X2pM+OHHpRhb/uF3nXo8Uu
        54cAEiZyYHpTEcelLPBoA1SY48ApeY6SPEd5XAS2TujB3wDgpcKdEwy5Dhhaekqo
        ClTSppVB/KXNO51l+M4dmFH4Pk1BXuWJqo4rVz7UAfAbJbMeEevT1G/Yp3/gyZgC
        CboA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686647787; x=1686734187; bh=Y0ahhceEFkOrW
        NGEf1B3K7FfOu/yMcR4EVDU/x3+V7k=; b=UqmoT6GiuKVSbOEE7Fb6HWmUwMj59
        Uy3enIU8e/nM/3tJTQRvwBd7S7PXMHntoNZ6ckIsvN8WBBeQyDBR+ml/zmbGT8av
        FpvG//5BMcXMvAfCCHWQB2/qaH2FLslkhBBpAnBhj140D9uD0lxwP3Wxsc8q6OEi
        IIX2j+3Ci61YHFPlEQwQD9LAapGHkZuCGYeJgslbmEkfl5rIdajqNo/tW+wpaHMH
        dIpoNY8XDvvl/oCwzXOrnozODPfWGxcAQiMmYcSng7tbMAwnpcDtswNxtX3CCW6r
        qCr3pi0cRW5L61+PSvP3qHZkiDODjYOCa2NgJcF1eGQK4KR9VFeMHMIFQ==
X-ME-Sender: <xms:6jOIZGhN8XCfI8Pgh97OTtwMX67OTiFkjXB4xP3KUB7jmlTEJtQERQ>
    <xme:6jOIZHCBH7bnhD81liYH-V-SB4qk2c6FH5MSD8MmVjZ8A7_0HMCy0ZhCsi2hQdKOX
    Dd3LAetC57ep6kJxdQ>
X-ME-Received: <xmr:6jOIZOEUVURzS1_56WGnQ5BnnAALKLobjlUA6X_z29MBg5akl8nW7_q9QmbtT0oVA1veOY_D1-usblTFf0k2ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeludefgeduheevleejiefgheetvdffheejvdejvefhudeuveehueevvdev
    veeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6jOIZPR1SyvF8xGLFDpFOD3fPEkSq17d5r7Gyvk9NGCpHj-SOUDoTg>
    <xmx:6jOIZDw1TsxlUnbHGQnQcQjpjVTDt-XQfgzvHOGFaua4jSq_ZGJ3gQ>
    <xmx:6jOIZN4uV92rkgVaKTFoMB6SzVHVfC9ngmPe0eYa1P1iaIx7prgpcg>
    <xmx:6zOIZDAd85MAG7wlvSYZMObd6V5uJ7YQSAMGt55N6SE30qJXxtJHcg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 05:16:26 -0400 (EDT)
Date:   Tue, 13 Jun 2023 11:16:24 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] thermal/drivers/sun8i: Fix some error handling paths
 in sun8i_ths_probe()
Message-ID: <4j74jv53tdf4n6txibl6xjh63dzzjr3ku3uoxhv3rzodthqbqy@25eho3f7wh6y>
References: <a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr>
 <ucnnixemxbpkjlbyenboydicslozt5jpyjjfbd4gjk4oye52et@fgyd3zqdqsh2>
 <u7mmywm63bm5q4zlsbnooeplscn4rrd3qnslkfq2xnquxgnkkd@n3tsnrutmfjp>
 <ad78c18e-13dd-fca3-1aff-5b8e68a91c90@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cjtzgc4xxdlkdkqv"
Content-Disposition: inline
In-Reply-To: <ad78c18e-13dd-fca3-1aff-5b8e68a91c90@linaro.org>
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


--cjtzgc4xxdlkdkqv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 10:49:24AM +0200, Daniel Lezcano wrote:
> On 15/05/2023 14:33, Ond=C5=99ej Jirman wrote:
> > Hi Maxime,
> >=20
> > On Mon, May 15, 2023 at 01:54:41PM +0200, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > On Sun, May 14, 2023 at 08:46:05PM +0200, Christophe JAILLET wrote:
> > > > Should an error occur after calling sun8i_ths_resource_init() in th=
e probe
> > > > function, some resources need to be released, as already done in the
> > > > .remove() function.
> > > >=20
> > > > Switch to the devm_clk_get_enabled() helper and add a new devm_acti=
on to
> > > > turn sun8i_ths_resource_init() into a fully managed function.
> > > >=20
> > > > Move the place where reset_control_deassert() is called so that the
> > > > recommended order of reset release/clock enable steps is kept.
> > > > A64 manual states that:
> > > >=20
> > > > 	3.3.6.4. Gating and reset
> > > >=20
> > > > 	Make sure that the reset signal has been released before the relea=
se of
> > > > 	module clock gating;
> > > >=20
> > > > This fixes the issue and removes some LoC at the same time.
> > >=20
> > > It should really be three different patches:
> > >   - One to fix the resource release, that can be backported to stable
> > >     releases
> > >   - One to switch to devm_clk_get_enabled
> > >   - and one to change the order of clock enable vs reset deassertion
> >=20
> > The order was correct before this patch. I don't think an incorrect ord=
er
> > should be intorduced, even if temporarily between two patches.
>=20
> Maxime ?

I agree with Ond=C5=99ej

Maxime

--cjtzgc4xxdlkdkqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgz6AAKCRDj7w1vZxhR
xbFeAP9nZaUHBaCk2zpQ9spk1lWcNPRC8lzIl2Swc+pADkJzfwEAoEPaz8Vy5Osm
Q+TSMfTLQNJhVNyS2FSE4zt1fM4g9wc=
=Fa6+
-----END PGP SIGNATURE-----

--cjtzgc4xxdlkdkqv--
