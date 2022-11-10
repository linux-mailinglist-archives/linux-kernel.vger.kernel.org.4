Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0E624C35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKJUxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKJUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:53:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C96205C2;
        Thu, 10 Nov 2022 12:53:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 685E5B82382;
        Thu, 10 Nov 2022 20:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7196AC433C1;
        Thu, 10 Nov 2022 20:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668113618;
        bh=J6mfoht5qBrFBxrC6sH4TYOnxV6LF52emDjer2Ypdwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WH7TRMx7C5cotdLr9EDFhUqhQiizydM+OKkWtChuu54yxZ5+cbJaIDl2Ce3iPuuYL
         Em5IoexpZDpO95CAG61oVilno/P4KjfrtR8/uHu76MjLwphcqSBVzlvSNLmTlc7kkq
         qZPjPly3CfH5o5Rfhm7SKTXUJdxXq7uklbniD8dzy6M7W+ef5H2n5UA1+0vRHS+9Ke
         O6MN4AD0yPgGVSeHg1LjyWiPssBp6xTQ8SukHR6UueTJNjA3HSYJK8AqljQLWtDZU9
         vlC5DO9lZjAzQd1rxdBJBsYAifKnAxG9LviHCsPEUB4qMJLPVr0jVgGTxdEYB7NLD8
         OK32ps9JyB2Ww==
Date:   Thu, 10 Nov 2022 20:53:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        tglx@linutronix.de, maz@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 00/12] Add support for the Cirrus Logic CS48L32 audio
 codecs
Message-ID: <Y21kzH4gDd6ZrpVm@sirena.org.uk>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8txgz163g9adksm"
Content-Disposition: inline
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
X-Cookie: Torque is cheap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O8txgz163g9adksm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 09, 2022 at 04:53:19PM +0000, Richard Fitzgerald wrote:

>   regulator: arizona-micsupp: Don't hardcode use of ARIZONA defines
>   regulator: arizona-micsupp: Don't use a common regulator name
>   ASoC: wm_adsp: Allow client to hook into pre_run callback

The regulator and ASoC bits look good.  It looks like this is going to
need another spin for at least the DT and irqchip bits, I think it'd
make sense to take the above cleanup patches for this release even if
everything else misses it to cut down on future patch volume.  I'll
leave it for a bit and do that unless someone has concerns, it's going
to be easier than applying and sending pull requests.

--O8txgz163g9adksm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNtZMsACgkQJNaLcl1U
h9D4zAf7BAdmu24FzKu8K/VatxXXCPdtwbu8htaSXj1JNOmeGwQq1PghD43yTI2D
w09fTstt6knzfqx3NI991TN+bU4EQhXBRpYbRqoDiTMeB6Ov0X9GOiugQNuplkwO
tAn56mY3y+59XOeqkq8V4dC8DcvRqoZqIgVqFjguhUtCgH1BURUXfa8dbChg3jsI
HxTcpmlQCeQwGTypJC3B1v78Z9rlwMm2xlm3u4uxzEwWcFSUz1T7T+z90a/GzlL9
1C/QqTZIllH+HbabJ4Hb1Jt1gdGNqi5ZmMghTSF5XRMkWQNDN9QwuJ2hLDZ8ti0k
942m5A0H518y12xFzo3EJ0zJmx62Lg==
=3Mhi
-----END PGP SIGNATURE-----

--O8txgz163g9adksm--
