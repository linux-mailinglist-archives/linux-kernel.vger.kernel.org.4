Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21C6F04CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbjD0LPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbjD0LO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21081BD9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E68663CA5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D13C433EF;
        Thu, 27 Apr 2023 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682594097;
        bh=GUOFfbmAJP3M6ejVXlUksPOFeFotCUX68QiDPPsiCuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKyUYmxDseGNU4fzV0xE3WKYtJKXMQfhcrhJcNp7ZY8lLUswhcveJHtUmgkExvnDq
         +I2+KhDfjopzYahOti+b3wkBgf+WuRXn49syPp3XE4+J0lV85wl1svrb9ilEij4CY7
         5RwXjfdzjQiX4F5V/pBBjLxCmI4s+5EBEOmH7Ml0utbpZZnwtHqMS6pYKDC2RFHkQY
         MNILJ2UyWC1jLOGlFuA/SxrngOGMS1AVEUzA1Nu0+tjQHD+hOMhbles8Lsw6Xf3EDP
         1INC34yFdv4jYb17GYqd7o5E3WGsUoVPi6B6omaF+Yo213nPOjmrVV1NXt1OTXoTPJ
         9zxvbBSRWIh7A==
Date:   Thu, 27 Apr 2023 12:14:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: max5970: Rename driver and remove wildcard
Message-ID: <1e1383c5-26ae-4874-8873-cb3b8d1a04f0@sirena.org.uk>
References: <20230427102254.3864526-1-Naresh.Solanki@9elements.com>
 <20230427102254.3864526-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xS9TrRz1iw+ftpKx"
Content-Disposition: inline
In-Reply-To: <20230427102254.3864526-2-Naresh.Solanki@9elements.com>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xS9TrRz1iw+ftpKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2023 at 12:22:54PM +0200, Naresh Solanki wrote:
> The previous version of this driver included wildcards in file names and
> descriptions. This patch renames the driver to only support MAX5970 and
> MAX5978, which are the only chips that the driver actually supports.

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--xS9TrRz1iw+ftpKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRKWSwACgkQJNaLcl1U
h9CEIgf8D38XG8UeWTjbctDxnZk5CVm1GsAsT4amA6LD7sUZpT4YVwsgsyFJmTJe
7RAZb8sTs6Jyf+9psJWqzOf8a7hJZxfhwcelanXarBHrgDUjdMT35JsLcDZXlueP
gWe8UFgG6RmpIDxWAU3atqT1+AOsAYCRCkkUooRV1zy7HsnjA8jnXsHSJvAxf88z
Z4u+YGryPPm3PWZT2tCwSK3ulA+LN9Q50bNlssM2CSF4XbErku1uP2fLifjyG/km
yfSDyyoWgQjRbxbWp6/l7aItNeXIBcrQwLGYdFMBy3wPmk3x1BW5x57GjJd+mWWC
Q5eY9KSvEs0uG1ATpuBT/Lc7WisERQ==
=l9/A
-----END PGP SIGNATURE-----

--xS9TrRz1iw+ftpKx--
