Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E86E30FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDOK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDOK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:59:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28B113
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681556389; i=j.neuschaefer@gmx.net;
        bh=vh2G0NzxpVIm2iQgrmrsWcH2f60myFavJlWnuw0wR/c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FY0mAQByVR3QIL6Kw3FVLBU40Yt54WS3yo/aR2fVLfuFKFcX5pQ4qtZ49MHmtMz8v
         /G82hxB4yCkRMx8PaXA1orgbtEu2y7NZGR0QMGc2/IPdct/RBiu6DKWOv28Zv6fzPO
         uU2ca921LkNq3gWp/tu20zrErlEly9YlWRNA2MIqY9aH204rkt49FKOLloEtNAOt++
         2DDn/0ckda3fGnviinmAopWc46sX44o7DC7MhFMfNo0Hy1lZLfWp2/opVjPbhk6tcf
         356t9wDdnJI7+QMkx3AdcWRWF/EvI+pdHeytyHvaOonKsqZz20BrkFn47v52foEyj+
         GM2z1YF/puvAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1q9YBB22e8-00md7d; Sat, 15
 Apr 2023 12:59:49 +0200
Date:   Sat, 15 Apr 2023 12:59:45 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] reset: Enable RESET_SIMPLE based on ARCH_WPCM450, not
 ARCH_NPCM
Message-ID: <ZDqDoW20eKlJugCU@probook>
References: <20230412191913.3821805-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="moUcEPBCoqy6xxOn"
Content-Disposition: inline
In-Reply-To: <20230412191913.3821805-1-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:/ezHTHsoJqXKHedU1/DsYBE9XgWgg9HP1ZZeVCVDpxvAA+J5+UE
 wzUvBPEGqK5r1CtB5OPYDNJ6AiN28sMQTXDAbsaTus5UQKMMN1QJLsWrFAFRhJR1C5ozJGA
 GO8ovI7MnKufFOHuCLiEWFzKKm4TS+RTnexUTA7ANoO0rGlg3cnvNF2WN4kbv75x5N9ABz7
 ujfqXxvAc5D2Bhse+LdxQ==
UI-OutboundReport: notjunk:1;M01:P0:zWeoyWKHePc=;dmjkYa0d0HLdAWQu403G5kzB0n4
 u8yUQDTBUlYJcyoFLSPn6QmW/Mzs668pd8kaqnFc9oILfRljj14kc+BBZQL1ccgqv0aEoEp8o
 46w1rqVM1HEb4P6W5g6l4LrPoD/kmHtXU4BkFioLMJwpX6mhGabg3s1vtFUeEd/EtVqwp4Fho
 JRsaDTf7hvxj+pDKNQ/4E8fjWZ6MZPOKMLvH5Tz9r66t66up34fAaIQpBKwkmtnbMHoaMm+Jt
 wKfqFUqj8wh8Ax7n7RAJ3PW545i2hdvgwYkOrYiQVe0EISqZ7ay0FVR+S+ac1V6gBIHQ/PirU
 19klXuNx1JQVTiCeOOY5Tq26kl30HO+lT+FL5bBjuda+mf/Fx3eq11AFqwxNoNGhaWAodJzP0
 N/G8Crhl786DCXXTPE9UDwWGI760Sxj+UPbB0V1tyuUe6essJyZfzNZ+bOSKWDM824NSGErEk
 3obZ+FZpB16zCwJ9n2tv+pyUyYhjhKbkfx0FaHCcDLer+k8O5JjRzUEEvf+ktkSDVK4cW0V7A
 EpjBbm6W9HIWXPy9CgsBUZSNQodgKyEPauoAICtWO2j/7Cm4FfAwYzlgN6w/VLo9qpDo619Nn
 Hkg6Zgf1tqKAiTiAJarOTwA6rODMVLQUD0SB5DdBsAVnWtQttYtz2+BA1QFqq5CCKjcDu8Rvo
 qC4S4bPmYRYza6ktV+8IsDaD/Qv6h2p6GCy3Cqy4wf3idOOfucuLSan2QAjoprgehLz6iqcL/
 hjP8DFkoA+M8DI4WFG8yma/9gy0zBel63Etq3KPd0oLlOwLFiXilFlk7gmfkkF2cjBYGMu/9E
 QV6674kvHQFJlo4Xcwfq26jmmwb9wFHZKK8IHi4AbvqKYDsXhdcwaoYAezIQxgGsLfUF9Uib4
 3EmRnc8FNUjgdk2Ii+cYi7pcoYEDZ7qfP9COWTBKQkgYYHGOr2k5Eu/6fVOuTbfAYL/eWdr/a
 7FkR3w==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--moUcEPBCoqy6xxOn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 09:19:13PM +0200, Jonathan Neusch=C3=A4fer wrote:
> The reset-simple driver is used on Nuvoton WPCM450, but not on other
> chips of the WPCM/NPCM family.
>=20
> Narrow down the "default ARCH_..." line from ARCH_NPCM to ARCH_WPCM450,
> to avoid unnecessarily compiling reset-simple on these other chips.
>=20
> Reported-by: Tomer Maimon <tmaimon77@gmail.com>
> Link: https://lore.kernel.org/lkml/CAP6Zq1hjbPpLMWST4cYyMQw_-jewFoSrudOC+=
FPP5qOxJz4=3Dxw@mail.gmail.com/
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Ah, sorry, please disregard.

This patch won't work as-is, because it depends on the WPCM450 clk
driver patch, that isn't applied yet. I'll fold it into that patch.


Jonathan


>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 4b36cdc73576c..16e111d213560 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -208,7 +208,7 @@ config RESET_SCMI
>=20
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
> -	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || A=
RCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || ARCH_NPCM
> +	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || A=
RCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || ARCH_WPC=
M450
>  	depends on HAS_IOMEM
>  	help
>  	  This enables a simple reset controller driver for reset lines that
> --
> 2.39.2
>=20

--moUcEPBCoqy6xxOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQ6g38ACgkQCDBEmo7z
X9vWNg//SwlD5KUFv9SdTavzPsixPLt0qQxmulKXxfxUZDx3Y3YwOUXnXyv8DNmB
ErVIB5Vipz5ziGeVlSU3hQYLoUTwzjOrOUQ4WKnN4KUdsOjRp+IrVKjDcXLTg0z0
RYcGvttujTexyHYNDmFY8xNMinSBcEd/RZMdyf+JOuK69InvJt5kouvgcRyJ3w2H
G+N5eE3Dwrds6Uo95h0JlzhQAooknvfovMlzafEr6aVOk1G0JrY23kwfRJ/zBJhE
HBuxh/IP8Lq/bVVRWmUJk24tctvvZRihElktZypFwaSIkRE4rU4uFoePK6fe+GHL
29kcpYgdJs92zuZ+6f6GuTZQLGpn0Xoc8t73dnp+2OtPdN8SZer+1iES13S4C4aZ
QLYTUmhMoQ5xXrZj3+9I+XSVBI7XvSuGxMv7tokv0AwFVsx0NaYhlo2F7LmdHqdF
4FEoZMW3CS1Z58jrMDuqf85q7/T9481QfHQ9/YxZ35ScIFC4BVde1jPlSzvcz/gN
d8NBVMdBlGle9/7A59oWbvWd51WzvIGXU7lMHBmiBx1yFsr5Q01D5+iYonlSeZDk
f8f9/i2S4SUgEZ6IXk6Dvcjkz9Pa0pM4d1ZHQ6FZchjh1og972ITKb+d29Quh4gg
G4ZZwnsScBVFnlFZIf+yY5KnYEdVK2nUNxDNY3hrSU6niYVh9KI=
=ooZ0
-----END PGP SIGNATURE-----

--moUcEPBCoqy6xxOn--
