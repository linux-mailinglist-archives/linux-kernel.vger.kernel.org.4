Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60329744287
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjF3StH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjF3Ssi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:48:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C303C35;
        Fri, 30 Jun 2023 11:48:37 -0700 (PDT)
Received: from mercury (dyndsl-091-248-211-174.ewe-ip-backbone.de [91.248.211.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98AD166057EC;
        Fri, 30 Jun 2023 19:48:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688150915;
        bh=SBBllfHo7bvybxOlx0jHFD0nrtAr7RUdPig05tF/QEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuBU9vc5FJn2Wt0zZYh2C3cohLT8a+12t7KPmUtbeGD4OfqEqEmU/KMTU89sC9tVy
         +0d/1Wle6xUyEgOXy6qTm1z6han1O0/p6D4q6t08Has0jxrIacb/bB3afOmYuar0Ky
         6iEih5FKmTRDRhWIgzznSYSR5bC9BipiSasmGQCsZI/ai5dSl6x42SSmOGDWPi5tW4
         46CJKmxyGZYyCNcypPiVzF+qytwp6sEPl/GiTXjfTt5iTpSpCsxn2TY73FC00eiq+J
         bxx7Mcj71vPWjTHpWBrAdEgHTdr2dv4HermFjqYrsuKkYCZmcj1J6urxKRRQnOYY17
         o4aLxWwnr4QYQ==
Received: by mercury (Postfix, from userid 1000)
        id 4696610613E0; Fri, 30 Jun 2023 20:48:33 +0200 (CEST)
Date:   Fri, 30 Jun 2023 20:48:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH v8 05/14] mfd: rk808: split into core and i2c
Message-ID: <20230630184833.o3lgqrtqzzwgb7nk@mercury.elektranox.org>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-6-sebastian.reichel@collabora.com>
 <CAMuHMdWRoNXrkD8ty4pUpFA-qQCMVF3wzXTCHFW4jYSy+dXivg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iqtscgntphb3oqls"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWRoNXrkD8ty4pUpFA-qQCMVF3wzXTCHFW4jYSy+dXivg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iqtscgntphb3oqls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Fri, Jun 30, 2023 at 01:34:44PM +0200, Geert Uytterhoeven wrote:
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1183,12 +1183,17 @@ config MFD_RC5T583
> >           Additional drivers must be enabled in order to use the
> >           different functionality of the device.
> >
> > -config MFD_RK808
> > +config MFD_RK8XX
> > +       bool
>=20
> Is there any specific reason why this cannot be modular, like most (all?)
> of its users that select it?

I don't remember why I made that bool. Tristate should be perfectly
fine. Do you want to send a patch (I will test it of course), or should
I take care of it?

Greetings and thanks for the report,

-- Sebastian

--iqtscgntphb3oqls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSfI3IACgkQ2O7X88g7
+pqfHQ/+OX906BcLDwv+c9Vj7iD1xMf/jeseVPwosYdbwztaWSudEc2oqnLracEz
qQBXFFZ2oQWA36fWxJfdrEIHW8OgcrkaAQ9IYKUja4qT4mNKEtyfC+xEH1PxTpTd
Elj3lUA9NaLILoR2MN1Q2hTWHmmrevL0P1QEIEAXB2N6+D+fWKNApHvPZDw4eI+R
iD2LLbVjYdmddX88zmZhKnAB4vuCZp/ReMR6Nki+eF/rCH3iR9S6gUomMFgW11Zq
fwxTKYBlxxBz439pj7o+zgiZf3Dbk6oyv74FbsCgiP4oeNjrcrQqxUX28vwi8NwP
FiCGdlCjY1gC4KwN4FqFBElQhKYJfU/0lxX60JUXh8EcDk3EVXatZUfSW+tfJFJw
DZ49WcCb/RjvKsx9Q5vgK432RV0avSLgarHhFmRfs83c4Tj1CbormHQs2iZPZwyt
n0R3mN+oI1v+ucvtGETOmICww36sWdf1nniscIKayv7FsOIqQlpF+WXB6or+UTUB
1RfrfcdsexLjNaJPHZ93Yfnkb1DQfOKEn9yYY1IUGpPBPH7vz2FoDdjrt2LYq6xR
niQNPMqzD2KO/GYhGA2ipu4paWPvuZE+UDCCjWZiC+knxFL1zBf5eQzoeOQqFdTk
tJovpTIl42CKM1oKm0MqAy1+lOqeWbkmJ7aHIkEB01Fb26w+3xc=
=iqU3
-----END PGP SIGNATURE-----

--iqtscgntphb3oqls--
