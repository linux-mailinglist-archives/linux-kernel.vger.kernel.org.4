Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCB61857F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKCQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiKCQ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120F13DDA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D40161F87
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CBDC433D6;
        Thu,  3 Nov 2022 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667494746;
        bh=FTOzZ6uuZquSbfOFcbmiJVcKYlIrxiylJP0Pypj4WRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVp5ebEyrBAdOKgLvZ17S5/agU+9m6wqTGurLuVumanr/j5nGDfYG3U2SMi+tFq8W
         cXZjWepxb8/DkPYppjDcQiUc+k7xPpOeXKQY9E1hcX6kDxeJwlsAxIO93dza4Ifh/n
         i2/AN66fojadK0w0IJjAl2ie2OYwo+0EaU33pTGPCoZYoFebzKVuE8/wnhfutzeG4b
         2mcS1plJwyd8/NULmUMNMTh9gbKP6mBk1JYHZpOnBekYh7ZS/JuARAPQDwT5EMb1jc
         zGuRyay8PjK4D0riVWoBPFtUVXfSbEHNgNGRpZk5vSmr3QHQduztE5kXtlt4kScl9Y
         cVPBL6gYShyXA==
Date:   Thu, 3 Nov 2022 16:59:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     george pee <georgepee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Keith Packard <keithpac@amazon.com>,
        Austin Kim <austindh.kim@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM : Support for optional ARMv8.2 half-precision
 floating point extension
Message-ID: <Y2PzVOzuuKU7r6Lz@sirena.org.uk>
References: <20220912132501.1812575-1-georgepee@gmail.com>
 <CACRpkdY96uPTKgxK_LkQjTuqtd3GU=VYmGDg1zWqsyoxo0Twog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aHGBJ8p+9XjYutzF"
Content-Disposition: inline
In-Reply-To: <CACRpkdY96uPTKgxK_LkQjTuqtd3GU=VYmGDg1zWqsyoxo0Twog@mail.gmail.com>
X-Cookie: Dead? No excuse for laying off work.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aHGBJ8p+9XjYutzF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 03, 2022 at 05:18:21PM +0100, Linus Walleij wrote:

> Please CC Mark Brown om FP extensions, he is looking after these.

For arm64 anyway, though this is targetted at 32 bit kernels running on
v8 hardware so still somewhere around my wheelhouse.

> On Mon, Sep 12, 2022 at 3:25 PM george pee <georgepee@gmail.com> wrote:

> > Report feature /proc/cpuinfo as fphp to be consistent with arm64

Well, more so that applications can discover and use this feature when
running on a system that has it in a way that's consistent with how they
might do this when running on arm64 kernels.  It's also adding a hwcap
as well as updating /proc/cpuinfo.

> > index 990199d8b7c6..5d635dce8853 100644
> > --- a/arch/arm/include/uapi/asm/hwcap.h
> > +++ b/arch/arm/include/uapi/asm/hwcap.h
> > @@ -37,5 +37,6 @@
> >  #define HWCAP2_SHA1    (1 << 2)
> >  #define HWCAP2_SHA2    (1 << 3)
> >  #define HWCAP2_CRC32   (1 << 4)
> > +#define HWCAP2_FPHP    (1 << 5)

This is adding a hwcap for the feature in arm, if we're addding this we
should also do so for compat mode for arm64 (as a second patch in the
series probably).  That will ensure that everything is consistent no
matter if the kernel is 32 or 64 bit.

> > +                       if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
> > +                               elf_hwcap2 |= HWCAP2_FPHP;

I'm not super familiar with the 32 bit code here but the change looks
reasonable and seems to match up with how DDI0487I.a describes things,
arm64 checks ID_AA64PFR0_EL1.FPHP but there's also requirements which
mean that the 32 bit ID register MVFR1 be in sync with that.

--aHGBJ8p+9XjYutzF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNj81MACgkQJNaLcl1U
h9AQVgf/XLSLX7Tc9OZO8k+qmAbSgXitfynTaQ8XFDOvj6V/T3bfFHgjG3yI/5j3
n6X2ywiWjX/hNsHVXwnaeG9c99/7LXrs/FR0w1NXdGSwXORJhD4MZ6zVzjm3okvD
m9Uo5+pJMd4A1LRI+DQdniD1akIoj52xjier6H8hz7TxrbTlk8fGvr1E3HFqeGEg
fXMiexO5sdXsuBzjwOEcNKS2mZokshJEGVl4ofweCfMS58YWaKQGuyAsGnvq27Qe
0jj6ZgA7RKoRm83ydgXUF7i7DWnupzAQZMj9zH6ERuuxkZ+jY8cc3tRNlxETX7uq
vMbO95tRl5BFHqPPAAdJb0t78hZFRQ==
=zLAB
-----END PGP SIGNATURE-----

--aHGBJ8p+9XjYutzF--
