Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D46897A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBCLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjBCLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E61E9D5;
        Fri,  3 Feb 2023 03:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B0861EEC;
        Fri,  3 Feb 2023 11:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1EBC433D2;
        Fri,  3 Feb 2023 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675423218;
        bh=/YwI5RdW92UD8iPcM1ouNlKTHt+ZcMmHFtc5PRvHtz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ju8eZt8zlpsjhy5mXjqYOizgjb+p6X1nND68YU3iE3/eFRyN5VEZWx/0MFiAlFlKn
         uW9qDsB+c/LM4WZPtjdiInWvHfpb5KznNdzjDYp2KB5CZYfA1TJylcSAOm+QtYexyy
         Nnc3wTWv5l8YECj9atN+AuM67AEN6rvVBevugkVCUSzxzxZRpW071soJtAjVFA2G42
         5APnMitPkwuIoukhg+/aMXprnarEO7CyKqhK2kAQbTRxL160TwJpjdwLKtoJIY8PzU
         iiBrAqQTp0IkVCqI2sSh5Ps6Z1Gd0ZjMVNx0fVUia4EWJmStSutPiKoQs1MFEsCTjy
         C4Da5v77or8bg==
Date:   Fri, 3 Feb 2023 11:20:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: s/a SPI/an SPI
Message-ID: <Y9zt7glBMhHeZezU@sirena.org.uk>
References: <20230203081119.69872-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BaLGJ7B/3otdqkkZ"
Content-Disposition: inline
In-Reply-To: <20230203081119.69872-1-tudor.ambarus@linaro.org>
X-Cookie: No animals were injured.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BaLGJ7B/3otdqkkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2023 at 10:11:19AM +0200, Tudor Ambarus wrote:
> The deciding factor for when a/an should be used is the sound
> that begins the word which follows these indefinite articles,
> rather than the letter which does. Use "an SPI". (SPI begins
> with the consonant letter S, but the S is pronounced with its
> letter name, "es.")

No, this is wrong.  English is really not regular enough to do anything
on the basis of rules and the more commonly used thing is that you use
an when the word starts with a vowel (frankly I've never heard the sound
thing before).  As a native speaker "an SPI" sounds wrong to me.

--BaLGJ7B/3otdqkkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPc7e4ACgkQJNaLcl1U
h9DDIAf/fZQ32jDyD6h7qfIg0GxE/klY+rH9LvF2bEeO+lwePkfN1glWUCDWSTYz
5knWzPfrodjdKgOBYmCQ4TUUjr/9TqskFnJURWJg6nr7ZrYEiRyR+gxBZMuiMrQr
Vfw5H0HtSgWvN5nsXkKVojVsbkGFkhAmUoATxyyuhO1rFD4DLyZT9DRQAEkqmksC
EN5Yf802+C84T0rM4GCFx02aUCjtKHSHMQiiWFvPrxGnduFHW79+K1x8dINzTZJq
OsLUMvVnWO5UrDwRFYEwz25J8FjJHXuR9tU90/5h2cLHmo1KzeZdoCDYrhxx45Oq
7EFjxKEvZbS76g/YcULdL6V/fAIZ8A==
=tKXT
-----END PGP SIGNATURE-----

--BaLGJ7B/3otdqkkZ--
