Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805136FD2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEIWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:55:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AEC59E7;
        Tue,  9 May 2023 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1683672871; i=j.neuschaefer@gmx.net;
        bh=IjOsP3Hl5WOUcxHtKpSlXVU2zmb5sAncILY7B0EhNVs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ndYA2tf/LPtkgltTOvt7X2+Zi6uiTPSZbAqw/mXBwe2s3qEMYWIHbVw2U7syYOtiu
         0ByeTgk6m0fQkzncsA2uFg7rs+4GDkYCaq3zleDHMNFIszwJSYZevaNUwCstSv1xs2
         q2XsYVKyF7xXnp4qsykgKdmrMBdtxCsRttws9I9ls8dUQV5PBqFxC2CHyOsYGjarJ/
         Rr2m1bZj51r337gAlDvnDkQfA5v+OxXvevYZAHhLDsYKtlfaLNIq481n2v1Dl3mPUG
         +ciwlK0+ezWRctjT6rrS4cmxjRJOY33gMIuTSxMpaalo6ZUK907KGn7D4ZZQnJjuQD
         xm3g+5vkab4wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1qdIgl1tr2-00lTxs; Wed, 10
 May 2023 00:54:31 +0200
Date:   Wed, 10 May 2023 00:54:29 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
        linux-realtek-soc@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
        openbmc@lists.ozlabs.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-unisoc@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel@dh-electronics.com, Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <ZFrPJQdwoxqFpzUO@probook>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ue5Z9u7UyMsdbJpp"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
X-Provags-ID: V03:K1:aR+k41JkL+Jax7RkQK1pXFPVqGsXbknpTCCf601eNGl3xQsbw4B
 lW4IptIuDnFJb+jaCScKg4f1qDLjuoiDEqEJsUWT/Ek6YzDXkULOeXYq9EqgQyN8A6axbG1
 JRKm5mq+iW4e1K1v2w2BOTrGSmAwegcfBLrzES8HGqnWOqrguxalKWu6+fqbhobKFkw7JNy
 qeUuaRpvcFFSSatMddRDg==
UI-OutboundReport: notjunk:1;M01:P0:NarrxlSjiwo=;5z5rCQykqX1e+FbZ2ba6e5Rh6DH
 bfvBGeIXFywNjKNr0Tn58UPG96wezZLM4+H12pkCrjAC7Mqwg2PXJ70aoM1kBI8o+tAa0/419
 3XnQYa+XRlKna2zFjBCJKWpZoYii5XtCMCKO105lV0P6vMHckC89sxCK/LdwCvu0lF7OfocC+
 2ouaaWRHCt4YshSvfh5z/Ja+IC5J4jOv8eNZ6b4Ga79LPwxkC/RJjnB/nQ4E0edaxrobbRSOn
 Mpc/31AKJOkyrRi41IgtGWTEODyE2XZV00pU1y5sHoF3JU/eGsc2doa+Rrzh30STHQZStIaTS
 0sulR/BBWHEsrZf3LZvhDzOcbQ+0mpl9BfQXNLiDuCZay2ePoIqaUwts7JSoeIsxQHjZrbVOf
 h75oej0aNqoFhgx0M6WDh9xZydkRj4bbDxKZdwcWTSlHLDLbE26jSZC/2Oe+gjXSYJFSqcTIo
 y61XXOKn0w6OleXfF53iuFeaDOuP15yxKD4yYijJGDa3gETH/hjoY9RV4RF3njrNZ9cpp0pyL
 Wt5sq1md9IKuXv5zDNciEDB062aPPEfIdiuOL3ekvbmUkb/y0X/5vyJogDfXW1s/BcAt1Lw7O
 3fGQXfFWHtWSvKoTsdKwCQNoGLoqEX0ymmlOjO2H6zmOGgpDD61I3NBO058aLG0Ir0rXeho5F
 meMuCSguMavkm9x2cC+ehI31nsDXo/+BF4SlfWoDxIdTlxFojtrUwUJw55+y8lR/UsTKS8nM4
 UfuLe8Un7sHRz/mdblkfo8MYekpfSGy5OF1q4F6ySdpHLnN9/KLwguD2QRIXgxNbN+S3apSzh
 3RdOKnqeNprc0VYDcOdrgnL7BqsQDF2Rl2MSPh0TxeAydGQ6S6Uk6WUGWH/J/uB0ZIvQUETeq
 5wpcXi+kJF8q+LL66lQwIIQV2De+d1d5U2u4IhbVKY+H63H0/8T+2HkkllmX/vS+xMdVykkpc
 +lGd2EXuA+PHYRD1FvmkNVjxg7g=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ue5Z9u7UyMsdbJpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 02:40:19PM -0500, Rob Herring wrote:
[...]
> I've dusted off my script and made a branch[1] with the result.
> There's just a couple of fixes needed after the script is run (see the
> top commit). The cross arch includes are all fixed up by the script.
> dtbs_install maintains a flat install. I compared the number of .dtbs
> before and after to check the script.
>=20
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.
>=20
> Here's the current mapping:
>=20
> vendor_map =3D {
[...]
>     'aspeed' : 'aspeed',
>     'ast2' : 'aspeed',
>     'facebook' : 'aspeed',
>     'ibm' : 'aspeed',

>     'openbmc' : 'aspeed',

The openbmc flash layouts are currently only used by aspeed devicetrees,
but they don't really depend on any aspeed details. It would be possible
to reuse them in Nuvoton BMC devicetrees in the future, for example.

In that sense, I think putting them in a separate "openbmc" directory
would be slightly better.


Jonathan



[...]
>     'nuvo' : 'nuvoton',
[...]
> }
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-=
move-v2

--ue5Z9u7UyMsdbJpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmRazv0ACgkQCDBEmo7z
X9tB/A//Y5MU9b+r/mxCUuxjsa0CB4Ewu8xmc+YTd1pdMEIrJYfgdpXFskBmzFsg
QFYR1gBnq7P4mhusW4RaYWxpzD3M45B2vIuhgL6t8lqIWae0UuNbPEO4rbCIbvGZ
PCx1dTAGZ2vg+mxRK0OYouuCE9EvgrC9PGmOcgDkqCLngGsr11gXz0GMNebggmie
TX8iauQHnzfGaSQWtwIdQRu1gj2d/VO5NSn4CrgvMIuLCSwhTwY+e9H9/+CcrqHK
wNiMG0W8yY5CMO7ZSYf7EkEidunJ0htwqJmUoLfpqN4NZ/21yno69v+L36ZRu/lq
+KrZJeaXC3Ar39R2x75Pns5em46uwJJdI5aXumj9xPU3A3rgWCQcrECZJ7i/HEoK
hzhnsQhJNP4jAPVxdiaWJTYUXHRwafI6/GVvj1BvfgqZ9VHE28iGdDcgVvOfmkDx
eRZQxcJzFaWZeWTOeM05/dHUDUJXFrYvDsj0+FgneBU/oqEc+H4bR9AP2ttU24hU
4jBq2I2FlDyKlC0ARS22oRQlZG6KS50d1Nvx6cLr7lxeOHmcW09dPCqHijQVtX3V
f/Z7MYrDEXgTK8r1wJk6PuvVN+jFX/l/Ali5L/OJqUsZB4bgteXKEWXWMmgik1/I
d3nr3gTYEaykVkjCJORFKu4G2FHrzWgWpFYsl8Mu+safGLa+rdA=
=Jzyt
-----END PGP SIGNATURE-----

--ue5Z9u7UyMsdbJpp--
