Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5C667ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjALQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbjALQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E353885
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FFC062085
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E331CC433EF;
        Thu, 12 Jan 2023 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673540820;
        bh=6B18eQK7F29TeAZAl4w4ZRa5vzYBaXl0zGGzZeMr0jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9E2tVfE55rLfk0/DL67Ga5vqStFqbGyZXHBHVjPf+gcyh8FD3DrLmPIhAb2JJwEA
         5FAIhCH2YQeV7ZqR2DXB94jZGQr5YH8wbfDcBuLSgV20GWBNiz14/6pb96tcUm1DLo
         rbMEEFfjftvd2x1JclwugCBQBxDVozvVZe4pxppVX8foAhY+fRSzQCABKShuhdJ1t6
         cnPzMqOlWjlWWbZsg1uV2TTqjb1AKBPkk+l4BnSY/dtapSnn9Tzw1pBfsfPLz9/Qi+
         6EXYTkLUPV/FEKqLUlKlBkyO82sAGKFHUqn+OV23octZ7luUq+lOyGOnOxAwGwBeI1
         bf/fmgVWnsNmQ==
Date:   Thu, 12 Jan 2023 16:26:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-pcm.c: Introduce a count to record the times
 of setting DAIs parameters
Message-ID: <Y8A0z1L0xUyhlxT2@sirena.org.uk>
References: <20230112065834.580192-1-chancel.liu@nxp.com>
 <d83615ae-10d9-ca5b-26aa-522b3f10b43f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aw7vIz3sK1rpMdsF"
Content-Disposition: inline
In-Reply-To: <d83615ae-10d9-ca5b-26aa-522b3f10b43f@linux.intel.com>
X-Cookie: A watched clock never boils.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Aw7vIz3sK1rpMdsF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 12, 2023 at 08:19:40AM -0600, Pierre-Louis Bossart wrote:

> IIRC it's also valid to call hw_params multiple times without calling
> hw_free every time.

Yes, you can call hw_params() as often as you like, the OSS emulation
does that all the time due to a fun mismatch between how OSS and ALSA
work.

--Aw7vIz3sK1rpMdsF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPANM4ACgkQJNaLcl1U
h9Cxbgf/cIVKEmivx4GVL63S/XlJ/ajGggtAf9VfYwdW13CwMWZifUnINlG35ly/
gDf4bqx01WM70f0L0tGSdte7xs5L6+BdH7p41n62Hf033IpwNCaF0W4j+x4qkx9G
XuNqvI58LoEkU4u6i8+oKfCQ7sW7tKFNyliVMuLvBy5nMOkr9Xj3Xs4Elz48FiDZ
54YO//QDi3ZPytuuzLa02/Z3G0MRJkuBg3UZHF3hPG8/2DUZP/778brweyMIPQD0
8CzxqmHt09n6khLTNHTGjoGjwU2kN9ZfFR20dSjlRRyrHvvdUv+jfTqAZfwP5lo2
ezfPh8egJYcd4wtkCD4L7C+jnttGTA==
=Hz1I
-----END PGP SIGNATURE-----

--Aw7vIz3sK1rpMdsF--
