Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8886932A0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBKQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBKQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:56:22 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058AFE8;
        Sat, 11 Feb 2023 08:56:21 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B0C681C0AB3; Sat, 11 Feb 2023 17:56:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676134579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybBWit8CYCNa3yLeSzNRPfxZ9MW6aPa0cslmWCmS/mo=;
        b=kANeMj+vlttwIneGhycnyVcDd+bGdDU0OdxXgxEj7/iNbJ53LX5DIjsdwVN5L23CIbB/Gg
        TEl1L492PjfluScWJeWWeq1NMMC8k84SOX6/NxKU1gHUkaK8GiUcve9UNHUpMR0asl+7xm
        WsFCQLuyGUfOtjgiD0G+iKLocwscIKc=
Date:   Sat, 11 Feb 2023 17:56:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <Y+fIr5Fxozjkg6yo@duo.ucw.cz>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
 <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q1paXAVODvBJ7djB"
Content-Disposition: inline
In-Reply-To: <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q1paXAVODvBJ7djB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Orlando Chamberlain <orlandoch.dev@gmail.com>
>=20
> This driver adds support for the keyboard backlight on Intel T2 Macs
> with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)

> +	backlight->hdev =3D hdev;
> +	backlight->cdev.name =3D "apple::kbd_backlight";

":white:kbd_backlight", plus document this in
Documentation/leds/well-known-leds.txt so that we keep it consistent
accross machines?

Thanks,
										Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Q1paXAVODvBJ7djB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+fIrwAKCRAw5/Bqldv6
8tDjAJ0R2m8u4PlfRc9Yx6XNCbuHrndKIwCgoCzXM/MAdQC5kXbx7qVKyaq4tDQ=
=fUZL
-----END PGP SIGNATURE-----

--Q1paXAVODvBJ7djB--
