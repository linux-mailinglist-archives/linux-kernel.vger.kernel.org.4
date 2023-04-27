Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E96F067C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjD0NPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjD0NPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:15:35 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF84495;
        Thu, 27 Apr 2023 06:15:22 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7172C1C0D22; Thu, 27 Apr 2023 15:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1682601320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2nKoZvt8N7LqYBmdBABrzailml1kvoxUqiS++FYAV8=;
        b=c37fUE6a0M9uFWN2LlcazPiUTJM3Hp8dmgmsfw2+FasKoOGIYrgBW+E2R6rUHWfhfcUa7j
        2SXrN0bd5BV6eLYhp36Ye/u2gdrP42DF9n2uQr114LiY+GyHyeq7y0wfwyBH6cJ+YojcG8
        Y0mba4PstW7od0yu81hagZQbHLTSpCE=
Date:   Thu, 27 Apr 2023 15:15:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        phone-devel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <ZEp1Z08/CQ+waw8+@duo.ucw.cz>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <ZEpWrWpzkI9kNTkr@duo.ucw.cz>
 <de87d6ae-3449-5581-3e17-4aae72e8197a@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CwltbjgpA33UBO1n"
Content-Disposition: inline
In-Reply-To: <de87d6ae-3449-5581-3e17-4aae72e8197a@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CwltbjgpA33UBO1n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >=20
> >> Some touchscreens are shipped with a physical layer on top of them whe=
re
> >> a number of buttons and a resized touchscreen surface might be
> >> available.
> >=20
> > Yes, it is quite comon, for example Motorola Droid 4 has 4 virtual
> > buttons below touchscreen.
>=20
> Are those buttons configurable in some way? Or do they have a fixed purpo=
se?

Fixed.

> How does Android handle those buttons, BTW?

No idea.

> > One question is if this should be handled inside the kernel. It will
> > make it compatible with existing software, but it will also reduce
> > flexibility.
>=20
> I would say that it should be described in device tree if the purpose is
> fixed. For example, if there is no display behind the touch screen at a
> certain point but a printed sheet (e.g., with a home or return symbol)
> then it is clear that this button is not going to change. In such a case
> I doubt that flexibility is required.

I agree it should be in the device tree.

AFAICT hardware can do drags between the buttons, and drag between the
buttons and touchscreen. Turning it into buttons prevents that.

Plus, real buttons can do simultaneous presses on all of them,
touchscreens will have problems with that.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--CwltbjgpA33UBO1n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEp1ZwAKCRAw5/Bqldv6
8oX2AKCHvc05pxAHX0VL5xbfmkbx9sLhkACfesnbnxpyU4K1Q08cSevtLEkKtlg=
=80om
-----END PGP SIGNATURE-----

--CwltbjgpA33UBO1n--
