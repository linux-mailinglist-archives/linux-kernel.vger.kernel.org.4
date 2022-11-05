Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382BE61DE00
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKEUY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiKEUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:24:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A2A1BE;
        Sat,  5 Nov 2022 13:24:21 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F63F6602366;
        Sat,  5 Nov 2022 20:24:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667679860;
        bh=LS7M3/CO1N/vKm4BNOmFkJ8nzHLkKoFHI/Os2jG2sPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVqEgVf9WOsC2QKeD6AZnz36i7kzyUBG5b1nDnp2EuRhjQ8hG7Qthb6MaP21Rb7b4
         s9Jo5lh4KEAEXp9LM5TQRqUHiMqxukFsoRNgEkzWSNSZFo3Ur+QbFDOb2m6fMH0SGK
         AKM/ksz4G6Q0979Xi12t7fXBx7ZskBju9HOgSCU+xs3aH5EGNr0MHoLtV/Ed5/pSJY
         IdJGUuqRzHBt60DXKi35HazEeGBzTBjLlhqkt2wUQ+ZP9ybj/hmQSNgYG93514Rast
         Idukwb1T3LgUDr2ZnB0F5nul+g3UJF0Zf2JcQjcgdv9oGcKcUzrpxIDsER9sxpOP3D
         cD7i4IwtZaynw==
Received: by mercury (Postfix, from userid 1000)
        id 18DF11060C37; Sat,  5 Nov 2022 21:24:18 +0100 (CET)
Date:   Sat, 5 Nov 2022 21:24:18 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: power: supply: bq25890: use one fallback
 compatible
Message-ID: <20221105202418.ffzqaxr46a6m2bqe@mercury.elektranox.org>
References: <20221102182011.106040-1-krzysztof.kozlowski@linaro.org>
 <166759879338.2892365.17924268048310200238.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ppx53uuspq45jza"
Content-Disposition: inline
In-Reply-To: <166759879338.2892365.17924268048310200238.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ppx53uuspq45jza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 04, 2022 at 04:53:14PM -0500, Rob Herring wrote:
> On Wed, 02 Nov 2022 14:20:11 -0400, Krzysztof Kozlowski wrote:
> > BQ2589[0256] seem compatible between each other in major aspects and
> > remaining features are auto-detectable (by reading device revision ID
> > register).  Existing DTS already uses the compatibles with a fallback,
> > so adjust the bindings to reflect this and fix dtbs_check warning:
> >=20
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: charger@6a: comp=
atible: ['ti,bq25895', 'ti,bq25890'] is too long
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/power/supply/bq25890.yaml  | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--5ppx53uuspq45jza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNmxnEACgkQ2O7X88g7
+poXHhAAlZnlPRbvTU/gQvcpCw8qsWekhYaiNYPAqTFVRLy3ef5Sb13hILOOmRaW
Etfp+MVtTrPM6AjXE0zEJ8dzEwl1E9ddjBX04s/kRjceImhHSK/3vjrdEpIRNl07
mlnZ/LMsBOo1LDcr+CyC6x7BEAMceRNd7oNGO6SQCNvGRFfkAQETXv97XMZrZUYG
zZamCcfM1G/RC+dUwXql4lJ7nF49hiNfN6DP34hnVEzUhKzknKmvM6iijxGJpXbc
DVYn3/Csg1U6YWkXCqTwV+06y9/8q8xeIHLPBZE0A7tY0Pd5PJsuRQRNq4oPuClF
xL9s1losSozZpajpg0DNKr5lwEfUymzek9n5Fa2XmBZRdCr7eMKJatOC+Tfu3Qgh
xqzp3F0CjpGkz3TC0GFA7ITm3XB20kjWFZ2qVmGKXh/I4TOXsO4SyyjdjzzTUENk
Ck0a4kfXqxxp6cylA3LKWJ5+YJFyiQD3fF6VjBDE4o5varXaRySt4CbSc1DfczPq
Iqzql5963zvq4R8mvSYCxqSfIOyH+nhrGiOaVHNY8bTOjPoqFeQDu1stPJnQARy5
zVlmzAWfY3wA2XoZ7e72uk8xpv+oQ5ecO7PqH8lthL8UPy7g/5p83nXB8+DVw7qG
UGhsznL2q5GG9OOB8LgkPd1xXg0UYNgWTb3pDihYtQG8s1/b/vs=
=5rL1
-----END PGP SIGNATURE-----

--5ppx53uuspq45jza--
