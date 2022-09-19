Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8635BCE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiISOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiISOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:15:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282414D30;
        Mon, 19 Sep 2022 07:15:09 -0700 (PDT)
Received: from mercury (dyndsl-091-096-063-043.ewe-ip-backbone.de [91.96.63.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 583CD66019EE;
        Mon, 19 Sep 2022 15:15:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663596908;
        bh=DJNFm5ow1ScUS1x0+XRJo/WRHt4yrriLZCg7LYoI/Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m77qtZSbn46FLo0nsEmpUwkmjkgWDqjmfTmzlAAn7vuX7QCzR3hs67wIn1O7nCpiF
         DiwFgcl13ZZzN19cA8bNbxxZrlHbwqRmKKQ1JOMyNP86X0FnPrXR0WIQkRfVgBOp4N
         IYFUSxgr7TS2fOPrBVhoN1vhwUK92rNNesyTP9hY9UWkWvsQvuepZdl23lSvRLirf3
         eSuG6b6o46iBHSFe5YMpod9N5mWXn0M/geC30xGLO/scEZKQ3JFq5ixW4YDtww2dmj
         gIrGhsaV/H2KWFKOkFvgjEIwrLKxRIR1QTlmqaWKCA6U335azkuulzHpeCHn7QnzKZ
         eXj5AawZX8QBw==
Received: by mercury (Postfix, from userid 1000)
        id 1D3E910607CF; Mon, 19 Sep 2022 16:15:06 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:15:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 12/14] regulator: expose regmap_find_closest_bigger
Message-ID: <20220919141506.mgq42y6k2a7ie5vo@mercury.elektranox.org>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-13-sebastian.reichel@collabora.com>
 <CANhJrGMd_4pK0Avbngggs3BJme7WgrkhzvJ+VbL7-JYri37Dow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jsfypupy7a7paias"
Content-Disposition: inline
In-Reply-To: <CANhJrGMd_4pK0Avbngggs3BJme7WgrkhzvJ+VbL7-JYri37Dow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jsfypupy7a7paias
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 10, 2022 at 08:17:09PM +0300, Matti Vaittinen wrote:
> pe 9. syysk. 2022 klo 21.21 Sebastian Reichel
> (sebastian.reichel@collabora.com) kirjoitti:
> >
> > Expose and document the table lookup logic used by
> > regulator_set_ramp_delay_regmap, so that it can be
> > reused for devices that cannot be configured via
> > regulator_set_ramp_delay_regmap.
> >
>=20
> I am always in favor of adding helpers to be used for common tasks. I
> am not demanding this (so please ignore my comment if you feel so) but
> I guess finding the "closest bigger" from a table is not ramp-delay or
> even regulator specific. I believe something like this might live
> under lib - if exported.

I'm bad with naming :) If you or Mark have a specific suggestion I
can change it accordingly.

> Anyways, and whatever it is worth:
> Acked-by: Matti Vaittinen <matti.vaittinen@mazziesaccount@gmail.com>
> for exporting such a helper. (Or please disregard the ack if acks are
> reserved only for maintainers - It's just a sign that I think this is
> a good idea [even if it could live in lib])

I usually use 'Reviewed-by: <...>' in that case. But your Acked
line is broken. Looks like you have split personality problem
between work and private mail account :)

-- Sebastian

--jsfypupy7a7paias
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMoeVwACgkQ2O7X88g7
+pr48Q//RAc8SdILtafslFNCUGJjg3RZ52DL7/45jBvpLSGdgkNlLsBxCZUutN20
Nu740kUnW/gDILLLX3J+KkTgO3Wp7Q+d0ZTy5ZWf1rnPGovd6tL+ivHihYN+s/Ya
jVgVAncV0EGMXD03HPQofyaoS4pVKXpYvDvM4Mdad9th7vYZhij7a6nn3eMBNic/
7xvFOP0hgbbw7AGEB9PdllE7BSeBxnODGJ6mwGicysDkckaPwcDUj6wkehur42uz
ZZnoG4C+hoA/d4bCDe/yYT0okaq/ZtHZT4ykQHtFXUJTymyNnfnVcpE5B6Rurxc2
1TamX/wZjaH8T+wSYMTiQ5ZFoSfSjWJ2W4teYCQO8M7s67JL8etbdNOeq/R3+bee
qB45IoXLuu4vxDEp7DQgQvtxhD5fqT5V063V3E6d8OdsAhKt+AVpgo3JWKvzMnCp
joNiHMgAhYAsnfBKJriV37jnHP5JWWNZ3CRd9zvWIwi0bMPiN3ewuRb5MnUgN0C7
kI+iGpOevRnbgqd+egWbnxf9eMOttE9dHGpvXoEhKnb6uVWk1R4CGRzWgHby3BJU
GJzN14J+5DT9d7VsQoaMsse47pBfMVdiArj7UFj93ID1/YIxg3tyyDKO3osCf+M9
bK+i5UhwwWuMAZJ+UBhRU16GpaGHPbthw7zhsCQ4H9AfJBvQ398=
=1HVD
-----END PGP SIGNATURE-----

--jsfypupy7a7paias--
