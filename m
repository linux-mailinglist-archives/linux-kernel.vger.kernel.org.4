Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB66EE73C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjDYSAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjDYSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47651720;
        Tue, 25 Apr 2023 11:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4931563085;
        Tue, 25 Apr 2023 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A05C433D2;
        Tue, 25 Apr 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445628;
        bh=x80D28o18e/C/P9T+DcQ5fd7ID5U6WPNI6OKMlgG70o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dm7bd7ynWhuvuKSBn3hLmfewfDOtWDlhTv80eQDM5mXWUoFh2EgB4r269ms8cWHyD
         QmhdgsJ1lqGjyTr1ayGBPSKrbU3++r/NYZ0qaF1s4RByQ0ZvDSf70oUFAdP4W8PEpZ
         y0magV7PPFOubxWv4JvK+YG8jFkAnk/kjsAgNqDQk+5GGFKnN0v7b4MSrHMn3SbuOc
         FBsBBXakREPxRlcPHJtgxyC19vTdS6qCk68YjK8wKrDz9/uZzXEKuICFq5xX2S2HBh
         JOkCdWjbfqLmIp1Gyo2wN+x8CzWpDswAoiLWIqV63qyvd0RSAi/IhAWx3by5edhZjL
         bX+3uZoSGrbjg==
Date:   Tue, 25 Apr 2023 19:00:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Gole, Dhruva" <d-gole@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Message-ID: <e67e0804-78a8-4326-92ca-6214825f0ceb@sirena.org.uk>
References: <20230420121615.967487-1-d-gole@ti.com>
 <8edb48ee-55a3-4cc2-9c81-514ec867b35c@roeck-us.net>
 <602392dc-de1f-90bf-3deb-cb5cee81e41c@ti.com>
 <ed33a2ee-9c94-818f-b4c0-bc0257207a2f@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sKtAIKhfZi5laQLY"
Content-Disposition: inline
In-Reply-To: <ed33a2ee-9c94-818f-b4c0-bc0257207a2f@roeck-us.net>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sKtAIKhfZi5laQLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 25, 2023 at 10:37:24AM -0700, Guenter Roeck wrote:

> Personally I would go for [0] as the least invasive solution, but I really
> have no idea, sorry. I just hope that your (broken) patch doesn't make it
> as-is into the upstream kernel.

I've applied the SIMPLE_DEV_PM_OPS patch which seems to fix the issue
for riscv.

--sKtAIKhfZi5laQLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRIFTMACgkQJNaLcl1U
h9A8gAf+ILotP0s7fUSCAalc6Ml3HPKN8u5NbT2dXOipDAa7Jl1L9J6UBjac/tEK
0Bf+0aAqXymtgPThoGWQ6LRBy2yoRUuGpyKBqEH4WaiwJU6F5r6bhETZbrH6/EG9
UhC+v0OU6yZrQ6XVo0sD4D81+MCAO95xkfPMCwR9GrLwXLWcsPSnVGqht9j1EgmK
+Oxrcu5yByYxYTPpcMRAOZ9OMBD7khDf8O9HDwAZiErLNZrMWviS5uj0/4gy8ZgU
3rHq+WBteVJ2hwgiGMO9lA4Lhu5LD+/50wyimINkxkwmAGVIjwmHKbpVVVoO+yzm
DvUpy6c0NM+lOgRAaGWPon+eCUF3mQ==
=qDn6
-----END PGP SIGNATURE-----

--sKtAIKhfZi5laQLY--
