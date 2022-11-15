Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E3462A011
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiKOROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKOROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:14:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19220355;
        Tue, 15 Nov 2022 09:14:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6A961937;
        Tue, 15 Nov 2022 17:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74244C433D6;
        Tue, 15 Nov 2022 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668532486;
        bh=k9HdUS7zrOXlFLwjH2b7B5JgNY4XRW93USVSPBniQL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2wlCdRyIonCrx94ab53JsUvdKYuct2JFfM3qCI9beEtMpQxlLiPgCEBHq2ieuC2+
         L+V/cgQtXo+8iyxseZzxWSyMOacARzHlm/NKZlXgeXE/2tNMho7iHQFVEb5yMBBkfa
         N7BVzCmDc3+VVOfEa+vMlIOCOI8eRHCAyGHw7tVV6rUJOC5vFOVNtvx3r4XgJS9wlE
         f59XtLHM7eXG3k2oRLQWbpyhJuBAcAoothg+LS7lWcUXkf1wZ+98o/gGeP9TBDzoVX
         EqCLu11OrmM4hSJL/NnYlJcJn6dxgi5Q+SCVruXfDVVA1H8XQgTaDXoQTPls/+ZEwc
         BAYFp1xre729w==
Date:   Tue, 15 Nov 2022 17:14:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 2/4] regmap-irq: Add handle_mask_sync() callback
Message-ID: <Y3PI5n8FXxOtGhzP@sirena.org.uk>
References: <cover.1668129763.git.william.gray@linaro.org>
 <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WJY0q1LVzw+BIMY"
Content-Disposition: inline
In-Reply-To: <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WJY0q1LVzw+BIMY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2022 at 08:55:51PM -0500, William Breathitt Gray wrote:

> Provide a public callback handle_mask_sync() that drivers can use when
> they have more complex IRQ masking logic. The default implementation is
> regmap_irq_handle_mask_sync(), used if the chip doesn't provide its own
> callback.

Can you provide examples of something that would make sense to
open code in a driver rather than factoring out?  It looks like
this has been added due to one of the devices you're looking at
for some reason disabling it's upstream interrupt when all of the
downstream interrupts are masked, while weird that doesn't seem
especally device specific.

--6WJY0q1LVzw+BIMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNzyOYACgkQJNaLcl1U
h9DI5wf/ReemeRWA1bhQND00SnN8oMnU5R0oinaAM9yFZymGxqvEVbBf8kf5wcCV
N8HjYk9DASKbW9kU/n7g3KbTt9f88bXcniJTKdSaDl8IaunGHgc9n/lpZuhkZmhT
UaMfu9YmHqc83Qle9cixfbc49kP2j5pfS8gLwkUd6PShZflYfg8P6RxVpb7SoI73
qCPhdx9Q2WvNLW4jmSxyqC/VuYUV7iU8AC2bQ33TpkC46F1NM9+HdSLBoM5pHap4
GEFOxh+/6hmYGZiVK8D2HD6Bbjy9xWGZyhNdZm7kVsifUlnUp0cE+aehsZX0CrBf
CCwLm4KtyjwBZjY/m2U1YNl0Sbzezw==
=dw0O
-----END PGP SIGNATURE-----

--6WJY0q1LVzw+BIMY--
