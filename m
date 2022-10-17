Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BB601594
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJQRm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJQRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BDC73917;
        Mon, 17 Oct 2022 10:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A3A5B818EC;
        Mon, 17 Oct 2022 17:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA88C433D6;
        Mon, 17 Oct 2022 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666028540;
        bh=z5gk7qFJmRqhLojhv9oCw+vP9v7YgMUdkrPHdgVRejA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvborPTJm5o2F6AY0iDZVW2ylSq+hDm4GiIrqLUFBoQQ4/pkAkRhnu/6p2X3ZZ5/u
         GyCpk3gbLLmRqUkC5D4J2UpIlLx+14XqybO9U8EKmZ9sfop5zkKMlIQGak8v5rrP88
         FzVO7FFrqGppljvYoVu3eG1i62ULYPFlEG2dgN/hsX4p7psksodKRp5GujYtHKHpZm
         jSqmmab3bnyL5Sb0FsE31DHKtSzwC4KQB9TP2Lncs+IoCTASedPMT6NB16ypEn6pmM
         sYIKE6YDlPw3qduvyxmghzvuMl9COZtCI2rNaNlSIodFPgE1W2YhT0jSSnxcY0DErW
         NdW66HvM/R5EA==
Date:   Mon, 17 Oct 2022 18:42:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y02T98CUTxX5fbjE@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l6uEA4glJ7IzHxV8"
Content-Disposition: inline
In-Reply-To: <Y02TR0UBseEKUjq8@sirena.org.uk>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l6uEA4glJ7IzHxV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 06:39:24PM +0100, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 08:35:16PM +0300, Andy Shevchenko wrote:

> > Currently the board code assures that the property is always there for all
> > existing devices.

> Which board code is this?  The names of the new properties you're adding
> is really not at all idiomatic for ACPI and this is pretty old code so
> it's surprising that there's not existing systems that don't have this
> in their BIOSs.

Incidentally stuff like this is part of why you should write cover
letters for your serieses explaining what they're up to and/or provide
much more detailed information on what's going on in your patch
descriptions.

--l6uEA4glJ7IzHxV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNk/YACgkQJNaLcl1U
h9Cvtwf7B0cCbo/Dk+pBFmJxrJQjLTlgEa1/F9t90hsKEpHbcah9o0TBOF+K3GF/
glYIl1nw7eKZtGYh0T3PN7p9Ng/GWaEapM7IjEW0BzQXmEY4k0o3t9KwJNLUVpzT
ILmykSyTuNzOID9gXiJUuHG3O+d+JrrRh/FdAm4EWxZ07LyQKdpvaTJlwMSKE3AG
go0AmPOlVpLiBybYoCPDAmt39w3+0ZnQYm2zCQIJAnCG9cbMYxFT6M3VMAX63yZT
0Kd5q9BZHBsgezptu3oFKExOiFUY7tYt98x1hQHbM7JT5IlQg7qVLWq+jM/6faaK
irQpsxf/OPvmCOwPi3KBpVtbjOkAkg==
=p7rw
-----END PGP SIGNATURE-----

--l6uEA4glJ7IzHxV8--
