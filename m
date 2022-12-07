Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAE64620C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLGUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:05:40 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162613D7C;
        Wed,  7 Dec 2022 12:05:40 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 04FC81C09FB; Wed,  7 Dec 2022 21:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670443539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uTPb2iiRqwR3lmmMdHLVMF8772znK7BUBKZdaP3vnE=;
        b=lkzaY7zzlKqVC3Xbl66xu3X4qOeLVUTXeIPCyf1jFFp9nKrDj6jRU4ekKvfQwDTJ+GpwaN
        ON23AjOQ4HqOhwOszFxtIPKu1PrVrN0MrM6PAJy1DEGwvYXZtGyPQ0w90KDXzmYRexDUek
        GfUHn2ne4IA2MFKMfhfGD5qRSGcuNTE=
Date:   Wed, 7 Dec 2022 21:05:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     ye.xingchen@zte.com.cn
Cc:     jansimon.moeller@gmx.de, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: use sysfs_emit() to instead of scnprintf()
Message-ID: <Y5DyEiNZcmquXO7Q@duo.ucw.cz>
References: <202212011611248725166@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HbDWOt0LCLuX+lCU"
Content-Disposition: inline
In-Reply-To: <202212011611248725166@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HbDWOt0LCLuX+lCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with sysfs_emit() to simplify the code.
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thank you, applied.

Best regards,

							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--HbDWOt0LCLuX+lCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5DyEgAKCRAw5/Bqldv6
8s0eAJ48jK/zhzF1ssF4UZXaf2shWFwmygCfY7qLDsyPD72hQCdhEZ9O9LzKHkU=
=yOlV
-----END PGP SIGNATURE-----

--HbDWOt0LCLuX+lCU--
