Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E96DAC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjDGLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64AF6A47;
        Fri,  7 Apr 2023 04:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54AD86115D;
        Fri,  7 Apr 2023 11:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAAAC433D2;
        Fri,  7 Apr 2023 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680867756;
        bh=ffJPEsfz6uevpDp0VZwg1T0jFu3Lsskw+llfUcg9HPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJQCpNye+Vu7dxJ7JxMQcNn+eWL7fLWZEoMKiCcXGvNibhVCri3nItu1MumialZ1h
         ZBxfvxx9nK3BRv1qKHqcljiOms5Uggr2ssrUiE7jGgJXo4jT5eemetRb4lk6jcm4Kl
         SyTu85V1GFyqCe//1YlkwvTu7WiVhEhEF6/+1ONELL0+lsVgQlpcMyC/+wPPe7DaIY
         N2+NlDQtflNBhRXykUrxlsuRQkJea1W593tYUXeQvoPtLhUx+NR5xCTTzVFaG1F9aQ
         SjV0QlUbC0APxsPSbTKoEXV6557lLmsORyLcKE7+HBxeYtEvjOmocw0rzgIaFQ55Rf
         dZqX93OBLE95g==
Date:   Fri, 7 Apr 2023 12:42:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v6 1/3] regmap: Pass irq_drv_data as a parameter for
 set_type_config()
Message-ID: <ZDABqiHHfhoP61VL@sirena.org.uk>
References: <cover.1680708357.git.william.gray@linaro.org>
 <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
 <50d8ee72-9b5c-4abc-a230-2aeb6eddf03e@sirena.org.uk>
 <CAMRc=Mc0HcMnuBqsN7ReNB5JTWR0C4FbMRRM9S7kqhW5otP5WA@mail.gmail.com>
 <ZDABDvbflOWAqcs+@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mWcjODE60AASDgeS"
Content-Disposition: inline
In-Reply-To: <ZDABDvbflOWAqcs+@fedora>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mWcjODE60AASDgeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 07, 2023 at 07:39:58AM -0400, William Breathitt Gray wrote:
> On Fri, Apr 07, 2023 at 12:17:31PM +0200, Bartosz Golaszewski wrote:

> Bart, the two remaining patches still depend on the handle_mask_sync
> change descripted in the cover patch [0].

> Mark, are you able to Ack those patches or alternatively provide an
> immutable branch with them? We need the handle_mask_sync change as well
> for the idio-16 migration patchset [1].

I don't have those patches, I presume I was expecting some
change.  Please resend.

--mWcjODE60AASDgeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQwAacACgkQJNaLcl1U
h9Cv6Qf/SzWW0MZ06FbGpomeqGr967VvIVdoq2stvunTx4e3vL3w+YZgjl3qLemQ
Knp5MmfEn4QtcCVnf/ydyLc14/2XN2foD4n6AYGp/8kF1DDwO2cjoYsd5LoaJB3M
2kqaEVSKSXrKw1m7A+xRaB04eODvMBeornx8aYPaU96zdIqwRNONmyrtc0qAndqB
w8XTzOV3ELh6bJ1nhO4bgsQ3Nv1j3GH666uopaRzQe1+fltOVrDmQEQhM5DZhf45
/xuqnEVlr1RKLudLJ4ve/BzPf1uG0YDNrH9wyScHPP2BBEd922erDp7KBhW84wSH
N9mgCFonVhltojLFgdNBjjDZ4/b7LA==
=hir/
-----END PGP SIGNATURE-----

--mWcjODE60AASDgeS--
