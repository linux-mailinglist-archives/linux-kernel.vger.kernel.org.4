Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A26B5B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCKLgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCKLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:35:56 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A3CDC6;
        Sat, 11 Mar 2023 03:35:54 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0F5801C0ABB; Sat, 11 Mar 2023 12:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1678534552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8RICs1u+MjwfLG/CWgDSoV9LWZ0rCZiZnqHTLiSwNZg=;
        b=MMMgC/XaPUzlLBGwpdZnfG5XHV6Rd6l8syImTclPhze8z12nVS1T0xh2jSfJDmK6+W+yVQ
        +1aGL4hb8+G38vPLp0r++7Kj4D0Qsx65fy/Qis08iDD3vl8ojegGFetaNY2WznqyzR4+9Y
        RyNs+ai66Pu/4AYP86tCpR0ialiZ86s=
Date:   Sat, 11 Mar 2023 12:35:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: tlc591xx: Mark OF related data as maybe unused
Message-ID: <ZAxnl9zn/IrHMx9S@duo.ucw.cz>
References: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QwladTTMgoGBbJiI"
Content-Disposition: inline
In-Reply-To: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QwladTTMgoGBbJiI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2023-03-11 12:17:17, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>=20
>   drivers/leds/leds-tlc591xx.c:138:34: error: =E2=80=98of_tlc591xx_leds_m=
atch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--QwladTTMgoGBbJiI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZAxnlwAKCRAw5/Bqldv6
8s6uAJ93PWtSt8cNgltMQ0dACRRK5i3k9QCguSMbcfuvXFxxGkUSXuH4TL3LyEU=
=ekng
-----END PGP SIGNATURE-----

--QwladTTMgoGBbJiI--
