Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6464E081
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiLOSRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLOSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:17:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E53FBB2;
        Thu, 15 Dec 2022 10:17:30 -0800 (PST)
Received: from mercury (dyndsl-095-033-168-084.ewe-ip-backbone.de [95.33.168.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67B746602C74;
        Thu, 15 Dec 2022 18:17:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671128249;
        bh=tPqBuypDEG2gjIdV3HpZSKNOgRo5PoSbRevw1WTLn78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIm+k7b1NTSw75LADYumnmVxlGYJ3gT0q5sLfS8MTD8/KFE+whE2jQY4H2YK7tbGQ
         /13a30uFEPFLoWuhueOdTmmHvBajDYaQZZUsJDEqPle/KM+JLONk2bQArF+pXGT0Cz
         a60RjFhXFDbsZUc0YLNio4Dxm94tCTI/60XQ4IPU4eEidWb61g9KgPhWRSVcijwW/W
         MRpw6PO9kUlqk6z13Q6RMKmt6MaFYjQlQksF0ntnyiAdWoJd2RWofOavatnwkfLZcI
         ZPZJeKIpnVqvweL283MvCSmGXcUJanGwFqI1ey5Juou+3ZXfhxQ2bGWJubukNANLHK
         izie65qAzcXlQ==
Received: by mercury (Postfix, from userid 1000)
        id DD0161060F45; Thu, 15 Dec 2022 19:17:26 +0100 (CET)
Date:   Thu, 15 Dec 2022 19:17:26 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 0/7] Initial rk3588 DT
Message-ID: <20221215181726.75qj6euoy3zgfbre@mercury.elektranox.org>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
 <20221215171828.GA153741-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nvfnquhkway6343"
Content-Disposition: inline
In-Reply-To: <20221215171828.GA153741-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6nvfnquhkway6343
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 15, 2022 at 11:18:28AM -0600, Rob Herring wrote:
> On Wed, Dec 14, 2022 at 07:22:40PM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > This adds initial rk3588(s) DT including two different board
> > devicetrees. All required driver changes have been merged into
> > the respective maintainer trees. There is one warning from the
> > DT check:
> >=20
> > $ make CHECK_DTBS=3Dy rockchip/rk3588-evb1-v10.dtb rockchip/rk3588s-roc=
k-5a.dtb
> >   DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
> > /home/sre/src/collabora/rode/linux-rockchip-upstream/arch/arm64/boot/dt=
s/rockchip/rk3588-evb1-v10.dtb:
> >     ethernet@fe1c0000: Unevaluated properties are not allowed ('interru=
pt-names', 'interrupts', 'mdio',
> >     'power-domains', 'reg', 'reset-names', 'resets', 'rx-queues-config'=
, 'snps,axi-config', 'snps,mixed-burst',
> >     'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'stmmac-axi=
-config', 'tx-queues-config' were unexpected)
> > 	From schema: /home/sre/src/collabora/rode/linux-rockchip-upstream/Docu=
mentation/devicetree/bindings/net/rockchip-dwmac.yaml
> >=20
> > This is for gmac1. gmac0 has the same properties and there is no warnin=
g. Also
> > rk3588s (and thus the Rock 5A) has only gmac1 and there is no warning f=
or the
> > Rock 5A. It looks like for some reason the referenced "snps,dwmac.yaml#"
> > is only checked for the first node. I think it's a bug in dt-validate.
> > Also the same issue can be seen with rk356x.
>=20
> I believe the issue is fixed in v2022.12. I didn't reproduce it. The=20
> problem is with disabled nodes. In some cases 'required' failing in turn=
=20
> triggers unevaluated property failures. So we now filter out both=20
> errors. But that's still not enough in some cases, so the only thing=20
> that works is just removing disabled nodes before validation. That's not=
=20
> great if it is something where the bootloader enables the node and also=
=20
> means whomever enables a block for a board gets to fix the issues.

Indeed, I can no longer reproduce this error with 2022.12
(previously I was on dt-schema 2022.09). Thanks for looking into it.

> BTW, I do also see this warning:
>=20
> arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb:0:0: /i2c@feaa0000/rtc@5=
1: failed to match any schema with compatible: ['haoyu,hym8563']

I suppose you are missing:

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?=
id=3Dc69bffe199270ce001d5764985a8e414c7e05fee

-- Sebastian

--6nvfnquhkway6343
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmObZKwACgkQ2O7X88g7
+ppQDA//VDi6HjP0j7Bb1Bx7v4JlMCRvVcD2toqQelyKcat50wUVFt0Ps6stMusT
VQjGpeacT6XC2NG0eqx9J7HTOpE10SyIQo30Xuq6k5rlihdMMNuiWNEtdWtLHVDq
Lglz/d6qqeooRBs7YT0rD0Ao+6ssZBkOJ6MaE89FCBp3dFgIZC1gH55W4dz6pade
+hfnBWAIPEx1PC3Ny8ltMTrgEnBV3zh1lwygFhQgLI7Ka0IvGiDeOAinhoPUQdLQ
Ffdal/IvZ/fPOFflZRcBKithpJWBouiM88JBN5ygN1bv18PwVdSUnPpgWJUEPmby
j8rDoTdLZB5vqwP52Tbt63Mh7DcvHhCVQ+elyVniai5uaahSkBhwgM8ksKlxgRlh
HVoDtnozZzsgX7Ol5Li9YUmVlzFFDaxOdhmRkThUy/djMfT75nsBwvgbYmeYooyY
+urxNvSfFVj5zosTLUKBUIW1+hKoNkRUkeKGkpdFv2/AWmcPspspJKezaJDd7tXI
0TFQTuzgGKA4pyktH+8v328l0zAXLB8gkMUAyInlHQ7a6tAxswJ/Loe0OmxxndLO
0vx9L7w5eQmjAlMPDEbABI87ePYM/zP5zNUQdufQut21LR6fiHMAfmUnGOczp+p0
STycbf+LbaAEHZEXEnB92vA73mXigKliApB9rvJjJ4n5Vdi5KbQ=
=AGbZ
-----END PGP SIGNATURE-----

--6nvfnquhkway6343--
