Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C05B86D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiINK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiINK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:57:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3B140E3;
        Wed, 14 Sep 2022 03:57:11 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E0D9660201C;
        Wed, 14 Sep 2022 11:57:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663153029;
        bh=eRW+oofSSgXLYsJ21Z1vqonSBjJ5bDGljpa+Xtah7mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGjdPu/r/JqY4+IPFdf2khVBPmETCsmIoqyKnCG7wYy6kK3Tik72pg3FsWeuVWqrG
         umwXCIXIu8Bh1hg1Q2jr4H9oFbY+DxXgWucIaileXyzkPB839VI8xWmijYysHvAF5m
         YxFHJ7juo2DOOoGshvsHJknTkJkaU9tETcr6ykGwUiLu9ezFN8GY4Zh+PKxqO7bjFq
         T/7SaAUsiOHwXOf8EYXkC5cIokPBwQbTw9Sk4LNPvFseQ0VX4eGKtAMdtAZOXxO3n0
         bROuABocer0NtvXZ/lzQ+fxBk+oJnE6nBou7Q3wIPTi1eswCxKrqGVHvnYu3LPKcWm
         STRrBhvkhoO9w==
Received: by mercury (Postfix, from userid 1000)
        id C6474106084A; Wed, 14 Sep 2022 12:56:59 +0200 (CEST)
Date:   Wed, 14 Sep 2022 12:56:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH -next] power: supply: bq25890: Fix enum conversion in
 bq25890_power_supply_set_property()
Message-ID: <20220914105659.ybfbcnrboahkkccm@mercury.elektranox.org>
References: <20220912141553.1743568-1-nathan@kernel.org>
 <bde49ca9-6515-63c1-2161-66ab0443fc33@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fhz7znvdp57m6wa6"
Content-Disposition: inline
In-Reply-To: <bde49ca9-6515-63c1-2161-66ab0443fc33@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fhz7znvdp57m6wa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 12, 2022 at 08:11:59PM +0200, Marek Vasut wrote:
> On 9/12/22 16:15, Nathan Chancellor wrote:
> > Clang warns:
> >=20
> >    drivers/power/supply/bq25890_charger.c:625:40: error: implicit conve=
rsion from enumeration type 'enum bq25890_fields' to different enumeration =
type 'enum bq25890_table_ids' [-Werror,-Wenum-conversion]
> >                    lval =3D bq25890_find_idx(val->intval, F_IINLIM);
> >                           ~~~~~~~~~~~~~~~~              ^~~~~~~~
> >    1 error generated.
> >=20
> > Use the proper value from the right enumerated type, TBL_IINLIM, so
> > there is no more implcit conversion. The numerical values of F_IINLIM
> > and TBL_IINLIM happen to be the same so there is no change in behavior.
> >=20
> > Fixes: 4a4748f28b0b ("power: supply: bq25890: Add support for setting I=
INLIM")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1707
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks, queued.

-- Sebastian

--fhz7znvdp57m6wa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMhs3cACgkQ2O7X88g7
+prgxQ//SY0hFyUVsTnca13f27t5ESE7O5TjsvWonq9LhJrgpYtYNG7yLI4hHkRt
mTSCQbO/GFu8HHkEl9CnGCMVQWMVtNCD7scU/zXzmxRYFp6BAmPHtvLeyiHInpbk
KUzZ3RG56ah/Vxe96sc80GbYInBGMxCTNSBFPMID1VQ45+0AmMoSbEKZ9oKQ5ClK
VVORhI2xh3O6TqrVOh5WzeNfMGRqzlRlhT9eyP2ZniUtzySlAB8WxUqGvRecZBS5
nSbuvCPuxVkTQm1C41Rn0l4SwSYdFD97JmqYDioaQfCLdFzXzFzciQwash0hKu/x
S4FGlUIz/m2e8UA4DNMTBYBPypdHQPNLXQDl9pDr1wv5eEtPLuios1OQRsGlaqKp
pSMtJlXbyaJZP1ca44IiXEWxBPFj6QR9PLP3m4Djxq/SWSJN0nW6cF305dUz80s+
Wc1JDtcHGvoX59CCEM8PL0JcQ+nMO6Zb7Vr+y9lDfJYieOTNltC22MQL7xU/rLqR
tnx7XoKTwlIaLgX5QryXtCTbP8omSg8RlbZt/+0zqR8AVmnuHhbxdMRdXO3xQ1zY
8rtpeRT1LrlYlg7kvr0oJ6U+HBfD6Otkz9lBAacCEQAIW78RsRbEYuKHDVSoBCl0
UzW0sZO4eJOkAk9vi7D15dfUqIRL4IDcbGvFec1mwcMtVhaArVQ=
=kLpH
-----END PGP SIGNATURE-----

--fhz7znvdp57m6wa6--
