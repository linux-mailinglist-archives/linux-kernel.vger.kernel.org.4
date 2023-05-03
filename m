Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BC6F5816
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjECMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjECMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:42:56 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9180949DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=gYfwJ7GhWlbQkcMj1JcM56SejKNs
        fbTZDXFiVzo4qr0=; b=S7GdNggFjoW5pgqnXLEQHxJBBL2PKlmITuenHqyWty80
        B2qxSmi/90aBsRqjZiqOM9NnJq5lXMMQYCQrnxD3u+PHj8tn9sTMW/7lRPdMsH9M
        STxaQzDJ8PQ7KKPcnsDNksw5JkjUB5XOAAPug1WUQ2WLqVVTe7PmYzE9ata4lgM=
Received: (qmail 85566 invoked from network); 3 May 2023 14:42:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 May 2023 14:42:52 +0200
X-UD-Smtp-Session: l3s3148p1@pl3rZMn6AK8ujnsI
Date:   Wed, 3 May 2023 14:42:51 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a779a0: Add PWM nodes
Message-ID: <ZFJWyxPR2iLVcOoL@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com>
 <20230502170618.55967-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdV0iZJwNDRTxZXr-Rg_=VDN1hYw2gbSwwys1EDrzgC7Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nlnmZCMUT4S19Qmp"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV0iZJwNDRTxZXr-Rg_=VDN1hYw2gbSwwys1EDrzgC7Ew@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nlnmZCMUT4S19Qmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > @@ -1108,6 +1108,56 @@ msiof5: spi@e6c28000 {
> >                         status =3D "disabled";
> >                 };
> >
> > +               pwm0: pwm@e6e30000 {
>=20
> I'll move this before serial@e6e60000 while applying, to preserve sort
> order (by unit address).

Oops, right, things have been added since I last worked on V3U. Thank
you!


--nlnmZCMUT4S19Qmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRSVssACgkQFA3kzBSg
KbYD/Q//byfip8AJ4NFJ+VuOVTkHRSqMm4tk+i5gyy3Q2DLMWmGEk/f7nXL4QB9x
kzQSfTif8VDDuKpKa6CXFejaMJwRO0i7OwT20e2OrplqOr0cStHgY8/qdYNtU0OE
n5m3UPTw+ndNIeaaVIi6IKVgwAEAFx3xriRWML79wqKut7IX/wW696KihXmFZoZu
OoWDx16P1xPQErN3HgWe/YNU//8Ab0/hRX8RTjc4WZMT3dt8t7F4bncL5daB44nE
7pLyx+8LQeo/5OJOLTeIQ5lVZKEMPidPD43H6t0D6shhPO88L2wDbyiryzh9jeuG
eBYVCnRpYKdeRGUUiMygg6u+ozJzms0QcnFIFvis5Xzykww71gtJ/f8SyMurjfst
MUXZeKXzEFg1d+kqCd/gfeU7UvZwgpClfR36rXyilpCD7uiFu/n60GlGc/jvWsls
xYVSUly90Bl9A6qosHLkZwvQZXjMObYjMU5Gtf/jibE+0nRIwoiQJ4mwcuALdz3S
VTsoMjOSXsGva1cxOU2Ci7zKUNuzy133OSbcl0TShmQDWQGFuJQ4le1ALJQnT48L
QOnF4QsVF1dqQbiduVS7NHCCLyAY/CjO+irE1ScIxBzoGBodvKm8X6wHcjiqgRNy
Av4hh+cBkmsYKpSLvMqdq8RNzvy1SgiZjQW6Kk6X0bMuHcYBz8c=
=Fqdy
-----END PGP SIGNATURE-----

--nlnmZCMUT4S19Qmp--
