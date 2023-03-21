Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F156C39CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCUTHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCUTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:07:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986421204F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ADB2B8197C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E0FC433D2;
        Tue, 21 Mar 2023 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679425619;
        bh=+P32cAz65GI10wW9cnhAMWCM0l0Lw9uUhzDfwJyuwN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8/RFya4LC+xIX816XivxfSGwEzXaW1j2eelq7rbclAiqxB6pIUDOxZfQiLQIWPx9
         lIs+Az4hNtzc5/w05xkNRoSEpdkqMNtdrduXvnFkg1pICw7Li9XM2qAUx5g2B//+jt
         CYcYXYN42HRNWqmCTJqoOsAWu5vA7JODvp81nvsxFq7u+ux+xr68HsYVqorG/ZWK0B
         Q9YIkU1G8U/IUaXLNXn7qq+8uXUW6wKTX6yYcLL0dsjBBMXn2SKpqz05LyizalQ3O6
         6kPH/UCf6IINoSxcNRW5xYQLuqAs0zD+xSyt9Zc9uzS1DuAWnj3PBQpWnJXvt888MD
         oe14SkC2UiDnw==
Date:   Tue, 21 Mar 2023 19:06:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Support CMDLINE_EXTEND
Message-ID: <10ecb85e-232a-4176-bca5-6c393200b291@sirena.org.uk>
References: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
 <ZBmS28ciIei5sKHY@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dCizFyuleEbP+tel"
Content-Disposition: inline
In-Reply-To: <ZBmS28ciIei5sKHY@FVFF77S0Q05N>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dCizFyuleEbP+tel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 21, 2023 at 11:19:55AM +0000, Mark Rutland wrote:

> We deliberately dropped support for CMDLINE_EXTEND in commit:

>   cae118b6acc3 ("arm64: Drop support for CMDLINE_EXTEND")

> ... which was mentioned the last time somone tried to re-add it:

>   https://lore.kernel.org/linux-arm-kernel/ZAh8dWvbNkVQT11C@arm.com/

> Has something changes such that those issues no longer apply? If so, please
> call that out explicitly in the commit message. If not, I do not think we
> should take this patch.

Given that there have been multiple attempts to readd it is it worth
documenting this in the code?

--dCizFyuleEbP+tel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQaAE0ACgkQJNaLcl1U
h9DoNAf+ImhcL+QNyURJON8iluAeuiA8oT3Me4GnlrbQrIPpAMPiTkmkm+tujngc
4DigRLMjJwTkyptpABOp/t1kWDbTX0bui48eNpZ1Nmtmhx8AkGhHKrcL5NlEgvQ+
N0jgidyrqDaycNdBzqcI4ngmP6GC8dT1LYuBjZ2qwYS5s2nUwrjYY3T93zlIbvaB
m6+lPtfg24izWG66pOR8U1+m8dVVqorI9f9r8Q1B85AyIRMYMQ3tQAhvR17ImjAJ
Xp3Yfrs0iYrS66dFo2mUXoj4fk+t6zMa40qD6q3MvlAqZis1IcbfYmFCjV9iBUNL
fg5sM2NO/+2fVStIr4+z0MF1+DVOaA==
=zWJm
-----END PGP SIGNATURE-----

--dCizFyuleEbP+tel--
