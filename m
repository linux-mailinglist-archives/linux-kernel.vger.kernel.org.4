Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDC66066B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjAFSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjAFSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:35:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A677CDDA;
        Fri,  6 Jan 2023 10:35:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF0D0B81C52;
        Fri,  6 Jan 2023 18:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2AAC433F0;
        Fri,  6 Jan 2023 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673030097;
        bh=rCzhA/52ddcfkNqEh7FMJ76ZEJnU+Wh9cDr+xpAZDnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjYrav64GXU/jG7gy7Tq7oZ+TOk6zDS56kpeFsK1eRzHMpq7uZwzmyxGVWFYtVRPl
         YKtE25439nA8eBUfj5hM2iVpQTPTqoVoYpCUr/Bj5rq2am9Wh0c7Ymn35ncXqg+CQ+
         wPkeq4r7axl5u8heHY8miJ8gb7UI3gA985aO0532XIK1y7g0mSmmEor71HxzrhkH5+
         U27wb/zJxQUzR2cvyY9oXoKVPb+g7pLxQmATinq/JirzYK2y1b7u+41pSp2A2icN4t
         DZQ3sTPSd9GuA5Fts69z71ccZByPBDwHz/6s4SFE8UrSUieXvmratJPcqi+rLPsshB
         EINBUD3Nrq+VQ==
Date:   Fri, 6 Jan 2023 18:34:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: Use a 32-bit DT property for
 spi-cs-setup-delay-ns
Message-ID: <Y7hpy91VcDZjm794@sirena.org.uk>
References: <20230104093631.15611-4-marcan@marcan.st>
 <Y7hLrxQO9GbgpW1h@sirena.org.uk>
 <6a9371e6-6516-5966-f92c-10bb228c8db3@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gz8dsIQ/IGaP9yH8"
Content-Disposition: inline
In-Reply-To: <6a9371e6-6516-5966-f92c-10bb228c8db3@marcan.st>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Gz8dsIQ/IGaP9yH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 07, 2023 at 01:40:49AM +0900, Hector Martin wrote:

> Yeah, the kernel test robot caught this one too. Sorry for missing it
> (it got buried in warning noise in a rather large rebuild on my side).
> That line should've been removed in #3 :(

> I see two patches got applied already. Do you want me to just respin #3-#5?

Yes, please.

--Gz8dsIQ/IGaP9yH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4acoACgkQJNaLcl1U
h9AGNgf/YLKaPX6bZYmFzuc9rgcJz4e+wLfOVLdyvXNxyuXADMOouc9UZUINAS5D
5NOpXgqT+zyx/I7HNYvtZ7qHbXkq2K1FR49HUcYLbGuZAbijeHl6e80k41T3+qEN
mExnNZOAb2URFnt64pbwYDA8jMbX6/94Jz5JTdXlvQJ8N0Bn1jMhYwUwCsh97bOI
o1/E58Mlq+mStedbmNEGC0j5lr8KJLWbK0/YQiJpITUKN81fb8YSlVflqwRRbkkK
H3xQp8vqNGcOlbZARTMzlOnobN+Vx1e+pWm3dA1q5cTBNDtFhbOgViy8B50ajKF3
AlV3Gyo9mgWxOdmdnI2Hs8tMV8oV5w==
=W9wq
-----END PGP SIGNATURE-----

--Gz8dsIQ/IGaP9yH8--
