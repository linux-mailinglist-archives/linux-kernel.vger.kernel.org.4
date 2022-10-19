Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37302604C61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiJSPyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiJSPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D14165CB3;
        Wed, 19 Oct 2022 08:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 167D6B8218D;
        Wed, 19 Oct 2022 15:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350A8C433D7;
        Wed, 19 Oct 2022 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194642;
        bh=TY0orbEGAOiH0r7H9/+KMm1DE/25ye2aBok9lDV8vYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAvVf9qHvZSbnxF4rWxem1TXbTcB2AQYvV3ItRL9R8oyZn3OQxr7PoDzbpESS1ccN
         nabYm9MriwVHXGdkdviV0ogluz5Wjx2XRQnO/kgLskRGj9JQuDWD5mNXeKz+2tDTpR
         AqYBjY/Yq9jBRENayBQ80c8i3Y7VcWx/TOio3xcGOueUOBvsKP/5ifNrWpHhv0xWoa
         43WBn4eIWzULVxsG7SES4UOgu+BHKiSe4ZoFehNIoSn1mif9HZggQ7JaJHZe4VnyyI
         2jPKzulvNawFffm9DStftmaCmfKvVHcRbUrWv0hJoySoQKACbysUG0LYDwNduQn01a
         mm+QCB5cP1oAw==
Date:   Wed, 19 Oct 2022 16:50:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1AczgwCEQO2gvQ2@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ga4n4LOd4R6Pxo1E"
Content-Disposition: inline
In-Reply-To: <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ga4n4LOd4R6Pxo1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2022 at 06:06:04PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 18, 2022 at 12:42:03PM +0100, Mark Brown wrote:

> > You should probably also restructure the code interpreting the device
> > IDs so that it's very clear that unknown values are handled well, this
> > would split things between multiple subsystems and right now the code is
> > a bit fragile.

> I'm not sure how better to do this. Any example?

For example a check that the ID is one we know about.  IIRC that bit of
context looked like a tree of if statements with no particular
validation.

--Ga4n4LOd4R6Pxo1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNQHM0ACgkQJNaLcl1U
h9BxeQf/R8ORB1eWSBIDqdmIwsmxYy0xdAyOWoTLlsp3vG6yb44uTXnz4OSf3uS8
IYAgxO+NyKhGj1lunscjTxrd74BnNSCKmC8Iyz2vMzucWN+vUosMzTpZX2i99Vdj
c0YfG4elcExFI9TZUd4ZecWkWfuWoUgnOnMMwBMRAe8WmXH2gfu/+gANbv+Izjma
sJOIWbIsPlEs0wHjFycI8t+6Z11Bk6BJ0ucUa9m9EvHpiGQ9KMyiS90OUuaYUGbu
Ktxo1RQ/E3k9AK52d+2ydDFcMan9KRmfVykcD2ND7q/mbHoGiapn2rsKVBsDpQzu
nlSvZXL1iUaAxYabNNUB5hFT/UeCUQ==
=UUDI
-----END PGP SIGNATURE-----

--Ga4n4LOd4R6Pxo1E--
