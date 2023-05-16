Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D557051F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjEPPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjEPPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC46A79;
        Tue, 16 May 2023 08:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCFF160A77;
        Tue, 16 May 2023 15:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F79C433EF;
        Tue, 16 May 2023 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250295;
        bh=TBIu8knwYZPtwYq1olJQ/VmcM7zPEFoYsoBU2zYDa9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QL1F3AIIV8aF1WETsjV5gwGquwJAWUIc+/gt+vKX3e6p7q6LtR1mzbNDGD47tdZog
         s9uWuTRNHHL7hkP6GqfQmPYdPfqOHKXAxgtpaJtcMWmLcNTm1PrpEY5nQ0Kt6Xsgak
         Qe0vgvcDnoX2vbMKHjH7fSYJGQmp5NXINNPIEtN5xHwHcqNGr7SZe3EyH7FOfCSWyx
         4cfE24ABzR9GjU3WNcTxQhaSFNYcfMa+Q7mmyjJGzlEsNZXH0HebhvWT74tN1bMbKu
         ptzP7rsmLWULlYCOnAWO/JMG7hrVsa1aarifeRnIBepFjuOapv9XyLpcMghur/t8Vg
         DzGrYiYxKPS4w==
Date:   Wed, 17 May 2023 00:18:12 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 2/8] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
Message-ID: <ZGOetCW+MXAvFicv@finisterre.sirena.org.uk>
References: <20230515181606.65953-1-blarson@amd.com>
 <20230515181606.65953-3-blarson@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ItvP3zGlvQYoSZpX"
Content-Disposition: inline
In-Reply-To: <20230515181606.65953-3-blarson@amd.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ItvP3zGlvQYoSZpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 11:16:00AM -0700, Brad Larson wrote:
> Document the cadence qspi controller compatible for AMD Pensando
> Elba SoC boards.  The Elba qspi fifo size is 1024.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ItvP3zGlvQYoSZpX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRjnrMACgkQJNaLcl1U
h9AF6Qf/YaEvaRgyBh7zYDffA8qs3vZxt5laeIpAFhS6j+HAPvoVfT/PoBHe/Hnq
a4P37guGmSwpB8ElH13fTWt16D7Wy0qTrN0dTEkakXbM73A4sOus0SxRRNbQER2J
9K94W9Go0uOpHD23XXl2Ntdlz8urwb5mhYwzxH3PT+Z0CHznK5WCevCdMSOnk98G
OY5hK8/R0opwnKglttC+/+IPthVME85bI1ER8zSMShL8gToVon0v2zvH8a3ngMfl
ryQDdtRcHkJ9Bvf1VdVcdX+SrfRWowZS32pDOdCVQvWWcaV1KdQm9aWf9xVccYAJ
+MYrObAGPLCyMuEfPOVqh2oiTpiBCw==
=SZNl
-----END PGP SIGNATURE-----

--ItvP3zGlvQYoSZpX--
