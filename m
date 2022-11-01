Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC96150D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKARgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKARga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:36:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C61D640;
        Tue,  1 Nov 2022 10:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B323B81E7B;
        Tue,  1 Nov 2022 17:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8937C433C1;
        Tue,  1 Nov 2022 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667324186;
        bh=l2/BGInigMpzUkkvNeiIzvRne5n+cAy/QymsCTZKTCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVyk91WQE58CYUvXZDLz3pczrjmayQOVsgd5oArv0+VSYem0mvtE7Gd4SyQhQG2SI
         pNtTXmBLmCIvYNSJXH5YzIgl7VZQeUvfd/ocSDtQO9ILQPU/1YG00sXOEOaYNkMvd/
         LYUk4O+G4HV5nwkPwJ+rdisrqVBnrg4jDfLC/5uQ3BTUwVrBQxjdelaPi3S7AhsWzf
         68DqVN7ZVYu9VNKztjpyUGIdQVIDex/HCuRmeHWapSawAiXJCqyN1cis7PkV39FnX4
         8Z+3acGsfNk32BTHxd/6JNxjmyrRq7F23cdkb4zUTsQLKPNZ7MCyUggR2dsbZk8yBt
         HXN3kurnKhFcg==
Date:   Tue, 1 Nov 2022 17:36:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: spi: Update reference to struct
 spi_controller
Message-ID: <Y2FZFuAvLCRmnhFo@sirena.org.uk>
References: <20221101173252.1069294-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBGaeP68nRHPkeus"
Content-Disposition: inline
In-Reply-To: <20221101173252.1069294-1-j.neuschaefer@gmx.net>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBGaeP68nRHPkeus
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 06:32:51PM +0100, Jonathan Neusch=E4fer wrote:
> struct spi_master has been renamed to struct spi_controller. Update the
> reference in spi.rst to make it clickable again.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--gBGaeP68nRHPkeus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNhWRUACgkQJNaLcl1U
h9BRlwf7B0mnc1fXywUeFOn6ugStBKXYFIOvrouynvHyJGp/8iQtjyPe0+kmQ6rK
aZl8LUVpUFG2n2YUbkMUL+0wRmo+JFM9/gycnZ+sAgyCu7tPnEhHhpTg5YXSo1JZ
5kjqa6WLvEw5ZEMCKVO+VWLuEsGPeOVcfZqQy6k3T2/knk0PtoBHG1ApvDAfz3jg
0FRfgTcyoC6+bvaNz1o1hAaHwJO7JZxrYOk9UgyIMCUsNKxEEuS+EqK7Kt1CS1jO
mpF32w93t+DqfBIAG/HLu7F2HbkRAVx/C8DjHZIPPtGUAg/7px+xrfSzjaIdBeZ5
FlSoPTjpCmU0ZPtdZNzspeoHQ6joug==
=gAQ/
-----END PGP SIGNATURE-----

--gBGaeP68nRHPkeus--
