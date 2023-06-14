Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770F27303D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbjFNP1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245099AbjFNP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:27:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7DC3;
        Wed, 14 Jun 2023 08:27:25 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-214.ewe-ip-backbone.de [91.248.213.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43DED6606F4F;
        Wed, 14 Jun 2023 16:27:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686756444;
        bh=GZ8Sf33JazmMkxEGjgJU5duB85Yb8pBBWqBGBBUZx94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaegutL4WL1b4gvUQkqIFcNre+qhwMQ6dYMcSeoDrwpk72yLm3RDAJR8IspFh0KtL
         mYkkP3sFKEzhd3NuSc8cmgyEad5uXGDqg/6qjPGATCJ5Sjeneo69n8ET9HhtFSm1tS
         ZBOEAjj0w8rARWE1/u0Q27E7pWDWi73CaRVM4zhrmHJm+cPqkqu6veTins9FaEqetE
         FPZMcNqPGCq612IIKU4UQm2fSXzEf9DgHGWl11E83BSyfbaZE/P/5ICfrDLzn/MSFh
         n9FofDXAfTomszqDsWqPcnIKrZwsNvgZhpp72DJhUVx2jnJt+yNWuIKdOpS2/YI/ZF
         uKyQ8sKw3U2zA==
Received: by mercury (Postfix, from userid 1000)
        id 604561060A61; Wed, 14 Jun 2023 17:27:21 +0200 (CEST)
Date:   Wed, 14 Jun 2023 17:27:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/25] Add perf support to the rockchip-dfi driver
Message-ID: <20230614152721.eep5ip726ump2kpe@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zyjzybui6e7gqjye"
Content-Disposition: inline
In-Reply-To: <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zyjzybui6e7gqjye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 14, 2023 at 03:40:34PM +0200, Sebastian Reichel wrote:
> I tested the series on RK3588 EVB1. The read/write byts looks
> sensible. Sometimes cycles reads unrealistic values, though:
>=20
> 18446744070475110400      rockchip_ddr/cycles/

I have seen this going off a few times with and without memory
pressure. If it's way off, it always seems to follow the same
pattern: The upper 32 bits are 0xffffffff instead of 0x00000000
with the lower 32 bits containing sensible data.

-- Sebastian

--zyjzybui6e7gqjye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSJ3FQACgkQ2O7X88g7
+pp2JA//SCpiw2slHYpTU8N4bPFSUT9ITBtddLnikjBs/LlWM9rDQV08dDBqnR1o
Eyyn11zHNQ49a145uEWthUM/j04gSR7n698ALsIJiCwEhglNB9maSJGFC2KjUISi
XqPkAcMfTXFuxWiRjuxGdcByP1XGbt2PUEmOL3ttATV4fsa+CBOqSRRCRFubufQ0
AVaDyNljEyMtvan5cgEq29iWXLL5LvQD15XZVWYiqhq0I8TTvZ/meQSTY7n2566G
WuYHXFWBnUQ/UhfKcTm1EHp+E43xPjaW+OTocMcijL4CqKXdj53rITNTZl0yBb5r
lvDlndiH2c9tgrxWtxGaEisdoeUEkc15N/OXubemWTXAnNF9Er5cImnP6H2zgc3r
IZNgiZnxcbqVcbXRsMvv6G9x2rgR1qrT7a8gfW+6XeKiTXMxhgfCyX12n++IMUWf
pfBezTJ9p4wa4sUW7xSNd7HL0AU0Lmb9LVDD1rFuNOEYKgeaOW+n5x3PIfjcqjgJ
1+HCmYklpAAdki85cEUZEuyf7D7C84j27uUUuOnlO670JpxQKvYndt022J69zZB0
UO3iDHemOx8Vwg8gkIcmCwsm7gopQOfhD4DjmOYQ6JddnuwwXlnOXRTLnBm9pzBw
hNPrd7KmbNw1nqhTDXc7OIT7iwOVmvJm5lj1GJ1m0gCnA8ZhVjg=
=xSXO
-----END PGP SIGNATURE-----

--zyjzybui6e7gqjye--
