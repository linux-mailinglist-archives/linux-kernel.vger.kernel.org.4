Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098826B7420
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCMKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCMKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:33:18 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC147EC7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:33:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6293120005;
        Mon, 13 Mar 2023 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678703589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8FPy5uKFiDq2l0zmMVB3owwRxWGEIonz0+Z5WC0wt0=;
        b=A4JqcLCuegFITVmpkqLqjiCFu8ALAvDuaHueT7IMEMjLltfikfkQKdE1Cj7WPvlQqgXtqy
        iwUqyewqMsQjkNX36rcM/wok3PDyWiZ1aJ1oHEW0VX4yQXnRY1ThYkP863I4IEelsFqlzX
        WUTk9NLZzUl7VWMxluzZcmXAiY3OGWoYGNoEinquo9gSOkJfR9QB592ZxlYX+EF+fwNDz/
        HJCNy6bQS/5sVlhgyKusqQc5czd7V0RpT5AAYPpTvEHcH+aN/e1POdcgUM8lAvJ9CXxzO4
        jkezh+JrQr7zRjFwGDVqIO5O++LusmE3eLm89jGboPR9xqjjZvwQb1ScBoTcXw==
Date:   Mon, 13 Mar 2023 11:33:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Luke He <sixuerain@gmail.com>, tudor.ambarus@linaro.org,
        pratyush@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Add support for XMC XM25QH256C /
 XM25QU256C / XM25QH512C / XM25QU512C site:
 https://www.xmcwh.com/site/product#
Message-ID: <20230313113304.1611638d@xps-13>
In-Reply-To: <d553beb1c6e38eac748d0b6b62bcd335@walle.cc>
References: <20230313100153.15441-1-sixuerain@gmail.com>
        <d553beb1c6e38eac748d0b6b62bcd335@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

michael@walle.cc wrote on Mon, 13 Mar 2023 11:08:15 +0100:

> Hi,
>=20
> please have a look at Documentation/process/submitting-patches.rst
> how to properly format patches. But also see below.
>=20
> Am 2023-03-13 11:01, schrieb Luke He:
> > Signed-off-by: Luke He <sixuerain@gmail.com>
> > ---
> >  drivers/mtd/spi-nor/xmc.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> > index 051411e86339..6db01b80237f 100644
> > --- a/drivers/mtd/spi-nor/xmc.c
> > +++ b/drivers/mtd/spi-nor/xmc.c
> > @@ -16,6 +16,18 @@ static const struct flash_info xmc_nor_parts[] =3D {
> >  	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
> >  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> >  			      SPI_NOR_QUAD_READ) },
> > +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> > +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> > +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> > +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> > +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) } =20
>=20
> I've just looked at XM25QH256C [1], but I suspect all of these
> flashes supports SFDP, therefore you shouldn't use the NO_SFDP_FLAGS.

I didn't check, do we have a kdoc or something like that which explains
what flags to use and when?

> Then, without any additional flags, there is no need for an entry
> at all, because it should be coverered by the "generic spi-nor"
> driver [2].
>=20
> -michael
>=20
> [1] https://www.xmcwh.com/uploads/198/XM25QH256C_Ver1.8.pdf
> [2] https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/mtd/spi-nor/=
core.c#L1637


Thanks,
Miqu=C3=A8l
