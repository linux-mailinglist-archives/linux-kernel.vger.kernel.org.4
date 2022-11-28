Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D498263AA44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiK1N7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiK1N7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:59:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850610BA;
        Mon, 28 Nov 2022 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669643943; bh=fNLBITOrzGNURlqG24wTjvnHcc19rTJ6Nep3M1Y2cME=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HdbpTayxuzNk2XxYuXkY575V2md9LGvaVJ9FqzpOptTWpFQ7+T1FHwoOhslZ6CPRD
         frjZ4JLLxu+X6rBhfqoLpjkTb76wx8cvTV8u/5EWf/3sriewZRRG4fuXycdbqdNswh
         dPXM8sqaWPhNGPVzQdjmGXyjoQV9SOroNovjboZsNv7RFg+P6TJGBAQhlEG2npy5IS
         0P5FBNFLZWAe+n5gtyMYvzlU44C/+aH0H66kHzr9x61JQ5+it2yqPXjDeG/7UMp6sR
         auMSKkX4GIxjI+NgmAmIlAU8N8x3odBh2asIlczXcyAYfZe+EWgekzuSU0l5YM1Wle
         LH+5Kx+fv4odA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1pBhLP1Gzs-00EIyB; Mon, 28
 Nov 2022 14:59:03 +0100
Date:   Mon, 28 Nov 2022 14:58:57 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y4S+oWz8fNsQj5Gj@probook>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-2-j.neuschaefer@gmx.net>
 <166950112932.8087.6546134123286782729.robh@kernel.org>
 <Y4SV+5/3Y0dw5QeU@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wYhQfr4TaDMG5L5b"
Content-Disposition: inline
In-Reply-To: <Y4SV+5/3Y0dw5QeU@wendy>
X-Provags-ID: V03:K1:UawUwTljaFZmjHPp2WDWznD+ZA5rr9lNR8hGceNy7bXH8HDhghq
 HiHSibk1k7KbSN4q7661mwuf2SlaH/3g009UcuHwI+v2OdIY9ezahSXNPCyu1qsxtrQ4ahV
 1biS9yI6fd2kRP9ehQ6t23oJzkVe2fVkaSqAmH6bptyCGkkZDjf4bdz29/Y0L2Lc1nvN4UT
 eRLD1DWqA9lWGmUfQSYwQ==
UI-OutboundReport: notjunk:1;M01:P0:d5FSRnk8sg8=;1dfz6LqfVWOJA+qmsrchA9aS1xk
 ZM1AjqtOeb9gV2tO9qVWStnbkL+e22yneih7+aUpfXjpZFtdFzHYPznTMl52s3kE0A0LP8eNA
 MHofqaK/Q3IQhJgWnWt87lIaFAFk4Y4MSDyBSbp59xS9R4rceUzku/KnzVP97UJzaFFjRkFlr
 GeaSoaSWOC6H4jePSmEmaC7Q1mFw5GDreXXw8na7XZEvJKnPXcAaQBTeBbIgi7+I3oF15MaJn
 2h2yEaZdiFxuDiYjIgwMCCmQN8gRAQqYTzBJWcFBP0J9zkNASo6Oru5gTg7R5zG/iyItGryJG
 dye40ZHjHbbpyx+NgUkymIq4J95LwaPnv6LZqCiE+yQOxwVpxCkTGxUFbPGv8ltC/LKPjNnzT
 535QemRd7ckj3jLWmeBWX/MIyOiYxkIwYrxOBiKdptYQzwCLN1Usc3AKCRijPl4R327ePlkKf
 vCsHLKkx61bez0D3vJKcXOZERZrFz6qDh0b/yFkvsucA0dqKpcWVrXzoyx17SCeMynmJhVK/C
 Om7I5PduESVnpqiSTaOB4kSPgOe1t1CnLh5vJDTcDYskg5D9BKzWcSiQwQe+8okWMWEZUagDh
 U86jxkXJzu5GoK+GlMoN2zDrnNDTEIkJce1CMWx0HHty2RhguwK1McunFSUsqitH2HfCkAiJk
 aPukkVUbsqDoiORBIdPESDzjBiVL1yTNt/9w0x+4jPUZVUKNQvlhWenPv00KDjxPMRphyII2o
 AuCyRtEM5NDWE/nSckJAMcuyPeyTd2X09yL9xbN+gmSuA+SsDD3rJjuqftUuYosFasGkaA6Q5
 QrnCUtZe4YK8qS4Ac4KjsbjGTFR+V21cm8P49BFiHz7KgaQRdtJwLyiD4b/D1OZGI2yanolfZ
 X0SMtH6R0CxI7Mh0mPj+g0gGDGxIe0f8G6TbxHm1IHc7bbiaHVbnTP+qFSr28sLzAM4OeFbgp
 0R34I5L+8ptvJRzPl+J1tT33NH8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wYhQfr4TaDMG5L5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 11:05:31AM +0000, Conor Dooley wrote:
> On Sat, Nov 26, 2022 at 04:25:36PM -0600, Rob Herring wrote:
[...]
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dts:1=
8:18: fatal error: dt-bindings/clock/nuvoton,wpcm450-clk.h: No such file or=
 directory
> >    18 |         #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindin=
gs/spi/nuvoton,wpcm450-fiu.example.dtb] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1492: dt_binding_check] Error 2
>=20
> FWIW this seems to now be in linux-next as dd71cd4dd6c9 ("spi: Add Nuvoton
> WPCM450 Flash Interface Unit (FIU) bindings") & is breaking
> dt_binding_check.

Ah, sorry about that. It should resolve itself once nuvoton,wpcm450-clk
binding gets merged, but I don't see a definite timeframe for that, yet.

Alternatively, I can send a patch to simplify the example in the FIU
binding.

Jonathan

--wYhQfr4TaDMG5L5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOEvkYACgkQCDBEmo7z
X9s7JA//b0x5Wz3oWxpKspCo0vQX9Pc0tbPMfyZfEmViSkIhrXBGDLxKDfgfBLc1
NkyS9KBRngGQmn7mk1fR40Vc0iZ9wpEfvqmKY47PPqEP+dC4bJmxwXbKLC5Npl/F
Nv8VuBy0CAHrdH3KvVG4KZRHMEPhKPmwAEuXeDuiqdLrB4UiKx+gjtreHuFrBujN
1VYronrrBG3vMsYlJha2zud4nQZw0Iz7fCJMXXEIV9OPrDoFHYP9kiPxowrbanHt
suK8RpvCBJcOkZZnpQmUEeSluIoe5y8VSORdMswttxYU+ft3Lg67W0Gl4A6Snrfp
h3bFxdkFqyxuKfk7fcr4IjG1DDhw3wXhxb5iJev4DzjGq545XwScdKDhkBR1jTRZ
BQYV4fjF6iSDo+HbhhF6hYAt+XO+THeTvkNJUt4A6X8McPnj724eOg9ngRPgGHEy
yGge/tPHa4GDa5EEJxd5QYdDP4oGV3/UdZFcn5Amox6dovIt2s/WJVn2DY1vP8mM
B0m1LO/WOk5JkGsWhH4amNN0+o1vboDvptAf0BgVkmXMuBFQA7R1qGn9M87VFLVu
BunTjZd1q5ELSVYWwBHDhoEPgoOd5AzLaZCAsYR2l5iZOIdvnzBtVok1wDgfQNaz
A4uo6W0O6mVxXYaM68TihdgKVjnSJFjImuY/rreq4RNYTty8KNs=
=uIeB
-----END PGP SIGNATURE-----

--wYhQfr4TaDMG5L5b--
