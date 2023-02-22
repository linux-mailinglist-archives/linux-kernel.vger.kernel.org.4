Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1569F457
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjBVMSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjBVMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:18:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F133A091;
        Wed, 22 Feb 2023 04:17:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2DE86140F;
        Wed, 22 Feb 2023 12:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E0EC433EF;
        Wed, 22 Feb 2023 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677068171;
        bh=f4AqES9u89TU5lnKVaH/Dh6alXUUeZYcLZDLaamkE8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXP1mDpUHpJnbTn/t9XShYZs4yvoJP3zXr+BUx8UDw2sdscYRajov5NnaqzrPfT/3
         KbqbVpVtmEp8UhQLcZ18TsupFKw62WwVfHACsCN6IDacwT8VA/r/P04p4lvoIcgKX6
         yNId43Jxp9MIXkEnzpeodyOdR8+ZDJyZOtzvqa6m4JdekpVT3WtDIDT2p9othQ78DG
         TNHlZOntinsbvyvGS46exQQoaDkgk8mKt7v/AkLC57TM+2B1TTYodbaoluCJRnUre6
         isIPqnNFWM2wWoStBvlgt0DS7No4/KlJWDurbpbwPRfNJ96tKWqu4Ljij58s+7pQYB
         9Qrw3uFiKl3SA==
Date:   Wed, 22 Feb 2023 12:16:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 02/10] sound: soc: jack: allow multiple interrupt per
 gpio
Message-ID: <Y/YHgn72PI4CQ4jg@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-3-clamor95@gmail.com>
 <Y/VA3HK/jGVPbrqb@sirena.org.uk>
 <CAPVz0n2cHvKfez6=ydR8HQfAfM_bipmAzav76Gxmp6pF4wLuhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pf0Zmmq6YW6dHegE"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2cHvKfez6=ydR8HQfAfM_bipmAzav76Gxmp6pF4wLuhw@mail.gmail.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pf0Zmmq6YW6dHegE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 09:53:28AM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 22 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 00:08 Mark Brown=
 <broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

> > On Tue, Feb 21, 2023 at 08:32:03PM +0200, Svyatoslav Ryhel wrote:
> > > This feature is required for coupled hp-mic quirk used
> > > by some Nvidia Tegra 3 based devices work properly.

> > Please submit this separately, there's no meaningful dependency
> > on the rest of the series.

> RT5631 by machine driver commit contains a coupled hp-mic quirk which
> requires this commit to work properly. In v2 RT5631 machine driver bringup
> and coupled hp-mic quirk may be split into separate commits.

This is needed to get the machine driver to work at runtime but that
doesn't block getting this merged, and there's no build time dependency
in the other direction either.

--Pf0Zmmq6YW6dHegE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2B4EACgkQJNaLcl1U
h9DRsgf/RCG23nPnnVRzCrfVLyrHStlD/EEOzmGlpWMsUNpfGf+dZao8XLMsRngw
mV2nXT0E1siPYCKxTk06KWPpSF1+MGYAO7yXsPkJWSWSzWuuh3ZuIU3OcoVMAWsC
VV8DbcqSXrovVbVIDgFcwIAmrVXWrNLogCiZeZqwJO6lSyPSXtVHjaH6DRpQ+/m2
2XfxdKoG7ecQTv1U6whNGZ47bEplT9XaDFAyEjHQTNYJhwzsPzl+Wo2oDzUe4uVK
v2OUOWUXhHTWlhIDORfFiiQ0GI4JMB8AbdQ6/rDAbvJ42QkS6A2anaXsIvtdU5Ta
F6DhUvXU+I+8SkE0Lia8hkm2nIo8CQ==
=9wj7
-----END PGP SIGNATURE-----

--Pf0Zmmq6YW6dHegE--
