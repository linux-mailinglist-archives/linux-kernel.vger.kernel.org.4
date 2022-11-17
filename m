Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966362E2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiKQROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbiKQROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:14:10 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61F73B8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:14:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8DB7F2B06A50;
        Thu, 17 Nov 2022 12:14:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 17 Nov 2022 12:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1668705244; x=1668712444; bh=EPKM98yuI0
        FafDSpZ4oH9M/3CpWV+m3u8fcRxTeHRuU=; b=IKSCrjRehJXLLAheMi3x1nBBT6
        xv79+oCuXcYWNZ56lfkM1xLPxqSAtDNNT3XxpSJC6jHP7Vkok/cXYc/Q95YEBpG+
        ezh5FAEU/QFRRHMU7pCIMZWiaEuhO0x26gZVc/BGSuAHy5m4qU6aEWjP9OzWk5Cf
        7y/V0+6av4McswO2nCTSoODDF+vOIcOUhzF9inIWGgUE2fphLHOeDM01YAIZHVuu
        6op3/MJ3VV7BmT1MOYTIwx+Fbwwh/wYlU+bcv4kNzWVhRhtS1sqQ7QUSpdXtsDF3
        jygjVycsZPOEbUmO7CCsQXSFduE2nvV6WgRq+ZD9hm+mSroQWO84l6sQNe3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668705244; x=1668712444; bh=EPKM98yuI0FafDSpZ4oH9M/3CpWV
        +m3u8fcRxTeHRuU=; b=FJ0o9lSTMDJUUNFAeEUAJvhsA4JEtyf0agBRuNaZs/Ax
        /vKmYa1NT94ktikwdItSLaULxP0rJYkbgBubo/OPC2hiCxDNnIO6FtAxj+/ejJGS
        iKmzcK9bLoYUzLTB6c7XqPKkxdZbPF4H0feWwbfpJ0BWVbdQePGuBroxY9MueMih
        7FT17Z+ie0MmgR4aTVQmXVHXO6zsdMFbjOYNE6tCp0e8Lbm1N/mKRHD2iGxx8Xcb
        IXPAvjwzB7KOyD9S/fDSePH03flvfPtPB7NrqZXeNUmupz+zQ9RaGmo2KcKRHvbT
        zwZ7vlVYZEzM0Z1UI08AtAbJrk2HLpqzUu9OF5IoOQ==
X-ME-Sender: <xms:22t2Y7aq50whuiFoQkEUePGTIQQg6ZfqHjYpnO3ZncSCACAWCnOiMg>
    <xme:22t2Y6ZPwV0Q-ALL-9E4JiTTYPis500kQYlEddlLdZGekFPHa-FsXpXfxA25fJ3o2
    gwMU9kLZtOVoGM6TQg>
X-ME-Received: <xmr:22t2Y99lRvGfydEV4TyGUQvS_xMgz5cYjOuHKny_YDGWhp55onjpyMcwIi6_VHCLq68SvWWLiZglAAmz18UhhoZIzXVeUJL6MkOpgZBxhvpz-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:22t2Yxom94qDjT-BzKQYtjOcEEJ5G_ZpbqblIPWD4ny5xSpnARo47w>
    <xmx:22t2Y2pZsh_WWZJSX9aXYTEk1HHwKH4A-o6rp_LoVNmwmGmnNPxxGA>
    <xmx:22t2Y3Tq45VHs9_ipPR4WzxHHa3NojkmAl11WzxKDRL27UL_x3KIdg>
    <xmx:3Gt2Y5CoJVgET8RSJmOoRJmYWzwp91a6JyV2_DM6wMLHtCwwG3cyUPBYqxc>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 12:14:02 -0500 (EST)
Date:   Thu, 17 Nov 2022 18:14:01 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 18/19] drm/vc4: vec: Add support for more analog TV
 standards
Message-ID: <20221117171401.3ogenv6g5nszufmm@houat>
References: <20220728-rpi-analog-tv-properties-v10-0-256dad125326@cerno.tech>
 <20220728-rpi-analog-tv-properties-v10-18-256dad125326@cerno.tech>
 <20221117164928.200b3a1a@maurocar-mobl2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cz56iqciiap5nisp"
Content-Disposition: inline
In-Reply-To: <20221117164928.200b3a1a@maurocar-mobl2>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cz56iqciiap5nisp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 04:49:28PM +0100, Mauro Carvalho Chehab wrote:
> On Thu, 17 Nov 2022 10:29:01 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> >=20
> > Add support for the following composite output modes (all of them are
> > somewhat more obscure than the previously defined ones):
> >=20
> > - NTSC_443 - NTSC-style signal with the chroma subcarrier shifted to
> >   4.43361875 MHz (the PAL subcarrier frequency). Never used for
> >   broadcasting, but sometimes used as a hack to play NTSC content in PAL
> >   regions (e.g. on VCRs).
>=20
> > - PAL_N - PAL with alternative chroma subcarrier frequency,
> >   3.58205625 MHz. Used as a broadcast standard in Argentina, Paraguay
> >   and Uruguay to fit 576i50 with colour in 6 MHz channel raster.
>=20
> That's not right. Argentina uses a different standard than Paraguay and
> Uruguai.
>=20
> See, there are two variants of PAL/N. The original one and PAL/N' - also
> called PAL/NC or PAL/CN (Combination N). Some of the timings are=20
> different on /NC variant.
>=20
> As far as I'm aware, PAL/Nc is used in Argentina, while
> PAL/N is used in Paraguai and Uruguai, but I may be wrong on that,
> as it has been a long time since had to touch on this.
>=20
> > - PAL60 - 480i60 signal with PAL-style color at normal European PAL
> >   frequency. Another non-standard, non-broadcast mode, used in similar
> >   contexts as NTSC_443. Some displays support one but not the other.
>=20
> > - SECAM - French frequency-modulated analog color standard; also have
> >   been broadcast in Eastern Europe and various parts of Africa and Asia.
> >   Uses the same 576i50 timings as PAL.
>=20
> This is also wrong. just like PAL, there are several variants of SECAM,
> one used in France, and a different one in France overseas and on
> previous France colonies in Africa and Asia. Eastern Europe also used
> different variants of SECAM.

And that's fine? Everything I did is supposed to be easy to extend if
and when needed, so if someone has some interest in providing support
for more standards, they are very welcome to do so.

I won't do it in this series though.

Maxime

--cz56iqciiap5nisp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY3Zr2QAKCRDj7w1vZxhR
xQY3AQC3ODU/A4r/xCJ5Ms7gOYpWhJaSGlaY+jf/qgMPcMmMhAD/VJCODvzEFvlF
AuxhxZDFClQh1TusZBNOY31fQyzDIAU=
=f8ne
-----END PGP SIGNATURE-----

--cz56iqciiap5nisp--
