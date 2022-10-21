Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811296076E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJUM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJUM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850F25FD19;
        Fri, 21 Oct 2022 05:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FE261E89;
        Fri, 21 Oct 2022 12:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7FEC43142;
        Fri, 21 Oct 2022 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666355337;
        bh=rUfmKUVVhF0scw8S6Lvg2qPCOJ6YwdzD3PAu+1AM4Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCvwmHpic3i2uDkdhSPjGfQoVfVCxgzxE5fUGQtaxttlkz8JMZEUZpy/CzSu3UCKI
         Qehfg0dCy+9fkF5I1W7UlycagaIkvVp1DV7uBlHAudnYrN6vxXSVYc9SSq+BOwX7lT
         uV57rKKs+JfAz0uDEe8xrwn68ewf9v3r2IErcGFh5gZBS36kp1YE+8OS1DHKi06ltm
         sQYvbbuUqHKdTwAFjENvrJ+e9n2OZTdcBZOfBn/2q/6pTBt4lYFxPo1kw3LVcDL98Q
         QFqtusuaaCwfbqVnFxhJ2oeGS2ROkLIn55K8oqlaVla0vXDRbg2b4Mnh+oi4WnwIi2
         96GyVg7eSQdQg==
Date:   Fri, 21 Oct 2022 13:28:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1KQhMwAWQ1/k7E8@sirena.org.uk>
References: <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
 <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
 <Y1J3lyrygPvVGUJw@sirena.org.uk>
 <Y1J5wx63bzq4tnik@smile.fi.intel.com>
 <Y1J7iJ967d0I83oZ@sirena.org.uk>
 <Y1J/by2TGbaYgoDq@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZasPzV9OCJWXG6dT"
Content-Disposition: inline
In-Reply-To: <Y1J/by2TGbaYgoDq@smile.fi.intel.com>
X-Cookie: PURGE COMPLETE.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZasPzV9OCJWXG6dT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2022 at 02:15:59PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 11:59:20AM +0100, Mark Brown wrote:

> > On DT based systems resources can be named by the firmware, I don't know
> > if that's possible with ACPI but as the name suggests the driver gets
> > used on PXA systems too.

> And how is it related to DT if the enumeration happens via platform driver
> code? As for PXA this is all comes via board files:

...

> In the current code and after my patch series the priority is that
> the driver data from the spi-pxa2xx.c is the first. So, if compatible
> (which is by fact the only "marvell,mmp2-ssp") has named resources
> that exactly the same as LPSS for MFD, nothing will change the driver
> behaviour.

> For the ACPI there is no names for the resources so far.

It's not so much does this work now as will this clearly work in future
when someone changes something, and will any changes that are concerning
be likely to set off alarm bells.  I'm sure it works fine now.

BTW the new property isn't added to the binding document, though this
case is a bit iffy given that the intent is apparently that it not be
added to the document since this is basically working around the issues
with ACPI not being terribly descriptive, the property is very much not
idiomatic for DT.  Having it in the binding document might actually end
up being an issue - from that point of view it'd be good if we had a
namespace for things that should never appear in DT that didn't look
like a DT namespace.

--ZasPzV9OCJWXG6dT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNSkIMACgkQJNaLcl1U
h9CYWQf/WxYDZEVizItGMMbdanK6wyt9ruitratllbK6YDu/BkeZy/p+z9Z24PXS
zPKnjg9qzLhLYfLoAah4bM4dW+AJoQo1YuNXmVy1OtoA6W08wV/tWgfw6va+THZL
50lYTkQnnpQ9B4mlcWc3QofDJrLbiwCE05yLPMN+oVwHWARywRtOwHDXvyk0OO91
pQ6ZtdDrb2bu0uc4MPNzS4LZihA+Qey/vNa4h5ANSBrlSviUfKweG5D1WlEVaTsf
99fE862qAPZP0VK8kee5nK3US/zpyX+GOYj4zNVNhEiyiaVlCrrkbHTIi0cKdnIl
VpIeg1ijOrVfsLSep0kgqmixmGDuuw==
=tD18
-----END PGP SIGNATURE-----

--ZasPzV9OCJWXG6dT--
