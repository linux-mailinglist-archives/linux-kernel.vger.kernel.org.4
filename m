Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF470F824
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjEXN7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEXN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA049A9;
        Wed, 24 May 2023 06:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46D326330B;
        Wed, 24 May 2023 13:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A495FC433EF;
        Wed, 24 May 2023 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684936747;
        bh=s7ODysrVL6L25XbJNWIyvhMKDv3+c3+iRnPs03vFH0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmWZFX7HB0sxfLupokaobr2jrqyYPq0DZgrCcu2R6nUQFf9ffaN084zM4/1xiSeVm
         gXH12b5GYmNFRNA1/1IlCBJs86tUMLo0lICqSR5IRNojIPMCVI+eZ0v4GgpobS0yYm
         rHS9s6pkdv7ixVaaRZ1vWzFT2K8v/rNNQkCwH8Y4d3wrsU/Np5VDiTjjnTPgjKdZw3
         UW/h9e6LruZqhj0j4WVuk7b5QBfvCtxzlW6ti3ZZzu0ThBWXRQgpf0+Fidb9jZMFN7
         HXZHZEzac7d0B9L6e8HZ0zvhNh4/6qSYGv2ShZ1Q7Qn6f+w2igm6XYeyP8Dnw3hr5y
         62HFi1m5D58hA==
Date:   Wed, 24 May 2023 14:59:00 +0100
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
Subject: Re: [PATCH 1/3] ASoC: es8316: Increment max value for ALC Capture
 Target Volume control
Message-ID: <01fd1a9f-56c7-4864-bb2b-8b004284c8cc@sirena.org.uk>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-2-cristian.ciocaltea@collabora.com>
 <5dbcbf84-602a-44de-ad99-268d4d5b4b2f@sirena.org.uk>
 <cfa23203-1626-440b-ec27-efe56cb297d2@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5dAsb6A5aa1oi1XV"
Content-Disposition: inline
In-Reply-To: <cfa23203-1626-440b-ec27-efe56cb297d2@collabora.com>
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


--5dAsb6A5aa1oi1XV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 04:49:37PM +0300, Cristian Ciocaltea wrote:
> On 5/24/23 13:30, Mark Brown wrote:

> > Presumably you can check the effects of changing the value?  It seems
> > plausible that what's written in the code might be accurate and the
> > higher values might actually change the gain but it'd be better to
> > check.

> I haven't noticed a (measurable) change in gain when switching between
> 10 and 11, but my testing equipment is also not that great. Will try to
> improve the tests accuracy.

I'd expect it should be really obvious with a scope if you've got one?
Testing with something consistent like a sine wave (eg, from
speaker-test) should also make a 1.5dB difference noticable enough to
check if there's at least a volume change by ear even if you can't
specifically quantify it.

--5dAsb6A5aa1oi1XV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRuGCMACgkQJNaLcl1U
h9AcDwf/Wi9oFO/zCuXcdQUi3Vp+Eyy46hZtVdxgIqdFlbsWoBoIYtHoKUyolbCe
KOrPtIARsf6WybwRtIymagviHxnu8jh8Abk+18Ns5ZxdYQ9Tj4VZTGXq1qodDEg6
XKlZ4Dm4g1vetWmf2ZE8zGRXKaJX3jMoa2Gz7TyiT9e6qf9yOiAHuYbf9c2t0BAA
CkZRrB+I8UVh0/G49kg7ApiN8W07RHEDYW0QaeMO49auGg+75ptD46316gJvAvVQ
QbYIH+YDmjxtv6pT9ZuXxBBRE2nVyeW/O/qPEK96ahLIPU9RZyjo3uE03+XeVYj/
hejkDQyW1odVohfhGZJFDVP7oeMzcQ==
=9KPI
-----END PGP SIGNATURE-----

--5dAsb6A5aa1oi1XV--
