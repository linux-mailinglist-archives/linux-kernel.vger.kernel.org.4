Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4272255E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjFEMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjFEMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDFDB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4862D60BB5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A95C4339B;
        Mon,  5 Jun 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685967397;
        bh=rW9dgDXI0IuBPS08+EyfBd4DNWbcr76ARJXZDYeuLbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyqUr0YNdNZYVb2hd/+b4lb1PcLGSdcEue471BELdw6hOWY8Ys/QyfrmRKoQ5/IRw
         9KPxNUz0I+tsyflhv3RpK6pHURxR8mwypvn74LQK+1AC3EcxOL5dsijBLNUcCW8RQX
         MyNzEtGqwiSm3ak4y2wW9vyYdjhpjneopIoyuD2BKcWzlTynGIJx/lzwKRaEtz/GPz
         VhCrXk4+B154sGCCgzzcGsh122DDOwiRGE2K1pnEjAJae+MqB3klu1yD0O3udO/541
         +Yb+LyfDyxvxKb4mJoQ1Xq1HAH3P7g2wnmE1fsmTjOgsCM0ie7BAY3dDmk2dEmcqFS
         CWVnaCcZpB/vg==
Date:   Mon, 5 Jun 2023 13:16:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
References: <20230605104830.68552-1-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0oO7Zo9cWYTLbwt+"
Content-Disposition: inline
In-Reply-To: <20230605104830.68552-1-raagjadav@gmail.com>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0oO7Zo9cWYTLbwt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2023 at 04:18:29PM +0530, Raag Jadav wrote:

> Convert ->get_mode() and ->set_mode() hooks to read/write operating mode
> from/to hardware instead of relying on driver memory.

Why is this change being made - what is the benefit here?

> While at it, map fixed-frequency PWM regulators to REGULATOR_MODE_FAST.

Don't combine multiple changes into a single patch, this just makes
everything harder to review.

--0oO7Zo9cWYTLbwt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR90iAACgkQJNaLcl1U
h9A6kwf+OqMF+3d7LmP0EcpT8N5evUuexunsk7rR2aHeOHqL4VK4TX+gG4lkmBHM
4PYtqrL5KkEaY10yAa6VCksusLeO7fHiErCPgBM4OdzEzGB4hAHIIt9L5dvEv8jK
F+x++v7bOi/MVA+dLP2IcPKTwlCCx9aHwTJfcelH6NmZ3fmbJCj+JyP/tYeAWJkw
iTccVIB9fJhu3Cqk8MK+0Dwd+ToSFxGL2qEaqpoNk9opDzMemHC01JjixJmDVTJd
HCGBkbtz44Jw3jwwKjuFXspbtKt53EmtbVbpMwnPIjFKMdtAx+D7mj1Rxve/uPLf
z7eOIcUhDqyyK0wCHpNFe3JQwR6J7g==
=ReKK
-----END PGP SIGNATURE-----

--0oO7Zo9cWYTLbwt+--
