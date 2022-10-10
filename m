Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45825F98AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJJGyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJJGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:54:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58362E5D;
        Sun,  9 Oct 2022 23:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12050B80E4B;
        Mon, 10 Oct 2022 06:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5AAC433D6;
        Mon, 10 Oct 2022 06:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384861;
        bh=b8eXH4dGjhkDDmvl3c+c/N9FezV9YsENdLe6lckGWZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYfuVdNGzjXObiDmuC/sl8CB647hy+fVlRiSVUUJcMYbpHTI1hN6m/CVZKnMV/s/t
         7LgkK8QmavUdFb1BUYkvrcZAEJ2KQDEXkMrWeSrzx6bvLYBx5SbAwMwSUUTTTOXuVP
         U0PCJ1T3wZezudDFkJmg3DgnA5unQtKCpPNJLRgojPh3s+9VX5ItkrQTrRuAERCCuj
         q3jLWIE8BQAf8Bj8YlXrj2TSlCa3Hoib93L90fH0+h54tQZy923OOYZ26v2/XGp7HU
         FMfbkneKIhe7Ymwm97ES6x0oiSFAxMgQGDaNeWL9ppfCS2Iya8YJngx8DETIfWZtlU
         X7IZUaT22Jctw==
Date:   Mon, 10 Oct 2022 08:54:18 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r9a07g044: Drop WDT2 node
Message-ID: <Y0PBmlgGyB/H0POY@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YOHHFdG8h9mmnr8u"
Content-Disposition: inline
In-Reply-To: <20221009230044.10961-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YOHHFdG8h9mmnr8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:00:42AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 node from RZ/G2L SoC DTSI.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Again, I'd squash patches 3-5.


--YOHHFdG8h9mmnr8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwZoACgkQFA3kzBSg
KbYsSQ/4qLmQuK1KEpcdPb5GENIZQdnSdQbNEsP5GJsaneGSNUI3+nHNd7pKBbC9
vfpj5QLVcLhicZOKw3Cja7Ckx4Mo/D0p2B5Lf+FqSr+9n/tVrvqs+D2iyyOcplCx
vMXkZGNEUWRtob9Dne3oOqAA4dbifk4NMqa8EkAUlFkiQ9Pw7pJeqZDP5123itPQ
SMeqsidfMO+uJKxX7NuSvIRGkuyPbA3rOEB3i/An1unJznmZHdae6H/W2Tf5+h3G
uuMEserxX/SFCOEwbU6CfgSdShKRULicfWfa3bTeSP/SYLiBgH+SevX7lxF2Htgr
ZUzEsOeBGWJoG1mouSLyTEPL6ANNGuJUowKWkoJL7xs1g0S6DKm/gtJmkWEzc5hO
kIa6DCYGYT+dICJgUHxlcKGrVpGZJ4z6kJBXyTOhD9jFERlRpCWsbulUR8NanI72
tywq3pcaAkcSDW8Q1jAEalJbuy86x+PhomMlQ4Oa4e4JGIdxV6rhkfD//FSTF3bD
2szCz4C/4R+awEIQWvLSByuo8SpMS/H6anXSXVESKc06P2sw1UJPA8nY+GgQHeR1
GupPBzgZSd76yTsikWUIs8MN5Y1dkDZgX8Tie4W90l0X3iY7kMphxrwNA3KDytbP
BI4fK8aiXFx5/0cACqZFNToj4gP2+p8jHG0zP8ytsIXTyd+7nw==
=a1Ki
-----END PGP SIGNATURE-----

--YOHHFdG8h9mmnr8u--
