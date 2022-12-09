Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA74648296
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLIMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLIMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:51:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A9F5654D;
        Fri,  9 Dec 2022 04:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43B7ECE2718;
        Fri,  9 Dec 2022 12:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750D4C43396;
        Fri,  9 Dec 2022 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670590271;
        bh=l6iQ7xL9UgI0P6o9KPYO7dLEzciOii5ZJrs3IMg8bQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abQxTjgutG9xtPqL/42nIPy5W0gB/wewQkRXXEhXsi5LlesduDiR81v6dGqpvsLh0
         XhVKEbRX7AYJpgjlcD4ijIvc5UqqfDKou/V1Ou89clO0z8e7PviRDnHIad/H5nBUui
         SxPZPQRp+XX0RM3NIfFhM4z/lpVguGa9IS43KJ9iRXvUdZ4jkUgpZ0/HFNFan94Jgd
         eEhvlCJeijjAlb1ZDNh43EkXDK5sp+GM9XaCWe3v/UGNR+gt+9qxxhm0dS0A4WS7y8
         Jj6grVzNKF90keO4UeSjelT3wuFV7rOyv3MNUpDE/69CjqAAJVFYNV25rbkKDttvVj
         R9vlGssn/Zxjg==
Date:   Fri, 9 Dec 2022 12:51:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC PATCH v2 2/3] regmap: mmio: allow reset control in a MMIO
 regmap
Message-ID: <Y5MvOp7kLoEJfwkk@sirena.org.uk>
References: <20221209013309.407879-1-jk@codeconstruct.com.au>
 <20221209013309.407879-3-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vo6Tx5ry7wCBatdt"
Content-Disposition: inline
In-Reply-To: <20221209013309.407879-3-jk@codeconstruct.com.au>
X-Cookie: Who is John Galt?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vo6Tx5ry7wCBatdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 09, 2022 at 09:33:08AM +0800, Jeremy Kerr wrote:
> A syscon device may need to be taken out of reset before functioning -
> this change adds a facility to attach a reset control to a mmio regmap,
> and performs the necessary deassert/assert operations on the reset
> controller on attach/detach.

Managment of reset feels like something that should be done at a higher
level - typically reset also implies losing all the register contents
which means it should be somewhere above the cache layer.

--vo6Tx5ry7wCBatdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOTLzkACgkQJNaLcl1U
h9AobAf+Ku+dEoKODV9xdIeqEwytNwQb2u35kHQnnJKq4P43eeHNL1TOkHdimrSx
sBElcYnuF/+G/F1eHMWoPJZ+zlpM/aHlLcMFJi8uS6NuLm4EqXctPZwFaRP4epv8
5zYbwBGgu0uzf9+zDMkTrP5sNqepcumcT3Jaakm3pqibrPMNdXIBR74noj7wH/gQ
UEOtB/thETWQlWqUmoc3EP+i2P/7ZN32gbgOBr+r+9X7XqeEEak5w69z0Kx/sHw/
DpfeEABsF2S4zBNmQCn0tg8qUlq5lzjlPzQJiMAaHLby0s1XVkGeOcyJubezEmFK
3sfIa4sY7QWSCEcSZKsRcKxXqY5+Mw==
=i4KA
-----END PGP SIGNATURE-----

--vo6Tx5ry7wCBatdt--
