Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7060758F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJUK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJUK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:59:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337FD9589;
        Fri, 21 Oct 2022 03:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98ECF61E56;
        Fri, 21 Oct 2022 10:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE6BC433D6;
        Fri, 21 Oct 2022 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666349965;
        bh=MX7AqOonF7ye3Ep2fovK6pVwLEUIuFjhJnUH+hlXQx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUetN10ob/FIbEPagcZvM2nW1HGj0igr495aAzUmGd0UtPsnbTqeniiK6vioUWvLE
         p6jWtOEByYJUx8bEq9t7AdZct5vopfSIt0lGbc0A3XYFyIkw39m/NCCzmsaATWLbTy
         WT3OXqP7IEIqICbeICW69e2exY+5fduZjr5+WXI0xdaXH7yT1WDTh4miVZbn40aCNj
         fAezUBi7Rtg86IwlYwx6slXIGvJtJc3jlC2qjwSebW4/RgV7DWaS5Zev8PO5mzw5Oe
         vbeMqXUxKx4Jtf9uJXqmb9fQWC83AL6WkrtjtFdbCp7QagJJc46iijNvRbgXhAOmWh
         uB0FMzVFyozpA==
Date:   Fri, 21 Oct 2022 11:59:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1J7iJ967d0I83oZ@sirena.org.uk>
References: <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
 <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
 <Y1J3lyrygPvVGUJw@sirena.org.uk>
 <Y1J5wx63bzq4tnik@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1syzuSsqkSt8kCc8"
Content-Disposition: inline
In-Reply-To: <Y1J5wx63bzq4tnik@smile.fi.intel.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1syzuSsqkSt8kCc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2022 at 01:51:47PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 11:42:31AM +0100, Mark Brown wrote:

> > > That's exactly what I'm talking about when said "named resource check".

> > Like I say a property can come from any firmware interface.

> But I'm talking about resource (not a property) as IO memory. It doesn't come
> via firmware at all. Have you had a chance to look into the v4?

On DT based systems resources can be named by the firmware, I don't know
if that's possible with ACPI but as the name suggests the driver gets
used on PXA systems too.

--1syzuSsqkSt8kCc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNSe4cACgkQJNaLcl1U
h9DGaAf/TtbS0H0VEp77qLTvAQrMYbEZujP2T1T0FjMijMAO1g7KBAdddAFjwtwu
TVvzGLojbch3aFCHSPdYlhib4xTYewUVdcmqK/p5CHtjMz2YOa+lVxyZTnk5ahok
Rx7OY+5/YpI5XYhJpoyK5cT02lvRuZC8lwQm3pWKz0D1mrcZCAXXhkVBSE4FclYZ
DYKnFEQVojSTpb6VX91oXZoOe7nNhrHjirF4in2rURyjNrySU/1BvZ6vxDp5gVcW
/Hpp6rJHmB42xxtrbYNNzvUYYW78qyWxqmkLW7ABB4bcbl7jAHzCve4AA7mzjMky
TtiDAaeMGUCVPlZfMT7QPcGz4Yd/gQ==
=FFfo
-----END PGP SIGNATURE-----

--1syzuSsqkSt8kCc8--
