Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6C5636223
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiKWOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiKWOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:44:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCAE2;
        Wed, 23 Nov 2022 06:43:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30BA661D2F;
        Wed, 23 Nov 2022 14:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4054C433D6;
        Wed, 23 Nov 2022 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214636;
        bh=Y//1b3rNjcukiNpZ5Pvh7pYLjJ73zqnquLe7wn350Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZG0A8BqvT2ORUrlb7I1sLgQbAJlUfWRx4X3QT05SHfMJHOiZi+oRORqmZj+4Ve1sr
         yrWervl3veC7SaL/o17MVgz3Dhfcy0sfIdmXTsu4djT54VPEw3RJkWavMyc6YUx1SN
         g9poRnTZVXeouBC0UZFuX6m9uQ4XqT9Rm2SZUstZY6NdbdpCNIZXXUg8rJ/rXGDFnm
         xocVZ/NP1GyqV/SPtlOUK0KMz9pz+BK8ggFE9KJ+P7VJYkoo1Jc9GcfSQ0yDAa9SVX
         zznkZz4xqfL53zsXyhV3+8pHvNOb+T4KROZfGYgEnEdEcDbd2YXbZBbjcYD5dpvcKV
         yktlDGX0NXmHQ==
Date:   Wed, 23 Nov 2022 14:43:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] memory: renesas-rpc-if: Pass device instead of
 rpcif to rpcif_*()
Message-ID: <Y34xpkf4c55D4VRc@sirena.org.uk>
References: <cover.1669213027.git.geert+renesas@glider.be>
 <0460fe82ba348cedec7a9a75a8eff762c50e817b.1669213027.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BKAJETaVx6g41XLW"
Content-Disposition: inline
In-Reply-To: <0460fe82ba348cedec7a9a75a8eff762c50e817b.1669213027.git.geert+renesas@glider.be>
X-Cookie: I'm rated PG-34!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BKAJETaVx6g41XLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2022 at 03:41:21PM +0100, Geert Uytterhoeven wrote:
> Most rpcif_*() API functions do not need access to any other fields in
> the rpcif structure than the device pointer.  Simplify dependencies by
> passing the device pointer instead.

Acked-by: Mark Brown <broonie@kernel.org>

--BKAJETaVx6g41XLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN+MaUACgkQJNaLcl1U
h9Bcugf9Fq5kxq2SwxU/HdgpmKvb/nRaHNMV7D4mCFZNMxmkwUY4eMNTKzbpvly3
D4lSGL4xRZWS1hQVR4EK5Xs5BCj2PqvvYhNTAM4BLDgLP/qK/+8B9Ezs8PuSYDRg
CRyR3HF7GGKhP0NM8Vj9+M+OoldvWwfAFp5wx4kp5henzsB1zSuwIs90Z4FxsQTN
IiCpmwcBJrmDQcBwYeZL+rGYiVWfs5xm/7WPt/E5ssbMGXms/cOnhjMZHgexSFEv
ZPT3WyWEY7Ka01Ri1OxtooAIgdQ3BHnxEswLJbAhJj5Reb9kPfvl8UN+6h1iV1f6
jLNoNQ5Gr5aHbQCbbs72ASpRcUqCqA==
=evAV
-----END PGP SIGNATURE-----

--BKAJETaVx6g41XLW--
