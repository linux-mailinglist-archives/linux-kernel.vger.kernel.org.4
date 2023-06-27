Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE18673FE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjF0Okh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjF0OkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46D35AF;
        Tue, 27 Jun 2023 07:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416B2611D8;
        Tue, 27 Jun 2023 14:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4228C433C9;
        Tue, 27 Jun 2023 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687876779;
        bh=LsPvMzESGQs/N3/vCu1zyLVq43PktsIlHmdAqetSq+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHxsk75/BFneiMvJT7fd0UT+h/y1N8gpKFlVXu4HfJQEY8LlkIme5Vu/F6fK3Bvvt
         Qo2RZhNYSa5vIQUVpCttaxIdKTRjrvgiGlzpytnCcR8q5MU/PDLUVjgHGvkpDka/Qm
         kdwNEOU6K7qE46NeMo2PK6h3h9t/9je9UmHkI7nvzK5twEJ93TwbzfQVielCK82Hsz
         yJaKlYBK6sZcwo9PWlp6gZ5yCjP7G04s8mrKHgoewoqKje0fvkzQZFixXDpDEV/DKk
         wwVmR3BjFziR9cLRlyzvP9CISYBYdeRCc1DF4wSD/ywcRSulWqoL2GWGwufi+xUwc6
         s1cL6RgfGO0pg==
Date:   Tue, 27 Jun 2023 15:39:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <841cb32b-36ef-4c58-9b83-6e2ed63fcd84@sirena.org.uk>
References: <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com>
 <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KkVPte+kntsdEuj+"
Content-Disposition: inline
In-Reply-To: <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
X-Cookie: Money is the root of all wealth.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KkVPte+kntsdEuj+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 08:10:59AM -0600, Rob Herring wrote:
> On Tue, Jun 27, 2023 at 7:56=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:

> > I cannot merge other subsystem's patches without and Acked-by.

> I (and Krzysztof) give one or the other. If I'm taking a patch, then
> it's neither. I'm pretty sure Mark only gives Reviewed-by when he is
> not taking something.

Yes, I'm unlikely to give any kind of tag if I'm expecting to apply
something.

--KkVPte+kntsdEuj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSa9KMACgkQJNaLcl1U
h9AoBQf/RYrIbJ374HR5LpjE33Cf+MV5JSn21l7dxqK2KdTPMScFap2w28LAJMrL
/K68HSu4oqRUkPTIdue/r14AsKfm5AagceoXRU6VFfSBTpw9rbR/QIdyhxiSp4Np
DTnaF5PHpkJ5/pW92fdSeYhU7aICnoJm3GN6G9xrDRgvP6S1IGY9qywtCxlsHmNG
hZXR7QVrWNFt6jPKz2GoSymQa9T5Dj4+4DG/Vj28ttX2i9IxgM6CfaueDIkFpAsp
bQpyCrdg06rMG18tPuKd9OdLDeIDLkT8EY0W2PHBcVFJS+a1fbc5gbyrRnn2dlPD
NYBGML3n/xtBnR5tg1EwwfzeLYzTKg==
=hakh
-----END PGP SIGNATURE-----

--KkVPte+kntsdEuj+--
