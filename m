Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6620731E33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjFOQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbjFOQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:49:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028582D50;
        Thu, 15 Jun 2023 09:49:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 412E45C0154;
        Thu, 15 Jun 2023 12:49:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Jun 2023 12:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847773; x=1686934173; bh=xL
        EW4NnANxOdl/dt5wfiU9/pSknljvRTvkIXuCTwMZY=; b=zMCPLxMwFqrJ+20e4j
        Xnbel7Lwh0CGWpzMWKcNQBb1E+JzdL/Y3/LqPa31JvFEzpocJksJio5/4U7jOUqD
        LxjchM0zhO6GNGt+8F1GdRBL3L8sde46OGivQmuv1T1dHTYDRUohlk0JZQK5hYYN
        2/ExxRmr9/MFbugHyNgCJsOQ0TBib6LFZIaEOHOeXTtGH+qW0FwO0qofPLywjVgt
        a8dcAfP6NaoGlmTDSQPe0usNmkxsEtSia6v9kmzwPXMFnj0zG8wFuHIanGKSg8uG
        bvYcDU+DS8ppIS+GW5WEdvc0s2mLQpdPP5AxzrF/XfXU+qCUFR5EJsfXgWJcYPzD
        DAvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847773; x=1686934173; bh=xLEW4NnANxOdl
        /dt5wfiU9/pSknljvRTvkIXuCTwMZY=; b=R67IH4XS+udV0JgowWk97zzmLloRe
        13TdqYHPgnWI0kOwQfB9WljI+zcLM1EqkeIFpiO8y3YE/hgxBRMDrUrHIdvvqGGp
        Qw7DQLN/yoWiWa7w++iOWd6RmopDUqvBAIPPwbMiFuP94hKdDbdqqZfDrTKMP+O/
        8EEB2yJeYx97D8yK0i3zB1fTMo+Ba3fRG3tueDZSBpUn/i1PMkjrItfMnHz/k0Ww
        A5XiQymsnHe45o4oe9Qa/yXYcUCumX5j/Vcm2RJs3K1GZjkAVz6bIkMFN6v7wEVQ
        bV12ExJhTqPP2/f4Ipqci5HnQ8P3UAbLpr9UxtOduYeShYmtObwiEnMzA==
X-ME-Sender: <xms:HEGLZPKA5AkL2kGVibpFkxCDv2YG5dYOREUmUgt5BDtC-QHZI04JJg>
    <xme:HEGLZDJvMoWYw9QRtO68keg65V0MWH7zNtIRzDdEOC_GZe_vD3U1IXaH0yE6OfEsC
    yoKymVqEaEIHKr0GUE>
X-ME-Received: <xmr:HEGLZHuc2Nu75DMnKbpKkvpGhVDN8ArBev6YZzWKywUf8PoIM3Dgat9tazp3kHnotTfmG1_mXINnS0aKuWH0NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HEGLZIaOGGglxt4VWdJJynvN0uTjq84E4nOwXWJ4qChCxDDlYOUrng>
    <xmx:HEGLZGbXTDa4udLJKl1lPchj-TAgi5UuGQtEpL4Yw-0WAjWIcAxUQQ>
    <xmx:HEGLZMD2K69O2Hq_nxBChV97jkOi3vYLLGzShJGHeD4PiXg_KuzbJQ>
    <xmx:HUGLZMOZo8KTGz2Zl4yaMiB8bHP2IdHnR3gFMWgMQEKg6EhfzjWXiA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:49:32 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:49:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] clk: at91: clk-programmable: add support for
 parent_hw
Message-ID: <dwljsogb2ctf3izxafja7wskel5jcamytzcmvz3xjrovvkzd7i@bhp5lnf4q2bf>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-6-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pckaourro5d7oc54"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-6-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pckaourro5d7oc54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:21PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in programmable clock driver.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-programmable were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--pckaourro5d7oc54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBGgAKCRDj7w1vZxhR
xQOgAP9KSmT5BgfbSNuYS5Bul+OAX198b5xDhSWWgYufRkjDqAEAsZ/ASQ3sQw6M
WDJoxjVsqlWh2SRr6ozGySmBoWCGPwc=
=amLs
-----END PGP SIGNATURE-----

--pckaourro5d7oc54--
