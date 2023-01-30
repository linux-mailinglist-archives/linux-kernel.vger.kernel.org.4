Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990E680548
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjA3Evh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjA3EvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:51:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FB12594;
        Sun, 29 Jan 2023 20:50:12 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.48.240]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZkd5-1p7DGc412N-00Wk4W; Mon, 30 Jan 2023 05:49:42 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id F1B6F3C0EE;
        Mon, 30 Jan 2023 05:49:37 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 74C7E1F5; Mon, 30 Jan 2023 05:49:37 +0100 (CET)
Date:   Mon, 30 Jan 2023 05:49:37 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] .gitignore: ignore *.mbx
Message-ID: <Y9dMYSCCTo/S6DYz@bergen.fjasle.eu>
References: <20230130021902.4088173-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgcybDLBsmM8w/ln"
Content-Disposition: inline
In-Reply-To: <20230130021902.4088173-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:8aqWJMH/dMAaW+vxomv1y48xJZrRjdBKhStb/sy121gf0nR9HBd
 wxxfIbJSuorWA434ChpM2HE4mgXOviM5duowkUtJ3gb7xsCSBwx6oVl1Z4FX82mv/PKWjjA
 7SQLlkERidAoZmxWDnqWa48zugI5z6BV4gYWMPLKwMoK6gvghf8wgqhQR2Do1rXSoA1PR8S
 9rXoGCz5XU2wzZjPlGQaQ==
UI-OutboundReport: notjunk:1;M01:P0:tLgrQO3UJn4=;prwCJBbbPG/H4N/auv6U+jB/+yA
 ZsKxCDOnZZI6AfsWzbtX72MyQmYfkqbYrA+KK2TtSSxQP9XkTAojQXhYLwIqfn9OlPTKD61La
 yqYVtbPYpa2rPfQvy01+PsEk+XgtBaZF5JQ+dIlVYFaaaky296r+g4JFGhbkIqnS5FqcP56qp
 vCkaO6AuedRLtjjYl0kBDbyd5MXPovD9ObrBQeBO89L+mB+XFlqjVxpw5wD1rwmnUz5w+jjrg
 ddpUhz1shJ6A3MVsESBlfwgWmt+Bj2Q/bae9sOaJ3SLGL4ClUQXYfOXJLQ5x9slUHtcQMw3J0
 plPjSElbqclqAbZQQKyS2qKHkEW2hvMz4iOeamByEwRJODhhPKirVLQv0Xx1jhTuCoP7kAHjW
 SEYUhgdIk/UX6DVON9/Y/h0ac97tSvf1B0gMERMWZbTLWcLrqXgG6PNd9xTc3cmppZmMS99A5
 udVpL62FjY2x5ETqisL0kQxtxw7Khe/LOHuGlpN6+MmMSHYluT3VmnviCYDzFIfEnm1ilz33V
 aC8nypL8d6S+U3y95e/haLNf9DwriSGOu+4NmEMCTdOI4xwuK8C/vT0T7omDynoo5tysrWPQg
 /ICJDHwJOHPB7GOsNUUFc+SDw2tvpsbYt2C+q8f4av4iZ53HU4LSO7Qvohukr60sbvyNIDW0X
 r9mX64e4U7rXbH2l8chSsJQOWDf5PqsTU4Kb2NhdyA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgcybDLBsmM8w/ln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 30 Jan 2023 11:19:02 GMT, Masahiro Yamada wrote:
> The 'b4' command creates a *.mbx file. Ignore it.

b4 also creates *.cover file.  Can you add that, too?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Thanks,
Nicolas

>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.gitignore b/.gitignore
> index 22984d22d29e..4dc02ef62202 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -33,6 +33,7 @@
>  *.lz4
>  *.lzma
>  *.lzo
> +*.mbx
>  *.mod
>  *.mod.c
>  *.o
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--OgcybDLBsmM8w/ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPXTGAACgkQB1IKcBYm
EmnJqBAAr9g7ZPyddzeBDAUfF4gXt/j8kF+n4zanYL4O6BurjHZ0xukHnpXax+OZ
rASE7WxYWRjURIwdg9/bmiI6MX90QbmJucIt+phhgGUlFNISGcYkAPbFZ2m6ZTxM
ElgVzzPK2CXNTXOyVOVSHwqXGJeSHjJuZ+Bb0rFFOsFofVkbH3njenNjnbD5Iwbe
StZSCsJGZvyStIMKIoCh8nUNtgfPNUon9VL3VT6OdiSLpnrccGWEXKmlpVpUN4Lq
lXbwPvKdyvpvTxCBPc/aq7K9v9XOklk9u0Qw225Vlo8Yko6rYY4QgFHfxxpaA3oA
0by38ruQsLPcQlkkM94F35EuOVArp+UTFjlR4Yj1ypQ6nmjpe92HAP7Tzudu3NO8
T4a/E6hPMrlWjqQdxqTkbQ9lvSxs24OooZoHYZgqnPFyNrHuF9wlvt8+efcrm8pl
yEXQO5EhtxWIV0db9KtsHGVYzdT/OJTo6Z9YdFPOtJxY4ldd5Mg2youbD38oXcmi
Ry561qnT/+/LpoQat/M9dbPXh/fvFlmWU/sWyOJPZWWSaUiTmLogS2/pZTRc9r1F
23/H5ak7MCcpV58z4tbZxBZYFb4ubAAUMktNJsa3MizcL0YOo68HBTjb2wK/azmn
rwXuSdlUK2Vcz/BGIMlvDsrTnJW78/FOVldneonfxkPTjkNTqo8=
=iFHV
-----END PGP SIGNATURE-----

--OgcybDLBsmM8w/ln--
