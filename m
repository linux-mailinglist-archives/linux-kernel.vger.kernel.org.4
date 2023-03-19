Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E076C02F0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCSP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCSP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:58:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82A65AD;
        Sun, 19 Mar 2023 08:58:41 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E0D0B1C0AAC; Sun, 19 Mar 2023 16:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679241518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3obTZ2qvEWJkW2gBF4qR8zlni6usT4nMn6KyMSCmG0c=;
        b=VDyYCMaX6+Cve6E5vxU9Jel3GKGyNilwkmcwXYTqEzkE1m7Qr4F1cjW/D9xRq04DUPAE9P
        Ul+s6VkyRiEKmWB5+Sz71MV50T/6UVns/7uqQxJsvgrWjhzvlY4gfmr7LdYMepyXSxyNMM
        JMju6X4Wenj+14/SnSkDVZUB8OEhgjg=
Date:   Sun, 19 Mar 2023 16:58:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux LEDs <linux-leds@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] MAINTAINERS: Add entry for LED devices documentation
Message-ID: <ZBcxLq8vDDBzFlCz@duo.ucw.cz>
References: <20230319084604.19749-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j2xdjf+cD4L4KecA"
Content-Disposition: inline
In-Reply-To: <20230319084604.19749-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2xdjf+cD4L4KecA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-03-19 15:46:04, Bagas Sanjaya wrote:
> When given patches that only touch documentation directory for LED
> devices (Documentation/leds/), get_maintainer doesn't list mailing list
> for LED subsystem. However, the patch should be seen on that list in order
> to be applied.
>=20
> Add the entry for Documentation/leds/.
>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--j2xdjf+cD4L4KecA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBcxLgAKCRAw5/Bqldv6
8rL2AJoDV4skP3Bd4ZvN+HQk12jMnXwJNgCgp03FPT1tBxER3DXB/fv7ZZ81sGc=
=7nd2
-----END PGP SIGNATURE-----

--j2xdjf+cD4L4KecA--
