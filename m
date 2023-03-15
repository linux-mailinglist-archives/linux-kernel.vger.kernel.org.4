Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477036BB498
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjCON2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCON2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:28:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808242FCD2;
        Wed, 15 Mar 2023 06:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 330D6B81E0E;
        Wed, 15 Mar 2023 13:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DBAC433EF;
        Wed, 15 Mar 2023 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678886906;
        bh=hSN/PN4SjnN8pAdgwBQiLHZFDiKFUfSkoGZW3XRHvRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+3XgYKDjgdt9UNQb7eXSKE6lfZp0H7iOhghiHvmJcXwXaEiuQPspq+me8em9nBSC
         2QHEj2mS9J0kPcyPCiK6qbfpZAsitVspmDwPzAAWygE8fFzPAkTJdiYrXbDS7EssCH
         dUgcFJSYh3atd2vsGzLsnIKrqmqeujbZiSNiiW3MaF+3UB+rK8k1BdispmstNPJhev
         xjQw+8xDrqpUyn5T8C9UzqsatNGQPbHamfDSJl7JrLhG6I2a16XSKCaMuUwDDGpkJa
         QuI7ss7bUoMxy72pRGrKjDpO+0IQrsJ0YWBGK+N+/lI1K721xebOoOQeyFdLAKcujL
         1ihLVKjjJMU4w==
Date:   Wed, 15 Mar 2023 13:28:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] regmap-irq: Add no_status support
Message-ID: <70a1d89e-9940-4669-aa31-c06a5901859c@sirena.org.uk>
References: <cover.1677515341.git.william.gray@linaro.org>
 <bd501b4b5ff88da24d467f75e8c71b4e0e6f21e2.1677515341.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YfCjUwijemfX+Aru"
Content-Disposition: inline
In-Reply-To: <bd501b4b5ff88da24d467f75e8c71b4e0e6f21e2.1677515341.git.william.gray@linaro.org>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YfCjUwijemfX+Aru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 11:45:22AM -0500, William Breathitt Gray wrote:
> Some devices lack status registers, yet expect to handle interrupts.
> Introduce a no_status flag to indicate such a configuration, where
> rather than read a status register to verify, all interrupts received
> are assumed to be active.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-no-status

for you to fetch changes up to 4d60cac951fd2dfbf261b83abb805748abc8b995:

  regmap-irq: Add no_status support (2023-03-05 23:38:50 +0000)

----------------------------------------------------------------
regmap: Add no_status support

This patch adds support for devices which don't support readback of
individual interrupt statuses, we report all interrupts as firing and
hope the consumers do the right thing.

----------------------------------------------------------------
William Breathitt Gray (1):
      regmap-irq: Add no_status support

 drivers/base/regmap/regmap-irq.c | 22 +++++++++++++++-------
 include/linux/regmap.h           |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

--YfCjUwijemfX+Aru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQRx/UACgkQJNaLcl1U
h9ACTQf/VLd9rRIf0jAokd2afPdlphtcdCig/HITgE/k6UzAd9WqYcNC4aYElYvq
nFu4nNfsDqh8MzLeNr2IahhOBiXTcyU5d2I7wV2CzgOKh+kK0/nxk17clrtoT4Wa
iF3Y5Sqi4JkBfYLvTMePqJ0nmtBz/d2nWSn2+AvrflnBJWjCBLt4maIondtwf672
2tr/aPFqPrLjBSIN3TqH1L8sVCkneV13XAsVM88cEVEBnGZXiA9Ny41KIZjQlZbn
gJoyYNBy9NVa6Oc/m2AHPNJbxfQp61wsHpSb/hoT8Uuped1Rwj8Tt6Mdq8xR+gqh
x3/skObTicxY8CdzAxJWiJx3Ni0LvQ==
=QD26
-----END PGP SIGNATURE-----

--YfCjUwijemfX+Aru--
