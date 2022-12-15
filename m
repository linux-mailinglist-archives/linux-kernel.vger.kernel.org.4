Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D964D755
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLOHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLOHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:37:58 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C531ED1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=KuvcfPvwa+BjCI6vaKqIJfDzVDwX
        Esjbl5vUFk9h+uc=; b=2Ex5NhqMqXKc1Yt6TKGJWD66qNNUV7VHNel0NTkxcsTp
        JldW9hnQru2ZVqpGXhE1B/QB0efkSbib4taacAr/1cj4eMToF/eRWnx8CAqTRJ3c
        5mjdMJlbeBYGauVtfqCOcd1lw6JiWRNbG9kszZ/a9X71kAIxtx8Jc/nsvU2+/EE=
Received: (qmail 2278995 invoked from network); 15 Dec 2022 08:37:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Dec 2022 08:37:47 +0100
X-UD-Smtp-Session: l3s3148p1@Q2Dy7djveK0ujnt8
Date:   Thu, 15 Dec 2022 08:37:46 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 2/4] dt-bindings: mmc: renesas,sdhi: Document RZ/V2M
 support
Message-ID: <Y5rOypDpz8obHoVN@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
 <20221213230129.549968-3-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nB2VAnfRyMJ63TdW"
Content-Disposition: inline
In-Reply-To: <20221213230129.549968-3-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nB2VAnfRyMJ63TdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 11:01:27PM +0000, Fabrizio Castro wrote:
> Document support for the SD Card/MMC interface on the Renesas
> RZ/V2M (a.k.a. r9a09g011) SoC.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nB2VAnfRyMJ63TdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmOazsYACgkQFA3kzBSg
Kba9bQ/+JGOXI+Dj4hMBDwMh7oY10zpnVssDROBvjW/J+jC9F5gwYx+SuQ2kSQhE
A+oL7+653MbG6lY5gHdqasfehSDi/S648o7sP731tcyrOf54ZD6UYtGcwMNck6k1
DGD2LAwQ9mlAu10bqGFkcLgR/ApCruxfOxmAaCdfZk+1OZ4drqNShlxTBVnTBPNV
WJdyeKNxqhQbamlTSrP9raZb390NuFnqBRODcs0SfYfThVCoBuHsnfzGaR2JBlZy
fyuY8N2VomEni4/r0Ciegnxz1Guy+NKJ+26eXL536Wsws7s3ydAOI0fYNUOA+RIw
cx+IZm/tOy+Iy0H9yESWdkcPPsLQO4scTG4f7Mqxg24h+goapU7379tDWw6+jd2Q
5p28hKpc21C0J8n7Fe3TfxkGnATS1VmpwMrBDQk1VSZxIOOh+qbWK+xanU4QxfSR
PuVLPe4EGxamFxB0b2F1YOvWUxjyJSUzZlnGB2nZpg0IHvQF0/DcK+Qzjc9YqLuz
Ef+RJ80JVZz3pmr5mm63Hjlj+YHdCC5MfXujSYSfKhskgfbJ12z7HE3JK3Oh/p1E
AEQDzpipflLlNTWJ/TYLe16FhUX2nNUjTfzUUZJhxZft7aaUFw7lVpmXPPtypDle
lzPGtDow1I+DrRIdkR5idqrBkAmjxfDbgQDrsY+LFitHB2ODeXg=
=3wdx
-----END PGP SIGNATURE-----

--nB2VAnfRyMJ63TdW--
