Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65036D4BC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDCPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDCPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:23:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E118C;
        Mon,  3 Apr 2023 08:23:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1DC491C0DFD; Mon,  3 Apr 2023 17:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1680535436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+20JBJaASJiHllLcAKtoJ1jR606tnbtfKQ5j05D9C4=;
        b=Nim0RUywF55I5QTq6a5tEMFkLTBvxDUf5atsqLCthbPnd2GDYj5kByGOzHoI/fVoZ3do6X
        Nm4yXgCb4zsqfX/5Kpb7y3cRjk61juLRgju8oxIuUBgL5l7EPmab1z9ssm0FbASLBNSu83
        DeahazT5TI8WIj+2fbzT6pT5UOBAzbI=
Date:   Mon, 3 Apr 2023 17:23:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        NeilBrown <neilb@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] leds: tca6507: fix error handling of using
 fwnode_property_read_string
Message-ID: <ZCrviz6zNXJpmkN7@duo.ucw.cz>
References: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RvdtlErZpwC/giq0"
Content-Disposition: inline
In-Reply-To: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RvdtlErZpwC/giq0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-04-02 13:12:59, H. Nikolaus Schaller wrote:
> Commit 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
>=20
> changed to fwnode API but did not take into account that a missing proper=
ty
> "linux,default-trigger" now seems to return an error and as a side effect
> sets value to -1. This seems to be different from of_get_property() which
> always returned NULL in any case of error.
>=20
> Neglecting this side-effect leads to
>=20
> [   11.201965] Unable to handle kernel paging request at virtual address =
ffffffff when read
>=20
> in the strcmp() of led_trigger_set_default() if there is no led-trigger
> defined in the DTS.
>=20
> I don't know if this was recently introduced somewhere in the fwnode lib
> or if the effect was missed in initial testing. Anyways it seems to be a
> bug to ignore the error return value of an optional value here in the
> driver.
>=20
> Fixes: 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
> Cc: Marek Beh=FAn <kabel@kernel.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

BR,							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--RvdtlErZpwC/giq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZCrviwAKCRAw5/Bqldv6
8uQ4AJ9rOLLlv5G2BzpYWe8ul/PHu2RIqACgri1XbusH5tIqu5gkm1e/2B7bUKs=
=PFP8
-----END PGP SIGNATURE-----

--RvdtlErZpwC/giq0--
