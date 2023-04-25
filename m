Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225F6EE545
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjDYQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjDYQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:09:14 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1912C16182
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:09:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 58BBE2B066EE;
        Tue, 25 Apr 2023 12:09:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Apr 2023 12:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682438945; x=1682446145; bh=OQ
        bk/kcId6uCyxUgunwrLpX0eRV2V+V1kjrMSflW4bw=; b=xfL+bIvoqJkDlIn6NT
        JZABXentETsjQmDqX+VeP82DXmf9JUaacNXYyZsOEz3yRUBp7Au7qCEIWJMIye7A
        t9DOuW4Pt7S4O9mEdjF5QCe5WKbPEYe9LUoqbHdJ7geCRNIDVbhmeADSSSe+lOYR
        Hvp27IX5gonGrfFCLaeiZ6v7E5QQZz5Gv0o1ucj6maVISdK9jZaYk1iwGpVJ/0JZ
        n1DnYTZWFAOSSA3amJP0yhbTXUX9zS1oPOkCs6mPnxvnrStliyvfwfURquB98u7C
        gH8LRGomgQNCAKFFFUeqJb0qKiPyFZrnBieOsvJ+huc4HWZBR7sW3XSz4KxbO7iQ
        Dmlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682438945; x=1682446145; bh=OQbk/kcId6uCy
        xUgunwrLpX0eRV2V+V1kjrMSflW4bw=; b=RrqaQmCV3ic2Cw6IQVPi+EHytTXcW
        Le8Pa5kd23TCvs+VtguVnHSgSxTIggj9nnZOkxI0FOx32Gr+j3ISk1DE4IdMqswU
        x+hI/gUJlNlmY+AgsD35ANsmSzXJcfwgk9/5WUUvFUs3yZOvG8EEUBYsn7+K2uI7
        L8R/Bdmx3S51Gmtyn1IaHlWATEaPhGWyLmvrH/lbakV/jWE21Huwowlmpo4C9HBr
        NZTqmaEzkeUhn4hCDX6uuTeBup+LKUsytzipT4TL3NU2YSQyQwpp80BY/i26D+jC
        xXGxB2Zs7cvEg/NT85L5atwMb9pUZnqyA8o7JRT+zJuVjuiufU+PeXVRA==
X-ME-Sender: <xms:IPtHZCqbNRTzXvOxc9ebAK-NhsMlCnlFevO7pBJv1-fkOSHYLfi-6A>
    <xme:IPtHZArp6IJ88X8w89fwRB93tfYVCarSxKmNR5mWP8p860iEGNUlxbJM8WDaHIfnT
    YQpZ3UW-iKJKynKQQ4>
X-ME-Received: <xmr:IPtHZHONIndbAJI4qZw5-icA44GPx5wXWKGTIo99f6vou0Y3To2uPfRnUWle8UNrnrMPODg7Gq5pBQpaZAdt1CBZAwThD_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:IPtHZB74simx7Dvnq_JO4GXRbnw6s5w60_fOTePPjHYkNjQB1jcYUw>
    <xmx:IPtHZB5dCohDIbKCcDNOda-l0U91Ve42omh-E2gD89tFvRstFAmhGQ>
    <xmx:IPtHZBg2oZhWOZIrfe8zI4Nw0PXTHjoc5n-JlQR2J-6NAms1ihA4jw>
    <xmx:IftHZBol1LSWumMtyJH7TvVO5McxamADQDbwywOuZMSn3_PRfga7yJ5wn1I>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 12:09:04 -0400 (EDT)
Date:   Tue, 25 Apr 2023 18:09:01 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Beranek <me@crly.cz>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosp.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] clk: sunxi-ng: a64: propagate rate change from
 pll-mipi
Message-ID: <eyhlequ4hldyvtjqi5ouvbozmjeqqve4jcvgdtvktf3tqmwqjf@bqvjcu2kxajf>
References: <20230418074008.69752-1-me@crly.cz>
 <20230418074008.69752-2-me@crly.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="drnscjmrlojh2hnd"
Content-Disposition: inline
In-Reply-To: <20230418074008.69752-2-me@crly.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--drnscjmrlojh2hnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 18, 2023 at 09:40:02AM +0200, Roman Beranek wrote:
> Propagating rate change from tcon0 all the way to pll-video0 allows for
> greater precision in matching requested display timing.
>=20
> Signed-off-by: Roman Beranek <me@crly.cz>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
> index 41519185600a..dd6212286dcd 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -179,7 +179,8 @@ static struct ccu_nkm pll_mipi_clk =3D {
>  	.common		=3D {
>  		.reg		=3D 0x040,
>  		.hw.init	=3D CLK_HW_INIT("pll-mipi", "pll-video0",
> -					      &ccu_nkm_ops, CLK_SET_RATE_UNGATE),
> +					      &ccu_nkm_ops, CLK_SET_RATE_UNGATE
> +							  | CLK_SET_RATE_PARENT),

The OR should be on the previous line

Maxime

--drnscjmrlojh2hnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEf7HQAKCRDj7w1vZxhR
xUnvAP4yDrqezoLe1dBxve+9KckvqmP5apjHhhVINJc5nbFIlgD+Pf04BAirUXFu
I2LHFHnGnYXeBu6+yR/jrJs6uxw9tAM=
=slla
-----END PGP SIGNATURE-----

--drnscjmrlojh2hnd--
