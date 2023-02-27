Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17F26A40C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjB0LiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB0Lh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:37:56 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B855BA7;
        Mon, 27 Feb 2023 03:37:54 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 046691C0AB2; Mon, 27 Feb 2023 12:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1677497872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvNbDAgoO1CzLGhet90te7XxqVDagl4w8J95zwdNGiQ=;
        b=UogOHrCBZfyz7nZHjpn6Vy+R/fYAi+V4mAvBYfT6REe7CEbKIJug3eQU5d8AQuM3DJl4tr
        FMh2Ybe5624qXHqYVWa9OacH0kxUgjKBd2NqLIW0b7M/mlz1DF42HyMYXLdgJ/J1wN8goU
        TZP36bdpiKNpwIcBgRj5cpZbk0Araqs=
Date:   Mon, 27 Feb 2023 12:37:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of
 depending on it
Message-ID: <Y/yWD3qx/6vnYVNw@duo.ucw.cz>
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-5-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1groQbyfwXWTSYKU"
Content-Disposition: inline
In-Reply-To: <20230226053953.4681-5-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1groQbyfwXWTSYKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2023-02-25 21:39:49, Randy Dunlap wrote:
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
>=20
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
>=20
> Therefore, change the use of "depends on REGMAP" to "select REGMAP".
>=20
> Fixes: 3fce8e1eb994 ("leds: TI LMU: Add common code for TI LMU devices")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Murphy <dmurphy@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1groQbyfwXWTSYKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/yWDwAKCRAw5/Bqldv6
8pZ9AJ9/rJTANbgP2TFdrvdh8mEYKIdDYACZAbI0f4Mx4ByCjV3Axc1iiMbLRaI=
=u2hG
-----END PGP SIGNATURE-----

--1groQbyfwXWTSYKU--
