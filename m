Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A846D2BD8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCaXyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCaXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:54:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8381C1F7;
        Fri, 31 Mar 2023 16:54:14 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C1A1660000F;
        Sat,  1 Apr 2023 00:54:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680306852;
        bh=YHlphjJ47UZM78sQZbxHJaPtfyy0JtsbqGEYFMBvjug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T61qRYR9D2V4zDhoi3erfn3IYnFrhSo5iAgPf3R1wn+XJZimSiW1Ih7jCGeO+yXM6
         Yrbxdauw3Mi48TuDfzP4+eW3CqEqBBu+bs+t6c43BDStkgC7PgOjUii+6/TaJzqYo9
         aB3TF3/UVxHcAb9cncdNESGxRopHMYMBNXl7iwE9BkGmw/kNtQQMHUxN338RL3Mck5
         D8OYJMWG9i/iVy2M6Xq0/SDakOKcHxvt8l8LbFqppiik4J1D5lsTzPO54S8Y5AuX4U
         Kx6j+0eYWbjY2NCOJO3UxoiZmNWKITJ8kpOjvMaOyNJmDOjFahxJhHM+npgWHnyLqW
         aN6Hczqq6sn1w==
Received: by mercury (Postfix, from userid 1000)
        id E69ED106279C; Sat,  1 Apr 2023 01:54:09 +0200 (CEST)
Date:   Sat, 1 Apr 2023 01:54:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alistair <alistair@alistair23.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>, ye.xingchen@zte.com.cn,
        pali@kernel.org, sravanhome@gmail.com, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: power_supply_show_property Kernel Oops
Message-ID: <20230331235409.tub5oxes4cse7wne@mercury.elektranox.org>
References: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
 <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
 <20230329224736.qzidpkzkdth2lvuq@mercury.elektranox.org>
 <3cd2ef19-f902-4493-ad90-00c410aca176@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2o6gmr26ich5y7ua"
Content-Disposition: inline
In-Reply-To: <3cd2ef19-f902-4493-ad90-00c410aca176@app.fastmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2o6gmr26ich5y7ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 30, 2023 at 06:00:41PM +1000, Alistair wrote:
> > I did not look deeply, but it's at least missing an update to
> > power_supply_attrs. I guess you were 'lucky' that it did not crash
> > with v6.2.
>=20
> Do you mind pointing to an example that does this correctly? I don't see
> anything obviously wrong compared to the in-tree max* drivers.
>=20
> Anything to help point me in the right direction would be greatly
> appreciated :)

I am talking about the extra additions to the core, that have been
done incorrectly. You cannot see that in other max* drivers. The
additions to the core basically break the core and thus the drivers
are broken.

> > None of the extra properties are acceptable upstream btw.:
> >=20
> > POWER_SUPPLY_PROP_CURRENT_MAX2:
> >     The driver seems to use CURRENT_MAX2 for input current;
> >     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT should be used for that
> >=20
> > POWER_SUPPLY_PROP_CHARGER_MODE:
> >     OTG should be handled via a regulator
> >=20
> > POWER_SUPPLY_PROP_STATUS_EX:
> >     Use extcon for connectors
>=20
> Thanks! I figured as much. These are just taken from the vendor
> tree, I need to clean everything up for upstreaming. I just wanted
> to have a working base point to start.

That did not turn out that well so far... :)

-- Sebastian

--2o6gmr26ich5y7ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQncp4ACgkQ2O7X88g7
+pqSNA/+OhSIKjmO8LExFGPc60OFNOZwKDQG909gAZQd8JFTJgT4a9S5T5ocsVP3
kCxPx45nrfRXCCxxqQWN4BM/qqLZZb13uuxs3lSjU+q5ha7lhD10Bk7s5sm54vOa
xNUKJwI+Eq1lXB12MNGHsSc7wPQPGLkqC927NLptGq/oERbQiPgia5oSu9zYgGpr
2FbWbnxThcWPbC2wxZzwpD2N7HmyhEm+kevZyv42Qxbx7K0YCXyiqY0eEbhP/ICt
xSrhPjabTpOC5Xix5dNlnI9iqAimB35YvF7/fx4ZM37MmS1wdMCf7vTfSRy/f7qv
qMGQiJbNx2mVlNDTCljh/OniMceutcZdeoXm4T5UDFbNK4anJc1HUmKPyRQTeFd3
7+xdFPOT3UjTudcCgOwYf+dRR+gD44GHC8IocsO52QfaMv/2Gbm4sIXEOKgDbjnV
ORLgA5sDjjvhDlJFOBfQr69Xmp5IwgxBHnesg+NBikVdD0fsDJ5PdcBrUqlRLXje
2BXpQsSKD41j6ZYVWWcVujoubr0YYbn8RxY6wi5hKCRJw8QzpPf5TbRsv2/yilfy
SeJPof6zMZ2dwNG0n+l6eqbeKUp2ycyS1bjWk4XslnBWHfc6ntsld2kcfsO++phN
+lJrQxhv4u8ctt03xwgkvUbxoMUqggbQj70hLPQhDMYAvaAELpc=
=rmUF
-----END PGP SIGNATURE-----

--2o6gmr26ich5y7ua--
