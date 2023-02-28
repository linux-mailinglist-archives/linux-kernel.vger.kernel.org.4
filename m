Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666726A5672
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjB1KPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjB1KPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:15:21 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8510255;
        Tue, 28 Feb 2023 02:15:20 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4C2BD1C0AB2; Tue, 28 Feb 2023 11:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1677579319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIobWVcWKOMktloTIZSETcSZg4B7IPXuWeejBjATNZw=;
        b=HDheuxhc1hRmJvYXsUf3ccCpxIb68CvBYyMb5YuLB7JYRl5v/lcNUnBKH6syYWIcr5c/8t
        LrivujR+7M1OybIyrP8N1jrU0g3z1UEwvnDwkIQtadKMUrl+kedPPblUaL9vR75UlsxUHW
        +oLnbUQSmABMhL2ag1R4GQE0ZE+gb0A=
Date:   Tue, 28 Feb 2023 11:15:18 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
Message-ID: <Y/3UNv4a9xmAR+54@duo.ucw.cz>
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
 <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
 <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
 <Y8f2elExwiwxK2n+@pendragon.ideasonboard.com>
 <CAMuHMdXYsCN+evJB8idRFQ-v2B4bJ6vi+DSF=Zg6+QSiu+Op5Q@mail.gmail.com>
 <Y8f88dw/fWfVij/d@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C8mDkYo+HW8Czfre"
Content-Disposition: inline
In-Reply-To: <Y8f88dw/fWfVij/d@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C8mDkYo+HW8Czfre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I prefer blacklisting in the driver, as dropping them from r8a77950.dtsi
> > wouldn't disable them when used with an older or out-of-tree DTB.
>=20
> Is that really a use case we need to care about ? Who will run a recent
> kernel with an old DTB on a H3 ES1.x, without an easy way to update to a
> mainline device tree ? It's not like those devices went into production.

There's some agreement that DTBs are an ABI, and that they should work
with old and new kernels. Disabling it in the driver seems like right
solution.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--C8mDkYo+HW8Czfre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/3UNgAKCRAw5/Bqldv6
8r5yAKCQhsFBOLk2Za5sOjz+PmJh6YjMrQCfctyb4Gw+Q2kmG1nPpaeCp7xkYU8=
=Vgwo
-----END PGP SIGNATURE-----

--C8mDkYo+HW8Czfre--
