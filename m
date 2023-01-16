Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52066BB87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAPKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjAPKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:17:23 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04F61A951;
        Mon, 16 Jan 2023 02:17:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E6215320010B;
        Mon, 16 Jan 2023 05:16:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Jan 2023 05:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1673864215; x=1673950615; bh=ohPYesaxXk
        sV3W2txrimDtAtBAhmW/4R6Nx2mCz0Zps=; b=Eaw8Xd2GS61lnPC+MNep66n+dC
        PCUEhiMxdPbFe1k/kw5XTMvIPinamdKeTutSmSfmd7YA1ukylFaGz4nNxf1J5YEu
        IjhQvqFv7MvCbxLOKdNhdS/+r+/t9Qz+TeEaBx/YHpnK9PmiZDXYTPZ1y1D077Ze
        ZwpbCMohYzcyOEzwbOQzHOD/H7AO5uKdQjn1L0Ow4vWcCzrnuHS50N9cPj8H52O8
        rbfoddzAOLKxrY4VOHazuz4cIGmLYwLli3jczhATfEQWqF9PKYLsCBhVUUwSGOby
        soypM3N0+un9uIwXY4iJlqES2K4xH7WR89IzLB0T998cHYoqXLWMhCzdFu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673864215; x=1673950615; bh=ohPYesaxXksV3W2txrimDtAtBAhm
        W/4R6Nx2mCz0Zps=; b=QyYpzpoC4JaiDhO9oOtlWLeMQJbky/neCi0IjmmzKyIw
        pNRw0vNqn35ekGLaYLMqTmPBKODOdBvLGGdrVWZG0KkRor67veTQcvjNqY35s+ll
        jhMAnfXJw+zMCJVMTM8LitiIqM3/diIkO0ZufNcx/pxWNkivpvKMcYMK2gxjWsDJ
        eLoYi1aydXHMXgW2GC3f/SfRKTHjWWm91r6HeKqm/RdNeXLRNAvUeQvyWlegq4oh
        Wi7mbgOhI0yC27c2wPQLdORbTS8wlUQxEQjGa0XT+TCPTo4gXRerGh294X4WTmP6
        WZ19W+iBIaHKZDX8vvc3s3ba1sKTRUJSC9wHN1bwdQ==
X-ME-Sender: <xms:FiTFYyg-udWjlu1DBrZdNQ4AJw8-kA9XMwrZlTV99IoyGPAyg7H65Q>
    <xme:FiTFYzCDjbI2Pe2YDW53smZCYPI-sbdRytq09rzeZVkig4Vcql8yEJ-AWtJI43Mtr
    sfKlDjpOH7nrwUgCgI>
X-ME-Received: <xmr:FiTFY6FTvrGJ17x2hBuRVPnAP6_Wq1euJ9cdgwLq4-1c6tDC0hpVZrhz5ropdj6H3fAEBWFYDB7zUH05hyz0OhJymdZILIzJ6vuPC1MgNLWgqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegt
    vghrnhhordhtvggthheqnecuggftrfgrthhtvghrnheptdelkeejiedufedvhfeiffetle
    fhiedvleeigfeiuefghfdvleeiffejieegteejnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FiTFY7Ste6i31k9z-m6htj1R-0C5H2A6lt1cKAXXNTThiSHzdYehfg>
    <xmx:FiTFY_xx7FBDWEh_sC-JbmhDsXGYEQBgJAjzXSQrYkbcBUUMd2CLZw>
    <xmx:FiTFY56MSwC_zNMqb6gStkqwmquKYd7Yd-eqLWx2HoSBkOwyNrOAaw>
    <xmx:FyTFY0zeH9ByF2HD5GBfu7_0NEOFU0Zs12Gi4rBdNJNsAx7ejXAg1Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 05:16:54 -0500 (EST)
Date:   Mon, 16 Jan 2023 11:16:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Oleg Verych <olecom@gmail.com>
Cc:     wens@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        sakari.ailus@linux.intel.com, wens@csie.org
Subject: Re: [PATCH 04/14] media: sun4i-csi: Fix [HV]sync polarity handling
Message-ID: <20230116101651.jjzz2rcdehs5wvsi@houat>
References: <20191215165924.28314-5-wens@kernel.org>
 <20230116100359.4479-1-olecom@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d42kwkvwzbbj3usb"
Content-Disposition: inline
In-Reply-To: <20230116100359.4479-1-olecom@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d42kwkvwzbbj3usb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 16, 2023 at 01:03:59PM +0300, Oleg Verych wrote:
> > -	hsync_pol =3D !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH);
> > -	vsync_pol =3D !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH);
> > +	/*
> > +	 * This hardware uses [HV]REF instead of [HV]SYNC. Based on the
> > +	 * provided timing diagrams in the manual, positive polarity
> > +	 * equals active high [HV]REF.
> > +	 *
> > +	 * When the back porch is 0, [HV]REF is more or less equivalent
> > +	 * to [HV]SYNC inverted.
> > +	 */
> > +	href_pol =3D !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_LOW);
> > +	vref_pol =3D !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_LOW);
>=20
> After this change has been made there is a need of explicit explanation
> of what "Active high" / "Active low" in dts really mean.

Why?

Active high means that the signal is considered active when it is held
high. Active low means that the signal is considered active when it is
low.

> Currently physical high/low voltage levels are like that:
> (I'm not sure about vsync-active)
>=20
> * hsync-active =3D <0>; /* HSYNC active 'low' =3D> wire active is 'high' =
*/

Yes

>   CSI register setting: href_pol: 1,

Not really, no. It's what this patch commit log is saying: HREF is
!HSYNC, so in order to get a hsync pulse active high, you need to set
href_pol to 0.

> That is confusing:
>=20
> [PATCH v6 5/5] DO NOT MERGE: ARM: dts: bananapi: Add Camera support
> https://lore.kernel.org/linux-arm-kernel/cf0e40b0bca9219d2bb023a5b7f23bad=
8baba1e5.1562847292.git-series.maxime.ripard@bootlin.com/#r
>=20
> > +	port {
> > +		csi_from_ov5640: endpoint {
> > +                        remote-endpoint =3D <&ov5640_to_csi>;
> > +                        bus-width =3D <8>;
> > +                        hsync-active =3D <1>; /* Active high */
>=20
> original CSI driver
>=20
> > +                        vsync-active =3D <0>; /* Active low */
> > +                        data-active =3D <1>;  /* Active high */
> > +                        pclk-sample =3D <1>;  /* Rising */
> > +                };
> > +	};
>=20
> [PATCH 13/14] [DO NOT MERGE] ARM: dts: sun7i: cubieboard2: Enable OV7670 =
camera on CSI1
> https://lore.kernel.org/linux-arm-kernel/20191215165924.28314-14-wens@ker=
nel.org/
>=20
> > +	port {
> > +		/* Parallel bus endpoint */
> > +		csi_from_ov7670: endpoint {
> > +			remote-endpoint =3D <&ov7670_to_csi>;
> > +			bus-width =3D <8>;
> > +			/* driver is broken */
> > +			hsync-active =3D <0>; /* Active high */
>=20
> this change patchset
>=20
> > +			vsync-active =3D <1>; /* Active high */
> > +			data-active =3D <1>;  /* Active high */
> > +			pclk-sample =3D <1>;  /* Rising */
> > +		};
>=20
> > +			ov7670_to_csi: endpoint {
> > +				remote-endpoint =3D <&csi_from_ov7670>;
> > +				bus-width =3D <8>;
> > +				hsync-active =3D <1>; /* Active high */
>=20
> this patcheset
>=20
> > +				vsync-active =3D <1>; /* Active high */
> > +				data-active =3D <1>;  /* Active high */
> > +				pclk-sample =3D <1>;  /* Rising */
> > +			};
> > +		};

I'm sorry, it's not clear to me what is confusing in those excerpts?

Maxime

--d42kwkvwzbbj3usb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY8UkEwAKCRDj7w1vZxhR
xTMkAP4+TgmiQeIUnqkQdGHMurxhX6R1RMA0WARr69iNcT7I+AD/ZaGQUas8YGRi
CYDPVdJ5hhgKlTctilLgpPIaA55YmwE=
=QilM
-----END PGP SIGNATURE-----

--d42kwkvwzbbj3usb--
