Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF08650E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiLSO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiLSO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:56:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C813CE4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 586E4B80E4C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0526C433D2;
        Mon, 19 Dec 2022 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671461455;
        bh=QxVPwZP8m+jsCHTTeqcdIpyCXjsptf4gIKs8BSGJBL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fly9y9GIhJwybfs+jroXKqdVzCJpHS4TqdxKwymyTZFKCIMk0mi2eb8IXsa1IZUFB
         7+N+Hv2jidaCNb+0CgIDr+p5cXuRXnCNPRwrY3Lad7uXROxpPf2m0t0wvJ+JEYoktP
         jUoI2CdzAkou6aamyEzAUZPpNMsY8icPDBWhpyL0SASaXMFRNrbrfHoOVFypoR6loJ
         ZQDnsNIP2VEhwT+0l0Kro4cXki1gCwCE3zegD+ucmls7eITliIHHuWXq7cZsK8yisN
         4uWwNj4weUVrPQXC0R2wpDweNqgjFdQK+JYM9wF5u6M3Utnyhs5KJhr0SK7qJd30Jg
         KKM2Kjx3NLJ8w==
Date:   Mon, 19 Dec 2022 14:50:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/3] arm64/sysreg: Add CCSIDR2_EL1
Message-ID: <Y6B6SNADJQkNRoLO@sirena.org.uk>
References: <20221211051700.275761-1-akihiko.odaki@daynix.com>
 <20221211051700.275761-2-akihiko.odaki@daynix.com>
 <Y6BjQiR5gUhIAyIS@sirena.org.uk>
 <6363f9d0979be5aedfb04db4810b71a4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYp6zYSC3VWc2bxT"
Content-Disposition: inline
In-Reply-To: <6363f9d0979be5aedfb04db4810b71a4@kernel.org>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYp6zYSC3VWc2bxT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2022 at 02:47:25PM +0000, Marc Zyngier wrote:

> Since you're reviewing some of this, please have a look at v3[1],
> which outlined a limitation of the sysreg generation tool as well
> as a potential fix.

Hrm, would've been nice to be CCed on stuff for the tool :/

--mYp6zYSC3VWc2bxT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgekcACgkQJNaLcl1U
h9ATOwf+M1ng9YlS25c373o/kUeoQ5yAyHdggFm6EfdGWuWfd556L8Rr9T/1HCUR
mFg67pwzlcmhBwX/BHbdjzAjYWvNmP5LzKO7G46uEksPmxNc4WCriBBR8jlsOvR1
dj0JsWF58BWDZg8jcnuotHTUNcDvU5RfLG8T9jcmN4dUXOz0xa/fh02oQfnbr8vE
f4jcRljPZGpF6pWNdAfKDJSvjrSq5QBU1gwo88nKXnuY1gq3GI6aLNFun/CP4iVm
1msraBt+TC6A2S09vcA6jaGW2bfgZGmWIS27Y3ZN+IzNlwKZ1YfsezF4EiLk/BmG
OeaDj3aqNy6h8EgioVkCGVZ8EyRisA==
=epbW
-----END PGP SIGNATURE-----

--mYp6zYSC3VWc2bxT--
