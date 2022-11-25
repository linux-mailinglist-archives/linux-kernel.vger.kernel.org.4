Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2575D638E46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKYQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKYQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:33:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A90209AB;
        Fri, 25 Nov 2022 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669394018; bh=qrGihlr8b0uyjJHQy1x/KScetL6qwz/fPjcUju+VMJU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=juM0A7hh5EKfp+jla4lVOwdEVPH1MxDYue7mza3MLtME3gzfaREFURa+0xwvllZl3
         rQmz3UdXVcZgAE6SVD/NC86zNxZmtLJoQQf9O4FdaYBBiwtJz3COOSMoHs/QAaUdGx
         mvyuxjXodrdUPZ7vLQL3mEDD7qE0DO1hXrQa/zq6pcm4cx32Bgb6MNp8KrE2hBdSnE
         vQhjdav+SvhFO+57VJen1PLzjmoXP9m/ckGce7S/ZSZozlqL/i4aTFk26POcDpqsqe
         fpKrUO6oWoxr9ZOvmaunRFPk7V0U5QFUeyJuR1YF8dIGBpgl578hRmZNJN85StW3cj
         Szyvj18UXSM1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1oqOFV0GRP-010eg3; Fri, 25
 Nov 2022 17:33:38 +0100
Date:   Fri, 25 Nov 2022 17:33:31 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: wpcm-fiu: Add driver for Nuvoton WPCM450
 Flash Interface Unit (FIU)
Message-ID: <Y4DuW6Rai0urvrEI@probook>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-3-j.neuschaefer@gmx.net>
 <Y4C9druicCm0m3wi@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwqlkzk/XEkwkl3l"
Content-Disposition: inline
In-Reply-To: <Y4C9druicCm0m3wi@sirena.org.uk>
X-Provags-ID: V03:K1:mzDpPOrp7RPNq9d1SLW3cp7WtEvYeFRz6k6oMkCwYUCf05fzHyq
 pC6/qkDFSJh6nXs6OlAFBi54Cvx52zNOSt45nKXIzZomk+3ur/ORqCJb3+gDUCWvteowj+q
 AOfAZY5XylKbdMYjO5kRjaDaypLC7cuG3Qck4NjHxbA0pZdSYHBuEwJjvXH+COGy7GiW1rc
 Gc+ex+UecT346RU97Oo5A==
UI-OutboundReport: notjunk:1;M01:P0:GlWsrrnxvSw=;QI54juyukrryQzvM0y4temuv/CY
 lhcS2H8HaJ5wEHjxdvdjhk4MYaaOcGCu+GAg/jgxzj6Hlq77Vsvhfje0GjzLkOkqmX+Ht9d9g
 5u95+h8qACQ/wSKkPXVcE7Xg2FntWcF7nCAQFnaGLY1j5HaB19VJs7Wxc42z59N0Vk8SVIp4j
 8ZM+BdYARuP4WwBNCjZ6J9QdXMoENVgsQucevK9NhQHLGQ31dTyVpjCxkXTkHYY0bBHFUVYNi
 yXT4L8HoioUWAFkdLPz0m48pFBbqWqNq+0+vemhwolVQKUai/q6MrbxZQ323DYcUn1NYnKMQW
 T7TCnCfQqqs6t/6xCZGeB7ZTFZWZzgToyZs22HQ3Y+bBGWy+1bzdT/SFYB7sAa4VLCM43NyJY
 cnRd1f9IKggrjSdUKRN7M/YdNhq4FA7GKYTGS1/qWgGUnLEP9dy/hNz1vVOVKGGrQhcy8zNFo
 WSsPDq0jU/ppspy41iqD7RamuD0nazb0IeAh0qsj1tQvkoTlJK/h3G1JjQMA9NGj0VhyfH2PT
 11YzrCcIn3oK8ewwOrCkUVG0XlQIu51/1iPUj8MiBPWoaevsg9rqteNqrqQuzxvG89Ty8UCDS
 Yj376G0fRoScRhaVLlVjRwR67QA1p2q+Ndr1xIkQuebsKGUletZIoGo6vyUDapA8JFcOpsREW
 cThF5Qn2WDXo1Kbaw52WxhBy+Eu9PFn38OSDta/4wJJciMDmQo+4tr5/RMyxWpe6HJcyjGRm2
 FeErGQziZRw6DS/qI1VMcUvQSSdbcOmbV1+XVRArg/HGuRdp32cUGjl15CBTkW0fQzC5vydP5
 mFdokiN3gJkUZ/Wg2aSOvOoRdJkdXfJaizA1iOheG37hqA2uvq5wSENVRTP/2Ks1TWw3uoefA
 Ylb09Xv008ffZVhqaYG3EqzYli/bm3qD1GRjUhJ2VsoJaVKvLu2o42AAhHXwbCIabaKmAlVY6
 4Rn/zQGd9fp6hMo+6N3xF+Hu5tE=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gwqlkzk/XEkwkl3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 25, 2022 at 01:04:54PM +0000, Mark Brown wrote:
> On Thu, Nov 24, 2022 at 08:13:59PM +0100, Jonathan Neusch=C3=A4fer wrote:
>=20
> > The Flash Interface Unit (FIU) is the SPI flash controller in the
> > Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> > (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> > accessed by software-defined SPI transfers.
>=20
> Those software defined SPI transfers seem to be most of the way to
> supporting normal SPI controller operations, they just need wiring up.
> That would both support people hooking other SPI chips up to the board
> and might help support future flash stuff without needing custom code in
> the driver like you've got now.

I'm not so sure. The hardware mechanism allowing "software defined" SPI
transfers is strongly oriented towards SPI flash, and it already felt
like a stretch to implement all the features that Linux expects of a
SPI MEM controller.

As to connecting non-memory chips: There is also a second, completely
different SPI controller in this SoC, which is used on some boards (in
factory configuration) to drive a little status LCD. I think it would be
easiest to use that one for custom hardware extensions.


>=20
> > +static int wpcm_fiu_do_uma(struct wpcm_fiu_spi *fiu, unsigned int cs,
> > +			   bool use_addr, bool write, int data_bytes)
> > +{
>=20
> This appears to only support half duplex access but the driver doesn't
> flag itself as SPI_CONTROLLER_HALF_DUPLEX. =20

Ok, I'll add it.

>=20
> > +	cts |=3D FIU_UMA_CTS_D_SIZE(data_bytes);
>=20
> I'm guessing there's a limit on data_bytes that should be enforced.  The
> driver should probably also flag a max transfer size, though that might
> cause issues if the limit is different between spi-mem and regular
> transfers.

For the existing spi-mem case, the transfer size is limited through
wpcm_fiu_adjust_op_size. I *think* this is enough, but please correct me
if I'm wrong.


> > +/*
> > + * RDID (Read Identification) needs special handling because Linux exp=
ects to
> > + * be able to read 6 ID bytes and FIU can only read up to 4 at once.
> > + *
> > + * We're lucky in this case, because executing the RDID instruction tw=
ice will
> > + * result in the same result.
> > + *
> > + * What we do is as follows (C: write command/opcode byte, D: read dat=
a byte,
> > + * A: write address byte):
> > + *
> > + *  1. C D D D
> > + *  2. C A A A D D D
> > + */
>=20
> If the driver were implementing regular SPI operations and advertising
> a maximum transfer length this should just work without having to jump
> through hoops.  The core can split transfers up into sections that fit
> within the controller limits transparently.

As far as I'm aware, the controller is not capable of performing a pure
read transfer, because the command byte (a byte that is written, in
half-duplex) is always included at the start. I think this limitation
would break your idea.

IOW, the hoops aren't nice, but I think they're necessary.


Thanks for your review,
Jonathan

--gwqlkzk/XEkwkl3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOA7joACgkQCDBEmo7z
X9sd4hAAm0jeohWy0jH516T3AFdtefq8JNrt/cxtxoPtof1l2XSrS3Z6HvNqChWw
ZoLYjVQfMJ/ABWXTPT2ODtVkrKlxaCBt7etGysg2NVGjD0BjaAgmMUcZk/YgzY8o
UBaQCt49gI/F66pbm2LDqMJYh6VhOZbGePjNC3zGYvY5dh6DNYP/jaHy5Bgjwrgf
1GTYYLsgaoLusWoDc+gamryqvweHXGGM1zE8Z8KORgqczhBe0Gj6Zi9tPRu9sEWF
gnYr79dyU7ikjwQ6BREJVdbYNoQVgB6TwRdc+da9pOmNES/iHUUM3g2Ko87RzTPg
8vk3yS+wc1rzn01+GOg2B3Fn1VkKmi4QfOJBU2WkeUf923wu/bWlpiCBkG55Kh9E
w5fjnms1+ikNiHQTByFW4xvZ0Z8g81yDS4xz0aQnBRBPsq5N/Frou69TQ4eumyWn
yuf0u6Bx5Pcf4pwPfjKFytiHO9uvqv9LwmsUkx5Q3Y8teBfKGRtGrlhInj0T0tSa
UYuRvfGywhDzl2KQKMoKmTBTLG5F0W0IVBg2Y6sDB7NdUagt5wzqqscyuSvrrKRI
+nIZqKjLKTDCYj/JIJY7DnFKyP6X/bCAKlcCUWdUHgrG8DCKaj2XsGcFut8LfNlV
4Qn9wnEFdHdEhivLyj3LLHMe4lVHKqqvryvzeLXcZD5LITLWP+k=
=RdbO
-----END PGP SIGNATURE-----

--gwqlkzk/XEkwkl3l--
