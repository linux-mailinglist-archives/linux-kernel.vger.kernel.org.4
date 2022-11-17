Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9C62E18F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiKQQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiKQQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:24:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8088FA6;
        Thu, 17 Nov 2022 08:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77FA62129;
        Thu, 17 Nov 2022 16:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F2C433C1;
        Thu, 17 Nov 2022 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702104;
        bh=phsVL3/hsv+v4acS8Sc0lFUGpjMm1v6dsEcH7Nzqomc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmkZC3D0au47/OYpQ1ksGKtVv9CiqIPL7XknQf09yV5vSp1F0K+2dCNLYWC/Va31V
         uVcvHviKCGT1romm1/eM6Lps6F2lIzXKYKSw58dDEO6suaqLQkZ0Y/imxN6FN/15U8
         vUFeHa2OWGz2rzOaEbPvm4osX0ugWuZ3EsMPsDanGPFB7Gt4CWAq9Fezqdc4hFBpBT
         sCLckKaFc12UFRGEGiQl1TsyyzbXp7ZJVKatO3Yq/MX8Tt7xFEwQiljuZ25I/aAT0M
         +4LgvdOmAj/Wg9cXXNK05x38NJ+mdtnYCnDuNscFozvoyqYS/XmAaHFgFLXWlvl06y
         sqTweD275CG9g==
Date:   Thu, 17 Nov 2022 16:21:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3ZflHI6CYfaGIbn@sirena.org.uk>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <5123090e11da67e57fb00984445ece2f@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KArWzu10SZ74/FYp"
Content-Disposition: inline
In-Reply-To: <5123090e11da67e57fb00984445ece2f@walle.cc>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KArWzu10SZ74/FYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2022 at 05:18:55PM +0100, Michael Walle wrote:
> Am 2022-11-11 02:55, schrieb William Breathitt Gray:

> > +	gpio_config.parent = config->parent;
> > +	gpio_config.regmap = config->map;

> I'd propose to add a new config flag to indicate that accesses to
> the device will be fast:

> gpio_config.regmap_has_fast_io = true;

> which will then set gpio->can_sleep = false.

It's probably useful to provide a query function in the regmap
API for generic regmap users like this.

--KArWzu10SZ74/FYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2X5EACgkQJNaLcl1U
h9BYlwf/cBtqSPMTzYsl99bR9c8JJNXZeeYSwkVnwLuXJs0lf70APD+eCNa2IQI0
qj2Zq/ekgfnYW9+YsswY9O/dzf0ZNFhC/Pie6TM5uNnYC3yJBMAaVNoA6KOQTBED
upXDb1QOSbYpct97CJJmx6/zyIzszjIQmuQZ/lC/gGq1Ni0Ye5+0M65tNMCDSUD3
Uuc6tRmXOtgwCHda6Hfpis033dwWQRMvMivF6+3svGZ0GzywBME5Eft23EHooqdt
2uEXT24DDssydf4LG65YbdeyFZJ3GQiVi/jmlSywKSyZ66bn8BpNJE/LT8aVDo6/
sEt1FKTcbQoJm0CgdJ2AJUI2OgP2sg==
=5d1H
-----END PGP SIGNATURE-----

--KArWzu10SZ74/FYp--
