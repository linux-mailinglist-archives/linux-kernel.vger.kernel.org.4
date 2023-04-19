Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68C6E751D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjDSI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjDSI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:29:23 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9341118DE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=cngb2C84g9BKZ0ZKG0g55bhS90ZJ
        kthu/ET5iXKNzS0=; b=JJnTkShpAJhojzEnWOTzzh3hgFjKb4NfN7iSUxv/4Aqi
        ezk2yj7IciJYZuuzujnGg10HXwIiSkFdBrU7JB1qUT7n56LoseD6SgwwzsYVD703
        gqKcsvpQ35eS2ZtApTVk127Hr5cM2Sp3QSOMmSfKoBXNsv9t1yI07eKsnPu+HFM=
Received: (qmail 3620324 invoked from network); 19 Apr 2023 10:29:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Apr 2023 10:29:12 +0200
X-UD-Smtp-Session: l3s3148p1@zO74N6z53O0ujnsI
Date:   Wed, 19 Apr 2023 10:29:12 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Message-ID: <ZD+mWDg0WTu3nvey@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230419082432.33808-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xmgsPSiGktTgQqHG"
Content-Disposition: inline
In-Reply-To: <20230419082432.33808-1-wsa+renesas@sang-engineering.com>
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


--xmgsPSiGktTgQqHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2023 at 10:24:32AM +0200, Wolfram Sang wrote:
> Documentation says only DTDL of 200 is allowed for this SoC.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Not super-sure which Fixes-tag, maybe this one?

Fixes: 4286db8456f4 ("spi: sh-msiof: Add R-Car Gen 2 and 3 fallback binding=
s")


--xmgsPSiGktTgQqHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmQ/plcACgkQFA3kzBSg
KbY0Ag/+JP3t/H48HVbpYsDOJ5Q1DSSffnyswkWjN1aZMwaaFmyQhTZYQ70+pdM3
7D7OxxrYpvzQR/Fs9oMiPfwHsUvA86FRLcTe6QON2cexh3b/GuYGfToOzHjVTk20
/u39O+whP0GHV4Uj2SqKTeG/jLHWhvXb+/GKTYtxp8Cil6JjRbQaQa3lgBkp+woM
OcIaLAgbbyCzk6ZZqDMDXj1nAxiHnv7K4J7Y89BSIAPPIF8aXtaXxcOGQsoSd3cQ
EymVe2SiX32GToXVUjPgwavKTRPqKFuk/YbhFzLj/QFtAbUuUIJBChgPuWnShzK2
d1awNVdsqw3jSQvx9ZZ78rDKqj1+CjhjnEeKI8fZO1l7muOsXZlwHd3DAVw/iqN4
Fxjub1HqQDq4ZhDWE1IdS67SGYNfV1EEzPDMYZEu8QxT/WvbEFHv5TfvB9JKQJ33
jJe3rjzCMJi2mSTpNR1nBgEf9QPimtm2QUqEVSoT+Yuy4Xo4UlUQFT67U9v8O5MX
92HSXEaVThrMVx/vFjMGeN7QB0LGTtDfJyBdG2qpOqLxUKa4Rl7823Hu3Fp67dma
unRqJgzSRNcmU911b/g5bGPlrot/lC0AafEvW9ZMaGQ+UL2S2t7VJfHs5j24Fmof
mgxgBnT1pQHazYEa1kErbzIo7QGavQtXhwXAKRD7A61rhfNPlTw=
=XLVC
-----END PGP SIGNATURE-----

--xmgsPSiGktTgQqHG--
