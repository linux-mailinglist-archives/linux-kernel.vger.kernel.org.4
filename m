Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B370F404
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEXKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEXKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D3E63;
        Wed, 24 May 2023 03:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09B2E63244;
        Wed, 24 May 2023 10:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C8C433EF;
        Wed, 24 May 2023 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684923555;
        bh=MtWBtQ6aAoXyFoAVZRww941etajSf0Pwbm9hhrT6pfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uw7G/dz0llS7lUVaJS3D/WIC2fhIKJtExPpIgjQ39YeXVmiLGXkU5Ri0nDd/oRAjX
         MbO1fPei28wWMNb9S2cN6YRwWJozrzW0pUWKG6EXbQRR2uY6O+5VNA1t/EiVPn++UV
         5EmwX1oe+gLkciKaBdnNVa/u9LcGxIyyYqIea6XpMNNVKmQrneaI2dSx/kPnnx4Ijm
         LUq1nUZ+8BGqp9oTCjq7GJ6LDCVC5pYolCKy5f9f2Vx03Ih5qSsQmkQeyA/C6UdNTu
         w9xjsQ2IquFlRofxLlUSpf2XJ9F9nk6lxXhugYHyLVHbqHDGawytYtkrbtYvg9SMMX
         h5YfmNsf8cfYA==
Date:   Wed, 24 May 2023 11:19:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v11 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <39e99d0b-9a5a-446d-aed7-efee21216ec1@sirena.org.uk>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-3-zhuyinbo@loongson.cn>
 <ZGy3b7ZfNwWoGDTu@surfacebook>
 <35b0500c-d7fe-6479-eeff-d45bbf9a9426@loongson.cn>
 <CAHp75VdHPFDAd4iHdX5jXCM-tq0ZbFJDjvF9GCR_n7HVtd+obg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xqg6i+1FCvZAy4Oy"
Content-Disposition: inline
In-Reply-To: <CAHp75VdHPFDAd4iHdX5jXCM-tq0ZbFJDjvF9GCR_n7HVtd+obg@mail.gmail.com>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xqg6i+1FCvZAy4Oy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 11:42:34AM +0300, Andy Shevchenko wrote:
> On Wed, May 24, 2023 at 10:52=E2=80=AFAM zhuyinbo <zhuyinbo@loongson.cn> =
wrote:

> > >> +#define     LOONGSON_SPI_SPCR_REG   0x00
> > >> +#define     LOONGSON_SPI_SPSR_REG   0x01
> > >> +#define     LOONGSON_SPI_FIFO_REG   0x02
> > >> +#define     LOONGSON_SPI_SPER_REG   0x03
> > >> +#define     LOONGSON_SPI_PARA_REG   0x04
> > >> +#define     LOONGSON_SPI_SFCS_REG   0x05
> > >> +#define     LOONGSON_SPI_TIMI_REG   0x06

> > > Where is this used outside of the main driver?

> > These definitions are only used in core.c

> Then the obvious question, why are they located in *.h?

It's absolutely fine to put them in a header file, that's a perfectly
normal way of writing code - it helps keep the driver a bit smaller by
putting big piles of defines in a separate file, that can help make
things a bit more manageable.

--Xqg6i+1FCvZAy4Oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt5JwACgkQJNaLcl1U
h9Ci5Af+NaHg1gQJOq8Q4R3aAaMCss64c2eb1tgoVaaTl1dAsuDyMvXBh/gZiY7Q
a8XqU5QVk9o7HD7UpvdY3f6ZlpakU9WdUfqsSX/XCaBheAa7MISY1NGyNkAjcDOl
hR17A+BK5REb3dlYcWsONd5fouuKl+KsOipPSOFVTeU3VJuIIlGQUFGaw74hxMsa
LWgZHOpAiCsgCMyyeJrzNgSl62j+iOeg4SIRbumZzvFdoFQbb5wnIzEzlWLDWgBd
vvYaqdcTlNTz5wQLjzyUDUsocO4LxXPLwJz5ljlnbji0CUzbc6h9XtUV6OoRohIE
H+u7g0Ma8nEu/VhuZiUszak7EoXxCA==
=SXKy
-----END PGP SIGNATURE-----

--Xqg6i+1FCvZAy4Oy--
