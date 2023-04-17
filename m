Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0126E4D56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDQPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDQPdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE7C657
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44D86276F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD825C433EF;
        Mon, 17 Apr 2023 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681745586;
        bh=Of1iyBIjBEh9nZ5iNrJ2Hz9ItpKyyzRZp3zaPHpda+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRTIq5/QZP8i8pkBucK4vD1OmtyXVRctn+mh38NX2uyIHMrxUHLXX4gYAdjQDlSiI
         Wwum6txVgPPXDsb8Im48Stkhsm3QseSExG5Gbs9DumkH6AWzw/g3z/SshpEXJpu0Ik
         6lLTqh5ozJ9tEIRMURHs3bLnIpCheEbJwDdDNJCHqgxvMfLoicJ80TT2IT8X6bJnfj
         xr0WMOoW/+dGRhEXKj4c/LczjGrgHDS+y8CWxOD5Tsu6OPTHG1b4gsAr9Zw3+HCu5/
         rcTC3xogJjH1LP01CA0/gE9yLRCpVASs6KPtTuNYTLKw/cqcFLTNoC+akjPtTsZvnf
         TabMN70vfu86w==
Date:   Mon, 17 Apr 2023 16:33:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ym9TkoocYsNsRt4"
Content-Disposition: inline
In-Reply-To: <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ym9TkoocYsNsRt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 04:14:51PM +0200, Krzysztof Kozlowski wrote:

> Code can be a bit simpler with dev_err_probe().

> -	if (IS_ERR(wcd->if_regmap)) {
> -		dev_err(dev, "Failed to allocate ifc register map\n");
> -		return PTR_ERR(wcd->if_regmap);
> -	}
> +	if (IS_ERR(wcd->if_regmap))
> +		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
> +				     "Failed to allocate ifc register map\n");

This is a functional change.

--7ym9TkoocYsNsRt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9ZqsACgkQJNaLcl1U
h9A0ogf+OG0JbKZGQvMMWHRl8olMh98p8FksZOl3Y3/QuuIvqo7CYBIl995DrU+4
SS1BgTs6c+ICkyry2pG267o+rKIEa/Tz+MeN7uvvOlEN/o7gg7Ie9Fs0kbhXLZyp
a7ZSeW4uq97nZ9HLI2FBsxnqg3nQ7KudHAg12InyY7dvmJRYQzsef/KO2eSOvsM7
++7VfbfyI77uSueGjDN1OcXIGM0AUSSDwh8QX7j/fbSBMVGmwl2rHWf3nsXS0OGa
vSL8PPbglcpbkI1bqTm2ge+tZUj/evRx47QozNAFZ4LfiEfaMwqcIrEU/H4wE2X/
xfN2YaNfcMxdY7/FrsYs3Skej9wjtg==
=dy1p
-----END PGP SIGNATURE-----

--7ym9TkoocYsNsRt4--
