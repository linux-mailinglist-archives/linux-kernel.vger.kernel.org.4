Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492095F98AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJJGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJJGyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:54:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE5CA;
        Sun,  9 Oct 2022 23:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D71D6B80E49;
        Mon, 10 Oct 2022 06:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17858C433C1;
        Mon, 10 Oct 2022 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384871;
        bh=TBK+vLP+SLH2BY+zwgCKLVNUM/Mg+YR35J+G2TuSMsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugnBMjB7MsKZO3EIP6lzH9By/LiRaifvgoAESvFkHC7l0MwrSH9WO/u7Q91bYyLbu
         Z2gvfi8SKKkpYUoXQx2/kaaS0d9U8kQ7rNZY7pMBHO6ergIBH4e4TOUrvmpEQLfyUg
         vepdcvU6hsDmhipnq7GvWZtaR6oC+iTPvh6Tcw68KZpIJlUxsI5UpF5IKJPOazNjVb
         oEv4ne7n5NUPBsOiPmAgiSHMvJqOCIzub8CujWtAYoBNm9eHrA7CV3MkqEOaX8Oq9S
         IfnihhcGvGesGw9qELMef3FM/MG5rp1Gc1uo06WCDFe6jf3FJZI1NB0vd/Saz1kRzr
         OWA9zcNjAFShA==
Date:   Mon, 10 Oct 2022 08:54:28 +0200
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
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r9a07g054: Drop WDT2 node
Message-ID: <Y0PBpJXbirVuEY4j@shikoro>
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
 <20221009230044.10961-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q3BHX7HePzA58VIG"
Content-Disposition: inline
In-Reply-To: <20221009230044.10961-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q3BHX7HePzA58VIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:00:43AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 node from RZ/V2L SoC DTSI.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Q3BHX7HePzA58VIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwaMACgkQFA3kzBSg
KbYGyw//VbtWk6Rn/NDvK71ANDpe+rC/Yhy8Llu7l2kPcOL+EqeMFvfap3cEF24J
ehe9v2OcywCfAMM2jF1TAeGxFqAKWXdw83rEESMLt8D0/fnmbdeR/8tqJy2Ux6D9
ZlTMj8B9J0pl494VXkfeSEMvR5FkZoGYHJzFQuwRC1S8kcy0MPKj2u01GV2WLCC+
C5n8PbScFNk8ZRbXYRA8rLQsyD2T/cuFM8Wpu3StoNpFvbi6IUv11Y8WHvAFIHiY
Q2frvGGCxCjBwtLMCpDOcZjm1/zKSube1hadQJagWv8Ax8WZeL0fUXJDFXvEdZOK
Knz0q9hzJrAAV96TN1zsdGqmvYAtIqf1gDga4IG+VP/CK7FCCo80nNB8lnVgWk4Q
1aZ3bJ2Vr6NFOi+EDVRZzXSFrpoiWmqSBNNxfboB6y0qpxM96mKKMLjiCBBhGwW3
RtND7ZoRWvtf9RVT/Oi5t4cL/+BL7oJzq1hByZJvL+09bDjq1rxDWpS+ffZuvfgS
NPRtMa4VB9nMMhL7KeLc1wt5fNSuwH9FspMIM6RbgFyezAx2Aistslxye2phi1aZ
30B0+17y8y0DVyQLZUzHNS6TPHxufNDrEFDuOka0KQqVag5a8hw4tqlQXzja3OIf
EWbw3kTEgErGYxPfguuCy3n//KqWD/VTCWaAIU5mK42EhHga9Ks=
=XBb6
-----END PGP SIGNATURE-----

--Q3BHX7HePzA58VIG--
