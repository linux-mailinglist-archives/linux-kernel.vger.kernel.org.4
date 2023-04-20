Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE86E9532
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDTNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDTNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269740E7;
        Thu, 20 Apr 2023 06:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10396496A;
        Thu, 20 Apr 2023 13:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A9DC433D2;
        Thu, 20 Apr 2023 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681995618;
        bh=CbmhJ3ZmVyg2k2Wza3FXUHP83EnEg08C0pPRDzyTo5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAnJ6mgoMDNZ3IS69NorlaK/rufDvakTN1i7fT5q559Ukqs3hl+WiRBur3cF6T74O
         vISmrHH9rSPS9BEUt4DjfjA7n5Tc9obUVfJwQUucBA4Sez3TpKs3WufBtpROiWwolb
         Wto99A1LUUgOYiD20XqGjDWc4x7pg9sSk4rGLgXTdU/ag41t8hZhVi2KbPwyqhGz8l
         KWh4IymK+Ug9WONtMrPTMp5Hc2nuXiBc5R64rLKp/UA+znk5ZhjfIKhhxDmfAqTXXO
         WjQ2cSueIwsrPTHlsNfV7QXo260JSHc8OHjA4OFSbw7Feh/cl9GytBQNYH8d00jO41
         fvau9+erQLAgQ==
Date:   Thu, 20 Apr 2023 14:00:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
Message-ID: <d746ee5f-283d-44ce-b72c-18c8955d38b1@sirena.org.uk>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
 <6b355201-a957-4fca-a513-d5fa0742fb40@sirena.org.uk>
 <fe6202ee-2552-8b5c-c2d5-f2f7042b901d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PfnKUriuZ2R4YLEv"
Content-Disposition: inline
In-Reply-To: <fe6202ee-2552-8b5c-c2d5-f2f7042b901d@linaro.org>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PfnKUriuZ2R4YLEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 02:30:17PM +0200, Krzysztof Kozlowski wrote:
> On 20/04/2023 13:58, Mark Brown wrote:
> > On Thu, Apr 20, 2023 at 12:16:12PM +0200, Krzysztof Kozlowski wrote:

> >> -	gpio_direction_output(wcd938x->reset_gpio, 0);
> >> -	/* 20us sleep required after pulling the reset gpio to LOW */
> >> +	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
> >> +	/* 20us sleep required after asserting the reset gpio */

> > This is inverting the sense of the GPIO in the API from active low to
> > active high which will mean we're introducing a new reliance on having
> > the signal described as active low in DT.  That's an ABI concern.

> It's bringing it to the correct level. Old code was not respecting the
> DTS thus if such DTS came with inverted design, the driver would not work.

Sure, but OTOH if the user didn't bother specifying as active low it
would work.  I suspect it's more likely that someone missed a flag that
had no practical impact in DT than that someone would add an inverter to
their design.

> We were already fixing the upstream DTS users and I thought all of them
> are fixed since long time (half a year) or even correct from the
> beginning. Now I found one more case with incorrect level, which I will fix.

That's just upstream, what about any downstream users?

> > I remain deeply unconvinced that remapping active low outputs like this
> > in the GPIO API is helping.

> The code is mapping them to correct state. The previous state was
> incorrect and did not allow to handle active high (which can happen).
> This is the effort to make code correct - driver and DTS.

We could handle inversions through an explicit property if that were
needed, that would be a less problematic transition and clearer in the
consumer code.

--PfnKUriuZ2R4YLEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBN1UACgkQJNaLcl1U
h9ARLgf8DLC7sm26xjBonZJsiIb04p8lxnLkqb2sEIpOo1F5Wjc4SP5X97YAICDM
E/UU3m0cvSWhzwHCy6JhM8IeudyRAOdzUeg5mfDt6QSE/bhynllmcgA5lid8/3IQ
SPdchu68hQL8tsFn0QCtSapGBDfpHJ2Np0URhl/Ej4k/1Iij4uWIC9BNNg+oyGt5
Cj6wcxugplyc3Mjnb/qW263HNA6cDNXUl6zxNBkPckbdFhuTQGazigpv+sdA7ZFc
i4quuojHDlbkABb8Cs2oT/rYFH5hBLRVaa+2hwHWX0hLKPmzZSeqkMz7Xq9/2R4k
VXlD4DkgX5ctElHSCn/c3mVLzvaa+Q==
=ksk9
-----END PGP SIGNATURE-----

--PfnKUriuZ2R4YLEv--
