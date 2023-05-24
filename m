Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DB70F45A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjEXKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEXKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0A3A3;
        Wed, 24 May 2023 03:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18065619A9;
        Wed, 24 May 2023 10:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB763C433D2;
        Wed, 24 May 2023 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684924749;
        bh=97Bo8M7vIcJpKbKSc2UjRTwALsSkh/PCl91iiCIBYgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTWnnoc9M65z0pi+/RphFF0cyaG7G0fBxhQ/CRdXGcaGayKSEvgqc9qTZKkQ/HcFx
         wHDyQEVfYGNbGpVedSYEPpvivoUllsZ47udQ2iWNbu8he4ct3pCnc4ZaxCLRdZSbAk
         exkhiGqn2Mbpnxc9RpMcaKYJIpuH6zT0WNFrH0nzlUiSkSJA51tbO0k7lFeTKElpzT
         WKIo/kmtZIK84+hcbg/S1AUcDM3n7Xd2pkQBVqEfDVeFgQEXDusM4S/sFEMfU8eYyM
         TCkDketyaOxgFeoD01aooo9Nlhc+goj7sYD6rroOJK7oN/PF9IDOKhWrXo0s94TeAW
         +efNTcdc8rVew==
Date:   Wed, 24 May 2023 11:39:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Assign ES8316 MCLK rate on
 rk3588-rock-5b
Message-ID: <5b3e479f-366b-4de7-a4ec-5348166ebcbc@sirena.org.uk>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-4-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ddn++dUqYG3z34LP"
Content-Disposition: inline
In-Reply-To: <20230524074156.147387-4-cristian.ciocaltea@collabora.com>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ddn++dUqYG3z34LP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 10:41:56AM +0300, Cristian Ciocaltea wrote:
> The I2S0_8CH_MCLKOUT clock rate on Rock 5B board defaults to 12 MHz and
> it is used to provide the master clock (MCLK) for the ES8316 audio
> codec.
>=20
> On sound card initialization, this limits the allowed sample rates
> according to the MCLK/LRCK ratios supported by the codec, which results
> in the following non-standard rates: 15625, 30000, 31250, 46875.
>=20
> Hence, the very first access of the sound card fails:
>=20
>   Broken configuration for playback: no configurations available: Invalid=
 argument
>   Setting of hwparams failed: Invalid argument
>=20
> However, all subsequent attempts will succeed, as the audio graph card
> will request a correct clock frequency, based on the stream sample rate
> and the multiplication factor.
>=20
> Assign MCLK to 12.288 MHz, which allows the codec to advertise most of
> the standard sample rates.

Surely this is irrelevant with your previous change, and if the clock is
freely reprogrammable as it sounds even harmful given that it'll
restrict rates that are not available with the selected MCLK?

--Ddn++dUqYG3z34LP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt6UQACgkQJNaLcl1U
h9DN5wf/W5WcD7Og4mMGFdpfZQX2dnzRyeSTEz0CjPCd8IH1EtUjs9/Ynbswoa1h
i4b9JEmZ6FhwJXA/mEhAD5UZ84MDSy3Eiaa1tyqU+WszFsDFkXRruycmYiLvjk3Z
qdz1fqWbl9PFKNcwC9Yx9fDnrph6/yI1ok1Xn+p1RuC13ykFo9eaecWEeowXCoCl
Q88gVYix4yYaXcTRuax6hnPq9PKnysUyuzTPB+FZ/HycBLwAWf51TwLkCUbGkGRF
eWViwSHzF9HVynxOFtINjPzzMS9HVyWh7Jr4a+CK/0NIkqyqvjP/318EfukXyw2k
WEVKpaYD0v05lvNpqUp4kEyVo+IKnQ==
=sTqD
-----END PGP SIGNATURE-----

--Ddn++dUqYG3z34LP--
