Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3C67FCBD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 05:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjA2Ean (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 23:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Eaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 23:30:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CD21969
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 20:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674966614; bh=2oY9+vEjQVKgGXNs7di0tfK+ZaWMzVuGiWD8inZ5rTY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pQMVi8RdJlENMQPXvQ6yDNbsDAVg7FeZQy4vGUvp1msH0d34l6M50RIAMy3TwOwgb
         a/bX9cKBwwIZi4W/OHrW+MlA76LLXFYdpUa5KlasnONYLLI5kCmictLhdoPAeAXK8M
         WUib5xrLU6pAdCt4V9so6J2Dl0T3j1E0JdbgZQaQ+n/U3KaxzxnSMbZtfPvXm2sner
         R0dzwwganJW37DebuibMXPOI2+ppqOjQG2HE538ctHbyZCEkVxdb6NZ6+d5PGePTA/
         t1pVi46E7JFnQFJY5OYAivXwH9akYaMKw3kVw2QFJw9H1DtjUr6XIW3xfdiqeNtoFG
         wDwvi8EOo09SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1p59P11Hjh-00LDUz; Sun, 29
 Jan 2023 05:30:14 +0100
Date:   Sun, 29 Jan 2023 05:30:10 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] ARM: Add wpcm450_defconfig for Nuvoton WPCM450
Message-ID: <Y9X2Ur6oHTsFtCmW@probook>
References: <20230129041547.942335-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrgSoAscP93Rd3cj"
Content-Disposition: inline
In-Reply-To: <20230129041547.942335-1-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:XRzcDZoEzXh9V3LG35lDY5DBVCh1R2Im/UHyEglDLr5dYRZ7e3D
 0GXMWuYKavtpYBjBTvq6gTjPk+Xh7OVqQtPHkbJ1pqnYiBL/w/o+UG1F1rf1iTxoErIAWXW
 TXoWV6X509LulYhvJQRDsxYpIcb5REZc1aG1Z6OVdEHOUk6hf5iUyRbrk+TZ6GuRUjZ5tqa
 +ENCC6ZOTX1BtUXHuke9w==
UI-OutboundReport: notjunk:1;M01:P0:nVGqwH7ZzTY=;AnFVMP5+RlVD7+n6a3Nrte32lwa
 MLCR0I/YBoT+YoFDg9BkmCvEqwZlsOD/Jtltdvr1mJTMQj8sL9e9B8Fi4/N8Dk5JMAuVYaSAD
 uUrGi4WTC8s65Gp9lzNYm5S8jm1SR5OqNhYmODx1QnhXFq+GtIxUBDMYgguZDzeHgFMW1aOx6
 jD+bNGrTLsVe+Ts08npKa0LjjF4YkKeW/JdYIKwQMSnvJeNltfeoD5FZBz07+nlqVLDnGCEf7
 CBOwanprmwTPX1X8CXjfsav5rlvCZ7zG4asHzw+UgDcDHyvOvx2fvSbaYiw8Kh8N0qw33BFjk
 FerEl2lq5oSMrMeU68BI2+B66dyTGsfFvLzz8x2JhbcYjbF0qHq2ox814aPyLCYfdLvp45vlP
 hg/KGGk1/n8N0kF615al353YVEvw9+oiWV8QNMSxLD169oNPKuhU2P8P5l+taZBtAZJrPFA85
 VlDJXTALdyVzJ0pP4MCpeQp85rp5VuAzOhQqpQOh16Mv+52n9sq9AiJTT4hWjPLA8pTXwo4no
 uilJwEy2HA7bdxBXigdg0NWHu9O6zbzC4bqwlJxrROUe5OUDFq51I/LY3FfT6PV1cgdrHfExU
 Xs8JJEb1sWz0aOiZTHp2CrH5e+2jq3O1ga82Uz8NMDuoJ8hC0dXIReiyFrCmNxGWCXXf/+x9C
 wvPIB6hB3CLBLOeGq+Nn1V6WdWyPx3eYpsPfix1dlFdptO0dG4pmhnuQikknZFlfftCi8BMHy
 0HwxM+LjViDDats7ixFkU3KF+54/3bBobEphO/7qVkERjeG2dOadXHuKfZPDyIUXjQpaWFUyN
 lx+ks11pi046e+WsASxoZnbB5uf3Gt61L4GhuVBNhZiFfWtwPM8fGMJC1OJRuZXeEvnL68oTh
 qk+oCX9HbDgA2QsXdDAkuC2uh0hZnS7hXudlqJ7j33mn2Mkw6xqZz+T7z5D6hmIC0IV7d7Pam
 QcCpvNDSmRF/uI49SKmY+Eb1/k4=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrgSoAscP93Rd3cj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2023 at 05:15:46AM +0100, Jonathan Neusch=C3=A4fer wrote:
> This defconfig aims to offer a reasonable set of defaults for all
> systems running on a Nuvoton WPCM450 chip.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---

Sorry, I hadn't noticed that v3 already made it into linux-next.

@Joel: I'll leave it up to you to decide whether you keep v3 or replace
it with v4 (although given the upcoming merge window, I guess keeping v3
is safer).


Best regards,
Jonathan

> v4:
> - Add Joel's R-b
> - Disable CPU_FREQ
> - Update for Linux 6.2: Enable CONFIG_SPI_WPCM_FIU, disable
>   CONFIG_LEGACY_TIOCSTI
> - Disable CONFIG_KEXEC, which isn't generally useful for the BMC usecase
>=20
> v3:
> - https://lore.kernel.org/lkml/20221101112134.673869-1-j.neuschaefer@gmx.=
net/
> - Regenerate for 6.1-rc1 and enable a few Nuvoton-specific options as
>   well as the PECI subsystem
>=20
> v2:
> - Regenerate for 5.19-rc1
> ---
>  MAINTAINERS                        |   1 +
>  arch/arm/configs/wpcm450_defconfig | 211 +++++++++++++++++++++++++++++
>  2 files changed, 212 insertions(+)
>  create mode 100644 arch/arm/configs/wpcm450_defconfig
[...]

--mrgSoAscP93Rd3cj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmPV9ikACgkQCDBEmo7z
X9vXWQ/+Ov8IS5JDDJmGLN3jT4vCLiqYEzQDg8K2iagvlwgbZcbHUFAPbANFt4qD
kG5HH2QDOZhrUg9WwnbVs7hsEFaCxNcl3G7fVfEb6LZMbw2iEoh154sxIu3vbnzj
HQBJACyvIfIKnAvgOUah2J9GhbS5iA75OouZsfOhLiDjTVPNLzpGmR8D4RmIk9xL
1rzCSCxkYxJZTJGV9n0yZDTgXU+9mvxkPPqGo4Wgzte99NP4KRa5kJ5YMrybR/D7
h8Q9RM/Dff6v1g1DawqINPU+sEdqKB4uqpK6uPF1ToKYDyvOq4yZ3J6Jzjq5Y9xm
WzN3/O2WvJriRJ8bHG88SSprcP9d9qsAZjNzkqgj2bc5zrfncP2b57zntCBjL3on
tV0wttFbqHsxCrJtppDraZBP0KqA5Az+VaTgIAzi8KkyQUXcd4F4zgrqp/6zd6hv
slnXe9/pLlVZ+mtSjzkXHBvsPj3ca9VGku1rMCNUo3ROSTiTIL7ZvmFU8Yu+QQCP
Hw4cvUFKLSXbwXP3ylkT2tc3X63Jm4M2Y8FEvHYEYBcvoaD+VVzV7P3luPElJwXA
S43cfTOPBnKqAYlBIknc0AySnXp1teizejV1tEPLh71PYlLPpCBiLlCWgloa7lis
nVyrnQzKgOk/6T9ACW081fB0akOkgRpii88qKZDQPQL/X2z2vwA=
=D2LN
-----END PGP SIGNATURE-----

--mrgSoAscP93Rd3cj--
