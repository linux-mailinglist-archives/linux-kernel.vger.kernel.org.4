Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB36D5E74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjDDK5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjDDK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C52710;
        Tue,  4 Apr 2023 03:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 023FF631E5;
        Tue,  4 Apr 2023 10:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42886C433EF;
        Tue,  4 Apr 2023 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680605662;
        bh=MQ47cjh8Q+yXUWyD5joNCWQybA/cTmAQwogQtzlap4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogttNBm8hx5IFbh8OWzseGPygdv7hb/2wGW5lMUy20rNw19BgHyl6GEAR7S7qdXKG
         zZVRD94nLt/c0WZrL7v4oNUu5kNp3uH14uQR9WFR9/lWt3sU+VGf3NUyKLduoaoRO+
         Iv445Q78k3ojHY1hFRRYizu+l1v7IbbWisq+yHhZsXv+L1Bs7sN1smlVMEtU4f/xWE
         /C8cP4WlIJbAAeUjfSHP/EG8YlmYOGjlm6Ioun1Oq6kRLGqZTsUNqeIMpkSU3EQMd+
         PKUkG/8BzGpuWvczaqI/p8s5hz9iKjGKouwJ81llTxjQvZ9Lc4YlvCfjmZWErE+8Cy
         5UfR4K7LUgS8Q==
Date:   Tue, 4 Apr 2023 11:54:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 1/3] spi: s3c64xx: support spi polling mode using
 devicetree
Message-ID: <a4a9d1d1-c5cd-460e-96e0-6db8048518c6@sirena.org.uk>
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
 <CGME20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9@epcas2p1.samsung.com>
 <20230404060011.108561-2-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NAJae5+Yyc5ThMF6"
Content-Disposition: inline
In-Reply-To: <20230404060011.108561-2-jaewon02.kim@samsung.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NAJae5+Yyc5ThMF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 03:00:09PM +0900, Jaewon Kim wrote:
> This patch adds new 'samsung,spi-polling' property to support polling mode.
> In some environments, polling mode is required even if DMA is supported.
> Changed it to support not only with quick but also optinally with
> devicetree.

Why would this be required if we can use DMA?  If this is a performance
optimisation for small messages the driver should just work out when to
choose PIO over DMA like other drivers do.  It is hard to see this as a
hardware property which should be configured via DT.

--NAJae5+Yyc5ThMF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsAdYACgkQJNaLcl1U
h9Darwf+Jk52mkwLL2rRQdC2vB6lKPF5wgWUUpeSpU3hkwx7p3lfLAF3aDgC4Fw2
8rpkC0V2VwVFnMM1sc99s2pAXcsjWTarYScyhHGMoBFprKADPIxe+nt48OELCfPi
uNzCJ7v8Pkt1LhivmWro78w9p15kKJd9C7tTrB2iLcA6pW+HX1GmjCeCRlhnB4A4
ph+ocMmdoqoLYC2+wN8D3uqNlx1W/ilcv0bnlJQP24EFqHKakkd08feppDMJ2qHV
0skrEUoI3srYGeRkwaNLBuVQVIQqClYlvueqS8Pf1KqWMkVVPtCMBjaRIW0Clb8s
k5qQCPLtw37gRXf/yCYjnsMpnytfqQ==
=v/Yo
-----END PGP SIGNATURE-----

--NAJae5+Yyc5ThMF6--
