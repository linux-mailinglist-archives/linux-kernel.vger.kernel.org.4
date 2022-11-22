Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9504C6344C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiKVTnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:43:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7427C443;
        Tue, 22 Nov 2022 11:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1A04B81D56;
        Tue, 22 Nov 2022 19:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2610C433D6;
        Tue, 22 Nov 2022 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669146194;
        bh=FnvUAA+yXCryMxim9anvCTDLRrStYPDHhE1Mo1spq0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/ODJsvuT+0eV2zbZJBb6f/EYKQReFze8s0xizTKzvjOtAqMhBIkhWTZClHk3EYlE
         Eh/LhR0lTWgnsnchipCleyxYOUop+fRrhiUjAseBmLOHbopIpwYoiAI6S2hk11R+EP
         NyxDfnGgBeeM7h9PXDwlylq2xVjs6fPgtcNpFLswSZzYrPTT7HlmASmTzvxFpzVEK7
         GvT6wEGzJTGHghiXXvY2aScotn78zWEB5Dj/w5RI5w0yx3Ak+p7YEjeK6ucpf3650w
         fUuqpgMObpfmD8fH1xLqD/qma5TcIkU0I0irT6NAByi5wvhVWuKGhdfCwwc/TR7IDz
         D+0bSoUsL7DhQ==
Date:   Tue, 22 Nov 2022 19:43:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH 1/2] regmap: add regmap_might_sleep()
Message-ID: <Y30mTVhne9vqgSlM@sirena.org.uk>
References: <20221121150843.1562603-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vY2Mmwx37l2oX2m0"
Content-Disposition: inline
In-Reply-To: <20221121150843.1562603-1-michael@walle.cc>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vY2Mmwx37l2oX2m0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 21, 2022 at 04:08:42PM +0100, Michael Walle wrote:
> With the dawn of MMIO gpio-regmap users, it is desirable to let
> gpio-regmap ask the regmap if it might sleep during an access so
> it can pass that information to gpiochip. Add a new regmap_might_sleep()
> to query the regmap.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-might-sleep

for you to fetch changes up to a6d99022e56e8c1ddc4c75895ed9e3ce5da88453:

  regmap: add regmap_might_sleep() (2022-11-22 12:23:17 +0000)

----------------------------------------------------------------
regmap: Add regmap_might_sleep()

Add an interface allowing generic users to determine if a regmap might
use sleeping operations.

----------------------------------------------------------------
Michael Walle (1):
      regmap: add regmap_might_sleep()

 drivers/base/regmap/regmap.c | 13 +++++++++++++
 include/linux/regmap.h       |  7 +++++++
 2 files changed, 20 insertions(+)

--vY2Mmwx37l2oX2m0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN9JkwACgkQJNaLcl1U
h9A8xwf/VK0xlFWr81nR7P0XOQiQJy+AACAlhakjRWX9+rRkYSp9iHNjHibKgbVy
466ozDuXN9Czl7arUMPa2uP+sCVdckZwioKnRkHnizkuzm3h/DAPyTJK4tuu1QQJ
Nq8l4jt4fKC6AUZpHK1Jioe1QePZ127dujH4kjYXWA/VSnbp7ThTltfqebmjicIu
b54tSnao8WOjPn2hw6L29t56us2UzSTPupVDUTsZkTfB336HhSyw04yx7zPJNiqh
0F+mXYSUl1M+8QKRYYRo+Q4wM+NEVp7TLUpZvf64mz5uROWVMdBCk6vsV0LtfM/z
HwSMm1qxDp70ex9vgPw9WeO9zKXXgg==
=jbZO
-----END PGP SIGNATURE-----

--vY2Mmwx37l2oX2m0--
