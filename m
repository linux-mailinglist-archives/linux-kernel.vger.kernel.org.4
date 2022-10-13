Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91115FD8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJMMBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJMMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:01:15 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A1E52E4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=N7+eHjL6LFM+ESLvcFQjUaWfxnyv
        zQIZKKCKQXqmslg=; b=G50JIk7tZfJDMAo3k49+2fBwPAbvjLZsZFn5gBoz0DLN
        a5jP6qU7yyHVVd8KjAHQLpr6tq1ONz+iL7E26bji5Kencl0XadNU1/oPUDj6Mc09
        vD9wPmHdoS7+A5SD8t6dChEEETtgy1htUY6Jf5dcIN53LlNmBPOMkFEboRcuCc0=
Received: (qmail 1095071 invoked from network); 13 Oct 2022 14:01:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Oct 2022 14:01:04 +0200
X-UD-Smtp-Session: l3s3148p1@dM9+Q+nqG/EucrUX
Date:   Thu, 13 Oct 2022 14:01:03 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>
Subject: Re: [PATCH 1/2] memory: renesas-rpc-if: Clear HS bit during hardware
 initialization
Message-ID: <Y0f9/9mcYpXG8Irf@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>
References: <cover.1665583089.git.geert+renesas@glider.be>
 <08d9fb10b3051decebf871267a6e2e7cb2d4faf9.1665583089.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="66w0jPitfrxKTN6+"
Content-Disposition: inline
In-Reply-To: <08d9fb10b3051decebf871267a6e2e7cb2d4faf9.1665583089.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--66w0jPitfrxKTN6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 04:01:51PM +0200, Geert Uytterhoeven wrote:
> From: Cong Dang <cong.dang.xn@renesas.com>
>=20
> According to the datasheet, HS bit should be specified to 1 when using
> DMA transfer. As DMA transfer is not supported, it should be cleared to
> 0.
>=20
> Previously, the driver relied on the HS bit being cleared by prior
> firmware but this is not always the case.
>=20
> Fix this by ensuring the bit is cleared during hardware initialization.
>=20
> Fixes: ca7d8b980b67f133 ("memory: add Renesas RPC-IF driver")
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--66w0jPitfrxKTN6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNH/f8ACgkQFA3kzBSg
KbYkAg//XV7tD7sfp+dZnLRiest7WjeH/nUh7Us4MDiw8WSSb3kkgKNIeXufAAYo
3zm3Rp/bX7B/xPnImZosl26jcjWK18NP1rVezTzhKQENQ3K13uOOjDI8pU3c9tg1
jbU4WTYso/mjqe4vHLB2WpJsR6FCHjGs9tQ2ii4Ta7PpQBodhlQISB6RH6Vllrt/
3d+cHL+EexdbVXhFKUDdgrGq11VanihCFOITVV1cwWi2blnybcugTlNNXchYOKQw
VTmyCcwnSKVitHZmLmBEO0ftFnaV/TkmJ3NSjG6vI2QAw5yh9rG9rPC8rXFLLYCW
xdJqRqC5uUOKYtEzpJaL5k4x7nfjm4i5OWJEhLRg7H7HvqTvEcH7+dil99lksE4Y
sOeB/abONu+wdP6d6ac1rFWtyYNbyDWB802ALeqQ8/hsHPBp/+1CXq3B/sdpxfj0
KBDa9tEkqrQ5G6RG2gtQxTWaGRldPiu8ZapmW1nkDvuUh69+JE4G+CZCEFpXtGUX
X1fdaqSLlQq3VXRME2/O6Bv3nsEvET6lf8dbA2mTSEL6sCHWDWw/pzgUkvjEHN3e
xTJDpZzEciCB4q4w6gZS9P+rBEXJ8N3FxXjj+iguDlWLeAadLoVpubYtK+U3DX/H
q6f1E/Jq65f9XKT9L1BaXgJxLze3je8MwN0KgE6E21IGr+kAoow=
=UBIc
-----END PGP SIGNATURE-----

--66w0jPitfrxKTN6+--
