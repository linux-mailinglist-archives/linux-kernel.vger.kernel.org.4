Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3D64BA88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiLMRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiLMRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:02:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1423393;
        Tue, 13 Dec 2022 08:59:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D104DB812A2;
        Tue, 13 Dec 2022 16:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E73C433D2;
        Tue, 13 Dec 2022 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670950786;
        bh=YSTfl8Ar5Fd58DF9UKjLVjEKlNxb4ToAynQ4CQcDe9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bU1UIoiWKh3a4+AJEc0JXh6lfyd7PbfjBSBbXzFrGeWmAYi0upv4ND96jcHDOUItA
         0R2pTNWAGCtRqWjyOO0/3n1dO+4A5ttPoACqJRcfnQLAwmztz4ymnntcYnq1a5inS7
         wvXfG4redS4DLbtIP8fvDIur84kuE44X20n2zwZFawv80BT9r17bIxCVnFT1p5iTyr
         u1LbIi5y38c2KKJSSp+LX5omeW013ntKxOdv008ksie097/Cx6jYu+rhjbfc7nFmQL
         d/7MOaik/pG/tkmt2rv++qehz5S6tI4eiqbG+GngYlSgAoBUxdy8gJJQwCniF/Li6R
         R5XVi0LlaCyhg==
Date:   Tue, 13 Dec 2022 16:59:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] spi: dt-bindings: snps,dw-ahb-ssi: Add generic
 dw-ahb-ssi version
Message-ID: <Y5ivfCku1P4CTFn8@sirena.org.uk>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-15-sudip.mukherjee@sifive.com>
 <20221213163209.GA1684072-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMfuxWKgPby+TTtg"
Content-Disposition: inline
In-Reply-To: <20221213163209.GA1684072-robh@kernel.org>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMfuxWKgPby+TTtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 10:32:09AM -0600, Rob Herring wrote:
> On Mon, Dec 12, 2022 at 06:07:31PM +0000, Sudip Mukherjee wrote:

> > Add new snps,dw-ahb-ssi version to the bindings.

> Really, this should probably only be a fallback with an SoC specific=20
> compatible. Future quirk properties which are not board specific only=20
> will be rejected. You've been warned.

Given how widely used DesignWare stuff is and usage in FPGAs it does
seem reasonable to have compatibles for just the IP rather than SoC
specific ones - we do have quirked versions that have been modified but
these are things that people manage to deploy without needing that and
SoC specific compatibles for FPGA instantiations would get painful.

--NMfuxWKgPby+TTtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYr3wACgkQJNaLcl1U
h9BCaAf/fD085DyORxSTc8lbNoVat/RXRzbrrj3SjfTj8DEuSrXrsU0t0BMTzXKE
Aj7XucH8bnKhZyN48oP81OVwztEblNdCx2AMKG6uTBeW/JUIk6Fdkr38sYXkTyWG
/FfyTj96szuD+sw21unz9s8kcgwuGjN92gAekAPFkO0hwFotpwmGr/6JfWx5OKgT
hclIBQx+ake1WWbVvq3g2Ie3mep7eHuQ1dNEvuus/neLnp9iSCHu0pU43PGT4YVx
UeOxSHD8lVFbw3boxsjdZtRiZDaHeUmai08mwOklMYwT8EbJf7rEcranZHDOExHy
CbnLNazlgkXa6zWG9yub5bEiVjAbRQ==
=vqgK
-----END PGP SIGNATURE-----

--NMfuxWKgPby+TTtg--
