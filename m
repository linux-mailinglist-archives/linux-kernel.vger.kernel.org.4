Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914A6A7358
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCASVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCASVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:21:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D748E36;
        Wed,  1 Mar 2023 10:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23670B810F4;
        Wed,  1 Mar 2023 18:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2F0C433EF;
        Wed,  1 Mar 2023 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677694891;
        bh=wqx/ay0lHpap0j1o8/uAn7LRcJL/k2DLH1o8Z/z6h0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzCTM4zVdbFlr/Yj8dTkxetxALlN5Vsc7dJw2b5baow95qFrV0GPfRl/91Rv0lLhR
         aol2CdXu6ZMXSFa3j8TOd04lKwsCNjFg1R2xOwHd69AV1nwBBOGkOxXEgfLwoFRI4u
         91zzFsrptMaNhCwztjWy2z57ZpaGEwCSl4WkxHYHqZK450n9eXCse4bxxcdD+7yZMA
         /MbX05PHHJsmtelziQ9uxRgOJMDmcP35BTzDWciJlmc1EHmU3T6Mc52R8U91F+pG83
         mGmyHDQbcinS/B1E5Y19JaLc5U2I8RkwvEjW5TE/f0ChrfKYxRGuKZvywQ4ChLW+73
         kKcvnDvj41JzQ==
Date:   Wed, 1 Mar 2023 18:21:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     dhruva gole <d-gole@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <ptyadav@amazon.de>, linux-spi@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-sn-f-ospi: fix white spaces and improve code
 formatting
Message-ID: <Y/+XpoWFBUkdhPYh@sirena.org.uk>
References: <20230223102918.985376-1-d-gole@ti.com>
 <Y/y5mHklSYINwnA5@sirena.org.uk>
 <067ff1a3-a00a-9e19-9c6f-8d446915efe9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wfm4XllFJqu+VQRR"
Content-Disposition: inline
In-Reply-To: <067ff1a3-a00a-9e19-9c6f-8d446915efe9@ti.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wfm4XllFJqu+VQRR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 01, 2023 at 10:49:31AM +0530, dhruva gole wrote:
> On 27/02/23 19:39, Mark Brown wrote:
> > On Thu, Feb 23, 2023 at 03:59:18PM +0530, Dhruva Gole wrote:

> > > Allignment issues in all the macro definitions of this driver have been
> > > fixed for better asthetics

> > In what way?

> In my humble opinion, the spacing between the MACRO names

> and their values seemed a bit OFF. Like there lacked

> consistency for example:

> OSPI_PROT_MODE_QUAD			2
> OSPI_PROT_MODE_OCTAL		3

> Here we can see 3 is at a shorter length compared to 2 from their respective macros.

These look perfectly lined up for me.  I suspect you may have your tab
size set to something other than 8.

--wfm4XllFJqu+VQRR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP/l6YACgkQJNaLcl1U
h9C/5Qf+PXcuRjOeh6VItzYbjCCDUMt4FRzOmMxWzofzFDEnGe3wpTLhHnI+llqy
BVEvdTo0TV1idw68Eth6FgYIMnqDeKs6d9DFaVp80JqktanlJZfns0XmMlKijTqM
JdcBZEFKZr8/CMvosmg8qDwWBa6Hsq7Lz/6D1zayMXvg/iF1Or6wh3L+jCfgBcdf
Uk8/g2i4sqakd7zMJGbGcV8PTtSBMcx5yJIcXCsdNs81SrPmdrX//gicmZBQH28l
bxvKbheWohwzKGyl6oVS5W2k5pjOgTte4ym7JPl6J9dWrPXG9Hm+nH1NoEn6VWdu
AN0JctJkLg6CnSVz/988G+/JARAwOg==
=yHzB
-----END PGP SIGNATURE-----

--wfm4XllFJqu+VQRR--
