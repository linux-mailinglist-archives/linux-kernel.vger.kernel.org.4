Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0650260753F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJUKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJUKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:42:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71DB25F1E8;
        Fri, 21 Oct 2022 03:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EE54B82B93;
        Fri, 21 Oct 2022 10:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B943C433C1;
        Fri, 21 Oct 2022 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666348956;
        bh=6kFhXO7wLcwrPbLp/Is1Y5U8BGHez3TkK1IWMQHhqxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0AKj4GgQXB36jdY/13p5VwOQ8qJ56X1AfCGK+5zL33D23Yo7m/RpwfCrtVFfq9eo
         ityhy56nvvgpnofyLOoYjQj3FY0Md0wJWfi+PGronUKLYsGhlxTzuwJ3z/QKjlXGDx
         vWFFFGJyMU49KfremOXKxTtaxW71rNPAm2ir4Em2zV3PxbqURzZd4gS8yAymCrTpW6
         TJVdQ7eYa4I30DTAoyhFXFpMoPEJO7kOAWs5LCdzRnnr26+ocI7fxsgxVekX+gREZH
         yqxslhjKpDnDHB1Y++VDBCng4qB16TQzBQ1vCI5YR9ZdHGSlGS/m7Pu8LrQx3gGEKQ
         g8AA9x7uY5Rlg==
Date:   Fri, 21 Oct 2022 11:42:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1J3lyrygPvVGUJw@sirena.org.uk>
References: <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
 <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lhL2Ud7ORY4pUWsg"
Content-Disposition: inline
In-Reply-To: <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lhL2Ud7ORY4pUWsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2022 at 09:19:06PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 20, 2022 at 07:07:10PM +0100, Mark Brown wrote:

> > Remember that device_property backs onto fwnode so properties can come
> > from _DSD properties too since fwnode will query any source of

> > I think the code would have to also check that it was a
> > MFD child at least,

> That's exactly what I'm talking about when said "named resource check".

Like I say a property can come from any firmware interface.

--lhL2Ud7ORY4pUWsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNSd5cACgkQJNaLcl1U
h9C1lQf9EHBaukWZgnG40NiujExN8BFbs61PRd0hLFpgKAZ0qH/Lyr6Rld9KuA0Y
fNqeZz303UJuFR8MnqBaWyyT1bZvsONCUDBDc3GAqwr6ss/OJo/Ygh6rQORnhOFb
zLDcLpBm3qbJt9tZ0hwYGcMZhZ/3I+f3+Gfb9SHibtTGWiSKeGL1mFY9I7DdpwV1
xPTdCJo6xhM5JparciTlr70bITnSqDX1HRPjspVM2Jah1sigmiHj5ULt+cZRv74h
wJjJloy5R9z6tr+5u2j7NNOpcHbNMDvjJKupxImRdW6M/uxyM2E4KgQ1NSLcW/EG
cmkKSjlojaY4vSG84B/CgyO+wt7AcQ==
=RFDr
-----END PGP SIGNATURE-----

--lhL2Ud7ORY4pUWsg--
