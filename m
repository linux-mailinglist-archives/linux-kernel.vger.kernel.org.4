Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3E602A73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJRLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJRLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548FE89966;
        Tue, 18 Oct 2022 04:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228C561537;
        Tue, 18 Oct 2022 11:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC77DC433C1;
        Tue, 18 Oct 2022 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666093328;
        bh=4eBe311Gl6JCjZC6GnoWSvoql8JiRYBOk2S/5ZU1VKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwQhT+b5Eq90s61tdFJ7dy11DE/xXtyM85NQ+RmSvgyzNtHASkqe9gSz65BMH2nQ6
         Y5RzjagQIjwtGfYniHmjRVavScPhju6Q6+cd7L4qnWcKl7sdti9le+NSCh32quXSbP
         S0FVpPXRE5AW9dnbELbVs7cuzkE+KNcwxA9sjTQCuwc0/fBmZH57tqERvUCCus/DRy
         Vgq8vlEkEkzO8pQXQHQUA6Wx1fII+3ehR4fEDM6SvfnEf6SkKoau3dwTYx4+G6fWJm
         wNsFcfMUedy7Rj2k/4GGXW3tDnDXdX936KlP63+4w5wtp+4ZtV0uu45C+Xh9ADbIdH
         VwkwEwCUo17KQ==
Date:   Tue, 18 Oct 2022 12:42:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y06RCxzwrPZwIETp@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b7Oq47z4m21j2l28"
Content-Disposition: inline
In-Reply-To: <Y02TxHp53XQo34ql@smile.fi.intel.com>
X-Cookie: Lake Erie died for your sins.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b7Oq47z4m21j2l28
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 08:41:24PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 17, 2022 at 06:39:19PM +0100, Mark Brown wrote:

> > Which board code is this?  The names of the new properties you're adding
> > is really not at all idiomatic for ACPI and this is pretty old code so
> > it's surprising that there's not existing systems that don't have this
> > in their BIOSs.

> drivers/mfd/intel-lpss-pci.c.

OK, so this is another push for device properties for passing stuff
internally.  Please resubmit this series with descriptions of why this
is being done - I really can't tell what the benefit is here in concrete
terms, you say it somehow improves identification of which variant is in
use but don't articulate specifically why.

You should probably also restructure the code interpreting the device
IDs so that it's very clear that unknown values are handled well, this
would split things between multiple subsystems and right now the code is
a bit fragile.

--b7Oq47z4m21j2l28
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNOkQoACgkQJNaLcl1U
h9CI3Qf/elavao3fuoGtG9QTK+EwdTXH38yIA40iXhb3RZk9LFhnDGu6i+c4kfNx
13TCX0W4ndHXG6l5kNgc/Di5RlpvS3kVj538c78lvm27BRlJv4891IGeicXLZshx
esOamwfkxlCyxaCMGQcr+xFWC0edeKv80cirnD6tPKohbbQ4CVULRxbDGN5jI736
m7CvhCZZ3kEBbw0oCe6z3M5+9e4YT2yiwADg522ft3nfZSNZnLNsWuC8U0ZAgISN
pqd076eRvOrG/VNdMxG5tc8ylA5Ao62cRnvNNfme5p1hHmLKHJn5xJ1b1eXkwaea
1/jKDhK/pXs22oxdLz5eml64JNCwQg==
=ZPrW
-----END PGP SIGNATURE-----

--b7Oq47z4m21j2l28--
