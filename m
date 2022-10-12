Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF435FCB48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJLTET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJLTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:04:08 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA83D18C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=UpgSkj6GmfW+NSNwCj+VisYlbK0M
        /XzHlZVxGc9d2q0=; b=Rq8YyG+VnFmxwE+oj5mefztRzA2PNpIBSlEcT8i4uKYX
        kjDIvj4cakn/MBHD+N7CdQh3kgqr55fW4KjlJ0Dw5R+7NmDsydOTSjEDSvo/z9fC
        WKBY3h1haoxEkFAxwp7qdDZ5sqko9rLuA3YnuxW4NewT0n0H3lBQhuqzEBBevYE=
Received: (qmail 816697 invoked from network); 12 Oct 2022 21:04:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Oct 2022 21:04:05 +0200
X-UD-Smtp-Session: l3s3148p1@W0FtDtvq2rkgAwDtxxN7ABspc7EPVowl
Date:   Wed, 12 Oct 2022 21:04:04 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hai Pham <hai.pham.ud@renesas.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4H
 support
Message-ID: <Y0cPpJin64ou4ivI@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hai Pham <hai.pham.ud@renesas.com>
References: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxEeX5/ZqgYrbyXW"
Content-Disposition: inline
In-Reply-To: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxEeX5/ZqgYrbyXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 03:51:46PM +0200, Geert Uytterhoeven wrote:
> From: Hai Pham <hai.pham.ud@renesas.com>
>=20
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> R-Car V4H SoC.
>=20
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

What about moving V3U to the new Gen4 section?


--qxEeX5/ZqgYrbyXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNHD6QACgkQFA3kzBSg
KbbUzw/9E8oJB+kpMZ+KHq3pXk48esFSsUV0Mf0Quh1Fg33pERUyvT0O0M5weYWB
UauVms76LbEC0deBGrS0ZVcLJYmExe9FRrUdOPOtQLsHjvLtUzMbcYGGDUh/hyTT
aIWkbwF1k7N720mB6Ve+Sb2LnhKC0ap+jl2fToVgz4BgVbpb9SWCFmzDQpl5+h86
GEpChdp91MU6FhBlNA47NzGCEegtkOp3B72XmvqIxS5KojtTZALLwc3db/DUlnHm
oVCr3+m/jFOFHoOz24Xz6mWa9/d6aGNQd743pBuCWMy2HQu54PGFN9TWiLmVsi37
1e/XxwBPNLbAqSpAaS4J6gGPu+4vz9Te1W3RiGKQBuIRqCZHwv3wrZYiQyAuEqMk
AhRyoN543LODFdiuCdmKzOXuDbp4huMc9FsLh2j3GaNyJC2g+5NK0yWktXX/jpOm
F+A0t7Rse+oLv+90rIxBMXsktTh674dkvcP+LBP4LMwmahmN4BU3Gq8Lqf26lsyq
Ec2k1lwfb/OmzPPapjfRlVMRJvdCrnAUx9GbduBKBmvTc6oXTVcVc/ZBMvPMPJoU
mX/apC5HUBlR8NdKkSzesgRiAQs12hxMQo0d9vJL69szP29CR0LuPCBUtqtqM1vM
jn3zC3afKrePHLkqSAu0xAvDPOhokp3kqS4hI+I5clWfXBfi3gk=
=ZWG+
-----END PGP SIGNATURE-----

--qxEeX5/ZqgYrbyXW--
