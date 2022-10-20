Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E56066F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJTR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:26:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E03519DD81;
        Thu, 20 Oct 2022 10:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 115EDB82886;
        Thu, 20 Oct 2022 17:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8FAC433C1;
        Thu, 20 Oct 2022 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666286766;
        bh=jDUzTYdJaq0kvJ+zhN0GDLnOVjiyj/xD/YSMO5d3900=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8lCNqPXg51ULWkqAEWqjWobGPnkkduoAkLVcyO/Ewve06HbvkvFa8DqGcSwXzcRx
         A6s0mU7SiZgKP0TDDdtaVKJi9uTEELW6o9efC//Q7hNKwwJBmL4GVKfIgi2sKTjC/Q
         3RrYS7hainlqrYp5GD3QNTnZZPpXfsb82tQyeY1iZH9vy+HeJ7ih4n3ize5U4nKcyX
         NvJaILNOawwjfaRoDGOwDsqa1gzQq1RYVrVCYRpajVQCpgH6pY5Y8akI9VM0n3C9b5
         FZWz+xCiu/t+ID0j21zY5BqESUmX3iD02ocllNvjaMvBdGAQM6CaQyaAXkyZGaCrZr
         CuGkGPmA79ckg==
Date:   Thu, 20 Oct 2022 18:26:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1GEqa07/b25utui@sirena.org.uk>
References: <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2f/UF7IsDLgeMiKs"
Content-Disposition: inline
In-Reply-To: <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2f/UF7IsDLgeMiKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2022 at 08:03:37PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 20, 2022 at 05:58:39PM +0100, Mark Brown wrote:

> > The driver won't even match and therefore load if it doesn't have a
> > lookup for the device with the current code, the type code comes from
> > the match.  If it has to go querying a device property then the driver
> > can load but end up with a device property it hasn't ever heard of and
> > end up misbehaving as a result.

> That's how all MFD devices work nowadays, right? What's so special about
> this driver? It's being used as a child by MFD. If what you are telling
> is a real concern, we have to have a way to assure that all drivers that
> are children of the MFDs should provide a match. IIRC there is no such
> mechanism exists in the kernel these days.

Most of the MFDs don't actually have multiple options for a given child
driver, and it's common where there are multiple options to either bind
with a different name representing the different child device or have
something that looks like a switch statement for the IDs which will
error out if it hits an ID that's not one the driver knows about (like
spi-pxa2xx-pci does with lpss_spi_setup()).

--2f/UF7IsDLgeMiKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRhKkACgkQJNaLcl1U
h9CJVQf/XOSG1w2v36RyWWqCnTu0eMfZ0rDC4uI3VpZKIdGeTANO9iobrKwOCDAb
MPnzsjKYHjdgJ/EGQIDBIH1oQ59WmyUPjoFucyViXyE9L5JslPW3EvcX08WXGzDm
fnaUVzPTT7CvhI31RVTz5w14xzOSUyMGj1Ua4NM3iXAnqa7gjCSTpGwzvCcvPBmP
jSBuN6sTicOhQmvXMFiixUE6R95eg7N3oq+mfhuHbrw46TcNG9JsYw21g+jJyVKT
a1dm18UC+eoXNKmiKX5A36po9BD40yCySfo3tmBZlJ7xvjLrvPhotfJRwa/fqRHs
7GQx+5TdlDTOlZeGr4/vT6Fs4dC7Yw==
=TcKn
-----END PGP SIGNATURE-----

--2f/UF7IsDLgeMiKs--
