Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D68606666
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJTQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJTQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48F19ABD0;
        Thu, 20 Oct 2022 09:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF65061C9C;
        Thu, 20 Oct 2022 16:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9214EC433D6;
        Thu, 20 Oct 2022 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666285124;
        bh=+OES5EZmhZxEwIIx+Cvwo2LLTdxU66Lge2u2Lr27KyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABYCw7v9z008luI93/k6ojwUsiJVDhhwK0Rr0PWe5lOLGSx/h9XHHzu/KF5IJDvn7
         wUOdqSbmRoLZ2h4pNO99kpGAOmc4ZbGeWSjyCmStJLme15Rw/2RCYcI0H0Lj5XpJBs
         7hfpAC9JQ6Eq3fY8XPb/CujLwjFlGfUWiPKVcgQ9F+b+yTQc1t4Ob0lcIDxKhVAAq8
         mzOesEITBmWyDH1MdIsHWCsmH26o1tLymb7gvTvhbXPqxGU2m5k0zThm5SMMeE2xmL
         iMeZ1S/iNhNAGBvbilhJLSEW/r5uKmWt79qcof+T7JnB6rJ1VWVytzXXlfloCI3a2j
         xUsO8vzMoC8lA==
Date:   Thu, 20 Oct 2022 17:58:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1F+Pw52nN195qDO@sirena.org.uk>
References: <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aJUxk5TzEVqHFiLi"
Content-Disposition: inline
In-Reply-To: <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aJUxk5TzEVqHFiLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2022 at 07:42:09PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 20, 2022 at 05:25:15PM +0100, Mark Brown wrote:

> > That's true currently since you're matching based on ACPI ID and then
> > have the lookup done with the ID information in the acpi_device_id table
> > but IIRC the patch was replacing that with some device property stuff.

> But that one also based on the IDs, it's not assigned without real IDs of
> the devices on the certain platforms. I don't see how it's different in
> this sense.

The driver won't even match and therefore load if it doesn't have a
lookup for the device with the current code, the type code comes from
the match.  If it has to go querying a device property then the driver
can load but end up with a device property it hasn't ever heard of and
end up misbehaving as a result.

--aJUxk5TzEVqHFiLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRfj4ACgkQJNaLcl1U
h9CYlQf/ZGasWtKFi/8Brya2HvpljMvaunGOitRyKwPyy32bw6LW76GE4b3wHW6s
BEOdvkvxeQK2M5KnnNWDd+0oWT7VRAoBMPmKJwWoCvq3bvSUyaF7goab7RzWs23F
ArKFyKsVgIE8tAraucAejv38diL4U/JR5KiNASMz3F3lp/jFTm0qsn3s7+jzp2Yh
pH79k7uLXXX3IrWCXn+GALUeXfvPJaYcqwHvVHaEl2D0sS5aquGY0tby/cmbri+P
exFeCloVN90w9HQqlJXdOQGfIbXE0DDoOJkbRCxDJcGcteKMrgPc+tG7jNOG+V09
rDQsY6g39dVlMI1F22Q00bLjJ8pj0Q==
=sOEF
-----END PGP SIGNATURE-----

--aJUxk5TzEVqHFiLi--
