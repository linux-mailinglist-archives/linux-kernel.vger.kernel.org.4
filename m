Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D70738E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFUSZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjFUSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0CD172C;
        Wed, 21 Jun 2023 11:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361746168B;
        Wed, 21 Jun 2023 18:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD6BC433C8;
        Wed, 21 Jun 2023 18:25:42 +0000 (UTC)
Date:   Wed, 21 Jun 2023 14:25:40 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH] counter: Fix menuconfig "Counter support" submenu
 entries disappearance
Message-ID: <ZJNApKjQq4sVtYRw@ishi>
References: <20230620170159.556788-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IIG1smBESFemXtZA"
Content-Disposition: inline
In-Reply-To: <20230620170159.556788-1-william.gray@linaro.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IIG1smBESFemXtZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 01:01:59PM -0400, William Breathitt Gray wrote:
> The current placement of the I8254 Kconfig entry results in the
> disappearance of the "Counter support" submenu items in menuconfig. Move
> the I8254 above the menuconfig COUNTER entry to restore the intended
> submenu behavior.
>=20
> Fixes: d428487471ba ("counter: i8254: Introduce the Intel 8254 interface =
library module")
> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Closes: https://lore.kernel.org/all/32ddaa7b-53a8-d61f-d526-b545bd561337@=
linux.intel.com/
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-current.

William Breathitt Gray

--IIG1smBESFemXtZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZJNApAAKCRC1SFbKvhIj
KzVqAQCzPgiiDm7Hgvr+Y/2UovXmD7r8KuICAfhtbzWUwEB2vwD/RrH3jW6Tm8oV
Q+NINURTy+8HhWGPZKwaGBbW0/nRpAk=
=yVtj
-----END PGP SIGNATURE-----

--IIG1smBESFemXtZA--
