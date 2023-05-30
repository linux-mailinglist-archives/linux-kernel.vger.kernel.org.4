Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D89716BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjE3R6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE3R6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:58:49 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2C89A1;
        Tue, 30 May 2023 10:58:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 05AE210810A;
        Tue, 30 May 2023 19:58:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QF-WIPNVhlb2; Tue, 30 May 2023 19:58:03 +0200 (CEST)
Received: from localhost (ns3093303.ip-145-239-244.eu [145.239.244.120])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 69E681080DD;
        Tue, 30 May 2023 19:57:56 +0200 (CEST)
Date:   Tue, 30 May 2023 19:57:43 +0200
From:   simon.guinot@sequanux.org
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, xingtong_wu@163.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Message-ID: <ZHY5FwYwRwPMmxVT@localhost>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost>
 <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost>
 <20230530125727.688b6042@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7+C/NBP0Jgpp+h2G"
Content-Disposition: inline
In-Reply-To: <20230530125727.688b6042@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7+C/NBP0Jgpp+h2G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 12:57:27PM +0200, Henning Schild wrote:
> Am Mon, 29 May 2023 15:54:36 +0200
> schrieb simon.guinot@sequanux.org:
>=20
> > On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> > > On Mon, May 29, 2023 at 2:27=E2=80=AFPM <simon.guinot@sequanux.org> w=
rote:
> > >  =20
> > > > It would be nice if a pin number found in the device datasheet
> > > > could still be converted into a Linux GPIO number by adding the
> > > > base of the first bank. =20
> > >=20
> > > We actively discourage this kind of mapping because of reasons
> > > stated in drivers/gpio/TODO: we want dynamic number allocation to
> > > be the norm. =20
> >=20
> > Hi Linus,
> >=20
> > Sure but it would be nice to have a dynamic base applied to a
> > controller (and not to each chip of this controller), and to respect
> > the interval between the chips (as stated in the controllers
> > datasheets).
>=20
> You mentioned yourself that there are the holes to take care of. And
> the symbols/names from the SPECs seem to be octal numbers to me. While
> humans might prefer decimal and the code seems to be hexadecimal.
>=20
> Not sure the numbers have ever been too useful for humans. And once we
> change one base (bank0) we actually already break user-land that so far
> failed to discover the base from sysfs (bug in that user-land code, not
> our problem).
>=20
> I am with Linus on that one, we should try.

I am also in the Linus and "everybody but me" team too :)

--7+C/NBP0Jgpp+h2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmR2ORYACgkQzyg/RDPm
szp6mg/+IH+vUcDLPTcoDP0RzreSpxM4mn6mSXFpdZ7cyCy81Secq5El+rJJKLoc
0xED48M/1i0/J/SDOzDF7Y4G8Krtop/Y3vDomc4pZCECm1z5VCkzQSEFjE1hNvi2
wTWgOvcPTtynHs5L9KBLAGpseKxrBeL8xCrv6BemuEXhIADsqyjGuiNHTkLD7J2X
rIHp3NF8FoKoZqlgFVRZZiTvioS0lhBWvNJhhqMQLkQifyWJ+wQLVbaNJzqdbbBJ
I1pamC6H8GBrlJtBO6UbB633pufygXGdDUm7ht0wOV4T/ymfd/FRQSlgcCMkPgiB
TkAlimaD+CGPuAtr9YVuKvJFrrD8rvx6wZ90zIu5rW5I1J+R3+VYVva//UI5u3Qx
fgNJjQBl8VI7rQl3MtCSObQba3CWv9C0QT4q3/Quc7dA0QQ22CG6QUSjxGwcfjV7
xibACzopKW5Oat4XkyotJyMOEpe/EUOw5DmYrldv/qgJDwBA9qEhPwatthyFy6q/
PO8kOj3SAJ3cI6KGbqOY93YrtlyYxkf5bEqgFFibz4LhkwscSSPJC6U1Atuc8nPe
Oq1WiJdI1GRGC1A35rrRXLqnVwwv6HT9wKu9yIqOx5DzAPEYjBDvtQKbInWn+KXD
nN6FWf4IH/6NEqVyCF48K121Hdyl+AhiIxxfoiwCfx403j737pY=
=bzTf
-----END PGP SIGNATURE-----

--7+C/NBP0Jgpp+h2G--
