Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A123602640
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJRH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJRH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:57:50 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430A785A3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:57:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 5DF992B06870;
        Tue, 18 Oct 2022 03:57:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 Oct 2022 03:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666079864; x=1666087064; bh=Lr4o8rmETJ
        5sK3ZkYq2gWw8lpC8hs57X7H/NqOJONxM=; b=vKvmy+HSRwwwE00QKORpSvA4Lo
        m6nq/1xr77nqOg39vFG00W1kaby+7ESVzfOveWTLMqST4HTnbXooc+IMpod42IOx
        fJGm1AGhRONMZeYRUC8qVcFjrltuSWFUnuGhjO6pk4D0ntIUYw9uBjp0BAxSC5cH
        j7gEMmUjV9UbEP2TMyPcbOnWjCNafa3T6/ay+St+jZUyEU+tW3z4r9bK5ApRYCPV
        QJnrQN1luLF7DkKijPPR5+TkCvGldFUPzrT/Dc6GaVBT7HOsrbRUiRo/ro4PYsXD
        hDtsNGB2GJotlu9Xr1uA6mSZ2koJikNZqtk5tyJhhYAX3t1uAYPjRUKabxxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666079864; x=1666087064; bh=Lr4o8rmETJ5sK3ZkYq2gWw8lpC8h
        s57X7H/NqOJONxM=; b=Rd+9e5DFtINlfMc2YYOI0+MKnMYwDD9655rlznh2dgSm
        SA/RTKgRXAJmxCQyG0mNyg/ehPPGbUW9PvYKwpqeDuWKUWoIaTLXh5LrXn0SgoYZ
        nGrre6A31fsxquFB7rgEOMQFal70yeQbUFPx1zrABdUaw49LrYPGQMIHXIHdJMPb
        PLWO1Hq2Cv278LKTd1EFIGyFuMHWpAwX5ZWc+iS2kmiBgMt3rT+GIoYDhM9fI3IQ
        USNm+HuOZpZUu9mz7gY8B18uk+KB/PWrMtGuIpIR4hXlLigHF+MR+BXYRGHC2HtT
        ZCPnv4OZLoSFh1TZ89Y/Pl3jCloaTiIG6MfTfd+OjQ==
X-ME-Sender: <xms:eFxOY4tYe0N7n4oHBdbnTVOOhVkDCJDseBVReSvbhu05j2V5icTOfw>
    <xme:eFxOY1exK__txeJ3ucTKAAh3PMZF4YNvd7eUb7kHi2WWoq68m7rCgMVW2UqMRL37C
    hUb0Qd7Z_qfvsOH6To>
X-ME-Received: <xmr:eFxOYzwEg8yoSZul-Huszm9lfzk3ZZVvktA7asEbvofMnzHsftMzVNAX5A3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfeg
    udffffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:eFxOY7Mhyv3PdEfoHEQDxG63PHDCvZ09uKXpAsXyARpEVsdwgVroog>
    <xmx:eFxOY4_vnjB7joccgkbFlUNnW32Xt0KLsvyB1Xj2t-83rXS-wAhcxQ>
    <xmx:eFxOYzUWodm9Qv1bDIg0-xDVme1dTkQXB7oWBBEcP7NL8kZszvOcuQ>
    <xmx:eFxOY2exmKJm-vn-OQTvnUQLosa1VgJBjnpovYIhjfkaRc-W6Behj_5TCgY>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 03:57:43 -0400 (EDT)
Date:   Tue, 18 Oct 2022 09:57:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Emma Anholt <emma@anholt.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v5 08/22] drm/modes: Move named modes parsing to a
 separate function
Message-ID: <20221018075742.7g3sfay3o7wk54kv@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-8-d841cc64fe4b@cerno.tech>
 <729f849a-0287-a2fb-125f-892b4dd6053f@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ah23qdqgdrx2vnp2"
Content-Disposition: inline
In-Reply-To: <729f849a-0287-a2fb-125f-892b4dd6053f@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ah23qdqgdrx2vnp2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 16, 2022 at 06:11:21PM +0200, Noralf Tr=F8nnes wrote:
> Den 13.10.2022 15.18, skrev Maxime Ripard:
> > The current construction of the named mode parsing doesn't allow to ext=
end
> > it easily. Let's move it to a separate function so we can add more
> > parameters and modes.
> >=20
> > In order for the tests to still pass, some extra checks are needed, so
> > it's not a 1:1 move.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
>=20
> I was hoping that someone else would step up and review these parser
> patches since the parser code is rather difficult to read, for me at
> least. I have studied it now, so I'll give it a try.
>=20
> > ---
> > Changes in v4:
> > - Fold down all the named mode patches that were split into a single
> >   patch again to maintain bisectability
> > ---
> >  drivers/gpu/drm/drm_modes.c | 73 +++++++++++++++++++++++++++++++++++++=
+-------
> >  1 file changed, 62 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index c0dceff51cac..2f020ef2ddf2 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -2229,6 +2229,55 @@ static const char * const drm_named_modes_whitel=
ist[] =3D {
> >  	"PAL",
> >  };
> > =20
> > +static int drm_mode_parse_cmdline_named_mode(const char *name,
> > +					     unsigned int name_end,
> > +					     struct drm_cmdline_mode *cmdline_mode)
> > +{
> > +	unsigned int i;
> > +
> > +	if (!name_end)
> > +		return 0;
>=20
> name_end can't be zero since the argument is checked before calling this
> function.

I'd really like to keep it in though. At least, we know by looking at
this small function that we're going to be safe all the time, no matter
what the caller does.

And if the caller wants to check it as well, fine, it's only a simple
comparison ran once or twice at boot, it's not like it's in a hot-path.

I've addressed your other comments, thanks!
Maxime

--ah23qdqgdrx2vnp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY05cdgAKCRDj7w1vZxhR
xQM1AP9H4JgsnRShCq6qLr9+GCsm7Uj/MW6Tqyv5ymF9akVodwD+MJH0PS0yUl6U
Krhepy+KRRj3eEBJ5bua3Ps8acgwCw8=
=otSH
-----END PGP SIGNATURE-----

--ah23qdqgdrx2vnp2--
