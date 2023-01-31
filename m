Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5325D6837EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjAaUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjAaUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:53:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B759233DE;
        Tue, 31 Jan 2023 12:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675198373; bh=HDxB0P5zwGe+abY0IPTRkMgnzZ77OEeJH9Ujawc8nac=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IHQ0MyKh50LjZyqH4Ip8oUE4FdiyeJ4Sjz0lsxOl6lH0aRSlIS+e1565NVL9FHxzE
         n7c4h7nmVoPj1laI6Rkru4nNHbrRKq/qLqNOnpk3Z1y2Hv06x+dhkqW/p941u63mVt
         uQK0cDzYwRjLxofjOlczeQG0Ro8yVD/wEzBXE7xcGk5qgJqJcX98bXb8NrSKjiO9DH
         Xl3ej7Q4hY1P4hKHr4vJX2H8xgyn+zbnXxGXCA9S8EWEicAuoYYdHdgNlr4m9b0Eqw
         X/105Hpb2hbBURRDjTPDTRTqsLdJge2xFqkg7XREoVA4bZj5FM/+Gu11Y47y9ZqIdh
         ds6DZD8ywsjDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1p7ys32rJS-00XbHB; Tue, 31
 Jan 2023 21:52:53 +0100
Date:   Tue, 31 Jan 2023 21:52:52 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bus: moxtet: Fix reference to SPI
 peripheral DT properties
Message-ID: <Y9l/pGzBCgWcLR2w@probook>
References: <20230129123553.1284503-1-j.neuschaefer@gmx.net>
 <20230130221626.GA3618337-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="syKY1ZXdedU5+4rp"
Content-Disposition: inline
In-Reply-To: <20230130221626.GA3618337-robh@kernel.org>
X-Provags-ID: V03:K1:7lRz+bdu1ad+wEiPBtAh1XCwjNWoWay9EuEAnQGWvm25gFHTEu2
 wOaeKJ4mSiOcJDyspIbXmBzBVQwPKkGGLtBeCaQME8Fhq9XjbizeUc7O8mafBtp6K6qhE60
 R3m7hyR+g10NM9YB3TV0qzd6RzWPyKxYZRvNiKDXs8/tvYH+0SBOZIOdA+AY/ESbmX5APPU
 8+pGeryq83YW/ZuMAyWpA==
UI-OutboundReport: notjunk:1;M01:P0:FJ07ktveZSg=;F8DE8xdz/2jFX+E3tkuVSisKGtM
 LYR4sD0r/i9V4RoAYHTrHhNnY5TIIwB6rGNxvxG7+5ghcssW27hT01+YRxKo5xRBS0szDa59Y
 6xnD8QOA28npgBoQ+rJy5U64C/8E9POc+tX9vSLaKy0rqMKjGvIIkgUMesgPaGJyqyvU00r4j
 BS+xBSatgawoxCtDs6EchASIsAlvZCSD3zq3LhlxyLQeDyciN+/ymg6lY4BzrQxSZysP2pErk
 TUnpUzuCg7Kdv8oCHTzL9vcTRjIWmhJD5+UIkYww8W4WgHhkLbxRQfv2hZdcbBc2ArHdU8AdA
 It1NtIT9AR2kRslEH6pJrJ1L1WCxhUa5gBtQvbMrXm6wk1MYD7fLEU31I8MLH8lKG7htT0DWh
 TR78hIstjc4fIV3gqccFlp6/aorZK3kWkSJ7rX7DIDOUzd4oP/iaLOs6HgCKZc5WTkvGuqtgg
 d6qenvbfeEi1ZO9bfKu4ZnE1AEdHS8sW3MvDfU9CSwbwx21pesGVn9/3r7syZwZ1rUrBgdZoi
 cyDILk2wsUFQ16JDicCsBzqmjA0QEZ0DKIAyx9ObRkZ9+z4rFeXYmL0RzNxuFRieExOBYhM/F
 knH+EoHAcFVM8SH3swHgQz4B33OwQozblqJAjWav7zNmLTCgUFEEyyRrtx4syiJSa0KoHhTdy
 WGrvfa+NjNj7NTN8FDFtBGuVnwtfhyx4Uq6cl5bsYazeuYZ3kiJBFdJ8b23YDxf7o370NI44i
 K085BuhcU8o9G86ZPsiSGCPJEd1rS3n0Fk/rF/K028rwDhAcI9lOJKqyL9Fc3EKZC5v1hHbGs
 6qb2Vhs4PJK5xkVPPIG97zNXa9RZhGOD465X/f0nYOkuEU6U2obAQfzVC2y8ms7P98Zu1ITIM
 o0IQRwd7u7Sp1TUBwmAga66MdIciFn9rXJTvTEMwJWI/rLsk8k7hcJ6xaKWwun/psWdCuQaB3
 UJ7T14Lt91CN9JYkjWiA+d7fCpA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--syKY1ZXdedU5+4rp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 04:16:26PM -0600, Rob Herring wrote:
> On Sun, Jan 29, 2023 at 01:35:53PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > spi-bus.txt has been converted to YAML and the peripheral properties
> > have been moved to spi-controller.yaml.
> >=20
> > Fixes: 0a1b929356830 ("spi: Add YAML schemas for the generic SPI option=
s")
> > Fixes: 8762b07c95c18 ("spi: dt-bindings: add schema listing peripheral-=
specific properties")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  Documentation/devicetree/bindings/bus/moxtet.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I'm not really interested in fixes to .txt bindings. Fix it by=20
> converting to schema if you want to.

Fair enough.

> By my count, there's 37 other cases, why just this one?

Mainly because a patch to a large number of files seemed harder to
coordinate well.


Jonathan

--syKY1ZXdedU5+4rp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmPZf34ACgkQCDBEmo7z
X9v8LxAAp84UuYkoLEGgNNgB5bDiBPkYSLZtIiV/sbNbjuvjkDQz4pcxSkfKufo/
ARMFrucQkSD3OkRfvF4L9RLmHaty1adwiKYS9pbGikfTcNI0OjAv8JVC+zxzstjg
zHp7rxItVhRtlIsH93o8owMMCf3bhkpnRLMzfln27iUcEzTct9L610oKsrde4B7v
S7ocuNr4+tK5tHdSjVew4CAR+YL+hxffYVZti7YKYx6PA0ip8lXALxH+2qCPGL90
dGOWv6/7OrOGDgN4UAHIE//qr/ulpxXPVu9vjWyw5Gn58CD+TYmZgRwc2YHdqFYJ
QsuzGW7ZrIlYJ9L6ECFThs33j67Ck0KlwqDtz5Ak/Ew1UehLL7EtPxZcRY6plmpU
BWFxIuVh7BIcKGRQOF7WVDMqnnTz+eHVeYV7UWPft+IOE7qDvpsed9c2IY7m32ir
fGMYoX1GJVUhEugBjnlOGLD4S+sUIkY5LF96yfWKZGV//gQRH1oTj2HJnTUj5QVw
Rw9yW7vRaH0jnDrG1vlF7vyeTJo/y4gs23bmmdas8hu6dfORDFAgyqn+1qBl5taC
mV/qqUiOz8TRbFaM9coFvUDIwswcSuxw7DSJ+bz5mOoZ9IQLLPpr/b9IIMWJ5qz3
qwHJ7UmoD5AXReRvHL6toh9GKqU8KinAF5YI+SoTohuqS5b5UPQ=
=lOlu
-----END PGP SIGNATURE-----

--syKY1ZXdedU5+4rp--
