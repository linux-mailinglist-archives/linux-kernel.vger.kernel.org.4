Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA76511D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiLSS3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiLSS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD201C2;
        Mon, 19 Dec 2022 10:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7FA9B80F10;
        Mon, 19 Dec 2022 18:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57783C433EF;
        Mon, 19 Dec 2022 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671474543;
        bh=aW0dVnR8JS/OKjUma5j4aUt68NrJCAPoT1ee88MBEfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1PHbN/Gh4KN+Q92/sPb7C9cW4yu98PLjRqg3qXoY0nMBqRYHYgXYbdZBlRkXOlKr
         ztbehJ2Ij6+vq5swdJpS9N5TOKDFsy3Pbc8IqdagQrsPN4cPqFH/S3gpcsnnSKaYT4
         X4wn+/GvUfBYmscJjg6mlJ4GFE3wWgMxe/51d+QPKmv0J8nVJOWd0HBNHCwASe2DXq
         DAmZi4MlcOCgFAwvPiI228bl8UpgtkK4F7KwGrdYneXabN0+d582FIM8JiejagrcKF
         vqDd9vkphlaFVUMW6WoLAWcYHWYXKEiOa+K+9PJNEbdDXtPk151kkDbAO5re03S6Pv
         l04s8erhaHcDA==
Date:   Mon, 19 Dec 2022 18:28:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Witold Sadowski <wsadowski@marvell.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
Subject: Re: [PATCH 7/7] spi: cadence: Force single modebyte
Message-ID: <Y6CtaU6pVoILUwkx@sirena.org.uk>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-8-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DIUCFWWQ3PJbaoV8"
Content-Disposition: inline
In-Reply-To: <20221219144254.20883-8-wsadowski@marvell.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DIUCFWWQ3PJbaoV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2022 at 06:42:54AM -0800, Witold Sadowski wrote:
> During dummy-cycles xSPI will switch GPIO into Hi-Z mode.
> To prevent unforeseen consequences of that behaviour, force send
> single modebyte(0x00).

Fixes should go at the start of the patch series so they don't depend on
any new features and can be sent as fixes.

--DIUCFWWQ3PJbaoV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgrWkACgkQJNaLcl1U
h9C8hwf9FEDogm7jqnZ2QMURFzw2cKgYSoIxQVmm+MmESxUAxrOa2nxqmWIwpyvJ
vHBS1Wcezt2hOcpT1cyGj48TZWFAou2CGAIa5OPCtdi1DawPbndd87cbId2WjrAK
iH2dZsTmerZhTIrVo2MIofq1RR4qLw7DoeTGHfOgyHCGqQ9bQv6YTMrRu33mmM0B
iq3UwPi/FdNzG2yFtkr8aH24nswkWBfI9oxsPmoMP/b0FiM2/VsWt2Zjh0enxFf7
Ki9eEpO596Zf9dIZ2UirZJqYj07c2aCz+ubzLoZ0q97ZKL6GZ7P5G6vtWvyzo/VR
Haik9/J4R992HHM3J7xjgqpDb8Ptkg==
=/MRZ
-----END PGP SIGNATURE-----

--DIUCFWWQ3PJbaoV8--
