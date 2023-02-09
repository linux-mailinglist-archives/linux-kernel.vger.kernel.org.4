Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39F0690C52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjBIO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBIO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:59:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD56196A0;
        Thu,  9 Feb 2023 06:59:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4279761ACF;
        Thu,  9 Feb 2023 14:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3548DC433EF;
        Thu,  9 Feb 2023 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675954791;
        bh=yP2cdaF/taunaTm0QZJAnNFJRyoecu6bhHnrp8Jt+Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcJBozYBxqxqscY6AHa49dPW9aZyLEYOLfsGL8mb72REUDltiJAkuNAS0Peoov59T
         43bMGKAyL9onw0GjiUakTvrItihAPWpICBAGIYVraTZiFm/hwIYridH+OeKQilFOLr
         WgFN1nxLqgfx4NlaOTRx/O2pWPaHNeYdiG0ycg6JxoX5h7pqkM2zg3oN8wZCw3PbtN
         YOa8P6SYLaIWyg673wp6Al+y/xeLbCbWVJe2amjILMBQ3OTXpwnyv1IrGRzohNV5rz
         Vz53PLAwWTaeji7/D+fnk3TW4s0Hs5iG7/bfFuIs+CAME7uNpV1Z/JooldvLoZfj9X
         pbTNx6OIFwzpg==
Date:   Thu, 9 Feb 2023 14:59:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/15] spi: export spi_transfer_cs_change_delay_exec
 function
Message-ID: <Y+UKYuY3K7PUakLE@sirena.org.uk>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
 <20230207065826.285013-9-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cj3dh+KR4Pkcvs08"
Content-Disposition: inline
In-Reply-To: <20230207065826.285013-9-william.zhang@broadcom.com>
X-Cookie: No passing zone.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cj3dh+KR4Pkcvs08
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2023 at 10:58:19PM -0800, William Zhang wrote:
> For SPI controller that implements transfer_one_message, it needs to
> insert the delay that required by cs change event between the transfers.
> Add a wrapper for the local function _spi_transfer_cs_change_delay_exec
> and export it for SPI controller driver to use.

This doesn't apply against current code, please check and resend.

--Cj3dh+KR4Pkcvs08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPlCmEACgkQJNaLcl1U
h9DNmQf8CN1rykAYS7g3iYE5bg3PuHtwNLHo/MLTDjtYCIfSsUlAeT0cKHSAYa3n
MY19CwOBuo0jXSjjE7WBWMpLBqfuhHWDZQlAdNceDU7rP28hu7hV1IKOIgcCPZZw
OyvJHm9BeHsgxYA6AF7nAFIf2g1ph80Des8n7uOJUj0BXu2HCBRCH6/0Gv1ebpAB
RPykqYBtMOmgQg4RZI+vMFm6ZwQvCv8jPUwZVUWb/m4+YZDco/m84xKbUoDAJqjW
MKBLMXlF/+dpvo2nE6mfDXCMf97GFYTg01uXLN2HgR3QtPMgbPaBY8ZcgMWjPBoH
6bMIrxMcIfa4peNC+BmLLLMuYdOQ5A==
=yCyf
-----END PGP SIGNATURE-----

--Cj3dh+KR4Pkcvs08--
