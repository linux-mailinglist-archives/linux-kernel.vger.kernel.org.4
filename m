Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDDD6461E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGTty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:49:52 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF66A771;
        Wed,  7 Dec 2022 11:49:52 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C8A021C09FA; Wed,  7 Dec 2022 20:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670442590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfbX8b3IcLTSo6OiYayfHgn7c+FfgItv2i9S7oRsPSw=;
        b=AVnDabuurJNJ9hnUxhb6HbM8HqybN1PAsn6Egi8imKYJtKBkXcKd+giVH1OaHmLkFgqt9O
        OkMqCjUW3Z3gs51mTOnOS9BP1kocLRVqM45LuHnuxCwx+iqaamESLUoIEUAzhrzPVHGzwt
        X7W2kW6ogHkGHgWHpZ5FC9PVM67NT5c=
Date:   Wed, 7 Dec 2022 20:49:50 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 2/2] leds: add aw20xx driver
Message-ID: <Y5DuXsvJhUQGGlmD@duo.ucw.cz>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n/1XYLv8CUf7pjHq"
Content-Disposition: inline
In-Reply-To: <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n/1XYLv8CUf7pjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-11-24 23:48:07, Martin Kurbanov wrote:
> This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> This driver supports following AW200XX features:
>   - 3 pattern controllers for auto breathing or group dimming control
>   - Individual 64-level DIM currents
>   - Interrupt output, low active

You may want to submit driver without the hardware pattern support,
first.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--n/1XYLv8CUf7pjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5DuXgAKCRAw5/Bqldv6
8ocvAJ0XOQM0YJyF5UQGAs5QgDHESOtXDACfaUGluw63oEH83Gfx8KfGbd/e1gQ=
=4REW
-----END PGP SIGNATURE-----

--n/1XYLv8CUf7pjHq--
