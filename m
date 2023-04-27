Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5A6F04AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbjD0LEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbjD0LEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:04:20 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE44410E;
        Thu, 27 Apr 2023 04:04:16 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E89D11C0E6E; Thu, 27 Apr 2023 13:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1682593453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gCx6799fPD1mvbmBrIDrAMnxIBHFIp4o9m2BUKCs55s=;
        b=iGQ3rxURs2j7UDZIKpZa2LfnryQV7Vyw7frtEnKUiCP1USATzOSHsjw9FGggesZRDsmYVA
        gKLEgNRd5Vaua6p6LgrvDf4V3QIkJW5MCItd/Fev+qDF9H6dOd4jCtNl2ug4VqwqcggW/+
        32mJaq+rPII/OVLH694uK55/LASSSQY=
Date:   Thu, 27 Apr 2023 13:04:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        phone-devel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <ZEpWrWpzkI9kNTkr@duo.ucw.cz>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C8RZd6IZ7KbnjRDA"
Content-Disposition: inline
In-Reply-To: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C8RZd6IZ7KbnjRDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Some touchscreens are shipped with a physical layer on top of them where
> a number of buttons and a resized touchscreen surface might be
> available.

Yes, it is quite comon, for example Motorola Droid 4 has 4 virtual
buttons below touchscreen.

One question is if this should be handled inside the kernel. It will
make it compatible with existing software, but it will also reduce
flexibility.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--C8RZd6IZ7KbnjRDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEpWrQAKCRAw5/Bqldv6
8sedAKCiULYxV9Tl2uWqI7oesubhsrSGugCbBS0adKSsnML10omfQxfe3amV/KU=
=Jsf+
-----END PGP SIGNATURE-----

--C8RZd6IZ7KbnjRDA--
