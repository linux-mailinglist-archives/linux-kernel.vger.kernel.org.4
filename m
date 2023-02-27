Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7CA6A43D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjB0OJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjB0OJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:09:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23EF4222;
        Mon, 27 Feb 2023 06:09:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A3F60E8E;
        Mon, 27 Feb 2023 14:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3FCC4339B;
        Mon, 27 Feb 2023 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677506972;
        bh=ZrX51T3bj5l6PWQT6PquHiFIL3Ckc1PPjA85uQwSV/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qK96yYXJuVTbSEnSrKFzn36zkCF3brWyKICgfsk1+r2UbNAButkLGWVAb++x7iq9U
         8MfRPXH9acHVHj2FC2d8UIkV/O0n120wBN2Ow6rhATNgGcussL/1CbNwBu5gHtU5nG
         IxTlYMJbGH6TKGgXrHV0DafGIi9kXqzrMx7L05eO0OLlNmEKmcfOtfVjwGut/HFMjM
         vKRTQx3hUB19wcPj0qF66fJkV2BH1P4Jiq/QGA/MoEecr1Ev5mFFW1Mn4lHf/ZYTi8
         oV/iEZqta9DgeWXiCrJUiUE+ybDAVhZKyotSxZPp1O1dFY0ADQVPErsS+EEkp8ie1T
         mGZZugiqVY/OQ==
Date:   Mon, 27 Feb 2023 14:09:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <ptyadav@amazon.de>, linux-spi@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-sn-f-ospi: fix white spaces and improve code
 formatting
Message-ID: <Y/y5mHklSYINwnA5@sirena.org.uk>
References: <20230223102918.985376-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E3uVSNsRZkeCHrbH"
Content-Disposition: inline
In-Reply-To: <20230223102918.985376-1-d-gole@ti.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E3uVSNsRZkeCHrbH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 03:59:18PM +0530, Dhruva Gole wrote:

> Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")

This is clearly not a good fit for using Fixes.

> Allignment issues in all the macro definitions of this driver have been
> fixed for better asthetics

In what way?

> -#define OSPI_PROT_CTL_INDIR			0x00
> -#define   OSPI_PROT_MODE_DATA_MASK		GENMASK(31, 30)
> -#define   OSPI_PROT_MODE_ALT_MASK		GENMASK(29, 28)
> -#define   OSPI_PROT_MODE_ADDR_MASK		GENMASK(27, 26)
> -#define   OSPI_PROT_MODE_CODE_MASK		GENMASK(25, 24)
> -#define     OSPI_PROT_MODE_SINGLE		0
> -#define     OSPI_PROT_MODE_DUAL			1
> -#define     OSPI_PROT_MODE_QUAD			2
> -#define     OSPI_PROT_MODE_OCTAL		3

> +#define	OSPI_PROT_CTL_INDIR			0x00
> +#define	OSPI_PROT_MODE_DATA_MASK		GENMASK(31, 30)
> +#define	OSPI_PROT_MODE_ALT_MASK			GENMASK(29, 28)
> +#define	OSPI_PROT_MODE_ADDR_MASK		GENMASK(27, 26)
> +#define	OSPI_PROT_MODE_CODE_MASK		GENMASK(25, 24)
> +#define	OSPI_PROT_MODE_SINGLE			0
> +#define	OSPI_PROT_MODE_DUAL			1
> +#define	OSPI_PROT_MODE_QUAD			2
> +#define	OSPI_PROT_MODE_OCTAL			3

As far as I can tell this is just removing all the intentation which
differentiates register, field and value - that looks like a clear step
back?

--E3uVSNsRZkeCHrbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP8uZcACgkQJNaLcl1U
h9AT+wf+Iz6NiD9htps/GXrMKp7hG52bv7Evyotkrw0wj8spIx1ACpodFE9dR67t
G+W0yvnmmCfC3sWlh8iq2hROvCQYnXOLJGW7ZvdMv7rm0bKIqWg0JNP4zrB0KPwr
fxhVgrPZejFsBCSOyfnF8Wpc/aj2FyTqGy0SZECZUugHl2H8yp7BtGuAWhCKIcxS
6B29+vuZ8gDWi6/TZKQPVijJ5ydgcS6518H7XFuOPf+q8SZuVSuaPoDbYEJHvp5A
cQhYiMSRUsjQ4Wb2S0xoBPEBzJ9bAa5BGWw6DVKqJWN24dSSeFw6VCJmhhv1mYZz
QnnvjuLi3n3vN6jAD6DK2KAxAnYHxQ==
=oakk
-----END PGP SIGNATURE-----

--E3uVSNsRZkeCHrbH--
