Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B4E5B9670
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIOIem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIOIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:34:23 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7980C96744;
        Thu, 15 Sep 2022 01:34:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9A51C3200B0A;
        Thu, 15 Sep 2022 04:34:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Sep 2022 04:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1663230859; x=1663317259; bh=vUqGwLgGnv
        jdJN3EeYf2AxkvIZhOPYtabrS2PcOns6o=; b=le+JZ+5CDlwi9EXQabwtuvDK+e
        e87H/rMyJt3a6KbeNM3dXWouovQYQFDWIT04BCRL+c2BSIsxpwxRHrgpEiUMx3jW
        ybljVlZUbuXr8R4dwM52sZlhRH/s27nPhnuW3hJHLsEwr9EAfhOB781H5iXDu9fW
        QE7oIvkoHBdKCE87Uo+0iR9J3fzzyiAJJzCwVB5gu6PWQ0xmfAxJYnz5GE4nXt8w
        FZjROLHhwIFViLlRxIS3N4Ydjeoa/65xtgbgUFMMGtsqcNEoZ017DJRv/fDIQ7iN
        lhXv2PAW/8xy2Fq3JryOHoflLiRAWga8kEctgpVyhjS5z7TTOcwe50EoxVqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663230859; x=1663317259; bh=vUqGwLgGnvjdJN3EeYf2AxkvIZhO
        PYtabrS2PcOns6o=; b=l/0D1SxBe0pTzrYfJ8BgnHFf91ySUsC/VIa7YceXkWX0
        qw2TGaiAJDRLs2maPY/4809U78Gj1RTq6/ojfZPAbchEyp3kg2RPuHz1Vh20igm7
        ks7uKjcn69KAM/pQ7UTHc1McDlDWrE5xEnYgGNhW6XBM7Uqy7DE6gmwBvCaenLCJ
        MLGysr012dMpp+FLEQqGySzV+8ZkjVqo0HMTPrDImzHDwHslscTlXxuACcJb9cF9
        3oBPXHgvwBvzEajpsqaMe+OpXrCwj6iH5lU5r/uV4LBBs1qdT3LI3Jkgh6HsJavz
        uooAlBDDbTa91cLN4fwLQUIJlnL2xe9fD6rWNNL1qA==
X-ME-Sender: <xms:iuMiYxLPxTEiUPDOaQStd7AVPFmjc7Q1NkTFVDUYM6pe3uZgi9_2Ig>
    <xme:iuMiY9Jy0bGvEpOBcIXjgnIA8qPV3u2T1ydiqK1BtaxpT-Zk-SthEj54LUOlK_rXo
    BdhzNm1JKOkgkWwJk4>
X-ME-Received: <xmr:iuMiY5vnTtC8exCYKvmzHdXDpOcjLTesl8dmxkjiY-vz0Y_Fjl0pQHeTTfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iuMiYyZLdcfd0yePK5bEe3AS1AnvzYzcVFNYVsbsGFuNQ4k5tBfXFA>
    <xmx:iuMiY4bnwMWnulBNX4mruedb7YjgK9YJsU9W25BDFYbCS_nxr9WpYg>
    <xmx:iuMiY2CUk6fxSvEk2DOn59AIwV2Pc9E2r-JvunQTAK2vKlEVRTQyJQ>
    <xmx:i-MiY-yraWZtP3k3T-lqqHDcOHTUMhtsFyWZSlT0qMEHzlTDSb62eA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Sep 2022 04:34:18 -0400 (EDT)
Date:   Thu, 15 Sep 2022 08:54:59 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] clk: bcm: rpi: Add a function to retrieve the
 maximum
Message-ID: <20220915075459.d2snlbwkingwnbh3@penduick>
References: <20220815-rpi-fix-4k-60-v1-0-c52bd642f7c6@cerno.tech>
 <20220815-rpi-fix-4k-60-v1-2-c52bd642f7c6@cerno.tech>
 <20220914155035.88E45C433C1@smtp.kernel.org>
 <50e8f1e8-806a-3599-7cbe-0c7d4bec1c51@i2se.com>
 <20220914180508.0EDD9C433D6@smtp.kernel.org>
 <c221873f-f230-0cce-e120-7e3cc732cf00@i2se.com>
 <20220914181458.C6FCCC433C1@smtp.kernel.org>
 <ecfe17be-5d81-3456-9a86-77acc848f95f@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrirgpyhbd54p5r5"
Content-Disposition: inline
In-Reply-To: <ecfe17be-5d81-3456-9a86-77acc848f95f@i2se.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrirgpyhbd54p5r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2022 at 08:26:55PM +0200, Stefan Wahren wrote:
> Am 14.09.22 um 20:14 schrieb Stephen Boyd:
> > Quoting Stefan Wahren (2022-09-14 11:09:04)
> > > Am 14.09.22 um 20:05 schrieb Stephen Boyd:
> > > > Quoting Stefan Wahren (2022-09-14 10:45:48)
> > > > > Am 14.09.22 um 17:50 schrieb Stephen Boyd:
> > > > > > Furthermore, I wonder if even that part needs to be implemented.  Why
> > > > > > not make a direct call to rpi_firmware_property() and get the max rate?
> > > > > > All of that can live in the drm driver. Making it a generic API that
> > > > > > takes a 'struct clk' means that it looks like any clk can be passed,
> > > > > > when that isn't true. It would be better to restrict it to the one use
> > > > > > case so that the scope of the problem doesn't grow. I understand that it
> > > > > > duplicates a few lines of code, but that looks like a fair tradeoff vs.
> > > > > > exposing an API that can be used for other clks in the future.
> > > > > it would be nice to keep all the Rpi specific stuff out of the DRM
> > > > > driver, since there more users of it.
> > > > Instead of 'all' did you mean 'any'?
> > > yes
> > Why?
> This firmware is written specific for the Raspberry Pi and not stable from
> interface point of view. So i'm afraid that the DRM driver is only usable
> for the Raspberry Pi at the end with all these board specific dependencies.

I'm open for suggestions there, but is there any other bcm2711 device
that we support upstream?

If not, I'm not sure what the big deal is at this point. Chances are the
DRM driver won't work as is on a different board.

Plus, such a board wouldn't be using config.txt at all, so this whole
dance to find what was enabled or not wouldn't be used at all.

> Emma invested a lot of time to make this open source and now it looks that
> like that more and more functionality moves back to firmware.

What functionality has been moved back to firmware?

Maxime

--hrirgpyhbd54p5r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTXEe0+DlZaRlgM8LOIQ8rmN6G3ywUCYyLaUwAKCRCIQ8rmN6G3
y9OpAP4piBbM6aPirswtJbaB00rQd11MuWbOXRUllFGsa+tQTAEAp0zgBVW200Xw
HsAzlYqWG/1RsqziBcl/XungkVnV4Ck=
=Rad4
-----END PGP SIGNATURE-----

--hrirgpyhbd54p5r5--
