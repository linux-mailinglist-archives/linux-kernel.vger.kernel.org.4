Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E005A6065B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJTQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJTQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C69A0267;
        Thu, 20 Oct 2022 09:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410A361C14;
        Thu, 20 Oct 2022 16:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E161C433C1;
        Thu, 20 Oct 2022 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666283120;
        bh=WA6ArbC///fPpUFKat2w0OyZjBrmeEDkfhpgrx6B+ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiePNk7+gyM4hfxx+v7U32xQIsBTDyQE3l+9jPy0Ggm0lOOn5jlBVEU89rreYttkW
         qREx7PQTpjn7Mj1b8bts7AHTbkLMDiQC+9opmSo9eQir8zRWc4h40gem2ZXl1ol+UI
         uiy2GnwvhhKxiQyQZ2NZr5cHcD4DbyrQuSbYqqYgZ+eUA/9wk09GVqaxXq9L4PyOzh
         LOYhXVeGwcJ2cbGo5pF5VsshWFLRdzG3TSLzxOIBXr5c6n66qJ8tZh0FwGTduDl+R6
         6Z6Nk29xFpLZIIiDTUeXdZ9nRP8eijqGcb+0fGKHvq40IAUEJAoY0WsKAJwI0j6Tw+
         tx59TfQONm9dw==
Date:   Thu, 20 Oct 2022 17:25:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1F2a6CR+9sY66Zz@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8ZsyvR6DT6KBTzFY"
Content-Disposition: inline
In-Reply-To: <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8ZsyvR6DT6KBTzFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2022 at 07:18:23PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 19, 2022 at 04:50:38PM +0100, Mark Brown wrote:

> > For example a check that the ID is one we know about.  IIRC that bit of
> > context looked like a tree of if statements with no particular
> > validation.

> But isn't it guaranteed to be handled by device core, i.e. we won't get driver
> even enumerated if ID is unknown to us.

That's true currently since you're matching based on ACPI ID and then
have the lookup done with the ID information in the acpi_device_id table
but IIRC the patch was replacing that with some device property stuff.

--8ZsyvR6DT6KBTzFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRdmsACgkQJNaLcl1U
h9AQWgf/cxAZpP10nopJ1x0dx9Fldq1w4K3nzW1g84Hdt6vHzb1+F+Yb/lg9hg4+
HqkyucjudaILCwckOsRs3WH1jXDOyDraBZ1QzdXWJfWiFa0BBBBg4PGxGhDHwF2/
Zr2LbwBp78nVEo6NF9VIB8QW5+NHPdlUN6q9m/NkOSkJRuDEntegov/FWzsCggjh
DkxBLHI6hf7aYdUkXO1vOt641cJVz90pf3H2fI+LlZ29iemdokC0lUuidWqk86cX
+yysqW/ENllNBWNiQM1eX8yZ4BVKKICdjD0o5n5NO5DWSglk1UpR6vfo9FJZHowH
4OjMAzESRqXaOi3vuc4NoT3Ov52bnA==
=cf23
-----END PGP SIGNATURE-----

--8ZsyvR6DT6KBTzFY--
