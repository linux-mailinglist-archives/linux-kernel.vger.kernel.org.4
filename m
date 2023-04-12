Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555046E00C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLVZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDLVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:25:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E76BFC;
        Wed, 12 Apr 2023 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681334692; i=j.neuschaefer@gmx.net;
        bh=1lJ48Ks8BJLDV0858j+7zFjPkSScyLQQDytPILWRroU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MqM6pNlGjibfGdC5QKhvhl0yAmQ6mAkFTyqgS2272odvCrSvQmS4ltpfUkiY90dI5
         d3KUzTohx/Co/RD0hnN6ghpmwAeJtDx2GC4NRUGTn5jjlk1gTbvaijwzTt5xuB/yBQ
         UtpJrZswJHgcWG/B0kU8KoLDZXahrC8QML3dTaUaoWGBSzq8Mgp89+O0A3tmcJP3rX
         Kd9sbSxVE9+YEhrPSaMKhM1YeGbn7b2J0EG52rDY2Rt1pkFvkvYX+NULQyO9konDpU
         nSyRULg01htzm+6FiJnP4+z9zjOVNB2XyPGqFZuIKu1HcKq/nUpjoDXFJsOYdlDybS
         xP0NGKdsOecqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1qQmcN1JRn-018LPv; Wed, 12
 Apr 2023 23:24:52 +0200
Date:   Wed, 12 Apr 2023 23:24:49 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 3/6] dt-bindings: clock: Add Nuvoton WPCM450
 clock/reset controller
Message-ID: <ZDchofAGChRo3rUi@probook>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
 <20221104161850.2889894-4-j.neuschaefer@gmx.net>
 <20221209202120.0AFACC433D2@smtp.kernel.org>
 <ZDcC9JBidzfu94NW@probook>
 <ed34eacdb1d35be8b9b2c44944f828e7.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijRhWXEzdUKaiJe1"
Content-Disposition: inline
In-Reply-To: <ed34eacdb1d35be8b9b2c44944f828e7.sboyd@kernel.org>
X-Provags-ID: V03:K1:11HHXOJlEmu5SAf22Qo6cW7aqsbyy3MHsKrLND7Ec+YYY+jpmto
 9zVADJVVK4YnjFYNDkNIn9xJ5m64xdfkRF0cFN3m7pLlp8NoQAxYUUbftgABatNOuPzNnRh
 nFGcF345rtT+y5LlMU/PPajrz1crlQv82C79eWKcdRPue/rfQFkbJ1iniuNOFPXkQ+aMWCU
 VX+gD2p6lVWxttOseUhzA==
UI-OutboundReport: notjunk:1;M01:P0:NqMDQeZ0dwY=;T2pOs7OeULQAguNA9usaI6xaFqM
 4vCrI2hHUwH7+38dwDt8IM/G1OYZic062fuk27MXLOzR3jaDUCBqYRjHqPEBp25vxH4zNuRiQ
 QCM+GdqPnNPkPOjR4OP3lg/Av5ynhpA4AUAVIewcY/pGeET2smtIX7e70UFsUEdiz97n2wSFe
 jWL0mLsDB60LbgIr3pBymlfBBIGY7ymC9WuaDzMrhPFbjYi8bqQPVSmMXrkGZvk0+NeNGJ+je
 qwAMHy3HPnImwruXp/7EbZUnnEzMgd7RxBvnSyFI33B6iIulf/WApJcdeCUYdJy6k3WlTz8kz
 0Y17UzFIUAbCTExbUs4J58JAoVQzdMdgPQIFTaag49ePD+NVT9LHK6GowJpEu5yQO66DA3wyk
 vsJuXnYzv3ceyryUkqWPv20WeJcrj1o7KXa2r3ZlQuVnc9/SMsocT1RwzUq4aonySjZSobW5u
 2fXVQYaTNp5pAZQJfuAuEbgsXe4Ddnk7pb8jmYUGJkN8VLBmgCjmcJL5oucjGowKAqHFeSLzP
 SXIW5PtFLaWaoww2YLmeW8/vRGNIztthhnBJTW2LPsvlmJ6Eid59L336rd/lKktz+xojsvLBR
 vclo1nlQgrloQst5MD+HnPsQ3JeyPfQtQZUE8Octg4cU3cyOGcuA2yG/o2qxXd397PT+ZisZ3
 6lVNH5X2n6Helyibrew/sEdnSGenLf4EI+LJFOHiO/2i/9zPvdBud1L4p2zAhrzcKzrW3bXnO
 Ge1yLYPJPC70hyoJ3zpCV31Qjipq/w2BsKchdrQp3sogwtxk44NszHSZq8mnyaAtromqYqNCT
 XB1QylVqZv1h6QD1c7MQm3nFfZdEronREeG3TFwbZPI+nzoFWT0m/zJyt6FsTno5/SAqen45X
 m0GJ9sI7i18QLof6ZhcDLOBvZ2s/+oSPZBFBv9c1TmUZpozw61L53Cx15jVEWTYGNL7fWX+ss
 ONi7jw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ijRhWXEzdUKaiJe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 01:34:20PM -0700, Stephen Boyd wrote:
> Quoting Jonathan Neusch=C3=A4fer (2023-04-12 12:13:56)
> > Hi,
> >=20
> > On Fri, Dec 09, 2022 at 12:21:17PM -0800, Stephen Boyd wrote:
> > > Quoting Jonathan Neusch=C3=A4fer (2022-11-04 09:18:47)
> > > > The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> > > > Add a devicetree binding for it, as well as definitions for the bit
> > > > numbers used by it.
> > > >=20
> > > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > ---
> > >=20
> > > Applied to clk-next
> >=20
> > I don't see this patch in clk/linux.git's clk-next branch. Did it get
> > lost somehow?
> >=20
>=20
> Must have gotten lost. I don't see it in my branch history locally.
> Resend?

Will do.

Thanks,
Jonathan

--ijRhWXEzdUKaiJe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQ3IYAACgkQCDBEmo7z
X9v0qA//ZCyWw17Vh1uj88edHIAvM13FiSkcbtje9SXoTMnffVwvHTaP5fh82Zs0
RJ7zJy080xBuP5dpeNcFKwNy+lv8XULtk3Y1ACzQjsZZRWUf37VEcaKZuuE9cjNJ
QjArNXSqv0PVk0DJAcSCGOrJe11A51whZy8Tv/vF+67nu6QjFaGKFAtuG9RMtYLm
5trTn96XKvFAOwckwzQe4FMLMLxXsHnsOk0G2fMj+jVoEDrMW9iC603lAIMqOCFJ
ODk+NlA5IpDBFC/Z+yayafGX9YVuoMlOimWvSxKWh313uD84EfgDfuoEhM3MwSzZ
c02XfSNQaWdMwFA93sj5Zw0Ar5wxDDuDxUkCTRH4PQo6RNSItsly8NfwnRKypysd
140br+efe14Gv67Z37Z2XhfYLd64B7fjRJhz9ukqi8cOrS/eQlapCK5JASnFzJdZ
f5HCXDNHF41HBL4r+hWgXsTCrB82N3jjGBptqr+qs9i7ZNKxxMKqy0NjTbAa2SzS
4WMEib4xX3fuELGor6g2NoKrftduQ2uHKmdT9kPo+PdtHh/gp4l7yIvSmKZPqqJy
oYnYWN+Yo/LkIV1mgXpLSzZTLuW0iyKv0iUM9N8jXRm4wQWfO0VjCpj69pk/26zq
QEsxsPNA3UYQzMcO8vIOMbYJ8X5LGVK393TvACKt0TBodX4k2dA=
=EKxn
-----END PGP SIGNATURE-----

--ijRhWXEzdUKaiJe1--
