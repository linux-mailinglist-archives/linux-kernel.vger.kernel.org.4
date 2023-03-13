Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BE6B8159
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCMTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCMTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB620686
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8BC61481
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FCCC433EF;
        Mon, 13 Mar 2023 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734307;
        bh=KORTFgFdvQagikwog4b50U+ODlaBFFnq9VjvDRcEimk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X91o+WM27Ke7uzkjnQi4lJPqbilHYldc2F4PCjjZLuTl7+F1/osnbqWJ7N9AQ4+GR
         gySBZ95fTBZTZfMl1O9E8J0aJ1mpNW31rLSbu2SGgfBUfG8l09wcijTVRgi3YZJdf1
         9Vog3feilrtjkoc+ha/n693LClRc6nZ/ZUwcwiBX3VHf6b0cq8vy24ranqh6gZx2pg
         RezTCZa851NydJ5h6wyMFPiSChatFjgCEh9+3LZInnu8/WcGVY+PoPEzNXLpLdwRAS
         y5liiyvMpfdpOgzWFAv0zHwA24m8598zsOW4uyKStQ2IcR2PtH+Cehi3NL43qb6V+R
         8mgAk7r5m0a4Q==
Date:   Mon, 13 Mar 2023 19:05:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS
Message-ID: <89bf362b-6c63-447a-ad4b-91385bf26dab@sirena.org.uk>
References: <20230313181820.2482385-1-dianders@chromium.org>
 <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="InRxaj+dd7oaT8FU"
Content-Disposition: inline
In-Reply-To: <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid>
X-Cookie: Type louder, please.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--InRxaj+dd7oaT8FU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2023 at 11:18:20AM -0700, Douglas Anderson wrote:
> As of commit 218320fec294 ("regulator: core: Fix off-on-delay-us for
> always-on/boot-on regulators"), we now might have a big delay during
> probe of fixed regulators. That can have a significant boot speed
> impact. Let's mitigate this by preferring async probe for fixed
> regulators. The regulator framework itself has no issues with
> regulators probing in an asynchronous way. The fixed regulator driver
> is fairly straightforward and also has no issues.

This is going to be true for all regulators...

--InRxaj+dd7oaT8FU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQPc90ACgkQJNaLcl1U
h9ChVQf9GOF2fRY1qNJhWc/iWYjSeyhLcI0hVoS/gH89oNJCxMUdV8Bq0U/dqC0s
HG9DbZCsUM41JJehkEhCs7sydcrB2BjgvKlqk9JXxKVJVyPsvLNv3z48fqn9sUjI
gUv4177ygTRFzBRY4NluS9NRD8CUD0dE5Tv49V05egB5i49WW3ra14tzHIanZMaX
i+7gebrvhC8YwKDSKkK4DVE/SQkey8u5yxZ7QifX1dyu0tymvHnNudrAQQrD+jXW
vwjFf1QUSNM4mh359X1Mts6TmSbKxiX7FKmmRWDY+lrVJdL5LHIP4YusxyQw+Co6
aHg9akZZZZA71rDHgrTeZSrF2Qeihw==
=0q/4
-----END PGP SIGNATURE-----

--InRxaj+dd7oaT8FU--
