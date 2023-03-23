Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B36C662A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCWLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCWLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:08:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F541FD6;
        Thu, 23 Mar 2023 04:08:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 140B21C0E45; Thu, 23 Mar 2023 12:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679569706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5hKQ0F5IqpeLP7FipvyIh82TpmOBiR55uTJeJOjZmg=;
        b=HO9K77TtTnbAMb5Za+OPE24h45qee6DG8hFbn7so3VwcFqvA/1HVWxnSBhjZ4oskgucixh
        e+PS0mQJN/JY5YO7qXY5BG9ipiVN9fuK7G9BRyZIH3wuQIsAghsOje8R0/38bqot1C5S7W
        XEdEvMk53wTa2HleZ96gsodpjC7CtEc=
Date:   Thu, 23 Mar 2023 12:08:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>, Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH 0/3] Documentation fixes for MT6370 RGB
Message-ID: <ZBwzKUem+Cg5GU0U@duo.ucw.cz>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D24VC61xTd81s6wO"
Content-Disposition: inline
In-Reply-To: <20230319074903.13075-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D24VC61xTd81s6wO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-03-19 14:49:00, Bagas Sanjaya wrote:
> kernel test robot recently reported htmldocs warnings on documentation
> for MT6370 RGB LED. So here are the fixes.
>=20
> Bagas Sanjaya (3):
>   Documentation: leds: Add MT6370 doc to the toctree
>   Documentation: leds: MT6370: Properly wrap hw_pattern chart
>   Documentation: leds: MT6370: Use bullet lists for timing variables
>=20
>  Documentation/leds/index.rst           |  1 +
>  Documentation/leds/leds-mt6370-rgb.rst | 42 +++++++++++++-------------
>  2 files changed, 22 insertions(+), 21 deletions(-)

Series looks good to me.

Acked-by: Pavel Machek <pavel@ucw.cz>

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--D24VC61xTd81s6wO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBwzKQAKCRAw5/Bqldv6
8j/vAJ0WmSMJOhbk/I5/iFHaEdFTR8H20gCgniwKgLB/GP2U0jwW2klmXEF8xEc=
=U7EG
-----END PGP SIGNATURE-----

--D24VC61xTd81s6wO--
