Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556E6B6A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCLTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCLTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:23:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236272BEED;
        Sun, 12 Mar 2023 12:23:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 547DA1C0AAC; Sun, 12 Mar 2023 20:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1678648999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ENrYoXUniiIN6iqHVHzqmbQlYLhcvk9pC7sZN0QGjck=;
        b=OcXwkaUt+n+woOVLMpF6z9ayLdx6dk62EUuISJEF+i3OQR7PW2xKa5mvn6ffgvM+EpU+OP
        SBieXc0KspIUqyoIdboTyeo2xK+0oZO1E2Dy6wrN5NAAzP+cnIU6/OFN5e/KnVPzwuJNT+
        N/JcqD6MNU6RWBFZrGNc0H/cV2X68go=
Date:   Sun, 12 Mar 2023 20:23:18 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: tlc591xx: Mark OF related data as maybe unused
Message-ID: <ZA4mps2jUpqWIfcJ@duo.ucw.cz>
References: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
 <ZAxnl9zn/IrHMx9S@duo.ucw.cz>
 <e62cfcf5-e43a-ee14-f290-9004818df839@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5ef3/Sw9JpJTKfqY"
Content-Disposition: inline
In-Reply-To: <e62cfcf5-e43a-ee14-f290-9004818df839@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ef3/Sw9JpJTKfqY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2023-03-12 11:21:44, Krzysztof Kozlowski wrote:
> On 11/03/2023 12:35, Pavel Machek wrote:
> > On Sat 2023-03-11 12:17:17, Krzysztof Kozlowski wrote:
> >> The driver can be compile tested with !CONFIG_OF making certain data
> >> unused:
> >>
> >>   drivers/leds/leds-tlc591xx.c:138:34: error: =E2=80=98of_tlc591xx_led=
s_match=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> I was thinking you will take it... or the Ack is for Lee then?

Me or Lee will take it, depending on workload.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--5ef3/Sw9JpJTKfqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZA4mpgAKCRAw5/Bqldv6
8h32AJ9VHhifB/G0F5tfaf56463zAfQZMQCfbj7GTUlVADfv83F8Wm0sOUtTYio=
=tlO1
-----END PGP SIGNATURE-----

--5ef3/Sw9JpJTKfqY--
