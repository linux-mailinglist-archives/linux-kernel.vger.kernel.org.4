Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B660158A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJQRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJQRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060092BEE;
        Mon, 17 Oct 2022 10:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A3F611F1;
        Mon, 17 Oct 2022 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA361C433D6;
        Mon, 17 Oct 2022 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666028364;
        bh=8grgGtOyTm/CU++FV+Ku5FUMhsQs+sluMrbJ+0HQLnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bw8MgKUXpnQCb5SlkccuyWTyHbLacQifRe6TYtldaJHMEC94cRW3y5KccTT6I+PIM
         gVq3tLXA8nV3HwfC0xxOe1LSs30BzDbTZcEX/J9R0tNODrDhzH79Bvir34d3btnytW
         VzKIenNoiAk1NFjYpLXAmYJaV45QHFdXz2WEALrHSicypE/DfbMmbo4bj5t/jIIvQg
         rmpy2GHfe5CM9HLHzNu+kW5Viol6WaF5XCsJV09icddtsihaYl/qUhvA99Lr0T4Epv
         qjmcTrFFCf0SJzfevLTU9Rr+MFrnaR1Q+l0O/1oN/FZrhCCNkAin+HdY0zmy8kp3yY
         +47BBAQkPaVig==
Date:   Mon, 17 Oct 2022 18:39:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y02TR0UBseEKUjq8@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9RA3DR3f0X40ZY4b"
Content-Disposition: inline
In-Reply-To: <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9RA3DR3f0X40ZY4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 08:35:16PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 17, 2022 at 06:18:38PM +0100, Mark Brown wrote:
> > On Mon, Oct 17, 2022 at 08:12:40PM +0300, Andy Shevchenko wrote:

> > > Since the PCI enumerated devices provide a property with SSP type,
> > > there is no more necessity to bear the copy of the ID table here.
> > > Remove it for good.

> > They do?  How?  Are you sure that this is true for all existing devices?

> Currently the board code assures that the property is always there for all
> existing devices.

Which board code is this?  The names of the new properties you're adding
is really not at all idiomatic for ACPI and this is pretty old code so
it's surprising that there's not existing systems that don't have this
in their BIOSs.

--9RA3DR3f0X40ZY4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNk0YACgkQJNaLcl1U
h9BbXAf/UKtY+JaR2/DAce9XeCjqhsTxVsGu3PI+fc2vJuiYY4tWV1cNHwThcioC
l07F+gs9cRBZ8UMqJq1XipQJ7+dLGz+z/JcMJfEmqBof6you0bwd+MOHI7FriK1A
EoCMQgR9knp51ptEks4nPNFu1jPXhbqB/UAjo4WZOrgxDN1xn+00vYaYpApWKXje
MjbZhQGplIMCIzJfkU+e8G0Hv459FT8awEjexQqQxGkVtpXC12Gkvsb8bb5GvA0s
gQp9bur+L/vRcGHm13AoEuI6nHU2SajQvRUSR9m9NRC0yKYt1wJUHcC2Y3fz9cUf
LieE1wuw8+GY1ucH9Nrsv+dvMvQdoQ==
=qmPX
-----END PGP SIGNATURE-----

--9RA3DR3f0X40ZY4b--
