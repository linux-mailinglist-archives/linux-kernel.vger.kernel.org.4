Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920876E9B85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDTSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDTSWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B72736;
        Thu, 20 Apr 2023 11:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA8764B33;
        Thu, 20 Apr 2023 18:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF48C433EF;
        Thu, 20 Apr 2023 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682014962;
        bh=MC9bIJY5eEXpsBB/snWTb+aONBCQciptukUfqls2Dqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0wtJUTbUJ9YsEcniesi3hoBs2Z4jnPDhAgHt6Ibdq8pHeCL4c9ZReNQAZE4DSLmD
         2t7U1iHmlzBlrm+5haAFX3eoviviORlWRXMls+XSUIUPvm5dvVb1pY5/Qg0VEoY9fi
         kzFoG8v6wEmuqZG739tXKgncuJjOijRBnZwjrFI3xR/PztHKhqHg0UeJZOnV0I5B2b
         cQHfIY52eWYlGTGHJ7ZXVXI06KJWqlrTwvk0GxJosCLBnlR3vj/j9N/5pW3dA1L+1T
         GIFGp0HwUrI4jDWNKXmo5uwm55/foTX+cpzglHMpNJCJhwKeGi2b+i7hrFKwB470LZ
         u6E3JqOvq9RaA==
Date:   Thu, 20 Apr 2023 19:22:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH 3/6] ASoC: codecs: wcd938x: Check for enumeration before
 using TX device
Message-ID: <3fa4060d-919e-4e25-8afc-09d3abd13575@sirena.org.uk>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-4-krzysztof.kozlowski@linaro.org>
 <dfe88b94-215b-a86f-60b4-25d2f9ea0e5f@linux.intel.com>
 <41daab8e-e116-83b3-234f-ece43817a0f5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SQnoPQeFBM8vzH9P"
Content-Disposition: inline
In-Reply-To: <41daab8e-e116-83b3-234f-ece43817a0f5@linaro.org>
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


--SQnoPQeFBM8vzH9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 07:57:11PM +0200, Krzysztof Kozlowski wrote:
> On 20/04/2023 16:18, Pierre-Louis Bossart wrote:

> > the alternative is to move regmap to be cache-only in the probe and
> > remove the cache-only property when the device is enumerated.

> The driver wants already to use the regmap in RW just few lines below in
> wcd938x_set_micbias_data().

> I guess I could move this entire piece of code to other place...

The register map is fully writeable (modulo any volatile registers of
course) in cache only mode, it's just that hardware access is
suppressed.  The driver needs to resync the cache when transitioning out
of cache only mode (often in a runtime PM resume or something), this
will ensure any pending changes make it to the hardware.

--SQnoPQeFBM8vzH9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBgusACgkQJNaLcl1U
h9D0RAf/cROt/EeqDKM/NmkHJJDxGDcNFwm4k6RUHi9dOYZHqRhsCfzoDktJPj/z
wIEQ4EinB1hj8064fLv0H3lwO4R9neyrRKWn7dPxL3wVIGPN1bzsau1QGwxkCvec
33tnNePJcfiGFNRU1/ibgl4pYack71zaiJgNHA92iS+1Efhn5aaN1DbwCXgP6Acg
LMnIBYG5IMJaw/iXuQEs3lfKeF4y7WZicAt1TTVFuIYbmVTh79gS01oaW4xeSr7K
SGXuN5MgxfrlS2vzl82LshVuHRiyXKtBf//XvEDGHyJ+5NsIURh6XLOZbSMex3mE
Efb5MyFOTtq7X99b1Qhisc0TUyp4Aw==
=WZyC
-----END PGP SIGNATURE-----

--SQnoPQeFBM8vzH9P--
